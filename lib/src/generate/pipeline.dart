/// The `generate` pipeline: source -> per-target sheet selection -> reader
/// -> validation -> emitters -> (format) -> writer, plus the command-line
/// front end around it.
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart' show loadYaml;

import '../localize/sheets.dart' show SheetData;
import 'cldr/plural_rules.dart';
import 'config.dart';
import 'diagnostics.dart';
import 'emitter.dart';
import 'manifest.dart';
import 'model.dart';
import 'reader.dart';
import 'source.dart';
import 'targets.dart';
import 'validate.dart';
import 'writer.dart';

/// Exit code: success (and, with `--check`, the output is up to date).
const int exitOk = 0;

/// Exit code: `--check` found files to add, change or remove.
const int exitStale = 1;

/// Exit code: errors in the sheet, the output directory or the source.
const int exitErrors = 2;

/// Exit code: invalid command line or configuration file.
const int exitUsage = 64;

/// Formats generated source code in memory.
abstract interface class CodeFormatter {
  /// [files] with their contents formatted (same paths, same order), keeping
  /// lines within [pageWidth], in the style of the Dart [languageVersion]
  /// (`3.6`; `null` for the latest). Throws [FormatterException].
  Future<List<GeneratedFile>> format(
    List<GeneratedFile> files, {
    int pageWidth = 80,
    String? languageVersion,
  });
}

/// The formatter failed (not installed, or the code does not parse).
final class FormatterException implements Exception {
  /// Creates a failure.
  const FormatterException(this.message);

  /// What went wrong.
  final String message;

  @override
  String toString() => message;
}

/// Formats the `.dart` files with the Dart SDK's `dart format`, through a
/// temporary directory (the output directory is never touched, so `--check`
/// compares formatted code with formatted code).
final class DartFormatter implements CodeFormatter {
  /// Creates a formatter running [executable] (default: the running Dart
  /// VM when it is `dart`, otherwise `dart` from `PATH`).
  DartFormatter({String? executable})
      : executable = executable ?? _dartExecutable();

  /// The `dart` executable.
  final String executable;

  static String _dartExecutable() {
    final vm = io.Platform.resolvedExecutable;
    final name = p.basenameWithoutExtension(vm);
    return name == 'dart' ? vm : 'dart';
  }

  @override
  Future<List<GeneratedFile>> format(
    List<GeneratedFile> files, {
    int pageWidth = 80,
    String? languageVersion,
  }) async {
    final dart = [
      for (final f in files)
        if (f.relativePath.endsWith('.dart')) f,
    ];
    if (dart.isEmpty) return files;
    final temp = await io.Directory.systemTemp.createTemp('sheety_format_');
    try {
      for (final f in dart) {
        final file =
            io.File(p.joinAll([temp.path, ...f.relativePath.split('/')]));
        await file.parent.create(recursive: true);
        await file.writeAsString(f.contents);
      }
      final io.ProcessResult result;
      try {
        result = await io.Process.run(
          executable,
          [
            'format',
            '--output=write',
            '--summary=none',
            '--line-length=$pageWidth',
            // The temporary directory has no package config, so without it
            // `dart format` would use the latest style even for a package
            // whose SDK constraint selects the short (pre-3.7) style.
            '--language-version=${languageVersion ?? 'latest'}',
            '.',
          ],
          workingDirectory: temp.path,
        );
      } on io.ProcessException catch (e) {
        throw FormatterException('Cannot run `$executable format` '
            '(${e.message}); install the Dart SDK or pass --no-format');
      }
      if (result.exitCode != 0) {
        throw FormatterException('`dart format` failed on the generated code '
            '(exit ${result.exitCode}):\n${result.stderr}${result.stdout}');
      }
      final formatted = <String, String>{
        for (final f in dart)
          f.relativePath: await io.File(
            p.joinAll([temp.path, ...f.relativePath.split('/')]),
          ).readAsString(),
      };
      return [
        for (final f in files)
          switch (formatted[f.relativePath]) {
            final String c => GeneratedFile(f.relativePath, c),
            null => f,
          },
      ];
    } finally {
      await temp.delete(recursive: true);
    }
  }
}

