// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:googleapis/people/v1.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart' as path;

final $log = io.stdout.writeln; // Log to stdout
final $err = io.stderr.writeln; // Log to stderr

/// Localize Google Sheets with OpenAI API (ChatGPT)
void main(List<String>? $arguments) => runZonedGuarded<void>(
      () async {
        // Get command line arguments
        // If no arguments are provided, use the default values
        final parser = buildArgumentsParser();
        final args = parser.parse($arguments ?? []);
        if (args['help'] == true) {
          io.stdout
            ..writeln($help)
            ..writeln()
            ..writeln(parser.usage);
          io.exit(0);
        }

        String? excludeQuotes(String? input) {
          if (input == null || input.length < 2) return input;
          final Runes(:first, :last) = input.runes;
          if (first == 34 && last == 34) {
            return input.substring(1, input.length - 1);
          } else if (first == 39 && last == 39) {
            return input.substring(1, input.length - 1);
          } else {
            return input;
          }
        }

        $log('Reading command line arguments...');
        final credentialsPath = excludeQuotes(args.option('credentials'));
        final sheetId = excludeQuotes(args.option('sheet'));
        var openaiApiKey = excludeQuotes(args.option('token'));
        final openaiApiKeyFile = excludeQuotes(args.option('token-file'));
        final openaiModel = excludeQuotes(args.option('model'));
        final promptPath = excludeQuotes(args.option('prompt'));
        final ignore = excludeQuotes(args.option('ignore'))
                ?.split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .map((e) => RegExp(e))
                .toList(growable: false) ??
            const [];
        final workers =
            int.tryParse(excludeQuotes(args.option('workers')) ?? '6') ?? 6;
        String? systemPrompt;

        // Validate required arguments
        {
          if (sheetId == null || sheetId.isEmpty) {
            $err('Error: Missing required argument --sheet');
            io.exit(1);
          }
          if (openaiApiKeyFile != null && openaiApiKeyFile.isNotEmpty) {
            try {
              final file = io.File(openaiApiKeyFile);
              if (!file.existsSync()) {
                $err(
                  'Error: OpenAI API key file not found at $openaiApiKeyFile',
                );
                io.exit(1);
              }
              openaiApiKey = (await file.readAsString()).trim();
            } on Object catch (e) {
              $err('Error: Invalid OpenAI API key file path: $e');
              io.exit(1);
            }
          }
          if (openaiApiKey == null || openaiApiKey.isEmpty) {
            $err('Error: Missing required argument --token');
            io.exit(1);
          }
          if (credentialsPath == null || credentialsPath.isEmpty) {
            $err('Error: Missing required argument --credentials');
            io.exit(1);
          }
          if (!io.File(credentialsPath).existsSync()) {
            $err('Error: Credentials file not found at $credentialsPath');
            io.exit(1);
          }
          if (promptPath != null && promptPath.isNotEmpty) {
            if (!io.File(promptPath).existsSync()) {
              $err('Error: Prompt file not found at $promptPath');
              io.exit(1);
            }
            systemPrompt = await io.File(promptPath).readAsString();
          }
        }

        // Create Google Sheets API client
        $log('Creating Google Sheets API client...');
        final sheetsApi = await createSheetsApiClient(
          credentialsPath,
        );

        // Fetch spreadsheets from Google Sheets API
        $log('Generating localization table...');
        final sheets = await fetchSpreadsheets(
          sheetsApi: sheetsApi,
          sheetId: sheetId,
          ignore: ignore,
        ).toList();

        if (sheets.isEmpty) {
          $err('No valid sheets found to process.');
          io.exit(1);
        }

        // Create OpenAI client
        final client = OpenAIClient(
          apiKey: openaiApiKey,
          model: openaiModel ?? 'O3-MINI',
          workers: workers.clamp(1, 14),
          systemPrompt: systemPrompt,
        );

        // Process each sheet
        $log('Processing ${sheets.length} sheets...');
        for (final (:sheet, :values) in sheets) {
          final title = sheet.properties?.title ?? 'Unknown';
          $log('Processing sheet: $title');
          final rows = await extractEmptyCells(
            sheet: sheet,
            values: values,
          );
          if (rows.isEmpty) continue;

          $log('Found ${rows.length} rows to localize in sheet: $title');
          await for (final row in localizeRows(
            rows: rows,
            client: client,
          )) {
            if (row.isEmpty) continue;
            await updateSheet(sheetsApi, sheetId, row);
          }
        }
      },
      (error, stackTrace) {
        $err(error);
        io.exit(1);
      },
    );

