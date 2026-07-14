// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:sheety_localization/sheety_localization.dart';

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
        // Parse a numeric option, telling the user when their value was not a
        // number or had to be clamped — a silent fallback to the default makes
        // a typo indistinguishable from an intentional omission.
        int number(String name, int fallback, int min, int max) {
          final raw = excludeQuotes(args.option(name));
          final value = raw == null ? fallback : int.tryParse(raw);
          if (value == null) {
            $err('Warning: --$name="$raw" is not a number, using $fallback');
            return fallback;
          }
          final clamped = value.clamp(min, max);
          if (clamped != value)
            $err('Warning: --$name=$value is out of range '
                '[$min..$max], using $clamped');
          return clamped;
        }

        final workers = number('workers', 6, 1, 14);
        final batch = number('batch', 3, 1, 20);
        final timeout = number('timeout', 120, 10, 900);
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
        final gateway = GoogleSheetsGateway(api: sheetsApi, id: sheetId);
        final List<SheetData> sheets;
        try {
          sheets = await gateway.fetch(ignore: ignore).toList();
        } on Object catch (e) {
          sheetsClient.close();
          $err('$e');
          io.exit(1);
        }

        if (sheets.isEmpty) {
          sheetsClient.close();
          $err('No valid sheets found to process.');
          io.exit(1);
        }

        // Create OpenAI client
        final client = OpenAIClient(
          apiKey: openaiApiKey,
          model: openaiModel ?? 'gpt-5-mini',
          workers: workers,
          systemPrompt: systemPrompt,
          timeout: Duration(seconds: timeout),
        );

        // Stay under the Google Sheets write quota (60 requests/min).
        final limiter = RateLimiter(maxRequestsPerMinute: 60);

        // Process each sheet
        $log('Processing ${sheets.length} sheets...');
        try {
          for (final (:title, :values) in sheets) {
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
              cellsPerBatch: batch,
            )) {
              if (row.isEmpty) continue;
              await updateRow(
                sheets: gateway,
                sheetTitle: title,
                row: row,
                limiter: limiter,
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
    mandatory: false,
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