/// The page width the Dart output of [target] is formatted to.
///
/// An explicit `page_width` (or `pageWidth`) target option wins. Otherwise
/// the `formatter: page_width:` of the nearest `analysis_options.yaml` in the
/// output directory or above it is used — the file `dart format` itself would
/// pick up when formatting the output in place — and 80 when there is none.
int resolveDartPageWidth(TargetConfig target) {
  for (final key in const ['page_width', 'pageWidth']) {
    if (target.options[key] case final int width) return width;
  }
  var dir = p.normalize(p.absolute(target.output));
  while (true) {
    final file = io.File(p.join(dir, 'analysis_options.yaml'));
    if (file.existsSync()) {
      try {
        if (loadYaml(file.readAsStringSync())
            case {'formatter': {'page_width': final int width}}) return width;
      } on Object {
        // An unreadable options file: `dart format` would fail on it too,
        // fall back to the default width.
      }
      return 80;
    }
    final parent = p.dirname(dir);
    if (parent == dir) return 80;
    dir = parent;
  }
}

/// The Dart language version `dart format` would use for the output of
/// [target] when run in place: the minimum SDK version (`major.minor`) of
/// `environment: sdk:` in the nearest `pubspec.yaml` in the output directory
/// or above it (as `pub` derives a package's language version), or `null`
/// (the latest version) when there is none or it has no lower bound.
String? resolveDartLanguageVersion(TargetConfig target) {
  var dir = p.normalize(p.absolute(target.output));
  while (true) {
    final file = io.File(p.join(dir, 'pubspec.yaml'));
    if (file.existsSync()) {
      try {
        if (loadYaml(file.readAsStringSync())
            case {'environment': {'sdk': final String sdk}}) {
          return minimumSdkLanguageVersion(sdk);
        }
      } on Object {
        // An unreadable pubspec: pub would fail too; use the latest.
      }
      return null;
    }
    final parent = p.dirname(dir);
    if (parent == dir) return null;
    dir = parent;
  }
}

/// The language version (`major.minor`) of the lower bound of an SDK
/// constraint (`>=3.6.0 <4.0.0`, `^3.6.0`, `3.6.0`), `null` when it has none.
String? minimumSdkLanguageVersion(String constraint) {
  final match = RegExp(r'(?:^|\s)(?:>=?|\^)?\s*(\d+)\.(\d+)\.\d+')
      .firstMatch(constraint.replaceAll(RegExp(r'<\S*'), ' '));
  if (match == null) return null;
  return '${match.group(1)}.${match.group(2)}';
}

/// The outcome for one target.
final class TargetResult {
  /// Creates a result.
  const TargetResult({
    required this.config,
    required this.scopes,
    this.plan,
    this.written = false,
    this.partial = false,
  });

  /// The target's configuration.
  final TargetConfig config;

  /// The scopes the target generated (or would generate).
  final List<String> scopes;

  /// The planned file operations; `null` when generation stopped earlier.
  final WritePlan? plan;

  /// Whether [plan] was applied: the files are on disk.
  final bool written;

  /// Whether writing [plan] failed half-way: some of its files are on disk.
  final bool partial;

  /// Copy marked as [written].
  TargetResult markWritten() =>
      TargetResult(config: config, scopes: scopes, plan: plan, written: true);

  /// Copy marked as [partial]ly written.
  TargetResult markPartial() =>
      TargetResult(config: config, scopes: scopes, plan: plan, partial: true);

  /// The target.
  Target get target => config.target;

  /// JSON form.
  Map<String, Object?> toJson() => {
        'target': target.id,
        'output': config.output,
        'scopes': scopes,
        'written': written,
        if (partial) 'partial': true,
        if (plan case final WritePlan plan) ...{
          'added': plan.added,
          'changed': plan.changed,
          'removed': plan.removed,
          'unchanged': plan.unchanged.length,
        },
      };
}

/// The outcome of [GeneratePipeline.run].
final class GenerateResult {
  /// Creates a result.
  const GenerateResult({
    required this.diagnostics,
    required this.issues,
    required this.targets,
    required this.check,
    this.written = false,
    this.sheets = 0,
    this.exitCodeOverride,
  });

  /// A result for a run that stopped before the pipeline (invalid usage or
  /// configuration, an unreadable source, an unexpected exception): only
  /// [issues], and the exit code [exitCode].
  const GenerateResult.failed(this.issues, {required int exitCode})
      : diagnostics = const [],
        targets = const [],
        check = false,
        written = false,
        sheets = 0,
        exitCodeOverride = exitCode;

  /// Sheet diagnostics (after `--strict`).
  final List<Diagnostic> diagnostics;

  /// Configuration, source, emitter and output problems.
  final List<GenerateIssue> issues;

  /// Per-target results.
  final List<TargetResult> targets;