/// Parse arguments
ArgParser buildArgumentsParser() => ArgParser()
  ..addFlag(
    'help',
    abbr: 'h',
    aliases: const <String>['readme', 'usage', 'info', 'howto'],
    negatable: false,
    defaultsTo: false,
    help: 'Print this usage information',
  )
  ..addOption(
    'credentials',
    abbr: 'c',
    aliases: const <String>['key', 'keyfile', 'cred', 'creds', 'secret'],
    mandatory: false,
    defaultsTo: 'credentials.json',
    valueHelp: 'path/to/credentials.json',
    help: 'Path to service account credentials JSON file',
  )
  ..addOption(
    'sheet',
    abbr: 's',
    aliases: const <String>[
      'sheet',
      'spreadsheet',
      'spreadsheet-id',
      'table',
      'source',
      'id',
    ],
    mandatory: true,
    valueHelp: 'spreadsheet-id',
    help: 'Google Spreadsheet ID',
  )
  ..addOption(
    'token',
    abbr: 't',
    aliases: const <String>[
      'chatgpt',
      'openai',
      'api',
      'apikey',
      'api-key',
    ],
    mandatory: false,
    valueHelp: '<your-api-key>',
    help: 'OpenAI API key (e.g. sk-...)',
  )
  ..addOption(
    'token-file',
    abbr: 'f',
    aliases: const <String>[
      'token-path',
      'chatgpt-file',
      'openai-file',
      'api-file',
      'apikey-file',
      'api-key-file',
    ],
    mandatory: false,
    valueHelp: '<your-api-key>',
    help: 'OpenAI API key (e.g. sk-...)',
  )
  ..addOption(
    'model',
    abbr: 'm',
    aliases: const <String>[
      'gpt',
      'gpt-model',
      'openai-model',
      'chatgpt-model',
      'localize-model',
      'llm',
    ],
    defaultsTo: 'O3-MINI',
    mandatory: false,
    valueHelp: 'model',
    help: 'OpenAI model to use (e.g. chatgpt-4)',
  )
  ..addOption(
    'ignore',
    abbr: 'i',
    aliases: const <String>[
      'ignore-table',
      'exclude',
      'skip',
      'ignore-patterns',
      'ignore-sheets',
      'exclude-sheets',
      'skip-sheets',
      'exclude-patterns',
      'skip-patterns',
    ],
    mandatory: false,
    defaultsTo: '',
    valueHelp: 'help, backend-.*, temp-.*',
    help: 'Comma-separated list of RegExp patterns to ignore sheets '
        'whose titles match any of the patterns',
  )
  ..addOption(
    'prompt',
    abbr: 'p',
    aliases: const <String>[
      'system',
      'instruction',
      'instructions',
      'localize-prompt',
      'chatgpt-prompt',
      'openai-prompt',
    ],
    mandatory: false,
    valueHelp: 'path/to/prompt.txt',
    help: 'Path to the system prompt file',
  )
  ..addOption(
    'workers',
    abbr: 'w',
    aliases: const <String>[
      'isolates',
      'isolate',
      'threads',
      'thread',
      'concurrency',
      'parallel',
      'parallelism'
    ],
    mandatory: false,
    defaultsTo: '6',
    valueHelp: 'number',
    help: 'Number of worker isolates to use',
  );

/// Help message for the command line arguments
const String $help = '''
Localization Generator

This script uses the OpenAI API to localize the content of a Google Sheet.
You need to provide the Google Spreadsheet ID and the path to the service account credentials JSON file.

Usage: dart run bin/localize.dart [options]
''';

