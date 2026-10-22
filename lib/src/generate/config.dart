/// Configuration of `generate`: command-line arguments plus an optional
/// `sheety.yaml`; the command line overrides the file.
library;

import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'emitter.dart';
import 'reader.dart';
import 'writer.dart' show canonicalPath;

/// The default configuration file name, used when it exists in the working
/// directory and `--config` is not given.
const String defaultConfigFile = 'sheety.yaml';

/// The configuration is invalid: an unknown key, a wrong type, a removed
/// flag, a missing target. [message] says what to change.
final class ConfigException implements Exception {
  /// Creates a failure.
  const ConfigException(this.message);

  /// What is wrong and how to fix it.
  final String message;

  @override
  String toString() => message;
}

/// How diagnostics are printed.
enum DiagnosticsFormat {
  /// Grouped, human-readable text.
  text,

  /// One JSON document on stdout.
  json,

  /// GitHub Actions workflow commands (`::error ...`), plus the text.
  github;

  /// Looks a format up by name.
  static DiagnosticsFormat? byName(String name) {
    for (final f in values) if (f.name == name) return f;
    return null;
  }
}

/// Configuration of one output language.
final class TargetConfig {
  /// Creates a target configuration.
  const TargetConfig({
    required this.target,
    required this.output,
    this.include = const [],
    this.ignore = const [],
    this.header,
    this.options = const {},
  });

  /// The language.
  final Target target;

  /// Absolute output directory.
  final String output;

  /// When not empty, only sheets whose title matches one of these.
  final List<RegExp> include;

  /// Sheets whose title matches one of these are skipped (after [include]).
  final List<RegExp> ignore;

  /// Header text overriding [GenerateConfig.header] for this target.
  final String? header;

  /// Opaque emitter options (`EmitOptions.options`).
  final Map<String, Object?> options;

  /// Whether this target uses the sheet [title] (the global ignore list is
  /// applied by [GenerateConfig.selects]).
  bool selects(String title) =>
      (include.isEmpty || include.any((r) => r.hasMatch(title))) &&
      !ignore.any((r) => r.hasMatch(title));

  /// Copy with some fields replaced.
  TargetConfig copyWith({
    String? output,
    List<RegExp>? include,
    List<RegExp>? ignore,
    String? header,
    Map<String, Object?>? options,
  }) =>
      TargetConfig(
        target: target,
        output: output ?? this.output,
        include: include ?? this.include,
        ignore: ignore ?? this.ignore,
        header: header ?? this.header,
        options: options ?? this.options,
      );
}

/// Everything `generate` needs to run.
final class GenerateConfig {
  /// Creates a configuration. Paths must be absolute.
  const GenerateConfig({
    required this.targets,
    this.sheet,
    this.credentials,
    this.snapshot,
    this.dumpSnapshot,
    this.ignore = const [],
    this.mustache = const [],
    this.header = EmitOptions.defaultHeader,
    this.strict = false,
    this.check = false,
    this.format = true,
    this.includeEmpty = true,
    this.legacyRegionalOverride = false,
    this.verbose = false,
    this.diagnosticsFormat = DiagnosticsFormat.text,
    this.configFile,
  });

  /// Google spreadsheet ID (not needed with [snapshot]).
  final String? sheet;

  /// Service account key file (not needed with [snapshot]).
  final String? credentials;

  /// Read the sheets from this snapshot file instead of Google.
  final String? snapshot;

  /// Also write the sheets that were read to this snapshot file.
  final String? dumpSnapshot;

  /// Sheets whose title matches one of these are skipped by every target.
  final List<RegExp> ignore;

  /// Sheets whose title matches one of these use `{{name}}` placeholders
  /// instead of ICU.
  final List<RegExp> mustache;

  /// Header comment text of generated files (without comment markers).
  final String header;

  /// Treat warnings as errors.
  final bool strict;

  /// Write nothing; fail when the output is not up to date.
  final bool check;

  /// Format Dart output with `dart format`.
  final bool format;

  /// Missing trailing cells of a short row are empty translations (instead
  /// of skipping the row, as 0.6.0 did).
  final bool includeEmpty;

  /// 0.6.0 behaviour: a regional column (`ar_EG`) overwrites its language's
  /// column (`ar`).
  final bool legacyRegionalOverride;

  /// Log every file.
  final bool verbose;

  /// How diagnostics are printed.
  final DiagnosticsFormat diagnosticsFormat;