  /// Whether this was a `--check` run.
  final bool check;

  /// Whether every target was written (see [TargetResult.written] for a
  /// write that failed half-way).
  final bool written;

  /// Number of sheets read.
  final int sheets;

  /// The exit code when it is not derived from the issues (e.g. 64 for
  /// invalid usage).
  final int? exitCodeOverride;

  /// Whether any diagnostic or issue is an error.
  bool get hasErrors =>
      diagnostics.any((d) => d.isError) || issues.any((i) => i.isError);

  /// Whether a `--check` run found differences.
  bool get isStale => check && targets.any((t) => t.plan?.hasChanges ?? false);

  /// The process exit code.
  int get exitCode =>
      exitCodeOverride ??
      (hasErrors
          ? exitErrors
          : isStale
              ? exitStale
              : exitOk);

  /// JSON form (for `--diagnostics-format=json`).
  Map<String, Object?> toJson() => {
        'ok': exitCode == exitOk,
        'exitCode': exitCode,
        'check': check,
        if (check) 'stale': isStale,
        'written': written,
        'summary': {
          for (final s in Severity.values)
            '${s.name}s': diagnostics.where((d) => d.severity == s).length +
                issues.where((i) => i.severity == s).length,
        },
        'targets': [for (final t in targets) t.toJson()],
        'issues': [for (final i in issues) i.toJson()],
        'diagnostics': [for (final d in diagnostics) d.toJson()],
      };
}

/// Runs generation for a [GenerateConfig].
final class GeneratePipeline {
  /// Creates a pipeline over the emitters of [registry].
  GeneratePipeline({
    required this.registry,
    CodeFormatter? dartFormatter,
    void Function(String line)? log,
    void Function(String line)? verbose,
  })  : dartFormatter = dartFormatter ?? DartFormatter(),
        _log = log ?? ((_) {}),
        _verbose = verbose ?? ((_) {});

  /// Available emitters.
  final TargetRegistry registry;

  /// Formats Dart output when `format` is on.
  final CodeFormatter dartFormatter;

  final void Function(String) _log;
  final void Function(String) _verbose;