/// Create Google Sheets API client
Future<SheetsApi> createSheetsApiClient(
  String credentialsPath,
) async {
  $log('Credentials path: $credentialsPath');
  final credentialsFile = io.File(credentialsPath);
  if (!credentialsFile.existsSync()) {
    $err('Credentials file not found: $credentialsPath');
    io.exit(1);
  }

  $log('Extracting credentials from file...');
  ServiceAccountCredentials credentials;
  try {
    final bytes = await credentialsFile.readAsBytes();
    final credentialsJson = const Utf8Decoder()
        .fuse(const JsonDecoder())
        .cast<List<int>, Map<String, Object?>>()
        .convert(bytes);
    credentials = ServiceAccountCredentials.fromJson(credentialsJson);
  } on Object catch (e) {
    $err('Error reading credentials file: $e');
    io.exit(1);
  }

  $log('Creating Google Sheets API client...');
  SheetsApi sheetsApi;
  try {
    final client = await clientViaServiceAccount(credentials, [
      SheetsApi.spreadsheetsReadonlyScope,
    ]);
    sheetsApi = SheetsApi(client);
  } on Object catch (e) {
    $err('Error creating Google Sheets API client: $e');
    io.exit(1);
  }
  return sheetsApi;
}

/// Fetch spreadsheets from Google Sheets API
/// [credentialsPath] - Path to the service account credentials JSON file
/// [sheetId] - Google Spreadsheet ID
/// Returns a list of sheets and their values.
Stream<({Sheet sheet, List<List<Object?>> values})> fetchSpreadsheets({
  required SheetsApi sheetsApi,
  required String sheetId,
  List<RegExp> ignore = const [],
}) async* {
  $log('Fetching spreadsheet data...');
  List<Sheet> sheets;
  try {
    final spreadsheet = await sheetsApi.spreadsheets.get(sheetId);
    sheets = spreadsheet.sheets ?? [];
  } on Object catch (e) {
    $err('Error fetching spreadsheet data: $e');
    io.exit(1);
  }
  if (sheets.isEmpty) {
    $err('No sheets found in the spreadsheet with ID: $sheetId');
    io.exit(1);
  }

  $log('Retrieving data from ${sheets.length} sheets...');
  for (final sheet in sheets) {
    final properties = sheet.properties;
    if (properties == null) {
      $err('Sheet properties are null, skipping sheet...');
      continue;
    }
    final SheetProperties(sheetId: id, title: title) = properties;

    // Check if the sheet title matches any of the ignore patterns
    if (id == null) {
      $err('Sheet ID is null, skipping sheet...');
      continue;
    } else if (title == null || title.isEmpty) {
      $err('Sheet title is null or empty, skipping sheet...');
      continue;
    } else if (ignore.any((pattern) => pattern.hasMatch(title))) {
      $log('Ignoring sheet "$title" as it matches ignore patterns');
      continue;
    }

    final ValueRange(:values) = await sheetsApi.spreadsheets.values.get(
      sheetId,
      title,
    );

    // Validate sheet values
    if (values == null) {
      $err('Sheet "$title" has no values, skipping sheet...');
      continue;
    } else if (values.isEmpty) {
      $err('Sheet "$title" is empty, skipping sheet...');
      continue;
    } else if (values.length < 2) {
      $err('Sheet "$title" has no rows, skipping sheet...');
      continue;
    } else if (values.first.length < 4) {
      $err('Sheet "$title" has no localizations, skipping sheet...');
      continue;
    }

    yield (sheet: sheet, values: values);
  }
}

