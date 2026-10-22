// End-to-end checks of the Dart emitter with the Flutter SDK (skipped when
// `flutter` is not on PATH):
//
// * the output for the in-repo fixture (and, with SHEETY_REAL_SNAPSHOT, the
//   real sheet) is written into a scratch Flutter package; `flutter analyze`
//   must be clean and a generated smoke test (`flutter test`) renders every
//   scope x locale x message through the metadata API and compares it with
//   direct getter/method calls;
// * `flutter gen-l10n` itself is run on ARB files built from the fixture,
//   and its output must equal the emitter's gen-l10n mode after
//   `dart format`.
@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:sheety_localization/src/generate/emit/dart/dart_code.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'helpers.dart';
import 'real_snapshot_test.dart' show escapeRawControls, firstDifference;

const String _fixture = 'test/fixtures/dart/dart_snapshot.json';
final RegExp _ignored = RegExp('^help|^backend|^telegram|^locales');

void main() {
  final flutter = findExecutable('flutter');
  final skip = flutter == null ? '`flutter` is not on PATH' : false;
  final snapshot = io.Platform.environment['SHEETY_REAL_SNAPSHOT'];

  late io.Directory temp;
  setUpAll(() {
    if (flutter != null) {
      temp = io.Directory.systemTemp.createTempSync('sheety_dart_flutter_');
    }
  });
  tearDownAll(() {
    if (flutter != null) temp.deleteSync(recursive: true);
  });

  Future<io.ProcessResult> run(String dir, List<String> args) async {
    final result = await io.Process.run(
      flutter!,
      args,
      workingDirectory: dir,
      runInShell: io.Platform.isWindows,
    );
    return result;
  }

  /// Creates a Flutter package at [name] containing the emitted [catalog]
  /// and [tests] (path under `test/` -> source); returns its directory.
  Future<String> package(
    String name,
    Catalog catalog,
    Map<String, String> tests,
  ) async {
    final dir = p.join(temp.path, name);
    final files = const DartEmitter().emit(catalog, const EmitOptions());
    writeTree(dir, {
      'pubspec.yaml': _pubspec,
      'analysis_options.yaml': _analysisOptions,
      for (final f in files) 'lib/${f.relativePath}': f.contents,
      for (final MapEntry(:key, :value) in tests.entries) 'test/$key': value,
    });
    var get = await run(dir, ['pub', 'get', '--offline']);
    if (get.exitCode != 0) get = await run(dir, ['pub', 'get']);
    expect(get.exitCode, 0, reason: '${get.stdout}\n${get.stderr}');
    return dir;
  }

  Future<void> analyzeAndTest(String dir) async {
    final analyze = await run(dir, ['analyze', '--no-pub']);
    expect(
      analyze.exitCode,
      0,
      reason: '${analyze.stdout}\n${analyze.stderr}',
    );
    expect('${analyze.stdout}', contains('No issues found'));
    final test = await run(dir, ['test', '--no-pub', '-r', 'expanded']);
    expect(test.exitCode, 0, reason: '${test.stdout}\n${test.stderr}');
  }

  test(
    'fixture: flutter analyze is clean and every message renders',
    () async {
      final catalog = readCatalog(loadSnapshot(_fixture)).catalog;
      final dir = await package('fixture', catalog, {
        'smoke_test.dart': smokeTest(catalog),
        'fixture_test.dart': _fixtureTest,
      });
      await analyzeAndTest(dir);
    },
    skip: skip,
    timeout: const Timeout(Duration(minutes: 5)),
  );

  test(
    'awkward names (keys key/args, locales is/as/new, scopes default/'
    'Function) analyze and render',
    () async {
      final catalog = readCatalog([
        (
          title: 'awkward',
          values: [
            // (`in` is left out: Flutter's Locale turns it into `id`.)
            ['label', 'description', 'meta', 'en', 'is', 'as', 'new'],
            ['key', '', '', 'the key', 'k', 'k', 'k'],
            ['args', '', '', 'args {a}', 'a {a}', 'a {a}', 'a {a}'],
            [
              'count',
              'bad \uD800 description',
              '',
              '{n, plural, one{one} other{{n} items}}',
              '{n, plural, one{eitt} other{{n}}}',
              '{n, plural, one{one} other{{n}}}',
              '{n, plural, other{{n}}}',
            ],
          ],
        ),
        // Scope names that are Dart keywords: 0.6.0 generated them fine.
        (
          title: 'default',
          values: [
            ['label', 'description', 'meta', 'en'],
            [
              'ratio',
              '',
              '{"placeholders": {"r": {"type": "double"}}}',
              'Ratio {r}',
            ],
            [
              'count',
              '',
              '{"placeholders": {"n": {"type": "int"}}}',
              '{n} things',
            ],
          ],
        ),
        (
          title: 'Function',
          values: [
            ['label', 'description', 'meta', 'en'],
            ['title', '', '', 'Fn'],
          ],
        ),
      ]).catalog;
      expect(
        const DartEmitter().validate(catalog, const {}).where((d) => d.isError),
        isEmpty,
      );
      final dir = await package('awkward', catalog, {
        'smoke_test.dart': smokeTest(catalog),
        'awkward_test.dart': _awkwardTest,
      });
      await analyzeAndTest(dir);
    },
    skip: skip,
    timeout: const Timeout(Duration(minutes: 5)),
  );

  test(
    'fixture: flutter gen-l10n produces the same code as gen-l10n mode',
    () async {
      final catalog = readCatalog(loadSnapshot(_fixture)).catalog;
      final dir = await package('genl10n', catalog, const {});
      final ours = p.join(dir, 'ours');
      writeTree(ours, {
        for (final f in const DartEmitter().emit(
          catalog,
          const EmitOptions(options: {'metadata': false}),
        ))
          if (f.relativePath.startsWith('src/generated/') &&
              f.relativePath != 'src/generated/locales.dart')
            f.relativePath.substring('src/generated/'.length): f.contents,
      });
      final theirs = p.join(dir, 'theirs');
      for (final scope in catalog.scopes) {
        final arbDir = p.join(dir, 'arb', scope.name);
        writeTree(arbDir, arbFiles(scope));
        final result = await run(dir, [
          'gen-l10n',
          '--arb-dir=$arbDir',
          '--template-arb-file=app_${scope.baseLocale.code}.arb',
          '--output-dir=${p.join(theirs, scope.name)}',
          '--output-localization-file=${scope.name}_localization.dart',
          '--output-class=${scopeClassName(scope.name)}',
          '--no-nullable-getter',
          '--header=${const EmitOptions().headerComment('//').trim()}',
          '--no-format',
        ]);
        expect(result.exitCode, 0, reason: '${result.stdout}${result.stderr}');
      }
      for (final root in [ours, theirs]) {
        final format = await dartFormat([root]);
        expect(format.exitCode, 0, reason: '${format.stderr}');
      }
      // The reference (gen-l10n of the Flutter release 0.6.0 ran with) has
      // a blank line between the two imports of a language file; the
      // current gen-l10n template does not. The emitter follows the
      // reference, so the blank line is ignored here.
      String normalize(String code) => code.replaceAll(
            "as intl;\n\nimport '",
            "as intl;\nimport '",
          );
      final a = {
        for (final MapEntry(:key, :value) in readTree(theirs).entries)
          key: normalize(escapeRawControls(value)),
      };
      final b = {
        for (final MapEntry(:key, :value) in readTree(ours).entries)
          key: normalize(value),
      };
      expect(b.keys.toSet(), a.keys.toSet());
      for (final path in a.keys) {
        expect(b[path], a[path],
            reason: firstDifference(a[path]!, b[path]!, path));
      }
    },
    skip: skip,
    timeout: const Timeout(Duration(minutes: 5)),
  );

  test(
    'real snapshot: flutter analyze is clean and every message renders',
    () async {
      final catalog = readCatalog(loadSnapshot(snapshot!))
          .catalog
          .where((s) => !_ignored.hasMatch(s.sheetTitle));
      final dir = await package('real', catalog, {
        'smoke_test.dart': smokeTest(catalog),
      });
      await analyzeAndTest(dir);
    },
    skip: skip != false
        ? skip
        : snapshot == null
            ? 'SHEETY_REAL_SNAPSHOT is not set'
            : false,
    timeout: const Timeout(Duration(minutes: 10)),
  );
}

