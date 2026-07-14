/// Google Sheets implementation of [SheetsGateway].
library;

import 'package:googleapis/sheets/v4.dart';

import 'sheets.dart';
import 'utils.dart';

/// Reads and writes a Google spreadsheet through the Sheets API.
class GoogleSheetsGateway implements SheetsGateway {
  /// Creates a gateway over an authenticated [api] for the spreadsheet [id].
  GoogleSheetsGateway({required this.api, required this.id});

  /// Authenticated Sheets API client.
  final SheetsApi api;

  /// Spreadsheet ID.
  final String id;

  @override
  Stream<SheetData> fetch({List<RegExp> ignore = const []}) async* {
    $log('Fetching spreadsheet data...');
    final List<Sheet> sheets;
    try {
      sheets = (await api.spreadsheets.get(id)).sheets ?? const <Sheet>[];
    } on Object catch (e) {
      throw _translate(e, 'Error fetching spreadsheet data');
    }
    if (sheets.isEmpty)
      throw SheetsException('No sheets found in the spreadsheet with ID: $id');

    $log('Retrieving data from ${sheets.length} sheets...');
    for (final sheet in sheets) {
      final properties = sheet.properties;
      if (properties == null) {
        $err('Sheet properties are null, skipping sheet...');
        continue;
      }
      final SheetProperties(sheetId: sheetId, title: title) = properties;

      if (sheetId == null) {
        $err('Sheet ID is null, skipping sheet...');
        continue;
      } else if (title == null || title.isEmpty) {
        $err('Sheet title is null or empty, skipping sheet...');
        continue;
      } else if (ignore.any((pattern) => pattern.hasMatch(title))) {
        $log('Ignoring sheet "$title" as it matches ignore patterns');
        continue;
      }

      final List<List<Object?>>? values;
      try {
        values = (await api.spreadsheets.values.get(id, title)).values;
      } on Object catch (e) {
        throw _translate(e, 'Error reading sheet "$title"');
      }

      // Validate sheet values
      if (values == null || values.isEmpty) {
        $err('Sheet "$title" is empty, skipping sheet...');
        continue;
      } else if (values.length < 2) {
        $err('Sheet "$title" has no rows, skipping sheet...');
        continue;
      } else if (values.first.length < 4) {
        $err('Sheet "$title" has no localizations, skipping sheet...');
        continue;
      }

      yield (title: title, values: values);
    }
  }

  @override
  Future<void> write(List<SheetUpdate> updates) async {
    try {
      await api.spreadsheets.values.batchUpdate(
        BatchUpdateValuesRequest(
          valueInputOption: 'RAW',
          data: <ValueRange>[
            for (final update in updates)
              ValueRange(
                range: update.range,
                values: [
                  [update.value]
                ],
              ),
          ],
        ),
        id,
      );
    } on Object catch (e) {
      throw _translate(e, 'Error writing to the spreadsheet');
    }
  }

  /// Map a Sheets API failure onto the transport-agnostic [SheetsException],
  /// preserving the status code the retry policy is built on.
  SheetsException _translate(Object error, String context) => switch (error) {
        DetailedApiRequestError(:final status, :final message) =>
          SheetsException('$context: ${message ?? error}', statusCode: status),
        _ => SheetsException('$context: $error'),
      };
}