/// Extract empty cells to be localized
/// [sheet] - The sheet to process
/// [values] - The values of the sheet
Future<List<LocalizeRow>> extractEmptyCells({
  required Sheet sheet,
  required List<List<Object?>> values,
}) async {
  final sanitize = sanitizer();

  String column(int index) {
    if (index < 0) throw ArgumentError('Index must be non-negative');
    var columnName = '';
    do {
      int remainder = index % 26;
      columnName = String.fromCharCode(65 + remainder) + columnName;
      index = (index / 26).floor() - 1; // ignore: parameter_assignments
    } while (index >= 0);
    return columnName;
  }

  final bucket = sanitize(sheet.properties?.title ?? '');
  if (bucket.isEmpty) {
    $err(
      'Sheet '
      '"${sheet.properties?.sheetId ?? sheet.properties?.index ?? '???'}" '
      'title is empty, skipping sheet...',
    );
    return const [];
  }

  final header = values.first;

  // Fill locales
  final locales = List.filled(header.length, '', growable: false);
  for (var i = 3; i < header.length; i++) {
    final cell = header[i];
    switch (cell) {
      case String text when text.isNotEmpty:
        final locale = sanitize(text);
        locales[i] = locale;
      case String _:
        $err(
          'Sheet "$bucket" has empty column [${column(i)}] in header, '
          'ignore the whole column...',
        );
        continue;
      default:
        $err(
          'Sheet "$bucket" has non-string column [${column(i)}] in header, '
          'ignore whole column...',
        );
        continue;
    }
  }

  // Process locales from the sheet, skipping empty ones
  final localize = <LocalizeRow>[];
  {
    final queue = Queue<LocalizeCell>();
    for (var i = 1; i < values.length; i++) {
      final row = values[i];
      if (row.isEmpty || row.every((cell) => cell == null) || row.length < 5) {
        $err('Sheet "$bucket" has empty row ${i + 1}, skipping row...');
        continue;
      }

      // Extract label, description, and meta from the row
      final [$label, $description, $meta, $english, ..._] = row;
      if ($label == null || $label is! String || $label.isEmpty) {
        $err(
          'Sheet "$bucket" has empty label in row #${i + 1}, '
          'skipping row...',
        );
        continue;
      }
      final label = sanitize($label);

      // Extract locales from the row
      for (var j = 4; j < locales.length; j++) {
        final cell = row.length > j ? row[j] : null;
        final locale = locales[j];
        if (locale.isEmpty) continue; // Skip empty locales
        switch (cell) {
          case null:
            queue.add(LocalizeCell(column: j, code: locale, text: ''));
          case String text when text.isNotEmpty:
            continue; // Already localized, skip
          case String():
            queue.add(LocalizeCell(column: j, code: locale, text: ''));
          case num():
          default:
            continue; // Skip non-string cells
        }
      }

      // Skip rows with no locales to localize
      if (queue.isEmpty) continue;
      localize.add(
        LocalizeRow(
          row: i,
          label: label,
          description: switch ($description) {
            String text when text.isNotEmpty => text,
            num number => number.toString(),
            _ => null,
          },
          meta: switch ($meta) {
            String text when text.isNotEmpty => text,
            num number => number.toString(),
            _ => null,
          },
          english: switch ($english) {
            String text when text.isNotEmpty => text,
            num number => number.toString(),
            _ => label,
          },
          cells: queue.toList(growable: false),
        ),
      );
      queue.clear();
    }
  }

  return localize;
}