/// ARB files for [scope], the way 0.6.0 wrote them: the base locale is the
/// template with `@key` metadata; every locale has its explicit texts.
Map<String, String> arbFiles(Scope scope) {
  const encoder = JsonEncoder.withIndent('  ');
  return {
    for (final locale in scope.localeTags)
      'app_${locale.code}.arb': encoder.convert({
        '@@locale': locale.code,
        for (final message in scope.messages)
          if (message.translations[locale] case final Translation t) ...{
            message.key: t.raw,
            if (locale == scope.baseLocale)
              '@${message.key}': {
                if (message.description != null)
                  'description': message.description,
                if (message.placeholders.any((p) => p.declared))
                  'placeholders': {
                    for (final p in message.placeholders)
                      if (p.declared)
                        p.name: {
                          'type': p.type.arbName,
                          if (p.example != null) 'example': p.example,
                          if (p.description != null)
                            'description': p.description,
                        },
                  },
              },
          },
      }),
  };
}

/// A Dart literal of the example value of [placeholder], as
/// `LocalizationPlaceholder.exampleValue` computes it.
String _exampleLiteral(Placeholder placeholder) {
  final example = placeholder.example;
  return switch (placeholder.type) {
    PlaceholderType.int => '${int.tryParse(example ?? '') ?? 1}',
    PlaceholderType.double => '${double.tryParse(example ?? '') ?? 1.0}',
    PlaceholderType.num => '${num.tryParse(example ?? '') ?? 1}',
    PlaceholderType.string ||
    PlaceholderType.object =>
      dartQuote(example ?? placeholder.name),
  };
}

