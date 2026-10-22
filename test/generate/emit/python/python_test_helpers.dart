import 'dart:convert';
import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';

import '../../helpers.dart';

/// The in-repo fixture of the Python target.
const String pythonFixturePath = 'test/fixtures/python/python_snapshot.json';

/// Reader options of the fixture: the monetization sheet is mustache.
final ReaderOptions pythonReaderOptions = ReaderOptions(
  mustacheSheets: [RegExp(r'^backend-monetization$')],
);

/// Reads [path] and returns the catalog with its diagnostics (reader +
/// validation for the Python target).
ReadResult readPythonCatalog(
  String path, {
  ReaderOptions? options,
}) {
  final read = readCatalog(
    loadSnapshot(path),
    options: options ?? pythonReaderOptions,
  );
  final diagnostics = [
    ...read.diagnostics,
    ...validateCatalog(
      read.catalog,
      targets: const [Target.python],
      reserved: const {Target.python: PythonEmitter.reservedNames},
    ),
  ];
  return (catalog: read.catalog, diagnostics: diagnostics);
}

/// Renders [message] in [locale] the way the generated code must: walks the
/// core AST, Dart's `'$value'` for values, the core CLDR evaluator over
/// `package:intl` operands and `Intl.pluralLogic` / `Intl.selectLogic`
/// branch choice.
String referenceRender(
  Message message,
  LocaleTag locale,
  Map<String, Object?> args,
) {
  final rules = pluralRulesFor(locale.code);
  String render(IcuMessage icu) {
    final out = StringBuffer();
    for (final part in icu.parts) {
      switch (part) {
        case IcuText(:final text):
          out.write(text);
        case IcuArgument(:final name):
          out.write(dartString(args[name]));
        case IcuPlural(:final argument):
          final howMany = args[argument]! as num;
          final cases = part.cases;
          final category = rules.select(PluralOperands.intl(howMany));
          final branch = choosePluralBranch(
            howMany,
            cases.keys.toSet(),
            category,
          );
          out.write(render(cases[branch]!));
        case IcuSelect(:final argument, :final branches):
          final cases = {for (final b in branches) b.value: b.message};
          final choice = args[argument];
          final chosen = cases[choice] ??
              cases[dartString(choice).split('.').last] ??
              cases['other']!;
          out.write(render(chosen));
      }
    }
    return out.toString();
  }

  return render(message.translationFor(locale).ast);
}

/// Dart's `'$value'`.
String dartString(Object? value) => '$value';

/// Typed example value of [placeholder].
Object exampleValue(Placeholder placeholder) {
  final example = placeholder.example;
  return switch (placeholder.type) {
    PlaceholderType.int => int.tryParse(example ?? '') ?? 3,
    PlaceholderType.num => num.tryParse(example ?? '') ?? 3,
    PlaceholderType.double => double.tryParse(example ?? '') ?? 2.5,
    PlaceholderType.string ||
    PlaceholderType.object =>
      example ?? '<${placeholder.name}>',
  };
}

/// Integer plural counts every message is rendered with.
const List<int> integerCounts = [
  0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, 19, 20, 21, 22, 25, 100, 101, //
  102, 111, 1000, 1000000,
];

/// Fractional plural counts for `num` / `double` placeholders.
const List<double> fractionalCounts = [
  0.0, 1.0, 2.0, 0.5, 1.5, 2.5, 1.25, 0.1, 1.05, 21.5, 100.75, 1e-7, //
  1.5e-7, 123.456, 1e21,
];

/// Argument sets for [message]: the examples, then every placeholder varied
/// alone (plural counts over [integerCounts] / [fractionalCounts], select
/// choices over every case value plus an unknown and an enum-like value).
List<Map<String, Object?>> argumentSets(Message message) {
  final base = {
    for (final p in message.placeholders) p.name: exampleValue(p),
  };
  final sets = <Map<String, Object?>>[base];
  final selectValues = <String, Set<String>>{};
  for (final translation in message.translations.values) {
    for (final select in translation.ast.selects) {
      (selectValues[select.argument] ??= {})
          .addAll(select.branches.map((b) => b.value));
    }
  }
  for (final p in message.placeholders) {
    if (p.isPluralCount) {
      final values = <Object>[
        ...integerCounts,
        if (p.type != PlaceholderType.int) ...fractionalCounts,
      ];
      for (final v in values) sets.add({...base, p.name: v});
    } else if (p.isSelectChoice) {
      for (final v in [
        ...?selectValues[p.name],
        'unknown',
        'Gender.${selectValues[p.name]?.first ?? 'x'}',
      ]) {
        sets.add({...base, p.name: v});
      }
    } else if (p.type.isNumeric) {
      for (final v in <Object>[
        0,
        -1,
        if (p.type != PlaceholderType.int) ...[1.0, 0.1, 1e21, -0.5, 1e-7],
      ]) {
        sets.add({...base, p.name: v});
      }
    }
  }
  return sets;
}

/// A Python 3 interpreter: `SHEETY_PYTHON` or `python3` on the `PATH`;
/// `null` when none runs.
String? findPython() {
  final candidate = io.Platform.environment['SHEETY_PYTHON'] ?? 'python3';
  try {
    final result = io.Process.runSync(candidate, ['--version']);
    if (result.exitCode == 0) return candidate;
  } on io.ProcessException {
    return null;
  }
  return null;
}

/// Whether `[python] -m [module] --version` works.
bool hasPythonModule(String python, String module) {
  try {
    return io.Process.runSync(python, ['-m', module, '--version']).exitCode ==
        0;
  } on io.ProcessException {
    return false;
  }
}

/// Writes [files] under [root].
void writeFiles(io.Directory root, List<GeneratedFile> files) {
  for (final file in files) {
    final target = io.File('${root.path}/${file.relativePath}');
    target.parent.createSync(recursive: true);
    target.writeAsStringSync(file.contents);
  }
}

/// Runs [python] with [args]; fails with the output on a non-zero exit.
io.ProcessResult runChecked(
  String executable,
  List<String> args, {
  String? workingDirectory,
  Map<String, String>? environment,
}) {
  final result = io.Process.runSync(
    executable,
    args,
    workingDirectory: workingDirectory,
    environment: environment,
    stdoutEncoding: utf8,
    stderrEncoding: utf8,
  );
  if (result.exitCode != 0) {
    throw StateError(
      '$executable ${args.join(' ')} failed (${result.exitCode}):\n'
      '${result.stdout}\n${result.stderr}',
    );
  }
  return result;
}