  /// Reads [source] and generates (or, with `check`, compares) every target
  /// of [config]. Nothing is written when anything has an error.
  ///
  /// Writing is staged: the new files of every target are written to
  /// temporary files first, and only when all of them could be written are
  /// they moved into place (target by target, stale files deleted first,
  /// the manifest last). A failure while staging writes nothing; a failure
  /// while moving files into place (rare: the staged files are on the same
  /// file system) is reported with the targets that were completely written
  /// and the one that was left partly written.
  Future<GenerateResult> run(GenerateConfig config, SheetSource source) async {
    final issues = <GenerateIssue>[];
    GenerateResult done({
      List<Diagnostic> diagnostics = const [],
      List<TargetResult> targets = const [],
      bool written = false,
      int sheets = 0,
    }) =>
        GenerateResult(
          diagnostics: diagnostics,
          issues: issues,
          targets: targets,
          check: config.check,
          written: written,
          sheets: sheets,
        );

    // Emitters.
    final specs = <Target, TargetSpec>{};
    for (final t in config.targets) {
      final spec = registry[t.target];
      if (spec == null) {
        issues.add(GenerateIssue(
          'target-unavailable',
          'The ${t.target.id} target is not available in this version',
          target: t.target.id,
        ));
        continue;
      }
      specs[t.target] = spec;
      issues.addAll(_checkOptions(t, spec));
    }
    if (issues.any((i) => i.isError)) return done();

    // Source.
    final List<SheetData> sheets;
    try {
      _log('Reading ${source.description}...');
      sheets = await source.fetchAll(
        where: config.dumpSnapshot == null ? config.anySelects : null,
      );
    } on SheetSourceException catch (e) {
      issues.add(GenerateIssue('source-error', e.message));
      return done();
    } finally {
      await source.close();
    }
    if (config.dumpSnapshot case final String path) {
      if (config.check) {
        // --check writes nothing, not even the snapshot.
        _log('Not writing the snapshot $path (--check writes nothing)');
      } else {
        try {
          await writeSnapshot(path, sheets);
          _log('Wrote a snapshot of ${sheets.length} sheets to $path');
        } on io.FileSystemException catch (e) {
          issues.add(GenerateIssue(
            'snapshot-write',
            'Cannot write the snapshot $path: ${e.message}',
            path: path,
          ));
          return done(sheets: sheets.length);
        }
      }
    }
    if (config.targets.isEmpty) return done(sheets: sheets.length);

    // Reader + validation.
    final selected = [
      for (final s in sheets)
        if (config.anySelects(s.title)) s,
    ];
    _log('Read ${sheets.length} sheets, ${selected.length} used by '
        '${config.targets.map((t) => t.target.id).join(', ')}');
    final read = readCatalog(selected, options: config.readerOptions);
    var diagnostics = [
      ...read.diagnostics,
      ...validateCatalog(read.catalog),
    ];
    final catalogs = <Target, Catalog>{};
    for (final t in config.targets) {
      final catalog =
          read.catalog.where((s) => config.selects(t, s.sheetTitle));
      catalogs[t.target] = catalog;
      if (catalog.scopes.isEmpty) {
        issues.add(GenerateIssue(
          'no-scopes',
          'The ${t.target.id} target selects no localization sheet; check '
              'its include/ignore patterns and the global ignore list',
          target: t.target.id,
        ));
        continue;
      }
      final spec = specs[t.target]!;
      diagnostics.addAll(spec.validate?.call(catalog, t.options) ??
          validateIdentifiers(catalog, t.target, reserved: spec.reserved));
    }
    diagnostics.addAll(pluralRulesMismatches(catalogs));
    if (config.strict) diagnostics = applyStrict(diagnostics);
    List<TargetResult> pending() => [
          for (final t in config.targets)
            TargetResult(
              config: t,
              scopes: [for (final s in catalogs[t.target]!.scopes) s.name],
            ),
        ];
    if (diagnostics.any((d) => d.isError) || issues.any((i) => i.isError)) {
      return done(
        diagnostics: diagnostics,
        targets: pending(),
        sheets: sheets.length,
      );
    }

    // Emit + plan.
    final results = <TargetResult>[];
    for (final t in config.targets) {
      final spec = specs[t.target]!;
      final catalog = catalogs[t.target]!;
      // `dart format` run in place (as 0.6.0 did) honours the page width and
      // the language version of the enclosing package; formatting in a
      // temporary directory does not, so resolve them here and hand them to
      // the emitter and the formatter.
      final pageWidth =
          t.target == Target.dart ? resolveDartPageWidth(t) : null;
      final options = EmitOptions(
        header: t.header ?? config.header,
        options: {
          ...t.options,
          if (pageWidth != null) 'page_width': pageWidth,
        },
      );
      List<GeneratedFile> files;
      try {
        files = spec.create().emit(catalog, options);
      } on Object catch (e, s) {
        issues.add(GenerateIssue(
          'emitter-failed',
          'The ${t.target.id} emitter failed: $e\n$s',
          target: t.target.id,
        ));
        continue;
      }
      if (t.target == Target.dart && config.format) {
        try {
          files = await dartFormatter.format(
            files,
            pageWidth: pageWidth ?? 80,
            languageVersion: resolveDartLanguageVersion(t),
          );
        } on FormatterException catch (e) {
          issues.add(
              GenerateIssue('format-failed', e.message, target: t.target.id));
          continue;
        }
      }
      // A file "looks generated" when it carries a whole header as a
      // comment (not just its first line, which may be a common word).
      final writer = OutputWriter(
        markers: {
          EmitOptions.defaultHeader,
          if (config.header.isNotEmpty) config.header,
          if (t.header case final String h when h.isNotEmpty) h,
        }.toList(),
        looksGenerated: spec.legacyFile,
      );
      final plan = writer.plan(
        outputDir: t.output,
        files: files,
        manifest: Manifest.build(t.target, catalog, files),
        target: t.target.id,
      );
      issues.addAll(plan.issues);
      results.add(TargetResult(
        config: t,
        scopes: [for (final s in catalog.scopes) s.name],
        plan: plan,
      ));
    }
    if (issues.any((i) => i.isError)) {
      return done(
        diagnostics: diagnostics,
        targets: results,
        sheets: sheets.length,
      );
    }

    for (final r in results) {
      final plan = r.plan!;
      for (final a in plan.actions) {
        if (a.change == FileChange.unchanged) continue;
        _verbose('  ${r.target.id}: ${_symbol(a.change)} ${a.path}'
            '${a.adopted ?? false ? ' (taken over)' : ''}');
      }
    }
    if (config.check) {
      return done(
        diagnostics: diagnostics,
        targets: results,
        sheets: sheets.length,
      );
    }
    try {
      const OutputWriter().applyAll([for (final r in results) r.plan!]);
    } on WriteFailure catch (e) {
      final written = {for (final dir in e.written) p.normalize(dir)};
      final byDir = {
        for (final r in results) p.normalize(r.plan!.outputDir): r.target.id,
      };
      final writtenIds = [for (final dir in e.written) byDir[dir] ?? dir];
      final partial = e.partial == null
          ? null
          : byDir[p.normalize(e.partial!)] ?? e.partial;
      final cause = e.cause;
      final os = cause.osError == null ? '' : ' (${cause.osError})';
      issues.add(GenerateIssue(
        'write-failed',
        'Cannot write ${cause.path ?? e.partial ?? 'the output'}: '
            '${cause.message}$os. '
            '${switch ((writtenIds.isEmpty, partial)) {
          (true, null) => 'Nothing was written.',
          (false, null) => 'Written completely: ${writtenIds.join(', ')}; '
              'the other targets were not written.',
          (true, final String t) => 'The $t target was left partly written; '
              'the other targets were not written. Run generate again.',
          (false, final String t) =>
            'Written completely: ${writtenIds.join(', ')}; the $t target was '
                'left partly written. Run generate again.',
        }}',
        target: partial,
        path: cause.path,
      ));
      return done(
        diagnostics: diagnostics,
        targets: [
          for (final r in results)
            if (written.contains(p.normalize(r.plan!.outputDir)))
              r.markWritten()
            else if (e.partial != null &&
                p.equals(e.partial!, r.plan!.outputDir))
              r.markPartial()
            else
              r,
        ],
        sheets: sheets.length,
      );
    }
    return done(
      diagnostics: diagnostics,
      targets: [for (final r in results) r.markWritten()],
      written: true,
      sheets: sheets.length,
    );
  }

  /// Unknown keys and values of the wrong kind in the `options:` of [t].
  List<GenerateIssue> _checkOptions(TargetConfig t, TargetSpec spec) {
    final known = spec.options;
    if (known == null) return const [];
    final issues = <GenerateIssue>[];
    for (final MapEntry(:key, :value) in t.options.entries) {
      final kind = known[key];
      if (kind == null) {
        issues.add(GenerateIssue(
          'unknown-option',
          known.isEmpty
              ? 'Unknown option "$key": the ${t.target.id} target has no '
                  'options'
              : 'Unknown option "$key" of the ${t.target.id} target; '
                  'known: ${(known.keys.toList()..sort()).join(', ')}',
          target: t.target.id,
        ));
      } else if (!kind.accepts(value)) {
        issues.add(GenerateIssue(
          'invalid-option',
          'Option "$key" of the ${t.target.id} target must be '
              '${kind.description}, not ${_describe(value)}',
          target: t.target.id,
        ));
      }
    }
    return issues;
  }
}

