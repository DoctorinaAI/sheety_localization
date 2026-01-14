// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:crypto/crypto.dart' as crypto show sha256;
import 'package:googleapis/people/v1.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:path/path.dart' as path;

final $log = io.stdout.writeln; // Log to stdout
final $err = io.stderr.writeln; // Log to stderr

/// Generate ARB files from Google Sheets
/// Usage: `dart run bin/generate.dart --credentials path/to/credentials.json --sheet spreadsheet-id --output path/to/output`
/// For more information, run `dart run bin/generate.dart --help`
/// Or compile and run the script directly: `dart compile exe bin/generate.dart -o localization.exe`
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
        final libDir = excludeQuotes(args.option('lib'));
        final arbDir = excludeQuotes(args.option('arb'));
        final genDir = excludeQuotes(args.option('gen'));
        final ignore = excludeQuotes(args.option('ignore'))
                ?.split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .map((e) => RegExp(e))
                .toList(growable: false) ??
            const [];
        final prefix = excludeQuotes(args.option('prefix')) ?? 'app';
        final header = excludeQuotes(args.option('header'));
        final format = args.flag('format');
        final includeEmpty = args.flag('include-empty');
        final includeLastModified = args.flag('last-modified');
        final meta = <String, String>{
          if (excludeQuotes(args.option('author')) case String author)
            '@@author': author,
          if (excludeQuotes(args.option('modified')) case String modified)
            if (includeLastModified) '@@last_modified': modified,
          if (excludeQuotes(args.option('comment')) case String comment)
            '@@comment': comment,
          if (excludeQuotes(args.option('context')) case String context)
            '@@context': context,
        };

        // Validate arguments
        if (credentialsPath == null ||
            sheetId == null ||
            libDir == null ||
            arbDir == null ||
            genDir == null) {
          $err('Missing required arguments. Use --help for usage information.');
          io.exit(1);
        }

        // Fetch spreadsheets from Google Sheets API
        $log('Generating localization table...');
        final sheets = fetchSpreadsheets(
          credentialsPath: credentialsPath,
          sheetId: sheetId,
          ignore: ignore,
        );

        // Generate localization table from the fetched sheets
        final buckets = await generateLocalizationTable(
          sheets,
          includeEmpty: includeEmpty,
        );
        if (buckets.isEmpty) {
          $err('No data found in the sheets');
          io.exit(1);
        }

        $log('Generating ARB files...');
        final arbs = await generateArbFiles(
          buckets: buckets,
          libDir: libDir,
          arbDir: arbDir,
          prefix: prefix,
          meta: meta,
        );
        if (arbs.isEmpty) {
          $log(
            'No new ARB files generated, '
            'nothing to do, exiting...',
          );
          io.exit(0);
        }

        $log('Generate Flutter localization files...');
        final files = await generateFlutterLocalization(
          arbs: arbs,
          libDir: libDir,
          genDir: genDir,
          prefix: prefix,
          header: header,
        );
        if (files.isEmpty) {
          $err('No localization files generated');
          io.exit(1);
        }

        final file = await generateFlutterLocalesFile(
          locales: buckets.locales,
          libDir: libDir,
          genDir: genDir,
        );

        $log('Generating batch file...');
        await generateLibraryFile(files: [...files, file], libDir: libDir);

        if (format) {
          $log('Formatting package...');
          await formatPackage(libDir: libDir);
        }

        $log(
          'Successfully generated localization table with '
          '${buckets.length} buckets',
        );
        io.exit(0);
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
    'lib',
    abbr: 'o',
    aliases: const <String>[
      'library',
      'output',
      'out',
      'output-dir',
      'localization',
      'out-dir',
    ],
    mandatory: false,
    defaultsTo: 'lib',
    valueHelp: 'path/to/output',
    help: 'Output directory for library barrel file (localization.dart)',
  )
  ..addOption(
    'arb',
    abbr: 'a',
    aliases: const <String>[
      'arbs',
      'l10n',
      'arb-dir',
      'arb-directory',
      'arb-dir-path',
      'arb-path',
    ],
    mandatory: false,
    defaultsTo: 'src/l10n',
    valueHelp: 'path/to/l10n',
    help: 'Output directory for ARB files, relative to the library directory',
  )
  ..addOption(
    'gen',
    abbr: 'g',
    aliases: const <String>[
      'generate',
      'generator',
      'gen-l10n',
      'generated',
      'classes',
    ],
    mandatory: false,
    defaultsTo: 'src/generated',
    valueHelp: 'path/to/generated',
    help: 'Output directory for generated localization classes, '
        'relative to the library directory',
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
    'author',
    aliases: const <String>['meta-author'],
    mandatory: false,
    valueHelp: 'author-name <name@domain.tld>',
    help: 'Author of the generated localization files',
  )
  ..addOption(
    'comment',
    aliases: const <String>['meta-comment'],
    mandatory: false,
    valueHelp: 'comment-text',
    help: 'Description of the generated localization files',
  )
  ..addOption(
    'modified',
    aliases: const <String>[
      'meta-modified',
      'modified-date',
      'last_modified',
      'timestamp',
      'date',
    ],
    mandatory: false,
    defaultsTo: DateTime.now().toUtc().toIso8601String(),
    valueHelp: '2025-06-04T12:30:00Z',
    help: 'Last modified date of the generated localization files, '
        'in ISO 8601 format (e.g. 2025-06-04T12:30:00Z)',
  )
  ..addOption(
    'context',
    aliases: const <String>['meta-context'],
    mandatory: false,
    valueHelp: '1.2.3',
    help: 'Context of the generated localization file',
  )
  ..addOption(
    'prefix',
    aliases: const <String>['arb-prefix', 'arb-file-prefix'],
    mandatory: false,
    defaultsTo: 'app',
    valueHelp: 'app',
    help: 'Prefix for the generated ARB files, e.g. "app" will generate '
        'files like "app_en.arb", "app_fr.arb" etc.',
  )
  ..addOption(
    'header',
    aliases: const <String>[
      'dart-header',
      'dart-header-comment',
      'dart-header-text',
      'file-header',
      'generated-header',
    ],
    mandatory: false,
    defaultsTo: '// This file is generated, do not edit it manually!',
    help: 'Header for the generated Dart files',
  )
  ..addFlag(
    'include-empty',
    aliases: const ['include-empty-strings', 'empty', 'keep-empty'],
    negatable: true,
    defaultsTo: false,
    help: 'Generate empty string values for missing translations. '
        'If false, missing translations are omitted (no key and no @meta).',
  )
  ..addFlag(
    'format',
    abbr: 'f',
    aliases: const <String>['dart-format', 'dartfmt', 'format-dart', 'fmt'],
    negatable: true,
    defaultsTo: true,
    help: 'Format the generated Dart files using `dart format`',
  )
  ..addFlag(
    'last-modified',
    aliases: const ['meta-last-modified'],
    negatable: true,
    defaultsTo: true,
    help: 'Include @@last_modified in generated ARB meta',
  );

