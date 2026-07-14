// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:sheety_localization/localize.dart';

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
                .map(RegExp.new)
                .toList(growable: false) ??
            const <RegExp>[];
        final workers =
            int.tryParse(excludeQuotes(args.option('workers')) ?? '6') ?? 6;
        final batch =
            int.tryParse(excludeQuotes(args.option('batch')) ?? '3') ?? 3;
        final timeout =
            int.tryParse(excludeQuotes(args.option('timeout')) ?? '120') ?? 120;
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
        final (api: sheetsApi, client: sheetsClient) =
            await createSheetsApiClient(
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
          sheetsClient.close();
          $err('No valid sheets found to process.');
          io.exit(1);
        }

        // Create OpenAI client
        final client = OpenAIClient(
          apiKey: openaiApiKey,
          model: openaiModel ?? 'gpt-5-mini',
          workers: workers.clamp(1, 14),
          systemPrompt: systemPrompt,
          timeout: Duration(seconds: timeout.clamp(10, 900)),
        );

        // Process each sheet
        $log('Processing ${sheets.length} sheets...');
        try {
          for (final (:sheet, :values) in sheets) {
            final title = sheet.properties?.title ?? 'Unknown';
            $log('Processing sheet: $title');
            final rows = extractEmptyCells(
              title: title,
              values: values,
            );
            if (rows.isEmpty) continue;

            $log('Found ${rows.length} rows to localize in sheet: $title');
            await for (final row in localizeRows(
              rows: rows,
              client: client,
              cellsPerBatch: batch.clamp(1, 20),
            )) {
              if (row.isEmpty) continue;
              await updateSheet(
                api: sheetsApi,
                sheetId: sheetId,
                sheetTitle: title,
                row: row,
              );
            }
          }
          $log('Localization completed successfully '
              'for ${sheets.length} sheets.');
        } finally {
          // Close the auth client so its token-refresh timer and keep-alive
          // sockets are released and the process can exit.
          sheetsClient.close();
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
    defaultsTo: 'gpt-5-mini',
    mandatory: false,
    valueHelp: 'model',
    help: 'OpenAI model to use (e.g. gpt-5-mini)',
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
    'batch',
    abbr: 'b',
    aliases: const <String>[
      'batch-size',
      'languages-per-batch',
      'langs-per-batch',
    ],
    mandatory: false,
    defaultsTo: '3',
    valueHelp: 'number',
    help: 'Number of languages to translate per single API call',
  )
  ..addOption(
    'timeout',
    aliases: const <String>[
      'request-timeout',
      'openai-timeout',
      'deadline',
    ],
    mandatory: false,
    defaultsTo: '120',
    valueHelp: 'seconds',
    help: 'Hard timeout of a single OpenAI request, in seconds',
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
    help: 'Number of concurrent OpenAI requests',
  );

/// Help message for the command line arguments
const String $help = '''
Localization Generator

This script uses the OpenAI API to localize the content of a Google Sheet.
You need to provide the Google Spreadsheet ID and the path to the service account credentials JSON file.

Usage: dart run bin/localize.dart [options]
''';

/// Create Google Sheets API client
Future<({SheetsApi api, AutoRefreshingAuthClient client})>
    createSheetsApiClient(
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
  try {
    final client = await clientViaServiceAccount(credentials, [
      // SheetsApi.spreadsheetsReadonlyScope,
      SheetsApi.spreadsheetsScope,
    ]);
    return (api: SheetsApi(client), client: client);
  } on Object catch (e) {
    $err('Error creating Google Sheets API client: $e');
    io.exit(1);
  }
}

/// Fetch spreadsheets from Google Sheets API
/// [sheetsApi] - The Google Sheets API client
/// [sheetId] - Google Spreadsheet ID
/// [ignore] - Patterns of sheet titles to skip
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

/// Rate limiter for Google Sheets API calls
class RateLimiter {
  /// Creates a limiter allowing [maxRequestsPerMinute] calls per minute.
  RateLimiter({
    required this.maxRequestsPerMinute,
  }) : _requestTimes = <int>[];

  /// Maximum number of requests per rolling minute.
  final int maxRequestsPerMinute;
  final List<int> _requestTimes;
  final Stopwatch _stopwatch = Stopwatch()..start();

  /// Wait if necessary to respect rate limits
  Future<void> waitIfNeeded() async {
    final now = _stopwatch.elapsedMilliseconds;

    // Remove requests older than 1 minute
    _requestTimes.removeWhere((time) => now - time > 60000);

    // If we're at the limit, wait until we can make another request
    if (_requestTimes.length >= maxRequestsPerMinute) {
      final oldestRequest = _requestTimes.first;
      final waitTime = 60000 - (now - oldestRequest) + 100; // +100ms buffer
      if (waitTime > 0) {
        $log('Rate limit reached, waiting ${waitTime}ms...');
        await Future<void>.delayed(Duration(milliseconds: waitTime));
      }
      // Remove the oldest request after waiting
      _requestTimes.removeAt(0);
    }

    // Record this request
    _requestTimes.add(_stopwatch.elapsedMilliseconds);
  }
}

// Global rate limiter instance
final RateLimiter _sheetsRateLimiter = RateLimiter(maxRequestsPerMinute: 60);

/// Update the Google Sheet with localized values
/// [api] - The Google Sheets API client
/// [sheetId] - The sheet to update
/// [sheetTitle] - The title of the sheet
/// [row] - The row with localized values
Future<void> updateSheet({
  required SheetsApi api,
  required String sheetId,
  required String sheetTitle,
  required LocalizeRow row,
}) async {
  if (row.isEmpty) return;

  // Collect every non-empty cell into a single batch so the whole row is
  // written in ONE API request instead of one request per cell. This keeps us
  // well under the Google Sheets write quota (60 requests/min).
  final data = <ValueRange>[];
  for (final cell in row.cells) {
    if (cell.isEmpty) continue;
    data.add(
      ValueRange(
        range: '$sheetTitle!${columnFromIndex(cell.column)}${row.row + 1}',
        values: [
          [cell.text]
        ],
      ),
    );
  }
  if (data.isEmpty) return;

  const attempts = 3;
  for (var attempt = 1; attempt <= attempts; attempt++) {
    try {
      // Wait for rate limiter before making API call
      await _sheetsRateLimiter.waitIfNeeded();

      await api.spreadsheets.values.batchUpdate(
        BatchUpdateValuesRequest(
          valueInputOption: 'RAW',
          data: data,
        ),
        sheetId,
      );
      break; // Success, exit retry loop
    } on Object catch (e) {
      if (attempt == attempts) {
        // Do not abort the whole run because of one unwritable row.
        $err(
          'Error updating sheet "$sheetTitle" '
          'row [${row.row + 1}], skipping it: $e',
        );
        return;
      }
      $err(
        'Retrying update for sheet "$sheetTitle" '
        'row [${row.row + 1}] '
        '(attempt $attempt/$attempts) due to error: $e',
      );
      await Future<void>.delayed(const Duration(seconds: 30));
    }
  }
}