String _describe(Object? value) => switch (value) {
      null => 'null',
      final String s => 'the string "$s"',
      final Object o => '${o.runtimeType} $o',
    };

/// `plural-rules-mismatch` warnings: when the Dart target and the
/// TypeScript or Python target generate the same scope, a locale whose
/// plural rules package:intl lacks (Scottish Gaelic `gd`, Manx `gv`,
/// Cornish `kw`, ...; see [intlMissingPluralLocales]) renders its plurals
/// differently in Dart (every count is `other`) than in the other targets
/// (CLDR rules). One warning per scope and locale that has plurals.
List<Diagnostic> pluralRulesMismatches(Map<Target, Catalog> catalogs) {
  final dart = catalogs[Target.dart];
  if (dart == null) return const [];
  final others = [
    for (final t in const [Target.ts, Target.python])
      if (catalogs[t] case final Catalog c) (t, c),
  ];
  if (others.isEmpty) return const [];
  final sink = DiagnosticSink();
  for (final scope in dart.scopes) {
    final alongside = [
      for (final (t, c) in others)
        if (c.scopes.any((s) => s.name == scope.name)) t.id,
    ];
    if (alongside.isEmpty) continue;
    for (final locale in scope.localeTags) {
      if (!intlLacksPluralRules(locale.code)) continue;
      final keys = [
        for (final m in scope.messages)
          if (m.translationFor(locale).ast.plurals.isNotEmpty) m.key,
      ];
      if (keys.isEmpty) continue;
      sink.report(
        DiagnosticCode.pluralRulesMismatch,
        'package:intl has no plural rules for "${locale.code}": the dart '
        'target renders every count without an exact =0/=1/=2 match as '
        '"other", while ${alongside.join(' and ')} use the CLDR rules '
        '(${pluralRulesFor(locale.code).categories.map((c) => c.name).join(
              ' ',
            )}), '
        'so ${keys.length} plural message(s) can differ between the targets: '
        '${keys.take(5).join(', ')}${keys.length > 5 ? ', ...' : ''}',
        scope: scope.name,
        sheetTitle: scope.sheetTitle,
        column: scope.locale(locale)?.column,
        locale: locale.code,
      );
    }
  }
  return sink.diagnostics;
}