/// Builds a strict prompt for a localization task.
/// - Comments are in English.
/// - Uses jsonEncode for safe inline JSON embedding.
/// - Uses StringBuffer with cascade operators for clarity and speed.
/// - Keeps soft-ish validation with explicit errors (same as original intent).
String buildLocalizationPrompt({
  required String label,
  required String en,
  required List<String> languages,
  String? description,
  String? meta,
}) {
  // -- helpers ---------------------------------------------------------------

  /// Return trimmed string or empty if null.
  String? safeStr(String? v) => v == null || v.isEmpty ? null : v.trim();

  /// Unique, order-preserving list of non-empty language codes.
  List<String> uniqLangs(Iterable<String> arr) =>
      List<String>.unmodifiable(LinkedHashSet<String>.from(
          arr.map(safeStr).whereType<String>().where((s) => s.isNotEmpty)));

  // -- unpack & normalize ----------------------------------------------------
  final normLabel = safeStr(label);
  final normDesc = safeStr(description);
  final normEn = safeStr(en);
  final langs = uniqLangs(languages);
  final metaObj = meta;
  final String? metaJson =
      metaObj == null ? null : jsonEncode(metaObj as Object);

  // -- validation (explicit) -------------------------------------------------
  if (normLabel == null) throw ArgumentError('Missing label');
  if (normEn == null) throw ArgumentError('Missing source English text');
  if (langs.isEmpty) throw ArgumentError('No target languages provided');

  // -- static schema block ---------------------------------------------------
  const schema = '{\n'
      '  "label": string,\n'
      '  "localization": {\n'
      '    <language_code>: { "text": string (non-empty) } '
      '(one entry per requested language, no extras)\n'
      '  }\n'
      '}';

  // -- output skeleton (use jsonEncode to safely embed strings) --------------
  final skeleton = StringBuffer()
    ..writeln('{')
    ..writeln('  "label": ${jsonEncode(normLabel)},')
    ..writeln('  "localization": {');
  for (var i = 0; i < langs.length; i++) {
    final key = jsonEncode(langs[i]); // safe quoted JSON key
    final comma = i == langs.length - 1 ? '' : ',';
    skeleton.writeln('    $key: { "text": "" }$comma');
  }
  skeleton
    ..writeln('  }')
    ..writeln('}');

  // -- prompt assembly -------------------------------------------------------
  final p = StringBuffer()
    ..writeln('You are a professional localization engine '
        'for a medical symptom-based advice chatbot.')
    ..writeln('Localize the item below into the target languages.')
    ..writeln('--- CONTEXT INPUT ---')
    ..writeln('label: $normLabel');
  if (normDesc != null) {
    p.writeln('description: $normDesc');
  }
  if (metaJson != null) {
    p.writeln('meta_placeholders (ICU / intl format): $metaJson');
  }
  p
    ..writeln('en_source: $normEn')
    ..writeln('target_languages: ${langs.join(', ')}')
    ..writeln('--- OUTPUT REQUIREMENTS ---')
    ..writeln(
        'Return ONLY valid minified JSON (no comments, no markdown fences).')
    ..writeln('Do NOT add explanatory text before or after JSON.')
    ..writeln('All requested languages MUST be present, no additional keys.')
    ..writeln('Preserve ICU/intl placeholders exactly '
        '(e.g., {name}, {version}, {count}).')
    ..writeln('Preserve HTML-like or XML-like tags verbatim if present.')
    ..writeln('Do not introduce new placeholders or variables.')
    ..writeln('If translation would be identical to English, '
        'repeat the English text.')
    ..writeln('Avoid adding periods if original does not have one; '
        'keep stylistic equivalence.')
    ..writeln('No leading/trailing spaces in values.')
    ..writeln('Each value MUST be culturally and medically appropriate, '
        'neutral and concise.')
    ..writeln('No quotes escaping beyond standard JSON string escaping.')
    ..writeln('--- JSON SCHEMA (informal) ---')
    ..writeln(schema)
    ..writeln('--- OUTPUT SKELETON (structure to follow) ---')
    ..writeln(skeleton.toString())
    ..writeln('--- RULES SUMMARY ---')
    ..writeln('1. Output only JSON.')
    ..writeln('2. Keys: label, localization.')
    ..writeln('3. localization contains exactly the target languages.')
    ..writeln('4. Each language object: {"text": "<translation>"}.')
    ..writeln('5. Do not include description, meta, or extra metadata fields.')
    ..writeln('6. Do not translate placeholders or modify their braces.')
    ..writeln('7. Keep punctuation style consistent with source.')
    ..writeln('8. Avoid hallucinating additional medical advice '
        'beyond the source meaning.')
    ..writeln('9. Keep resulting JSON compact (no unnecessary whitespace).')
    ..writeln('10. Use UTF-8 characters directly (no HTML entities).');

  return p.toString();
}

/// Localize rows using OpenAI API
/// [rows] - The rows to localize
/// [openaiApiKey] - OpenAI API key
/// [openaiModel] - OpenAI model to use
/// [workers] - Number of worker isolates to use
/// [systemPrompt] - Optional system prompt to guide the localization
Stream<LocalizeRow> localizeRows({
  required List<LocalizeRow> rows,
  required OpenAIClient client,
}) async* {
  for (final row in rows) {
    // Create user prompt:
    final prompt = buildLocalizationPrompt(
      label: row.label,
      en: row.english,
      description: row.description,
      meta: row.meta,
      languages: row.cells.map((e) => e.code).toList(growable: false),
    );
    final response = await client(prompt);
    debugger();
  }
}

class OpenAIClient {
  OpenAIClient({
    required this.apiKey,
    this.model = 'O3-MINI',
    this.workers = 6,
    this.retries = 3,
    this.systemPrompt,
  });

  final String apiKey;
  final String model;
  final int workers;
  final int retries;
  final String? systemPrompt;