/// A `flutter test` file that renders every message of every scope in every
/// supported locale through `format` and compares it with a direct call.
String smokeTest(Catalog catalog) {
  final b = StringBuffer()
    ..writeln("import 'package:flutter_test/flutter_test.dart';")
    ..writeln("import 'package:sheety_dart_check/localization.dart';")
    ..writeln()
    ..writeln('final Map<String, String Function(LocalizationBundle, String)>')
    ..writeln('    direct = {');
  for (final scope in catalog.scopes) {
    final type = scopeClassName(scope.name);
    b
      ..writeln("  '${scope.name}': (bundle, key) {")
      ..writeln('    final l = bundle as $type;')
      ..writeln('    return switch (key) {');
    for (final m in scope.messages) {
      final call = m.hasPlaceholders
          ? '${m.key}(${m.placeholders.map(_exampleLiteral).join(', ')})'
          : m.key;
      b.writeln("      '${m.key}' => l.$call,");
    }
    b
      ..writeln("      _ => throw StateError('unknown \$key'),")
      ..writeln('    };')
      ..writeln('  },');
  }
  b
    ..writeln('};')
    ..write(_smokeBody);
  return b.toString();
}

const String _smokeBody = r'''

void main() {
  test('every scope x locale x message renders', () async {
    var rendered = 0;
    expect(localizationScopes, isNotEmpty);
    for (final scope in localizationScopes) {
      expect(scope.supportedLocales, contains(scope.baseLocale));
      final keys = [for (final m in scope.messages) m.key];
      for (final locale in scope.supportedLocales) {
        expect(scope.delegate.isSupported(locale), isTrue);
        final bundle = scope.lookup(locale);
        final loaded = await scope.delegate.load(locale);
        expect(loaded.runtimeType, bundle.runtimeType);
        expect(bundle.localeName, isNotEmpty);
        expect(bundle.templates.keys.toList(), keys);
        expect(keys.toSet().containsAll(bundle.fallbackKeys), isTrue);
        for (final message in scope.messages) {
          final text = bundle.format(message.key, message.exampleArguments);
          final where = '${scope.name} $locale ${message.key}';
          expect(text, isNotEmpty, reason: where);
          expect(text, direct[scope.name]!(bundle, message.key), reason: where);
          expect(bundle.templates[message.key], isNotEmpty, reason: where);
          if (message.placeholders.isNotEmpty) {
            expect(() => bundle.format(message.key), throwsArgumentError,
                reason: where);
          }
          rendered++;
        }
        expect(() => bundle.format('not a key'), throwsArgumentError);
      }
    }
    expect(rendered, greaterThan(0));
  });
}
''';

