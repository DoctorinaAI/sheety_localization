// Shared helpers of the TypeScript emitter tests: fixture loading, a Dart
// reference renderer with the exact semantics of the gen-l10n generated
// code (package:intl), example arguments, and node / tsc plumbing.
import 'dart:convert';
import 'dart:io' as io;

import 'package:intl/intl.dart' as intl;

import '../../../sheety.dart';
import '../../helpers.dart';

export '../../helpers.dart' show hasTool, requireTools;

/// The exact TypeScript compiler the generated code is checked with. Pinned
/// to a patch release so a new upstream release cannot change the result of
/// a run; bump it deliberately.
const String typescriptVersion = '5.9.3';

/// The fixture of the TypeScript tests.
const String tsFixturePath = 'test/fixtures/ts/ts_snapshot.json';

/// Reader options of the fixture: a regional column never overwrites its
/// parent, so `de_AT` (partly empty) falls back to `de`.
const ReaderOptions tsReaderOptions =
    ReaderOptions(legacyRegionalOverride: false);

/// Reads [path] into a catalog.
ReadResult readSnapshot(String path, {ReaderOptions? options}) =>
    readCatalog(loadSnapshot(path), options: options ?? tsReaderOptions);

/// The fixture catalog.
Catalog tsFixtureCatalog() => readSnapshot(tsFixturePath).catalog;

/// Emits [catalog] with default options.
List<GeneratedFile> emitTs(Catalog catalog, {EmitOptions? options}) =>
    const TypeScriptEmitter().emit(catalog, options ?? const EmitOptions());

/// Writes [files] under [dir].
void writeFiles(io.Directory dir, Iterable<GeneratedFile> files) {
  for (final file in files) {
    io.File('${dir.path}/${file.relativePath}')
      ..parent.createSync(recursive: true)
      ..writeAsStringSync(file.contents);
  }
}

/// Renders [ast] exactly like the Dart code gen-l10n generates for it:
/// `'$value'` interpolation, `intl.Intl.pluralLogic(howMany, locale:
/// localeName, zero: .., other: ..)` with every branch rendered eagerly, and
/// `intl.Intl.selectLogic(choice, {...})`.
String renderDart(
  IcuMessage ast,
  LocaleTag locale,
  Map<String, Object?> args,
) {
  final localeName = intl.Intl.canonicalizedLocale(locale.code);
  String render(IcuMessage message) => [
        for (final part in message.parts)
          switch (part) {
            IcuText(:final text) => text,
            IcuArgument(:final name) => '${args[name]}',
            IcuPlural(:final argument) => () {
                String? branch(PluralCategory c) =>
                    part.cases[c] == null ? null : render(part.cases[c]!);
                return intl.Intl.pluralLogic<String>(
                  args[argument]! as num,
                  locale: localeName,
                  zero: branch(PluralCategory.zero),
                  one: branch(PluralCategory.one),
                  two: branch(PluralCategory.two),
                  few: branch(PluralCategory.few),
                  many: branch(PluralCategory.many),
                  other: branch(PluralCategory.other)!,
                );
              }(),
            IcuSelect(:final argument, :final branches) =>
              intl.Intl.selectLogic<String>(args[argument]!, {
                for (final b in branches) b.value: render(b.message),
              }),
          },
      ].join();
  return render(ast);
}

/// Numbers used for plural counts of type `int`.
const List<int> integerSamples = [
  0, 1, 2, 3, 4, 5, 7, 11, 12, 14, 21, 22, 25, 100, 101, 102, 111, 1000, //
  1000000, -1, -2,
];

/// Additional numbers for `num` / `double` placeholders.
const List<double> fractionSamples = [
  0.5,
  1.0,
  1.5,
  1.9,
  2.25,
  0.1,
  1.05,
  3.999,
  21.5,
  1.0001,
  -1.5,
  1e-7,
  1234.5678,
];

