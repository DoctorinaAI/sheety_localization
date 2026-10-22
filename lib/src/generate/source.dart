/// Where `generate` reads the spreadsheet from: the Google Sheets API or a
/// JSON snapshot of it.
library;

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

import '../localize/sheets.dart' show SheetData;

/// A failure to read the spreadsheet (credentials, network, permissions,
/// malformed snapshot).
final class SheetSourceException implements Exception {
  /// Creates a failure with an optional HTTP [statusCode].
  const SheetSourceException(this.message, {this.statusCode});

  /// Human-readable reason, including a hint when one is known.
  final String message;

  /// HTTP status code, when the Sheets API reported one.
  final int? statusCode;

  @override
  String toString() => message;
}

/// The sheets of a spreadsheet, in spreadsheet order.
abstract interface class SheetSource {
  /// Short human-readable description for logs, e.g. `snapshot foo.json`.
  String get description;

  /// The sheets whose title passes [where] (all when `null`), in
  /// spreadsheet order. Throws [SheetSourceException].
  Stream<SheetData> fetch({bool Function(String title)? where});

  /// Releases the connection, if any.
  Future<void> close();
}

/// Convenience helpers for [SheetSource].
extension SheetSourceX on SheetSource {
  /// [SheetSource.fetch] collected into a list.
  Future<List<SheetData>> fetchAll({bool Function(String title)? where}) =>
      fetch(where: where).toList();
}

/// The A1 range that selects the whole sheet [title].
///
/// The title is always quoted and its apostrophes doubled (like
/// `cellRange` of `localize`): an unquoted title with spaces or one that
/// looks like a cell reference (`A1`) is not the sheet it names.
String sheetRange(String title) => "'${title.replaceAll("'", "''")}'";

/// Reads a spreadsheet through the Google Sheets API.
final class GoogleSheetSource implements SheetSource {
  /// Creates a source over an authenticated [api] for [spreadsheetId].
  ///
  /// [onClose] runs on [close] (e.g. closing the HTTP client).
  GoogleSheetSource({
    required this.api,
    required this.spreadsheetId,
    FutureOr<void> Function()? onClose,
    this.rangesPerRequest = 40,
  }) : _onClose = onClose;

  /// Authenticates with the service account key at [credentialsPath]
  /// (read-only scope) and returns a source for [spreadsheetId].
  static Future<GoogleSheetSource> connect({
    required String credentialsPath,
    required String spreadsheetId,
  }) async {
    final client = await createSheetsClient(
      credentialsPath,
      scopes: const [SheetsApi.spreadsheetsReadonlyScope],
    );
    return GoogleSheetSource(
      api: SheetsApi(client),
      spreadsheetId: spreadsheetId,
      onClose: client.close,
    );
  }

  /// Authenticated Sheets API client.
  final SheetsApi api;

  /// Spreadsheet ID.
  final String spreadsheetId;

  /// How many sheets are read per `values.batchGet` request.
  final int rangesPerRequest;

  final FutureOr<void> Function()? _onClose;

  @override
  String get description => 'Google spreadsheet $spreadsheetId';

  @override
  Stream<SheetData> fetch({bool Function(String title)? where}) async* {
    final Spreadsheet spreadsheet;
    try {
      spreadsheet = await api.spreadsheets.get(
        spreadsheetId,
        $fields: 'sheets.properties(sheetId,title)',
      );
    } on Object catch (e) {
      throw _translate(e, 'Cannot read the spreadsheet $spreadsheetId');
    }
    final titles = [
      for (final sheet in spreadsheet.sheets ?? const <Sheet>[])
        if (sheet.properties?.title case final String title
            when title.isNotEmpty && (where == null || where(title)))
          title,
    ];
    if ((spreadsheet.sheets ?? const <Sheet>[]).isEmpty) {
      throw SheetSourceException(
        'The spreadsheet $spreadsheetId has no sheets',
      );
    }
    for (var start = 0; start < titles.length; start += rangesPerRequest) {
      final chunk = titles.sublist(
        start,
        (start + rangesPerRequest).clamp(0, titles.length),
      );
      final BatchGetValuesResponse response;
      try {
        response = await api.spreadsheets.values.batchGet(
          spreadsheetId,
          ranges: [for (final title in chunk) sheetRange(title)],
          majorDimension: 'ROWS',
        );
      } on Object catch (e) {
        throw _translate(e, 'Cannot read the sheets of $spreadsheetId');
      }
      final ranges = response.valueRanges ?? const <ValueRange>[];
      if (ranges.length != chunk.length) {
        throw SheetSourceException(
          'The Sheets API returned ${ranges.length} ranges for '
          '${chunk.length} requested sheets',
        );
      }
      for (final (index, range) in ranges.indexed) {
        yield (
          title: chunk[index],
          values: [
            for (final row in range.values ?? const <List<Object?>>[])
              row.toList(),
          ],
        );
      }
    }
  }