const String _fixtureTest = r'''
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sheety_dart_check/localization.dart';

void main() {
  AppLocalization app(String code) {
    final parts = code.split('_');
    return lookupAppLocalization(switch (parts) {
      [final l] => Locale(l),
      [final l, final s] when s.length == 4 =>
        Locale.fromSubtags(languageCode: l, scriptCode: s),
      [final l, final c] => Locale(l, c),
      [final l, final s, final c] =>
        Locale.fromSubtags(languageCode: l, scriptCode: s, countryCode: c),
      _ => throw ArgumentError(code),
    });
  }

  test('plurals follow Intl.pluralLogic', () {
    expect(app('en').items(0), 'No items');
    expect(app('en').items(1), 'One item');
    expect(app('en').items(7), '7 items');
    expect(app('ru').items(1), '1 товар');
    expect(app('ru').items(3), '3 товара');
    expect(app('ru').items(5), '5 товаров');
    expect(app('ru').items(0), 'Нет товаров');
    expect(app('ar').items(0), 'لا عناصر');
    expect(app('ar').items(2), 'عنصران');
    expect(app('ar').items(3), '3 عناصر');
    expect(app('ar').items(11), '11 عنصرًا');
    expect(app('ar').items(100), '100 عنصر');
    // `#` is literal text in gen-l10n.
    expect(app('pt_BR').items(1), '# item');
    // The later of `=1{}` and `one{}` wins.
    expect(app('en').overridden(1), 'one-ish');
    expect(app('en').overridden(2), 'two');
    expect(app('en').overridden(3), '3 many');
  });

  test('select and nesting', () {
    expect(app('en').pronoun('female'), 'she');
    expect(app('en').pronoun('robot'), 'they');
    expect(app('en').nested('male', 1), 'He has one item');
    expect(app('en').nested('x', 0), 'They have nothing');
    expect(app('ru').nested('male', 5), 'У него 5 вещей');
  });

  test('escaping and interpolation', () {
    expect(
      app('en').special,
      'It\'s \$5 \\ 100% "quoted" #1\nsecond\tline\r\nthird ünïcødé 😀 \$x \\n',
    );
    expect(app('en').specialArg('Ann'), "Anns and Ann's \$ Ann_x");
    expect(app('en').lastSeen(DateTime.utc(2020)), startsWith('Last seen 2020'));
    expect(app('en').price(9.99), 'Price: 9.99 €');
    expect(app('en').emptyBranch(0), '');
  });

  test('regional subclasses and fallbacks', () {
    expect(app('pt').title, 'Exemplo');
    expect(app('pt_BR').title, 'Exemplo');
    expect(app('es_419').title, 'Ejemplo LatAm');
    expect(app('es_419').greeting('Ana'), '¡Hola, Ana!');
    expect(app('es_419').fallbackKeys, contains('greeting'));
    expect(app('es').fallbackKeys, isNot(contains('greeting')));
    expect(app('zh_Hant_TW').title, '範例 TW');
    expect(app('zh_Hant_TW').greeting('A'), '你好，A！');
    expect(app('zh_Hant').runtimeType.toString(), 'AppLocalizationZhHant');
    expect(app('de').fallbackOnly, 'Only English');
    expect(app('de').fallbackKeys, contains('fallbackOnly'));
    expect(app('de').templates['fallbackOnly'], 'Only English');
    expect(app('ru').templates['items'], startsWith('{count, plural,'));
    expect(lookupSignUpLocalization(const Locale('en')).codeSent('+1', 5),
        'Code sent to +1, resend in 5s');
  });

  test('format checks its arguments', () {
    expect(app('en').format('greeting', {'name': 'Bob'}), 'Hello, Bob!');
    expect(() => app('en').format('greeting', {'name': 1}),
        throwsArgumentError);
    expect(() => app('en').format('greeting'), throwsArgumentError);
    expect(app('en').format('items', {'count': 2}), '2 items');
    expect(() => app('en').format('items', {'count': 2.5}),
        throwsArgumentError);
    expect(app('en').format('items', {'count': 2.0}), '2 items');
    expect(app('en').format('price', {'amount': 1}), 'Price: 1 €');
  });

  test('metadata', () {
    final message =
        AppLocalization.messages.firstWhere((m) => m.key == 'greeting');
    expect(message.description, 'Greets the user');
    expect(message.placeholders.single.name, 'name');
    expect(message.placeholders.single.type, 'String');
    expect(message.exampleArguments, {'name': 'Bob'});
    expect(localizationScopes.map((s) => s.name), ['app', 'sign_up']);
    expect(localizationScopes.last.baseLocale, const Locale('de'));
    expect(Locales.values, contains(Locales.pt$BR));
  });
}
''';