  /// Targets to generate, in [Target] order.
  final List<TargetConfig> targets;

  /// The `sheety.yaml` used, if any.
  final String? configFile;

  /// Reader options derived from this configuration.
  ReaderOptions get readerOptions => ReaderOptions(
        includeEmpty: includeEmpty,
        legacyRegionalOverride: legacyRegionalOverride,
        mustacheSheets: mustache,
      );

  /// Whether the global ignore list keeps the sheet [title].
  bool keeps(String title) => !ignore.any((r) => r.hasMatch(title));

  /// Whether [target] generates the sheet [title].
  bool selects(TargetConfig target, String title) =>
      keeps(title) && target.selects(title);

  /// Whether any target generates the sheet [title].
  bool anySelects(String title) => targets.any((t) => selects(t, title));

  /// Builds the configuration from command-line [args] and the optional
  /// YAML file. Relative CLI paths resolve against [workingDirectory]
  /// (default: the current directory), YAML paths against the YAML file's
  /// directory. Throws [ConfigException].
  factory GenerateConfig.fromArgs(
    ArgResults args, {
    String? workingDirectory,
  }) =>
      _build(args, p.normalize(p.absolute(workingDirectory ?? '.')));
}

// ---------------------------------------------------------------------------
// Command line
// ---------------------------------------------------------------------------

/// Options removed in 1.0.0 and what replaces them.
const Map<String, String> removedOptions = {
  'arb': 'ARB files are no longer generated: the Dart target emits the '
      'localization classes directly (no `flutter gen-l10n`). Remove --arb '
      'and delete the old ARB directory (e.g. lib/src/l10n).',
  'prefix': 'ARB files are no longer generated, so their file prefix has no '
      'effect. Remove --prefix.',
  'author': 'ARB metadata (@@author) is no longer produced. Remove --author; '
      'use --header (or "header:" in sheety.yaml) to put text into every '
      'generated file.',
  'comment': 'ARB metadata (@@comment) is no longer produced. Remove '
      '--comment; use --header to put text into every generated file.',
  'context': 'ARB metadata (@@context) is no longer produced. Remove '
      '--context; use --header to put text into every generated file.',
  'modified': 'ARB metadata (@@last_modified) is no longer produced; '
      'output is deterministic and carries no timestamps. Remove --modified.',
  'last-modified': 'ARB metadata (@@last_modified) is no longer produced; '
      'output is deterministic and carries no timestamps. Remove '
      '--[no-]last-modified.',
};

const _removedAliases = <String, List<String>>{
  'arb': [
    'arbs',
    'l10n',
    'arb-dir',
    'arb-directory',
    'arb-dir-path',
    'arb-path',
  ],
  'prefix': ['arb-prefix', 'arb-file-prefix'],
  'author': ['meta-author'],
  'comment': ['meta-comment'],
  'context': ['meta-context'],
  'modified': [
    'meta-modified',
    'modified-date',
    'last_modified',
    'timestamp',
    'date',
  ],
};

