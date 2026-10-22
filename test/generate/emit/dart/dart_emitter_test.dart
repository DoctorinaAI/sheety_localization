import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:sheety_localization/src/generate/emit/dart/dart_code.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'helpers.dart';
import 'version_api.dart';

const String fixturePath = 'test/fixtures/dart/dart_snapshot.json';

Catalog fixtureCatalog() => readCatalog(loadSnapshot(fixturePath)).catalog;

Map<String, String> emit(Catalog catalog, [Map<String, Object?>? options]) => {
      for (final file in const DartEmitter().emit(
        catalog,
        EmitOptions(options: options ?? const {}),
      ))
        file.relativePath: file.contents,
    };

void main() {
  late Catalog catalog;
  setUpAll(() => catalog = fixtureCatalog());

  test('the fixture is valid for the Dart target', () {
    final result = readCatalog(loadSnapshot(fixturePath));
    final diagnostics = [
      ...result.diagnostics,
      ...validateCatalog(
        result.catalog,
        targets: [Target.dart],
        reserved: {Target.dart: DartEmitter.reservedNames},
      ),
    ];
    expect(diagnostics.where((d) => d.isError), isEmpty);
  });

  group('goldens', () {
    for (final (name, options) in [
      ('metadata', const <String, Object?>{}),
      ('gen_l10n', const <String, Object?>{'metadata': false}),
    ]) {
      test(name, () {
        final files = emit(catalog, options);
        final dir = io.Directory('test/golden/dart/$name');
        if (updateGoldens) {
          if (dir.existsSync()) dir.deleteSync(recursive: true);
          writeTree(dir.path, {
            for (final MapEntry(:key, :value) in files.entries)
              '$key.golden': value,
          });
        }
        final golden = {
          for (final MapEntry(:key, :value) in readTree(dir.path).entries)
            key.substring(0, key.length - '.golden'.length): value,
        };
        expect(files.keys.toSet(), golden.keys.toSet());
        for (final path in files.keys) {
          expect(files[path], golden[path], reason: path);
        }
      });
    }
  });

  test('is deterministic', () {
    expect(emit(fixtureCatalog()), emit(fixtureCatalog()));
  });

  test('file layout', () {
    expect(emit(catalog).keys, [
      'src/generated/app/app_localization.dart',
      for (final l in ['ar', 'de', 'en', 'es', 'pt', 'ru', 'zh'])
        'src/generated/app/app_localization_$l.dart',
      'src/generated/sign_up/sign_up_localization.dart',
      'src/generated/sign_up/sign_up_localization_de.dart',
      'src/generated/sign_up/sign_up_localization_en.dart',
      'src/generated/locales.dart',
      'src/generated/localization_meta.dart',
      'localization.dart',
    ]);
  });

  test('output is already formatted (dart format changes nothing)', () async {
    final temp = io.Directory.systemTemp.createTempSync('sheety_dart_fmt_');
    addTearDown(() => temp.deleteSync(recursive: true));
    for (final (name, options) in [
      ('a', const <String, Object?>{}),
      ('b', const <String, Object?>{'metadata': false}),
    ]) {
      writeTree(p.join(temp.path, name), emit(catalog, options));
    }
    final result = await dartFormat(
      [temp.path],
      setExitIfChanged: true,
      dryRun: true,
    );
    expect(result.exitCode, 0, reason: '${result.stdout}${result.stderr}');
  });

  group('options', () {
    test('barrel and directory are configurable', () {
      final files = emit(catalog, {
        'directory': 'gen/l10n',
        'barrel': 'lib/all.dart',
      });
      expect(files.keys, contains('gen/l10n/app/app_localization.dart'));
      expect(files.keys, contains('gen/l10n/locales.dart'));
      final barrel = files['lib/all.dart']!;
      expect(
          barrel, contains("export '../gen/l10n/app/app_localization.dart';"));
      expect(barrel, contains("export '../gen/l10n/localization_meta.dart';"));
      expect(
        files['gen/l10n/app/app_localization.dart'],
        contains("import '../localization_meta.dart';"),
      );
    });

    test('everything at the root, no barrel', () {
      final files = emit(catalog, {'directory': '', 'barrel': ''});
      expect(files.keys, contains('app/app_localization.dart'));
      expect(files.keys, contains('locales.dart'));
      expect(files.keys, isNot(contains('localization.dart')));
    });

    test('rejects absolute and parent paths', () {
      for (final path in ['/abs', '../up', r'a\b', 'a//b', './a']) {
        expect(
          () => emit(catalog, {'directory': path}),
          throwsArgumentError,
          reason: path,
        );
        expect(
          () => emit(catalog, {'barrel': path}),
          throwsArgumentError,
          reason: path,
        );
      }
    });

    test('header', () {
      final files = const DartEmitter().emit(
        catalog,
        const EmitOptions(header: 'Line one\n\nLine two'),
      );
      for (final file in files) {
        expect(file.contents, startsWith('// Line one\n//\n// Line two\n'));
      }
      final none =
          const DartEmitter().emit(catalog, const EmitOptions(header: ''));
      for (final file in none) {
        expect(file.contents, isNot(startsWith('//\n')));
      }
    });

    test('page width', () {
      final narrow = emit(catalog, {'page_width': 40});
      final wide = emit(catalog, {'page_width': 200});
      expect(narrow, isNot(wide));
    });
  });

  group('tool/version.dart API extraction', () {
    test('same members with and without metadata', () {
      final plain = VersionApi.of(emit(catalog, {'metadata': false}));
      final meta = VersionApi.of(emit(catalog));
      expect(plain.members, isNotEmpty);
      expect(meta.members, plain.members);
      expect(meta.locales, plain.locales);
      expect(plain.members['AppLocalization.title'], '');
      expect(plain.members['AppLocalization.items'], '(int count)');
      expect(plain.members['AppLocalization.lastSeen'], '(Object when)');
      expect(
        plain.members['SignUpLocalization.codeSent'],
        '(String phone, int seconds)',
      );
      expect(plain.members.keys, isNot(contains('AppLocalization.format')));
      expect(plain.locales, containsAll(['pt_BR', 'es_419', 'en']));
    });

    test('every key of every scope is a member, nothing else', () {
      final api = VersionApi.of(emit(catalog));
      expect(api.members.keys.toSet(), {
        for (final scope in catalog.scopes)
          for (final m in scope.messages)
            '${scopeClassName(scope.name)}.${m.key}',
      });
    });
  });

  group('message code', () {
    test('escaping matches gen-l10n generateString', () {
      expect(dartString(r'''It's $5 \ "q"'''), r'''It\'s \$5 \\ \"q\"''');
      expect(dartString('a\nb\tc\rd\fe\bf'), r'a\nb\tc\rd\fe\bf');
      expect(dartString('ünï 😀'), 'ünï 😀');
      expect(dartString('nul\u0000 vt\u000b del\u007f'),
          r'nul\u{0} vt\u{b} del\u{7f}');
    });

    test('return expressions add braces before identifier characters', () {
      expect(returnExpression([]), "''");
      expect(returnExpression([r'$a']), r"'$a'");
      expect(returnExpression([r'$a', 's']), r"'${a}s'");
      expect(returnExpression([r'$a', '_x']), r"'${a}_x'");
      expect(returnExpression([r'$a', ' s']), r"'$a s'");
      expect(returnExpression([r'$a', r'$b']), r"'$a$b'");
    });

    test('plural branches: reverse order, the later duplicate wins', () {
      final body = methodBody(
        parseIcu('{n, plural, =1{exactly one} one{one-ish} =2{two} other{x}}'),
      );
      expect(
          body.temps.single.$2.flat,
          "intl.Intl.pluralLogic(n, locale: localeName, other: 'x', "
          "two: 'two', one: 'one-ish')");
      expect(body.result, r"'$_temp0'");
    });

    test('nested temps are numbered first', () {
      final body = methodBody(parseIcu(
        '{g, select, a{{n, plural, other{A}}} other{{n, plural, other{B}}}}',
      ));
      expect(
          [for (final t in body.temps) t.$1], ['_temp0', '_temp1', '_temp2']);
      expect(body.temps.last.$2.flat,
          r"intl.Intl.selectLogic(g, {'a': '$_temp0', 'other': '$_temp1'})");
    });
  });
  group('names that would break the generated code', () {
    Catalog awkward() => readCatalog([
          (
            title: 'keys',
            values: [
              ['label', 'description', 'meta', 'en', 'is', 'in', 'as', 'new'],
              ['key', '', '', 'the key', 'k', 'k', 'k', 'k'],
              ['args', '', '', 'args {a}', 'a {a}', 'a {a}', 'a {a}', 'a {a}'],
            ],
          ),
        ]).catalog;

    test('format() calls `key` and `args` through this.', () {
      final main =
          emit(awkward())['src/generated/keys/keys_localization.dart']!;
      expect(main, contains("'key' => this.key,"));
      expect(main, contains("'args' => this.args("));
      expect(main, contains('String get key;'));
    });

    test('a locale that is a reserved word gets a trailing \$ field', () {
      final locales = emit(awkward())['src/generated/locales.dart']!;
      expect(locales, contains(r"static const Locale is$ = Locale('is');"));
      expect(locales, contains(r"static const Locale in$ = Locale('in');"));
      expect(locales, contains(r"static const Locale new$ = Locale('new');"));
      expect(locales, contains("static const Locale as = Locale('as');"));
      expect(locales, contains(r'[en, is$, in$, as, new$]'));
      expect(dartLocaleField(LocaleTag.parse('pt_BR')), r'pt$BR');
      // The tool/version.dart contract still sees every locale.
      expect(
        {
          for (final m in VersionApi.locale.allMatches(locales)) m.group(1),
        },
        {'en', 'is', 'in', 'as', 'new'},
      );
    });

    test('metadata members are reserved only with the metadata API', () {
      final catalog = readCatalog([
        (
          title: 'm',
          values: [
            ['label', 'description', 'meta', 'en'],
            for (final key in DartEmitter.reservedNames) [key, '', '', 'x'],
          ],
        ),
      ]).catalog;
      final withMeta = const DartEmitter().validate(catalog, const {});
      expect(
        [for (final d in withMeta) d.key],
        DartEmitter.reservedNames.toList(),
      );
      expect(withMeta.first.code, DiagnosticCode.reservedWord);
      expect(
        const DartEmitter().validate(catalog, const {'metadata': false}),
        isEmpty,
      );
      // Placeholders may use those names either way.
      final placeholder = readCatalog([
        (
          title: 'p',
          values: [
            ['label', 'description', 'meta', 'en'],
            ['m', '', '', '{format} {messages}'],
          ],
        ),
      ]).catalog;
      expect(const DartEmitter().validate(placeholder, const {}), isEmpty);
    });

    test('lone surrogates become U+FFFD in doc comments only', () {
      final catalog = readCatalog([
        (
          title: 's',
          values: [
            ['label', 'description', 'meta', 'en'],
            ['a', 'bad \uD800 desc', '', 'A \uDC00'],
          ],
        ),
      ]).catalog;
      final files = emit(catalog);
      final main = files['src/generated/s/s_localization.dart']!;
      expect(main, contains('/// bad � desc'));
      expect(main, contains("/// **'A �'**"));
      expect(main, isNot(contains('\uD800')));
      expect(files['src/generated/s/s_localization_en.dart'],
          contains(r"'A \u{dc00}'"));
    });
  });
}