const String _pubspec = '''
name: sheety_dart_check
publish_to: none
environment:
  # A language version with the tall formatting style, like consumers.
  sdk: ">=3.8.0 <4.0.0"
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any
dev_dependencies:
  flutter_test:
    sdk: flutter
flutter:
  generate: true
''';

const String _analysisOptions = '''
analyzer:
  language:
    strict-casts: true
    strict-raw-types: true
    strict-inference: true
''';

const String _awkwardTest = r'''
import 'package:flutter_test/flutter_test.dart';
import 'package:sheety_dart_check/localization.dart';

void main() {
  test('format() reaches the messages named like its parameters', () {
    final l = lookupAwkwardLocalization(Locales.en);
    expect(l.format('key'), 'the key');
    expect(l.format('args', {'a': 'x'}), 'args x');
    expect(lookupAwkwardLocalization(Locales.is$).key, 'k');
    expect(Locales.values, hasLength(4));
  });

  test('scopes named like Dart keywords', () {
    expect(lookupFunctionLocalization(Locales.en).title, 'Fn');
    expect(localizationScopes.map((s) => s.name),
        ['awkward', 'default', 'Function']);
  });

  test('format() checks numbers by value, as on the web', () {
    final l = lookupDefaultLocalization(Locales.en);
    // An int for a double placeholder (on the web `1 is double` is true).
    expect(l.format('ratio', {'r': 1}), l.ratio(1.0));
    expect(l.format('ratio', {'r': 1.5}), 'Ratio 1.5');
    expect(() => l.format('ratio', {'r': '1'}), throwsArgumentError);
    // An integral double for an int placeholder (on the web `2.0 is int`).
    expect(l.format('count', {'n': 2.0}), '2 things');
    expect(l.format('count', {'n': 2}), '2 things');
    for (final bad in [2.5, double.nan, double.infinity, '2']) {
      expect(() => l.format('count', {'n': bad}), throwsArgumentError,
          reason: '$bad');
    }
  });
}
''';