/// The argument parser of `generate`.
ArgParser generateArgParser() {
  final parser = ArgParser(usageLineLength: 80)
    ..addFlag(
      'help',
      abbr: 'h',
      aliases: const ['readme', 'usage', 'info', 'howto'],
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addOption(
      'config',
      valueHelp: 'sheety.yaml',
      help: 'Configuration file. Default: $defaultConfigFile in the '
          'current directory, if it exists. Command-line options override '
          'it.',
    )
    ..addSeparator('Input:')
    ..addOption(
      'sheet',
      abbr: 's',
      aliases: const ['spreadsheet', 'spreadsheet-id', 'table', 'source', 'id'],
      valueHelp: 'spreadsheet-id',
      help: 'Google spreadsheet ID.',
    )
    ..addOption(
      'credentials',
      abbr: 'c',
      aliases: const ['key', 'keyfile', 'cred', 'creds', 'secret'],
      valueHelp: 'credentials.json',
      help: 'Service account key (read-only access is enough). '
          'Default: credentials.json.',
    )
    ..addOption(
      'snapshot',
      valueHelp: 'sheets.json',
      help: 'Read the sheets from a snapshot file instead of Google '
          '(offline / CI). Format: {"sheets": [{"title": .., "values": '
          '[[..]]}]}.',
    )
    ..addOption(
      'dump-snapshot',
      valueHelp: 'sheets.json',
      help: 'Write the sheets that were read to a snapshot file. May be '
          'used without any target; not written with --check.',
    )
    ..addMultiOption(
      'ignore',
      abbr: 'i',
      aliases: const [
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
      valueHelp: '^help\$,^locales\$',
      splitCommas: false,
      help: 'RegExps (repeated, or comma-separated: a comma inside {}, [] '
          'or () or escaped as \\, does not split) of sheet titles skipped '
          'by every target.',
    )
    ..addMultiOption(
      'mustache',
      valueHelp: '^backend-',
      splitCommas: false,
      help: 'RegExps of sheet titles whose texts use {{name}} placeholders '
          'instead of ICU messages.',
    )
    ..addFlag(
      'include-empty',
      aliases: const ['include-empty-strings', 'empty', 'keep-empty'],
      defaultsTo: true,
      help: 'Treat the missing trailing cells of a short row as empty '
          'translations (they fall back). --no-include-empty skips such '
          'rows, like 0.6.0.',
    )
    ..addFlag(
      'legacy-regional-override',
      help: '0.6.0 behaviour: the first regional column of a language '
          '(ar_EG) overwrites the language column (ar).',
    )
    ..addSeparator('Targets (at least one):')
    ..addOption(
      'dart',
      valueHelp: 'dir',
      help: 'Generate Dart (Flutter) into this directory.',
    )
    ..addOption(
      'ts',
      aliases: const ['typescript'],
      valueHelp: 'dir',
      help: 'Generate TypeScript into this directory.',
    )
    ..addOption(
      'python',
      aliases: const ['py'],
      valueHelp: 'dir',
      help: 'Generate Python into this directory.',
    );
  for (final target in Target.values) {
    parser
      ..addMultiOption(
        '${target.id}-include',
        valueHelp: 'regexp',
        splitCommas: false,
        help: 'Only sheets matching these RegExps go to the ${target.id} '
            'target.',
      )
      ..addMultiOption(
        '${target.id}-ignore',
        valueHelp: 'regexp',
        splitCommas: false,
        help: 'Sheets matching these RegExps are skipped by the '
            '${target.id} target.',
      );
  }
  parser
    ..addMultiOption(
      'only',
      allowed: [for (final t in Target.values) t.id],
      help: 'Generate only these of the configured targets.',
    )
    ..addSeparator('Output:')
    ..addOption(
      'header',
      aliases: const [
        'dart-header',
        'dart-header-comment',
        'dart-header-text',
        'file-header',
        'generated-header',
      ],
      valueHelp: 'text',
      help: 'Header comment of every generated file (comment markers are '
          'added per language; a leading "// " is stripped). Empty: no '
          'header. Default: "${EmitOptions.defaultHeader}"',
    )
    ..addFlag(
      'format',
      abbr: 'f',
      aliases: const ['dart-format', 'dartfmt', 'format-dart', 'fmt'],
      defaultsTo: true,
      help: 'Format the Dart output with `dart format` (before comparing, '
          'so --check is stable).',
    )
    ..addFlag(
      'check',
      negatable: false,
      help: 'Write nothing; list added/changed/removed files and exit with '
          '1 when the output is not up to date.',
    )
    ..addFlag(
      'strict',
      help: 'Treat sheet warnings as errors.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Log every file and info diagnostics.',
    )
    ..addOption(
      'diagnostics-format',
      allowed: [for (final f in DiagnosticsFormat.values) f.name],
      defaultsTo: DiagnosticsFormat.text.name,
      allowedHelp: const {
        'text': 'Grouped human-readable report.',
        'json': 'One JSON document on stdout (logs go to stderr).',
        'github': 'GitHub Actions annotations (::error ...) plus the text.',
      },
      help: 'How diagnostics are printed.',
    )
    // 0.6.0 compatibility.
    ..addOption(
      'lib',
      abbr: 'o',
      aliases: const [
        'library',
        'output',
        'out',
        'output-dir',
        'localization',
        'out-dir',
      ],
      hide: true,
    )
    ..addOption(
      'gen',
      abbr: 'g',
      aliases: const [
        'generate',
        'generator',
        'gen-l10n',
        'generated',
        'classes',
      ],
      hide: true,
    );
  for (final MapEntry(:key) in removedOptions.entries) {
    if (key == 'last-modified') {
      parser.addFlag(key, aliases: const ['meta-last-modified'], hide: true);
    } else {
      parser.addOption(
        key,
        abbr: key == 'arb' ? 'a' : null,
        aliases: _removedAliases[key] ?? const [],
        hide: true,
      );
    }
  }
  return parser;
}

/// Dart emitter option that places the per-scope files under a
/// subdirectory of the output (0.6.0's `--gen`), keeping the barrel file in
/// the output root (0.6.0's `--lib`).
const String dartGeneratedDirOption = 'directory';

String? _unquote(String? input) {
  if (input == null || input.length < 2) return input;
  final first = input[0], last = input[input.length - 1];
  if ((first == '"' && last == '"') || (first == "'" && last == "'")) {
    return input.substring(1, input.length - 1);
  }
  return input;
}

/// Turns a `--header` value into header text: strips a leading `//` (and
/// one space) from every line; `\n` escapes become newlines.
String normalizeHeader(String raw) => raw
    .replaceAll(r'\n', '\n')
    .split('\n')
    .map((line) => line.startsWith('//')
        ? line.substring(line.startsWith('// ') ? 3 : 2)
        : line)
    .join('\n')
    .trimRight();

/// Splits a command-line list of RegExps at the commas that are not inside
/// `{}`, `[]` or `()` and not escaped as `\,` (which becomes `,`):
/// `^a{1,2}$,^b` -> `[^a{1,2}$, ^b]`.
List<String> splitRegExpList(String value) {
  final parts = <String>[];
  final current = StringBuffer();
  var depth = 0;
  var inClass = false;
  for (var i = 0; i < value.length; i++) {
    final c = value[i];
    if (c == r'\' && i + 1 < value.length) {
      final next = value[i + 1];
      if (next == ',') {
        current.write(',');
      } else {
        current
          ..write(c)
          ..write(next);
      }
      i++;
      continue;
    }
    if (inClass) {
      if (c == ']') inClass = false;
    } else if (c == '[') {
      inClass = true;
    } else if (c == '{' || c == '(') {
      depth++;
    } else if ((c == '}' || c == ')') && depth > 0) {
      depth--;
    } else if (c == ',' && depth == 0) {
      parts.add(current.toString());
      current.clear();
      continue;
    }
    current.write(c);
  }
  parts.add(current.toString());
  return parts;
}

List<RegExp> _regexps(Iterable<String> values, String where) => [
      for (final raw in [for (final v in values) ...splitRegExpList(v)])
        if (_unquote(raw.trim()) case final String s when s.isNotEmpty)
          () {
            try {
              return RegExp(s);
            } on FormatException catch (e) {
              throw ConfigException('$where: invalid RegExp "$s": '
                  '${e.message}');
            }
          }(),
    ];

GenerateConfig _build(ArgResults args, String cwd) {
  // Removed options first: they make every other message irrelevant.
  for (final MapEntry(:key, :value) in removedOptions.entries) {
    if (args.wasParsed(key)) {
      throw ConfigException('--$key was removed in 1.0.0. $value');
    }
  }
  if (args.rest.isNotEmpty) {
    throw ConfigException('Unexpected arguments: ${args.rest.join(' ')}');
  }

  String? option(String name) {
    final value = _unquote(args.option(name));
    return value == null || value.isEmpty ? null : value;
  }

  String cliPath(String value) => p.normalize(p.join(cwd, value));

  // YAML.
  String? configPath;
  if (option('config') case final String path) {
    configPath = cliPath(path);
    if (!io.File(configPath).existsSync()) {
      throw ConfigException('Configuration file not found: $configPath');
    }
  } else if (io.File(p.join(cwd, defaultConfigFile)).existsSync()) {
    configPath = p.join(cwd, defaultConfigFile);
  }
  final yaml =
      configPath == null ? _YamlConfig.empty() : _YamlConfig.load(configPath);

  // Targets: YAML, then CLI overrides.
  final targets = <Target, TargetConfig>{...yaml.targets};
  final libDir = option('lib'), genDir = option('gen');
  for (final target in Target.values) {
    final output = option(target.id);
    if (output != null) {
      final current = targets[target];
      targets[target] = current == null
          ? TargetConfig(target: target, output: cliPath(output))
          : current.copyWith(output: cliPath(output));
    }
  }
  if (libDir != null || genDir != null) {
    if (option('dart') != null) {
      throw const ConfigException(
        '--lib/--gen (0.6.0) and --dart cannot be combined. Use --dart=<lib> '
        'and set the "$dartGeneratedDirOption" option of the dart target in '
        'sheety.yaml.',
      );
    }
    final current = targets[Target.dart];
    final output = cliPath(libDir ?? 'lib');
    final options = {
      ...?current?.options,
      dartGeneratedDirOption: p.posix.normalize(genDir ?? 'src/generated'),
    };
    targets[Target.dart] = current == null
        ? TargetConfig(target: Target.dart, output: output, options: options)
        : current.copyWith(output: output, options: options);
  }
  for (final target in Target.values) {
    for (final kind in const ['include', 'ignore']) {
      final name = '${target.id}-$kind';
      if (!args.wasParsed(name)) continue;
      final current = targets[target];
      if (current == null) {
        throw ConfigException('--$name is given, but the ${target.id} target '
            'is not configured (--${target.id}=<dir> or targets.${target.id} '
            'in sheety.yaml)');
      }
      final patterns = _regexps(args.multiOption(name), '--$name');
      targets[target] = kind == 'include'
          ? current.copyWith(include: patterns)
          : current.copyWith(ignore: patterns);
    }
  }
  if (args.wasParsed('only')) {
    final only = {for (final id in args.multiOption('only')) Target.byId(id)};
    for (final target in only) {
      if (target != null && !targets.containsKey(target)) {
        throw ConfigException('--only=${target.id}, but the ${target.id} '
            'target is not configured');
      }
    }
    targets.removeWhere((t, _) => !only.contains(t));
  }

  // The input: a spreadsheet or a snapshot. The command line overrides the
  // file as a whole (--sheet replaces a snapshot: of the file and the other
  // way round); one layer giving both is ambiguous.
  final cliSnapshot = option('snapshot'), cliSheet = option('sheet');
  if (cliSnapshot != null && cliSheet != null) {
    throw const ConfigException(
      '--sheet and --snapshot cannot be combined: read either the '
      'spreadsheet or a snapshot (use --dump-snapshot to save what is read '
      'from the spreadsheet)',
    );
  }
  if (cliSnapshot == null &&
      cliSheet == null &&
      yaml.snapshot != null &&
      yaml.sheet != null) {
    throw ConfigException(
      '${yaml.file}: "sheet" and "snapshot" cannot both be set: read either '
      'the spreadsheet or a snapshot (use "dump_snapshot" to save what is '
      'read from the spreadsheet, or override one on the command line with '
      '--sheet / --snapshot)',
    );
  }
  final String? snapshot, sheet;
  if (cliSnapshot != null) {
    (snapshot, sheet) = (cliPath(cliSnapshot), null);
  } else if (cliSheet != null) {
    (snapshot, sheet) = (null, cliSheet);
  } else {
    (snapshot, sheet) = (yaml.snapshot, yaml.sheet);
  }
  final dumpSnapshot = option('dump-snapshot') != null
      ? cliPath(option('dump-snapshot')!)
      : yaml.dumpSnapshot;
  final credentials = option('credentials') != null
      ? cliPath(option('credentials')!)
      : yaml.credentials ?? cliPath('credentials.json');

  if (targets.isEmpty && dumpSnapshot == null) {
    throw ConfigException(
      'No target configured. Pass at least one of --dart=<dir>, --ts=<dir>, '
      '--python=<dir>${configPath == null ? '' : ', or add "targets:" to '
          '$configPath'} (or only --dump-snapshot=<file>).',
    );
  }
  if (snapshot == null && sheet == null) {
    throw const ConfigException(
      'No input: pass --sheet=<spreadsheet-id> (with --credentials) or '
      '--snapshot=<file>, or set "sheet:" in sheety.yaml.',
    );
  }
  if (snapshot != null &&
      dumpSnapshot != null &&
      p.equals(snapshot, dumpSnapshot)) {
    throw const ConfigException(
        '--snapshot and --dump-snapshot are the same file');
  }

  final ordered = [
    for (final t in Target.values)
      if (targets[t] case final TargetConfig c) c,
  ];
  // Compared canonically: `out` and `OUT` on a case-insensitive file system,
  // or a symbolic link to `out`, are the directory `out`.
  final canonical = {for (final t in ordered) t: canonicalPath(t.output)};
  for (final (i, a) in ordered.indexed) {
    for (final b in ordered.skip(i + 1)) {
      if (p.equals(canonical[a]!, canonical[b]!)) {
        throw ConfigException('Targets ${a.target.id} and ${b.target.id} '
            'have the same output directory ${a.output}'
            '${p.equals(a.output, b.output) ? '' : ' (${b.output} is the same '
                'directory, by a symbolic link or by case on a '
                'case-insensitive file system)'}; each target needs '
            'its own (it keeps a manifest of the files it owns there)');
      }
      for (final (outer, inner) in [(a, b), (b, a)]) {
        if (p.isWithin(canonical[outer]!, canonical[inner]!)) {
          throw ConfigException('The output directory of the '
              '${inner.target.id} target (${inner.output}) is inside the one '
              'of the ${outer.target.id} target (${outer.output}); the '
              'directories of two targets must not overlap (each owns its '
              'whole directory). Use sibling directories');
        }
      }
    }
  }

  bool flag(String name, bool? fromYaml) =>
      args.wasParsed(name) ? args.flag(name) : fromYaml ?? args.flag(name);

  final headerArg = args.option('header');
  return GenerateConfig(
    sheet: sheet,
    credentials: credentials,
    snapshot: snapshot,
    dumpSnapshot: dumpSnapshot,
    ignore: args.wasParsed('ignore')
        ? _regexps(args.multiOption('ignore'), '--ignore')
        : yaml.ignore,
    mustache: args.wasParsed('mustache')
        ? _regexps(args.multiOption('mustache'), '--mustache')
        : yaml.mustache,
    header: headerArg != null
        ? normalizeHeader(_unquote(headerArg)!)
        : yaml.header ?? EmitOptions.defaultHeader,
    strict: flag('strict', yaml.strict),
    check: args.flag('check'),
    format: flag('format', yaml.format),
    includeEmpty: flag('include-empty', yaml.includeEmpty),
    legacyRegionalOverride:
        flag('legacy-regional-override', yaml.legacyRegionalOverride),
    verbose: args.flag('verbose'),
    diagnosticsFormat:
        DiagnosticsFormat.byName(args.option('diagnostics-format')!)!,
    targets: ordered,
    configFile: configPath,
  );
}

// ---------------------------------------------------------------------------
// sheety.yaml
// ---------------------------------------------------------------------------

const _topKeys = {
  'sheet',
  'credentials',
  'snapshot',
  'dump_snapshot',
  'ignore',
  'syntax',
  'header',
  'strict',
  'format',
  'include_empty',
  'legacy_regional_override',
  'targets',
};
const _targetKeys = {'output', 'include', 'ignore', 'header', 'options'};
const _syntaxKeys = {'mustache'};

final class _YamlConfig {
  _YamlConfig.empty() : file = null;

  _YamlConfig.load(String this.file) {
    final Object? root;
    try {
      root = loadYaml(io.File(file!).readAsStringSync(),
          sourceUrl: Uri.file(file!));
    } on YamlException catch (e) {
      throw ConfigException('Invalid YAML in $file: ${e.message}\n'
          '${e.span?.highlight() ?? ''}');
    } on io.FileSystemException catch (e) {
      throw ConfigException('Cannot read $file: ${e.message}');
    }
    if (root == null) return; // empty file
    final map = _map(root, '');
    _checkKeys(map, _topKeys, '');
    sheet = _string(map, 'sheet', '');
    credentials = _path(map, 'credentials', '');
    snapshot = _path(map, 'snapshot', '');
    dumpSnapshot = _path(map, 'dump_snapshot', '');
    ignore = _patterns(map, 'ignore', '');
    header = _string(map, 'header', '', allowEmpty: true);
    if (header != null) header = normalizeHeader(header!);
    strict = _bool(map, 'strict', '');
    format = _bool(map, 'format', '');
    includeEmpty = _bool(map, 'include_empty', '');
    legacyRegionalOverride = _bool(map, 'legacy_regional_override', '');
    if (map['syntax'] case final Object syntax) {
      final s = _map(syntax, 'syntax');
      _checkKeys(s, _syntaxKeys, 'syntax.');
      mustache = _patterns(s, 'mustache', 'syntax.');
    }
    if (map['targets'] case final Object raw) {
      final t = _map(raw, 'targets');
      _checkKeys(
          t, {for (final target in Target.values) target.id}, 'targets.');
      for (final MapEntry(:key, :value) in t.entries) {
        final target = Target.byId(key)!;
        final where = 'targets.$key';
        final c = _map(value, where);
        _checkKeys(c, _targetKeys, '$where.');
        final output = _path(c, 'output', '$where.');
        if (output == null) {
          throw ConfigException('$file: $where.output is required (the '
              'directory the ${target.id} code is generated into)');
        }
        targets[target] = TargetConfig(
          target: target,
          output: output,
          include: _patterns(c, 'include', '$where.'),
          ignore: _patterns(c, 'ignore', '$where.'),
          header: switch (_string(c, 'header', '$where.', allowEmpty: true)) {
            final String h => normalizeHeader(h),
            null => null,
          },
          options: c['options'] == null
              ? const {}
              : (_plain(_map(c['options'], '$where.options'))!
                  as Map<String, Object?>),
        );
      }
    }
  }

  final String? file;
  String? sheet, credentials, snapshot, dumpSnapshot, header;
  bool? strict, format, includeEmpty, legacyRegionalOverride;
  List<RegExp> ignore = const [];
  List<RegExp> mustache = const [];
  final Map<Target, TargetConfig> targets = {};

  String get _dir => p.dirname(file!);

  Never _fail(String message) => throw ConfigException('$file: $message');

  Map<String, Object?> _map(Object? value, String where) {
    if (value is! Map) {
      _fail('${where.isEmpty ? 'the document' : where} must be a mapping');
    }
    final result = <String, Object?>{};
    for (final MapEntry(:key, :value) in value.entries) {
      if (key is! String) {
        _fail('${where.isEmpty ? '' : '$where: '}key $key is not a string');
      }
      result[key] = value;
    }
    return result;
  }

  void _checkKeys(
      Map<String, Object?> map, Set<String> allowed, String prefix) {
    for (final key in map.keys) {
      if (allowed.contains(key)) continue;
      final suggestion = _closest(key, allowed);
      _fail('unknown key "$prefix$key"'
          '${suggestion == null ? '' : ' (did you mean "$prefix$suggestion"?)'}'
          '; allowed: ${allowed.join(', ')}');
    }
  }

  String? _string(Map<String, Object?> map, String key, String prefix,
      {bool allowEmpty = false}) {
    final value = map[key];
    if (value == null) return null;
    if (value is! String || (!allowEmpty && value.isEmpty)) {
      _fail('$prefix$key must be a${allowEmpty ? '' : ' non-empty'} string');
    }
    return value;
  }

  String? _path(Map<String, Object?> map, String key, String prefix) {
    final value = _string(map, key, prefix);
    return value == null ? null : p.normalize(p.join(_dir, value));
  }

  bool? _bool(Map<String, Object?> map, String key, String prefix) {
    final value = map[key];
    if (value == null) return null;
    if (value is! bool) _fail('$prefix$key must be true or false');
    return value;
  }

  List<RegExp> _patterns(Map<String, Object?> map, String key, String prefix) {
    final value = map[key];
    if (value == null) return const [];
    final List<String> sources;
    if (value is String) {
      sources = [value];
    } else if (value is List && value.every((v) => v is String)) {
      sources = value.cast<String>();
    } else {
      _fail('$prefix$key must be a RegExp string or a list of them');
    }
    return [
      for (final s in sources)
        () {
          try {
            return RegExp(s);
          } on FormatException catch (e) {
            _fail('$prefix$key: invalid RegExp "$s": ${e.message}');
          }
        }(),
    ];
  }
}

/// Deep-converts YAML nodes into plain maps/lists/scalars.
Object? _plain(Object? value) => switch (value) {
      final Map<Object?, Object?> m => <String, Object?>{
          for (final MapEntry(:key, :value) in m.entries) '$key': _plain(value),
        },
      final List<Object?> l => [for (final v in l) _plain(v)],
      _ => value,
    };

String? _closest(String key, Iterable<String> candidates) {
  String? best;
  var bestDistance = 3; // suggest only close matches
  for (final c in candidates) {
    final d = _levenshtein(key, c);
    if (d < bestDistance) {
      bestDistance = d;
      best = c;
    }
  }
  return best;
}

int _levenshtein(String a, String b) {
  var previous = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    final current = List<int>.filled(b.length + 1, 0)..[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a[i - 1] == b[j - 1] ? 0 : 1;
      current[j] = [
        previous[j] + 1,
        current[j - 1] + 1,
        previous[j - 1] + cost,
      ].reduce((x, y) => x < y ? x : y);
    }
    previous = current;
  }
  return previous[b.length];
}