/// Fetch spreadsheets from Google Sheets API
/// [credentialsPath] - Path to the service account credentials JSON file
/// [sheetId] - Google Spreadsheet ID
/// Returns a list of sheets and their values.
Stream<({Sheet sheet, List<List<Object?>> values})> fetchSpreadsheets({
  required String credentialsPath,
  required String sheetId,
  List<RegExp> ignore = const [],
}) async* {
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

/// Generate localization table from Google Sheets
/// [sheets] - List of sheets in the spreadsheet
Future<Buckets> generateLocalizationTable(
  Stream<({Sheet sheet, List<List<Object?>> values})> sheets, {
  bool includeEmpty = false,
}) async {
  final sanitize = Buckets.sanitizer();
  final buckets = Buckets.empty();

  void ignoreColumn(String key, Object value) {}

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

  await for (final (:sheet, :values) in sheets) {
    final bucket = sanitize(sheet.properties?.title ?? '');
    if (bucket.isEmpty) {
      $err(
        'Sheet '
        '"${sheet.properties?.sheetId ?? sheet.properties?.index ?? '???'}" '
        'title is empty, skipping sheet...',
      );
      continue;
    }
    //final data = sheet.data ?? [];
    final header = values.first;
    final $ = buckets.push(bucket);
    final locales = List.filled(
      header.length,
      (
        locale: '',
        push: ignoreColumn,
      ),
      growable: false,
    );

    // Fill locales
    for (var i = 3; i < header.length; i++) {
      final cell = header[i];
      switch (cell) {
        case String text when text.isNotEmpty:
          final locale = sanitize(text);
          locales[i] = (locale: locale, push: $(locale));
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

    // Add missing base locales
    final missingBaseLocales = <String>{};
    for (var i = 0; i < locales.length; i++) {
      final lcl = locales[i];
      // Ignore base and unrecognized locales
      if (lcl.locale.length < 4 || lcl.locale[2] != '_') continue;
      final baseLocale = lcl.locale.substring(0, 2);
      // Skip if base locale already fixed
      if (missingBaseLocales.contains(baseLocale)) continue;
      missingBaseLocales.add(baseLocale);
      $log('Sheet "$bucket" has missing base locale "$baseLocale", adding...');
      final basePush = $(baseLocale);
      final localePush = lcl.push;
      locales[i] = (
        locale: lcl.locale,
        push: (key, value) {
          // Add to the base locale
          basePush(key, value);
          // Add to the original locale
          localePush(key, value);
        }
      );
    }

    // Fill in data from the sheet, row by row, cell by cell
    for (var i = 1; i < values.length; i++) {
      final row = values[i];
      if (row.isEmpty) {
        $err('Sheet "$bucket" has empty row #${i + 1}, skipping row...');
        continue;
      }

      // If row has fewer cells than header/locales, Sheets API may have omitted trailing empties.
      // Default behaviour: skip such rows.
      // With includeEmpty=true: pad missing cells with nulls
      // so we can still generate existing translations.
      final List<Object?> normalizedRow;
      if (row.length == locales.length) {
        normalizedRow = row;
      } else if (row.length < locales.length) {
        if (!includeEmpty) {
          $err(
            'Sheet "$bucket" row #${i + 1} has missing locale columns '
            '(${row.length} < ${locales.length}), skipping row...',
          );
          continue;
        }
        normalizedRow = <Object?>[
          ...row,
          ...List<Object?>.filled(locales.length - row.length, null),
        ];
      } else {
        // Extra cells: keep only header-sized part
        normalizedRow = row.sublist(0, locales.length);
      }

      final [$label, $description, $meta, ..._] = normalizedRow;

      if ($label == null || $label is! String || $label.isEmpty) {
        $err(
          'Sheet "$bucket" has empty label in row #${i + 1}, skipping row...',
        );
        continue;
      }
      final label = sanitize($label);

      // Prepare meta data
      final meta = <String, Object?>{
        // Add description to meta if it is not empty
        if ($description case String description when description.isNotEmpty)
          'description': description,
      };

      // Add meta to the localization table if it is not empty
      switch ($meta) {
        case String text
            when text.isNotEmpty && text.startsWith('{') && text.endsWith('}'):
          try {
            final json = jsonDecode(text);
            if (json is! Map<String, Object?>) {
              $err('Sheet $bucket has invalid meta JSON in row #${i + 1}');
              break;
            }
            meta.addAll(json);
          } on Object {
            $err('Sheet $bucket has invalid meta JSON in row #${i + 1}');
          }
        case String text when text.isEmpty:
          break; // Ignore empty meta
        case String():
          $err('Sheet $bucket has unknown meta in row #${i + 1}');
        case Map<String, Object?> map:
          meta.addAll(map);
      }

      // Extract locales from the row
      for (var j = 3; j < normalizedRow.length; j++) {
        final cell = normalizedRow[j];
        final locale = locales[j];

        // TODO(plugfox): Add support for other types of cells
        // (e.g. booleans, DateTime, Formulas, JSON etc.)
        // Mike Matiunin <plugfox@gmail.com>, 03 April 2025
        switch (cell) {
          case String text when text.isNotEmpty:
            locale.push(label, text);
            locale.push('@$label', meta);
            break;

          case String() || null:
            // Missing translation:
            // do not generate key nor @meta for this locale.
            break;

          case num():
            locale.push(label, cell.toString());
            locale.push('@$label', meta);
            break;

          default:
            locale.push(label, cell.toString());
            locale.push('@$label', meta);
            break;
        }
      }
    }
  }

  return buckets;
}

/// Generate ARB files from the localization table
/// [buckets] - Localization table
/// [outputDir] - Output directory for ARB files
Future<List<io.File>> generateArbFiles({
  required Buckets buckets,
  String? libDir,
  String? arbDir,
  String? prefix,
  Map<String, String>? meta,
}) async {
  final libDirectory = switch (libDir) {
    String p when p.isNotEmpty => io.Directory(path.normalize(p)),
    String() || null => io.Directory.current,
  }
      .absolute;

  if (!libDirectory.existsSync()) {
    $log('Creating library directory: ${libDirectory.path}');
    await libDirectory.create(recursive: true);
  }

  final arbDirectory = switch (arbDir) {
    String p when p.isNotEmpty => io.Directory(
        path.join(libDirectory.path, path.normalize(p)),
      ),
    String() || null => io.Directory.current,
  };

  if (!arbDirectory.existsSync()) {
    $log('Creating arb directory: ${arbDirectory.path}');
    await arbDirectory.create(recursive: true);
  }

  final toDelete = arbDirectory
      .listSync(followLinks: true, recursive: true)
      .whereType<io.File>()
      .map((file) => file.path)
      .where((path) => path.endsWith('.arb'))
      .toSet();

  final files = <io.File>[];
  final iterator = buckets.encode(meta: meta).iterator;
  while (iterator.moveNext()) {
    final (:bucket, :locale, :bytes) = iterator.current;
    final fileName = '${prefix ?? 'app'}_$locale.arb';
    final filePath = path.normalize(
      path.join(arbDirectory.path, bucket, fileName),
    );
    final file = io.File(filePath);
    toDelete.remove(filePath);
    if (!file.parent.existsSync()) {
      $log('Creating directory: ${file.parent.path}');
      await file.parent.create(recursive: true);
    } else {
      if (file.existsSync() && file.lengthSync() == bytes.length) {
        // File exists and has the same length as the new bytes,
        // check if the content is the same using SHA-256 hash.
        final existingBytes = await file.readAsBytes();
        if (crypto.sha256.convert(existingBytes) ==
            crypto.sha256.convert(bytes)) {
          $log('Arb file already exists and is up to date: $filePath');
          continue;
        }
      }
    }
    await file.writeAsBytes(bytes, mode: io.FileMode.writeOnly, flush: true);
    if (!file.existsSync()) {
      $err('Failed to create file: $filePath');
      continue;
    }
    $log('Generated file: $filePath (${bytes.length} bytes)');
    files.add(file);
  }
  for (final file in toDelete) {
    $log('Deleting old file: $file');
    io.File(file).deleteSync(recursive: true);
  }
  return files;
}

/// Generate Flutter localization files from the arb files
/// flutter gen-l10n --no-synthetic-package \
///   --no-nullable-getter --template-arb-file=app_en.arb \
///   --arb-dir=lib/src/l10n/errors --output-dir=lib/src/generated/errors \
///   --output-localization-file=errors.dart --output-class=ErrorsLocalization
///
/// return a set of generated localization files.
Future<Set<String>> generateFlutterLocalization({
  required List<io.File> arbs,
  String? libDir,
  String? genDir,
  String? prefix,
  String? header,
}) async {
  final libDirectory = switch (libDir) {
    String p when p.isNotEmpty => io.Directory(path.normalize(p)),
    String() || null => io.Directory.current,
  }
      .absolute;

  if (!libDirectory.existsSync()) {
    $log('Creating library directory: ${libDirectory.path}');
    await libDirectory.create(recursive: true);
  }

  final genDirectory = switch (genDir) {
    String p when p.isNotEmpty => io.Directory(
        path.join(libDirectory.path, path.normalize(p)),
      ),
    String() || null => io.Directory.current,
  };

  final toDelete = <String>{};
  if (!genDirectory.existsSync()) {
    $log('Creating output directory: ${genDirectory.path}');
    await genDirectory.create(recursive: true);
  } else {
    toDelete.addAll(
      genDirectory
          .listSync(followLinks: false, recursive: true)
          .whereType<io.File>()
          .map((file) => file.absolute.path)
          .where((path) => path.endsWith('.dart')),
    );
  }

  /// Convert snake_case to PascalCase
  /// This is used to convert the bucket name to the class name
  String snakeToPascalCase(String snakeCase) => snakeCase
      .split('_')
      .map(
        (word) => (word.length < 2)
            ? word.toUpperCase()
            : word[0].toUpperCase() + word.substring(1).toLowerCase(),
      )
      .join('');

  final localizations = <String>{};

  final toGenerate = arbs.map((e) => e.parent.absolute.path).toSet();

  for (final dir in toGenerate) {
    final bucket = path.basename(dir);
    final genPath = path.normalize(path.join(genDirectory.path, bucket));
    if (!genPath.startsWith(libDirectory.path)) {
      $err('Gen path is outside of the library directory: $genPath');
      io.exit(1);
    }
    final genDir = io.Directory(genPath).absolute;
    if (!genDir.existsSync()) {
      $log('Creating directory: ${genDir.path}');
      await genDir.create(recursive: true);
    }
    final outputFile = '${bucket}_localization.dart';
    // flutter gen-l10n --help
    final process = await io.Process.start(
      'flutter',
      <String>[
        'gen-l10n',
        '--no-nullable-getter',
        // flutter config --explicit-package-dependencies
        //'--no-synthetic-package',
        '--template-arb-file=${prefix ?? 'app'}_en.arb',
        '--arb-dir=$dir',
        '--output-dir=${genDir.path}',
        '--output-localization-file=$outputFile',
        '--output-class=${snakeToPascalCase(bucket)}Localization',
        if (header case String value when value.isNotEmpty) '--header=$value',
        '--no-format',
      ],
      mode: io.ProcessStartMode.normal,
      includeParentEnvironment: true,
      runInShell: true,
      workingDirectory: io.Directory.current.absolute.path,
      environment: {},
    )
      ..stdout
          .transform(const Utf8Decoder(allowMalformed: true))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .listen($log)
      ..stderr
          .transform(const Utf8Decoder(allowMalformed: true))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .listen($err);
    if (await process.exitCode != 0) {
      $err('Error generating localization files for $bucket');
      io.exit(1);
    }
    $log('Generated localization files for "$bucket"');
    final file = io.File(
      path.normalize(path.join(genPath, outputFile)),
    ).absolute;
    if (!file.existsSync()) {
      $err('Generated file does not exist: ${file.path}');
      continue;
    }
    localizations.add(file.path);
    // Remove generated files from deletion list
    toDelete.removeWhere(
      (f) => f.startsWith(genDir.path) && f.endsWith('.dart'),
    );
  }

  for (final file in toDelete) {
    $log('Deleting old file: $file');
    io.File(file).deleteSync(recursive: true);
  }

  // Validate generated files
  if (localizations.length < toGenerate.length) {
    $err(
      'Not all localization files were generated, '
      'expected: ${toGenerate.length}, '
      'got: ${localizations.length}',
    );
    io.exit(1);
  }

  return localizations;
}

Future<String> generateFlutterLocalesFile({
  required Iterable<String> locales,
  String? libDir,
  String? genDir,
}) async {
  final libDirectory = switch (libDir) {
    String p when p.isNotEmpty => io.Directory(path.normalize(p)),
    String() || null => io.Directory.current,
  }
      .absolute;

  if (!libDirectory.existsSync()) {
    $log('Creating library directory: ${libDirectory.path}');
    await libDirectory.create(recursive: true);
  }

  final genDirectory = switch (genDir) {
    String p when p.isNotEmpty => io.Directory(
        path.join(libDirectory.path, path.normalize(p)),
      ),
    String() || null => io.Directory.current,
  };

  final file = io.File(
    path.join(genDirectory.path, 'locales.dart'),
  ).absolute;

  final buffer = StringBuffer()
    ..writeln('// This file is generated, do not edit it manually!')
    ..writeln('// ignore_for_file: directives_ordering')
    ..writeln()
    ..writeln('import \'dart:ui\' show Locale;')
    ..writeln()
    ..writeln('/// Supported locales for the application.')
    ..writeln('abstract final class Locales {')
    ..writeln('  const Locales._();')
    ..writeln('');

  final vars = <String>[];
  for (final lcl in locales) {
    final parts = lcl.split('_');
    final language = parts.first;
    if (language.isEmpty) continue;
    final country = parts.length > 1 ? parts.last : null;
    final field = country != null ? '$language\$$country' : language;
    buffer
      ..write('  static const Locale ')
      ..write(field)
      ..write(' = Locale(\'$language\'');
    if (country != null) {
      buffer.write(', \'$country\'');
    }
    buffer.writeln(');');
    vars.add(field);
  }
  buffer
    ..writeln()
    ..writeln('  static const List<Locale> values = [${vars.join(', ')}];')
    ..writeln('}');

  file.writeAsStringSync(
    buffer.toString(),
    mode: io.FileMode.writeOnly,
    flush: true,
  );

  return file.path;
}

/// Generate a library file for the localization files
/// to export all localization files
/// [files] - Set of localization files to export
Future<void> generateLibraryFile({
  required Iterable<String> files,
  String? libDir,
}) async {
  final libDirectory = switch (libDir) {
    String p when p.isNotEmpty => io.Directory(path.normalize(p)),
    String() || null => io.Directory.current,
  }
      .absolute;

  if (!libDirectory.existsSync()) {
    $log('Creating library directory: ${libDirectory.path}');
    await libDirectory.create(recursive: true);
  }

  const flutterLocalizations =
      'flutter_localizations/flutter_localizations.dart';
  final buffer = StringBuffer()
    ..writeln('// This file is generated, do not edit it manually!')
    ..writeln('// ignore_for_file: directives_ordering')
    ..writeln('library;')
    ..writeln()
    ..writeln('export \'package:$flutterLocalizations\';')
    ..writeln();
  for (final file in files) {
    final import = path
        .relative(file, from: libDirectory.path)
        .replaceAll(path.separator, '/');
    buffer.writeln('export \'$import\';');
  }
  final localizationBytes = utf8.encode(buffer.toString());

  final libraryFile = io.File(
    path.join(libDirectory.path, 'localization.dart'),
  );
  if (libraryFile.existsSync() &&
      libraryFile.lengthSync() == localizationBytes.length) {
    // File exists and has the same length as the new bytes,
    // check if the content is the same using SHA-256 hash.
    final existingBytes = await libraryFile.readAsBytes();
    if (crypto.sha256.convert(existingBytes) ==
        crypto.sha256.convert(localizationBytes)) {
      $log(
        'Library file already exists and is up to date: '
        '${libraryFile.path}',
      );
      return;
    }
  }
  await libraryFile.writeAsBytes(
    localizationBytes,
    mode: io.FileMode.writeOnly,
    flush: true,
  );
}

/// Format the package using dart format
Future<void> formatPackage({String? libDir}) async {
  final process = await io.Process.start(
    'dart',
    <String>['format', libDir ?? 'lib/'],
    mode: io.ProcessStartMode.normal,
    includeParentEnvironment: true,
    runInShell: true,
    workingDirectory: io.Directory.current.absolute.path,
    environment: {},
  )
    ..stdout
        .transform(const Utf8Decoder(allowMalformed: true))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .listen($log)
    ..stderr
        .transform(const Utf8Decoder(allowMalformed: true))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .listen($err);
  if (await process.exitCode != 0) {
    $err('Error formatting package');
    io.exit(1);
  }
}

/// Localization table
/// This class is used to store the localization table for the application
extension type Buckets._(
    Map<String, Map<String, Map<String, Object>>> _source) {
  /// Creates a new localization table from a list of buckets (sheets)
  Buckets(List<String> buckets)
      : _source = <String, Map<String, Map<String, Object>>>{
          for (final key in buckets) key: <String, Map<String, Object>>{},
        };

  /// Creates an empty localization table
  /// This constructor is used to create an empty localization table
  Buckets.empty() : _source = <String, Map<String, Map<String, Object>>>{};

  /// Check if the localization table is empty
  bool get isEmpty => _source.isEmpty;

  /// Check if the localization table is not empty
  bool get isNotEmpty => _source.isNotEmpty;

  /// Create sanitizer function to sanitize the localization table keys
  static String Function(String input) sanitizer() {
    final invalid = RegExp('[^a-zA-Z0-9_]');
    final merge = RegExp('_+');
    final trim = RegExp(r'^_+|_+$');
    return (String input) => input
        .replaceAll(invalid, '_') // replace invalid characters with _
        .replaceAll(merge, '_') // merge multiple _ into one
        .replaceAll(trim, ''); // remove leading and trailing _
  }

  /// Create a new record in the localization table
  /// bucket - The name of the sheet (bucket) in the spreadsheet
  /// locale - The locale (language) of the record
  /// key - The label (key) of the record
  /// value - The value of the record
  void Function(String key, Object value) Function(String) push(String bucket) {
    // Add the bucket if it doesn't exist
    final $ = _source.putIfAbsent(
      bucket,
      () => <String, Map<String, Object>>{},
    );
    return (String locale) {
      // Add the locale if it doesn't exist
      final $$ = $.putIfAbsent(locale, () => <String, Object>{});
      // Upsert the label and value in the localization table
      return (String key, Object value) => $$[key] = value;
    };
  }

  /// Bucket (sheet) count
  int get length => _source.length;

  /// Get the list of all buckets (sheets) in the localization table
  Set<String> get buckets => _source.keys.toSet();

  /// Get the set of all possible locales in the localization table
  Set<String> get locales => <String>{
        for (final locales in _source.values) ...locales.keys,
      };

  /// Human readable representation of the localization table
  String get representation {
    final buffer = StringBuffer();
    const String indent = '\u{00A0}'; // No breaking space
    for (final MapEntry(key: bucket, value: locales) in _source.entries) {
      buffer.writeln(bucket);
      for (final MapEntry(key: locale, value: values) in locales.entries) {
        buffer.writeln('${indent * 2}$locale');
        for (final MapEntry(key: label, value: value) in values.entries) {
          buffer.writeln('${indent * 4}$label: $value');
        }
      }
    }
    return buffer.toString();
  }

  /// Encode the localization table to JSON
  Iterable<({String bucket, String locale, List<int> bytes})> encode({
    Map<String, String>? meta,
  }) sync* {
    final encoder = const JsonEncoder.withIndent(
      '  ',
    ).fuse(const Utf8Encoder());
    for (final MapEntry(key: bucket, value: locales) in _source.entries)
      for (final MapEntry(key: locale, value: values) in locales.entries)
        yield (
          bucket: bucket,
          locale: locale,
          bytes: encoder.convert({'@@locale': locale, ...?meta, ...values}),
        );
  }
}

/// Help message for the command line arguments
const String $help = '''
Localization Generator

Generate ARB files from Google Sheets.
This script uses the Google Sheets API to fetch
the localization table from a spreadsheet and generates ARB files for localization.
You need to create a service account and download the credentials JSON file.
You can find more information about how to create a service account here:
https://cloud.google.com/docs/authentication/getting-started#creating_a_service_account

Usage: dart run bin/generate.dart [options]
''';