String _symbol(FileChange change) => switch (change) {
      FileChange.added => '+',
      FileChange.changed => '~',
      FileChange.removed => '-',
      FileChange.unchanged => '=',
    };

// ---------------------------------------------------------------------------
// Reporting
// ---------------------------------------------------------------------------

/// Human-readable report of [result]: issues, diagnostics (infos only when
/// [verbose]) and one summary line per target.
String formatResultText(GenerateResult result, {bool verbose = false}) {
  final buffer = StringBuffer();
  final shown = result.diagnostics
      .where((d) => verbose || d.severity != Severity.info)
      .toList();
  if (shown.isNotEmpty) {
    buffer.writeln(formatDiagnostics(shown).trimRight());
  }
  for (final issue in result.issues) {
    if (!verbose && issue.severity == Severity.info) continue;
    buffer.writeln(issue);
  }
  for (final t in result.targets) {
    final plan = t.plan;
    final head = '${t.target.id}: ${t.scopes.length} scope(s) -> '
        '${t.config.output}';
    if (plan == null) {
      buffer.writeln('$head (not generated)');
      continue;
    }
    // Only a target that was written reports its changes as done.
    final counts = t.written
        ? '${plan.added.length} added, ${plan.changed.length} changed, '
            '${plan.removed.length} removed, ${plan.unchanged.length} '
            'unchanged'
        : 'would add ${plan.added.length}, change ${plan.changed.length}, '
            'remove ${plan.removed.length}; ${plan.unchanged.length} '
            'unchanged';
    if (result.check) {
      buffer.writeln('$head: ${plan.hasChanges ? 'OUT OF DATE' : 'up to date'}'
          ' ($counts)');
      for (final path in plan.added) buffer.writeln('  + $path');
      for (final path in plan.changed) buffer.writeln('  ~ $path');
      for (final path in plan.removed) buffer.writeln('  - $path');
    } else {
      buffer.writeln('$head ($counts)${t.written ? '' : t.partial ? ' - '
          'partly written' : ' - not written'}');
    }
  }
  final writtenIds = [
    for (final t in result.targets)
      if (t.written) t.target.id,
  ];
  final partialIds = [
    for (final t in result.targets)
      if (t.partial) t.target.id,
  ];
  final verdict = switch (result.exitCode) {
    exitOk when result.check => 'Generated code is up to date.',
    exitOk when result.written => 'Done.',
    exitOk => 'Done (nothing generated).',
    exitStale => 'Generated code is out of date: run generate without '
        '--check.',
    _ when writtenIds.isNotEmpty || partialIds.isNotEmpty =>
      'Generation failed after ${[
        if (writtenIds.isNotEmpty) 'writing ${writtenIds.join(', ')}',
        if (partialIds.isNotEmpty) 'partly writing ${partialIds.join(', ')}',
      ].join(' and ')} (see write-failed).',
    _ => 'Generation failed: nothing was written.',
  };
  buffer.writeln(verdict);
  return buffer.toString();
}

/// GitHub Actions workflow commands for the errors and warnings of
/// [result] (`::error title=...::message`).
///
/// GitHub resolves the `file=` of an annotation against the repository
/// root, so a path inside [workspace] (default: `$GITHUB_WORKSPACE`, else
/// the current directory) is given relative to it, with `/` separators.
List<String> githubAnnotations(GenerateResult result, {String? workspace}) {
  final root = p.normalize(p.absolute(workspace ??
      io.Platform.environment['GITHUB_WORKSPACE'] ??
      io.Directory.current.path));
  String file(String path) {
    final absolute = p.normalize(p.absolute(path));
    if (!p.isWithin(root, absolute)) return absolute;
    return p.split(p.relative(absolute, from: root)).join('/');
  }

  String data(String s) =>
      s.replaceAll('%', '%25').replaceAll('\r', '%0D').replaceAll('\n', '%0A');
  String property(String s) =>
      data(s).replaceAll(':', '%3A').replaceAll(',', '%2C');
  String command(Severity s) => s == Severity.error
      ? 'error'
      : (s == Severity.warning ? 'warning' : 'notice');
  return [
    for (final d in result.diagnostics)
      if (d.severity != Severity.info)
        '::${command(d.severity)} title=${property('sheety ${d.code.id}'
                '${d.location.isEmpty ? '' : ' ${d.location}'}')}::'
            '${data(d.toString())}',
    for (final i in result.issues)
      if (i.severity != Severity.info)
        '::${command(i.severity)} '
            '${i.path == null ? '' : 'file=${property(file(i.path!))},'}'
            'title=${property('sheety ${i.code}')}::${data(i.toString())}',
  ];
}