/// Sets of example arguments for [message]: the meta examples first, then
/// variations that walk through plural counts and select choices. Values
/// are JSON-compatible; [toDart] converts them to the Dart types of the
/// placeholders.
List<Map<String, Object?>> exampleArgs(Message message) {
  if (!message.hasPlaceholders) return const [{}];
  final choices = <String, List<String>>{};
  for (final translation in message.translations.values) {
    for (final select in translation.ast.selects) {
      final list = choices[select.argument] ??= [];
      for (final b in select.branches) {
        if (!list.contains(b.value)) list.add(b.value);
      }
    }
  }
  final values = <String, List<Object?>>{};
  for (final p in message.placeholders) {
    final example = p.example;
    values[p.name] = switch (p.type) {
      PlaceholderType.int => [
          if (example != null && int.tryParse(example) != null)
            int.parse(example),
          ...integerSamples,
        ],
      PlaceholderType.num || PlaceholderType.double => [
          if (example != null && num.tryParse(example) != null)
            num.parse(example),
          ...integerSamples,
          ...fractionSamples,
        ],
      PlaceholderType.string => [
          example ?? p.name,
          ...?choices[p.name],
          'unknown',
          'Gender.${choices[p.name]?.first ?? 'x'}',
        ],
      PlaceholderType.object => [example ?? '<${p.name}>', 42, 'x'],
    };
  }
  final count = values.values.map((v) => v.length).reduce(
        (a, b) => a > b ? a : b,
      );
  return [
    for (var k = 0; k < count; k++)
      {
        for (final MapEntry(:key, value: list) in values.entries)
          key: list[k % list.length],
      },
  ];
}

/// [args] with every value converted to the Dart type of its placeholder
/// (`double` placeholders get doubles, `int` ints; a `num` keeps what JSON
/// gives: an int for an integral value).
Map<String, Object?> toDart(Message message, Map<String, Object?> args) => {
      for (final MapEntry(:key, :value) in args.entries)
        key: switch ((message.placeholder(key)?.type, value)) {
          (PlaceholderType.double, final num n) => n.toDouble(),
          (PlaceholderType.int, final num n) => n.toInt(),
          (PlaceholderType.num, final double d)
              when d == d.truncate() && d.abs() < 1e15 =>
            // JSON (and JavaScript) cannot tell 1.0 from 1: the TS side
            // sees an integer, so a Dart caller passing an int is the
            // equivalent.
            d.toInt(),
          _ => value,
        },
    };

/// Runs `npx -y -p typescript@<version> tsc <arguments>` in [dir].
Future<io.ProcessResult> runTsc(
  io.Directory dir,
  List<String> arguments, {
  String version = typescriptVersion,
}) =>
    io.Process.run(
      'npx',
      ['-y', '-p', 'typescript@$version', 'tsc', ...arguments],
      workingDirectory: dir.path,
      runInShell: io.Platform.isWindows,
    );

/// Strict compiler options every generated tree must satisfy.
Map<String, Object?> strictCompilerOptions({
  required String module,
  required String moduleResolution,
}) =>
    {
      'target': 'ES2022',
      'lib': ['ES2022'],
      'types': <String>[],
      'module': module,
      'moduleResolution': moduleResolution,
      'strict': true,
      'noUncheckedIndexedAccess': true,
      'exactOptionalPropertyTypes': true,
      'verbatimModuleSyntax': true,
      'isolatedModules': true,
      'erasableSyntaxOnly': true,
      'noImplicitReturns': true,
      'noImplicitOverride': true,
      'noUnusedLocals': true,
      'noUnusedParameters': true,
      'noFallthroughCasesInSwitch': true,
      'noPropertyAccessFromIndexSignature': true,
      'forceConsistentCasingInFileNames': true,
      'skipLibCheck': false,
    };

/// Encodes [value] as pretty JSON.
String prettyJson(Object? value) =>
    const JsonEncoder.withIndent('  ').convert(value);