  @override
  Future<void> close() async => _onClose?.call();

  SheetSourceException _translate(Object error, String context) {
    if (error is SheetSourceException) return error;
    if (error is DetailedApiRequestError) {
      final hint = switch (error.status) {
        403 => ' — share the spreadsheet with the service account e-mail '
            '(client_email in the credentials file) as a viewer',
        404 => ' — check the spreadsheet ID (--sheet)',
        _ => '',
      };
      return SheetSourceException(
        '$context: ${error.message ?? error}$hint',
        statusCode: error.status,
      );
    }
    return SheetSourceException('$context: $error');
  }
}

/// An authenticated HTTP client for the Sheets API from the service account
/// key at [credentialsPath]. Throws [SheetSourceException].
Future<AutoRefreshingAuthClient> createSheetsClient(
  String credentialsPath, {
  List<String> scopes = const [SheetsApi.spreadsheetsReadonlyScope],
}) async {
  final file = io.File(credentialsPath);
  if (!file.existsSync()) {
    throw SheetSourceException(
      'Credentials file not found: $credentialsPath '
      '(pass --credentials or set "credentials" in sheety.yaml)',
    );
  }
  final ServiceAccountCredentials credentials;
  try {
    final json = jsonDecode(await file.readAsString());
    credentials = ServiceAccountCredentials.fromJson(json);
  } on Object catch (e) {
    throw SheetSourceException(
      'Credentials file $credentialsPath is not a service account key: $e',
    );
  }
  try {
    return await clientViaServiceAccount(credentials, scopes);
  } on Object catch (e) {
    throw SheetSourceException('Cannot authenticate with Google: $e');
  }
}

/// Reads a JSON snapshot: `{"sheets": [{"title": "...", "values": [[...]]}]}`
/// (what `--dump-snapshot` / [writeSnapshot] write).
final class SnapshotSource implements SheetSource {
  /// Creates a source for the snapshot file at [path].
  const SnapshotSource(this.path);

  /// Path of the snapshot file.
  final String path;

  @override
  String get description => 'snapshot $path';

  @override
  Stream<SheetData> fetch({bool Function(String title)? where}) async* {
    final file = io.File(path);
    if (!file.existsSync()) {
      throw SheetSourceException('Snapshot file not found: $path');
    }
    final Object? json;
    try {
      json = jsonDecode(await file.readAsString());
    } on FormatException catch (e) {
      throw SheetSourceException('Snapshot $path is not valid JSON: '
          '${e.message}');
    }
    for (final sheet in parseSnapshot(json, path)) {
      if (where == null || where(sheet.title)) yield sheet;
    }
  }

  @override
  Future<void> close() async {}
}

/// Validates and converts decoded snapshot [json]; [name] is used in error
/// messages.
List<SheetData> parseSnapshot(Object? json, [String name = 'snapshot']) {
  Never fail(String what) =>
      throw SheetSourceException('Snapshot $name: $what (expected '
          '{"sheets": [{"title": "...", "values": [[...], ...]}]})');
  if (json is! Map<String, Object?>) fail('the root is not an object');
  final sheets = json['sheets'];
  if (sheets is! List<Object?>) fail('"sheets" is not a list');
  return [
    for (final (index, sheet) in sheets.indexed)
      if (sheet
          case {
            'title': final String title,
            'values': final List<Object?> values
          })
        (
          title: title,
          values: [
            for (final row in values)
              if (row is List<Object?>)
                row.toList()
              else
                fail('sheets[$index] ("$title") has a row that is not a list'),
          ],
        )
      else
        fail('sheets[$index] needs a string "title" and a list "values"'),
  ];
}

/// The snapshot JSON of [sheets] (one-space indentation, trailing newline;
/// deterministic for the same input).
String encodeSnapshot(Iterable<SheetData> sheets) =>
    '${const JsonEncoder.withIndent(' ').convert({
          'sheets': [
            for (final sheet in sheets)
              {'title': sheet.title, 'values': sheet.values},
          ],
        })}\n';

/// Writes [sheets] as a snapshot file to [path], creating parent
/// directories.
Future<void> writeSnapshot(String path, Iterable<SheetData> sheets) async {
  final file = io.File(path);
  await file.parent.create(recursive: true);
  await file.writeAsString(encodeSnapshot(sheets));
}