// ---------------------------------------------------------------------------
// Command line
// ---------------------------------------------------------------------------

/// Help text of `generate` (printed before the option list).
const String generateHelp = r'''
sheety_localization generate — turn a Google Sheet into localization code.

Reads every sheet (layout: label | description | meta | <base> | <locale>...)
and generates, per sheet ("scope"), code for each configured target:
  dart    Flutter localization classes (drop-in for `flutter gen-l10n`)
  ts      TypeScript ES modules, no runtime dependencies
  python  a Python package (>= 3.9), no runtime dependencies
Each target directory gets a sheety_manifest.json listing the files the
generator owns; only those are ever rewritten or deleted.

Usage:
  dart run sheety_localization:generate --sheet=<id> --credentials=key.json \
      --dart=lib/src/generated [--ts=web/src/i18n] [--python=py/pkg/l10n]
  dart run sheety_localization:generate --config=sheety.yaml --check
  dart run sheety_localization:generate --sheet=<id> --dump-snapshot=s.json
  dart run sheety_localization:generate --snapshot=s.json --dart=out

sheety.yaml (all keys optional except targets.<t>.output; paths are relative
to the file; unknown keys are errors; command-line options override it):
  sheet: 1AbC...                    # spreadsheet ID
  credentials: credentials.json     # service account key
  snapshot: sheets.json             # read this instead of Google
  dump_snapshot: sheets.json        # also save what was read (not --check)
  ignore: ['^help$', '^locales$']   # sheets skipped by every target
  syntax:
    mustache: ['^backend-']         # sheets using {{name}} instead of ICU
  header: This file is generated, do not edit it manually!
  strict: false                     # warnings are errors
  format: true                      # dart format the Dart output
  include_empty: true               # short rows: missing cells are empty
  legacy_regional_override: false   # 0.6.0: ar_EG overwrites ar
  targets:
    dart:
      output: dart/lib
      ignore: ['^backend', '^telegram']
      options: { directory: src/generated, barrel: localization.dart }
    python:
      output: python/src/app_localization
      include: ['^backend']
    ts:
      output: web/src/generated
      ignore: ['^backend']
      header: Generated from the localization sheet.

Per target: output (required; the directories of two targets must not be
nested), include / ignore (RegExps over sheet titles; include first, then
ignore, after the global ignore), header, options (dart: directory, barrel,
metadata, page_width; ts and python have none).

Exit codes: 0 ok / up to date, 1 --check found differences,
2 errors (sheet, output directory, source), 64 invalid usage.

Migrating from 0.6.0: --arb, --prefix, --author, --comment, --modified,
--last-modified and --context are removed (no ARB files are generated; the
output has no timestamps). --lib=<dir> --gen=<subdir> still work: they select
the dart target with output <dir> and the per-scope files under <subdir>.
The first run over 0.6.0 output takes over files that carry the generated
header and lists the leftovers (the old ARB files) for you to delete.''';