  final Queue<Future<void> Function()> _taskQueue =
      Queue<Future<void> Function()>();

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  Future<String> _request(
      {required io.HttpClient client, required String prompt}) async {
    final request = await client.postUrl(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
    );
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('Authorization', 'Bearer $apiKey');
    final body = jsonEncode({
      'model': model,
      'messages': [
        if (systemPrompt != null) {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': prompt},
      ],
      'max_tokens': 2000,
      'temperature': 0.7,
    });
    request.add(utf8.encode(body));
    final response = await request.close();
    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      final data = jsonDecode(responseBody) as Map<String, Object?>;
      final choices = data['choices'] as List<Object?>?;
      if (choices != null && choices.isNotEmpty) {
        final message = (choices.first as Map<String, Object?>)['message']
            as Map<String, Object?>?;
        if (message != null) {
          final content = message['content'] as String?;
          if (content != null) {
            return content.trim();
          }
        }
      }
      throw Exception('Invalid response format from OpenAI API');
    } else {
      final errorBody = await response.transform(utf8.decoder).join();
      throw Exception(
        'OpenAI API error: ${response.statusCode} - $errorBody',
      );
    }
  }

  void _processQueue() {
    if (_isProcessing) return;
    if (_taskQueue.isEmpty) return;
    _isProcessing = true;
    Future<void>(() async {
      while (_taskQueue.isNotEmpty) {
        try {
          final task = _taskQueue.removeFirst();
          await task();
        } on Object {
          // Ignore errors in the queue processing
        }
      }
      _isProcessing = false;
    }).ignore();
  }

  Future<Map<String, Object?>> call(String prompt) async {
    final completer = Completer<Map<String, Object?>>();
    _taskQueue.add(() async {
      io.HttpClient client = io.HttpClient();
      try {
        for (var i = 0; i < retries; i++) {
          try {
            final response = await _request(client: client, prompt: prompt);
            if (jsonDecode(response) case Map<String, Object?> json) {
              completer.complete(json);
              return;
            }
            throw Exception('Invalid JSON response from OpenAI API');
          } on Object catch (e) {
            if (i == retries - 1) rethrow;
            $err('OpenAI API call failed (attempt ${i + 1}/$retries): $e');
            await Future<void>.delayed(const Duration(seconds: 1));
          }
        }
      } on Object catch (e, s) {
        if (!completer.isCompleted) completer.completeError(e, s);
        $err('OpenAI API call failed: $e');
      } finally {
        client.close();
      }
    });
    _processQueue();
    return completer.future;
  }
}

/// Update the Google Sheet with localized values
/// [api] - The Google Sheets API client
/// [sheetId] - The sheet to update
/// [rows] - The rows with localized values
Future<void> updateSheet(
  SheetsApi api,
  String sheetId,
  LocalizeRow row,
) async {
  if (row.isEmpty) return;
  debugger();
}

/// Represents a cell to be localized
class LocalizeCell {
  LocalizeCell({
    required this.column,
    required this.code,
    required this.text,
  });

  int column;
  String code;
  String text;
  bool get isEmpty => text.isEmpty;
}

/// Represents a row to be localized
class LocalizeRow {
  LocalizeRow({
    required this.row,
    required this.label,
    required this.description,
    required this.meta,
    required this.english,
    required this.cells,
  });

  int row;
  String label;
  String? description;
  String? meta;
  String english;
  List<LocalizeCell> cells;
  bool get isEmpty => cells.isEmpty;
}

/*
sheetsApi.spreadsheets.values.batchUpdate(
  BatchUpdateValuesRequest(
    data: <ValueRange>[
      ValueRange(
        range: 'A1:Z1',
        majorDimension: 'ROWS',
        values: [
          ['Header1', 'Header2', 'Header3', 'Locale1', 'Locale2']
        ],
      ),
    ],
    valueInputOption: 'RAW',
  ),
  sheetId,
); */

/// Create sanitizer function to sanitize the localization table keys
String Function(String input) sanitizer() {
  final invalid = RegExp('[^a-zA-Z0-9_]');
  final merge = RegExp('_+');
  final trim = RegExp(r'^_+|_+$');
  return (String input) => input
      .replaceAll(invalid, '_') // replace invalid characters with _
      .replaceAll(merge, '_') // merge multiple _ into one
      .replaceAll(trim, ''); // remove leading and trailing _
}