/// Runs `generate` with command-line [arguments] and returns the exit code.
///
/// [registry] defaults to [defaultTargets]; [sourceFor] to a
/// [SnapshotSource] or [GoogleSheetSource] as configured. Progress goes to
/// [out] and diagnostics to [err] (with `--diagnostics-format=json`, the JSON
/// goes to [out] and everything else to [err]).
Future<int> runGenerate(
  List<String> arguments, {
  TargetRegistry? registry,
  Future<SheetSource> Function(GenerateConfig config)? sourceFor,
  CodeFormatter? dartFormatter,
  StringSink? out,
  StringSink? err,
  String? workingDirectory,
}) async {
  final stdout = out ?? io.stdout;
  final stderr = err ?? io.stderr;
  final workspace =
      io.Platform.environment['GITHUB_WORKSPACE'] ?? workingDirectory;
  // Until the arguments are parsed, the format is looked up in them as
  // written, so that even a usage error is reported in it.
  var format = _diagnosticsFormatIn(arguments);
  var verbose = arguments.contains('--verbose') || arguments.contains('-v');

  // Reports a failure that stopped the run before (or outside) the
  // pipeline: the error on stderr, plus a JSON result or an annotation.
  int fail(String code, String message, int exitCode, {bool usage = false}) {
    final result = GenerateResult.failed(
      [GenerateIssue(code, message)],
      exitCode: exitCode,
    );
    switch (format) {
      case DiagnosticsFormat.json:
        stdout.writeln(
            const JsonEncoder.withIndent('  ').convert(result.toJson()));
      case DiagnosticsFormat.github:
        for (final line in githubAnnotations(result, workspace: workspace)) {
          stdout.writeln(line);
        }
      case DiagnosticsFormat.text:
        break;
    }
    stderr.writeln('error: $message');
    if (usage) stderr.writeln('Run with --help for usage.');
    return exitCode;
  }

  final parser = generateArgParser();
  final ArgResults args;
  try {
    args = parser.parse(arguments);
  } on FormatException catch (e) {
    return fail('usage-error', e.message, exitUsage, usage: true);
  }
  format = DiagnosticsFormat.byName(args.option('diagnostics-format')!)!;
  verbose = args.flag('verbose');
  if (args.flag('help')) {
    stdout
      ..writeln(generateHelp)
      ..writeln()
      ..writeln('Options:')
      ..writeln(parser.usage);
    return exitOk;
  }
  final GenerateConfig config;
  try {
    config = GenerateConfig.fromArgs(args, workingDirectory: workingDirectory);
  } on ConfigException catch (e) {
    return fail('config-error', e.message, exitUsage, usage: true);
  }

  final json = config.diagnosticsFormat == DiagnosticsFormat.json;
  final log = json ? stderr : stdout;
  if (config.configFile case final String file) log.writeln('Using $file');
  final pipeline = GeneratePipeline(
    registry: registry ?? defaultTargets(),
    dartFormatter: dartFormatter,
    log: log.writeln,
    verbose: config.verbose ? log.writeln : null,
  );

  int internalError(Object e, StackTrace s) {
    if (verbose) stderr.writeln(s);
    return fail(
      'internal-error',
      'Unexpected error (please report it; run with --verbose for the stack '
          'trace): $e',
      exitErrors,
    );
  }

  final SheetSource source;
  try {
    source = await (sourceFor ?? defaultSourceFor)(config);
  } on SheetSourceException catch (e) {
    return fail('source-error', e.message, exitErrors);
  } on Object catch (e, s) {
    return internalError(e, s);
  }
  final GenerateResult result;
  try {
    result = await pipeline.run(config, source);
  } on Object catch (e, s) {
    return internalError(e, s);
  }

  switch (config.diagnosticsFormat) {
    case DiagnosticsFormat.json:
      stdout
          .writeln(const JsonEncoder.withIndent('  ').convert(result.toJson()));
    case DiagnosticsFormat.github:
      for (final line in githubAnnotations(result, workspace: workspace)) {
        stdout.writeln(line);
      }
      stderr.write(formatResultText(result, verbose: config.verbose));
    case DiagnosticsFormat.text:
      stderr.write(formatResultText(result, verbose: config.verbose));
  }
  return result.exitCode;
}

/// The last `--diagnostics-format` in [arguments] as written (before `--`),
/// [DiagnosticsFormat.text] when there is none or it is not a format.
DiagnosticsFormat _diagnosticsFormatIn(List<String> arguments) {
  const option = '--diagnostics-format';
  var format = DiagnosticsFormat.text;
  for (var i = 0; i < arguments.length; i++) {
    final arg = arguments[i];
    if (arg == '--') break;
    final String? value;
    if (arg.startsWith('$option=')) {
      value = arg.substring(option.length + 1);
    } else if (arg == option && i + 1 < arguments.length) {
      value = arguments[++i];
    } else {
      continue;
    }
    format = DiagnosticsFormat.byName(value) ?? format;
  }
  return format;
}

/// The source [config] asks for: its snapshot, or the Google spreadsheet.
Future<SheetSource> defaultSourceFor(GenerateConfig config) async {
  if (config.snapshot case final String snapshot) {
    return SnapshotSource(snapshot);
  }
  return GoogleSheetSource.connect(
    credentialsPath: config.credentials ?? 'credentials.json',
    spreadsheetId: config.sheet!,
  );
}
