import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';
import 'package:sheety_localization/src/generate/emit/ts/ts_code.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'ts_helpers.dart';

const _goldenDir = 'test/golden/ts';

void main() {
  group('fixture', () {
    test('reads without errors and validates for ts', () {
      final result = readSnapshot(tsFixturePath);
      final catalog = result.catalog;
      final diagnostics = [
        ...result.diagnostics,
        ...validateCatalog(catalog),
        ...const TypeScriptEmitter().validate(catalog),
      ];
      expect(
        diagnostics.where((d) => d.isError),
        isEmpty,
        reason: formatDiagnostics(diagnostics),
      );
      expect(catalog.scopes.map((s) => s.name), ['app', 'sign_up', 'errors']);
      final app = catalog.scope('app')!;
      expect(app.locale(LocaleTag.parse('pt'))!.isSynthetic, isTrue);
      expect(
        app
            .message('greeting')!
            .translationFor(LocaleTag.parse('de_AT'))
            .isFallback,
        isFalse,
      );
      expect(
        app.message('title')!.translationFor(LocaleTag.parse('ja')).raw,
        '例',
      );
      expect(
        app.message('price')!.translationFor(LocaleTag.parse('de_AT')).source,
        LocaleTag.parse('de'),
      );
    });
  });

  group('golden', () {
    final files = emitTs(tsFixtureCatalog());
    final update = io.Platform.environment['UPDATE_GOLDENS'] == '1';

    setUpAll(() {
      if (!update) return;
      final dir = io.Directory(_goldenDir);
      if (dir.existsSync()) dir.deleteSync(recursive: true);
      writeFiles(dir, files);
    });

    test('the set of files', () {
      final golden = io.Directory(_goldenDir)
          .listSync(recursive: true)
          .whereType<io.File>()
          .map((f) => f.path.substring(_goldenDir.length + 1))
          .toList()
        ..sort();
      expect(files.map((f) => f.relativePath).toList(), golden);
    });

    for (final file in files) {
      test(file.relativePath, () {
        final golden = io.File('$_goldenDir/${file.relativePath}');
        expect(golden.existsSync(), isTrue,
            reason: 'run with UPDATE_GOLDENS=1');
        expect(file.contents, golden.readAsStringSync());
      });
    }
  });

  group('emit', () {
    test('is deterministic', () {
      final a = emitTs(tsFixtureCatalog());
      final b = emitTs(tsFixtureCatalog());
      expect(
        [for (final f in a) '${f.relativePath}\n${f.contents}'],
        [for (final f in b) '${f.relativePath}\n${f.contents}'],
      );
    });

    test('uses the header of the options on every file', () {
      final files = emitTs(
        tsFixtureCatalog(),
        options: const EmitOptions(header: 'Custom\nheader'),
      );
      for (final file in files) {
        expect(
          file.contents,
          startsWith('// Custom\n// header\n/* eslint-disable */\n'),
          reason: file.relativePath,
        );
        expect(file.contents, isNot(contains('ts-nocheck')));
      }
      final bare = emitTs(
        tsFixtureCatalog(),
        options: const EmitOptions(header: ''),
      );
      expect(bare.first.contents, startsWith('/* eslint-disable */\n'));
    });

    test('layout', () {
      final paths = emitTs(tsFixtureCatalog()).map((f) => f.relativePath);
      expect(
        paths,
        containsAll([
          'runtime.ts',
          'index.ts',
          'meta.ts',
          'app/types.ts',
          'app/index.ts',
          'app/eager.ts',
          'app/meta.ts',
          'app/en.ts',
          'app/pt-BR.ts',
          'app/pt.ts',
          'app/de-AT.ts',
          'sign_up/index.ts',
          'errors/ru.ts',
          'errors/es-419.ts',
          'errors/es.ts',
        ]),
      );
    });

    test('relative imports always carry a .js suffix', () {
      final import = RegExp(r'''(?:from|import\()\s*'([^']+)'\s*''');
      for (final file in emitTs(tsFixtureCatalog())) {
        for (final m in import.allMatches(file.contents)) {
          final target = m.group(1)!;
          expect(target, startsWith('.'), reason: file.relativePath);
          expect(target, endsWith('.js'), reason: file.relativePath);
        }
      }
    });

    test('rules are compiled only for locales that use plurals', () {
      final runtime = emitTs(tsFixtureCatalog())
          .firstWhere((f) => f.relativePath == 'runtime.ts')
          .contents;
      final rules = RegExp(r'export function (plural_\w+)\(')
          .allMatches(runtime)
          .map((m) => m.group(1))
          .toList();
      // ja only through the fallback texts of `pronoun`; de_AT shares the
      // rules of de; es is the synthetic parent of es_419; ja has its own.
      expect(rules, [
        'plural_ar',
        'plural_de',
        'plural_en',
        'plural_es',
        'plural_fr',
        'plural_ja',
        'plural_pl',
        'plural_pt',
        'plural_ru',
      ]);
    });

    test('an empty catalog still produces valid modules', () {
      final files = emitTs(Catalog(const []));
      expect(files.map((f) => f.relativePath), [
        'index.ts',
        'meta.ts',
        'runtime.ts',
      ]);
      final index = files.first.contents;
      expect(index, contains('export const scopes = [] as const;'));
      expect(index, isNot(contains('resolveLocale')));
    });
  });

  group('validate', () {
    test('reports scopes that shadow root exports', () {
      final catalog = readCatalog(sheet('scopes', [
        ['label', 'description', 'meta', 'en'],
        ['a', '', '', 'A'],
      ])).catalog;
      final diagnostics = const TypeScriptEmitter().validate(catalog);
      expect(codes(diagnostics), ['reserved-word']);
      expect(diagnostics.single.target, 'ts');
    });

    test('reports Object members as keys and reserved words as params', () {
      final catalog = readCatalog(sheet('app', [
        ['label', 'description', 'meta', 'en'],
        ['constructor', '', '', 'A'],
        ['delete', '', '', 'fine as a property'],
        ['b', '', '', 'Hi {class}'],
      ])).catalog;
      final diagnostics = const TypeScriptEmitter().validate(catalog);
      expect(codes(diagnostics), ['reserved-word', 'reserved-word']);
      expect(diagnostics.map((d) => d.key), ['constructor', 'b']);
    });

    test('reports `then`: a dictionary must not be a thenable', () {
      final catalog = readCatalog(sheet('app', [
        ['label', 'description', 'meta', 'en'],
        ['then', '', '', 'and then {x}'],
        ['thenWhat', '', '', 'fine'],
      ])).catalog;
      final diagnostics = const TypeScriptEmitter().validate(catalog);
      expect(codes(diagnostics), ['reserved-word']);
      expect(diagnostics.single.key, 'then');
      expect(diagnostics.single.message, contains('thenable'));
    });
  });

  group('string literals', () {
    test('escape quotes, backslashes and line terminators', () {
      expect(tsString(r"It's \ ok"), r"'It\'s \\ ok'");
      expect(tsString('a\nb\r\tc\b\f'), r"'a\nb\r\tc\b\f'");
      expect(tsString('\u2028\u2029\ufeff'), r"'\u2028\u2029\uFEFF'");
      expect(tsString('\x00\x1f\x7f'), r"'\x00\x1F\x7F'");
      expect(tsString(r'${x} `'), r"'${x} `'");
    });

    test('keep non-ASCII text, escape lone surrogates', () {
      expect(tsString('héllo 👋 עברית'), "'héllo 👋 עברית'");
      expect(tsString('a\uD83D!'), r"'a\uD83D!'");
      expect(tsString('\uDC00x'), r"'\uDC00x'");
      expect(tsString('👋'), "'👋'");
    });

    test('template literal text escapes backticks and dollars', () {
      expect(tsTemplateText(r'${x} `y` $'), r'\${x} \`y\` \$');
      expect(tsTemplateText("'"), "'");
    });

    test('property keys', () {
      expect(tsPropertyKey('male'), 'male');
      expect(tsPropertyKey('a|b'), "'a|b'");
      expect(tsPropertyKey('1'), "'1'");
      expect(tsPropertyKey('__proto__'), "['__proto__']");
    });

    test('doc comments cannot be closed early', () {
      expect(tsDocComment(['a */ b', 'c']), '/**\n * a *\\/ b\n * c\n */\n');
      expect(tsDocComment([]), '');
      // A lone surrogate becomes U+FFFD, like in the other targets.
      expect(tsCommentText('a\uD83D\u2028\x00\tb'),
          'a\uFFFD' r'\u2028\u0000' '\tb');
    });
  });

  group('runtime', () {
    test('compiles CLDR relations', () {
      final ru = tsRuntimeSource(pluralLocales: ['ru'], header: '');
      expect(
        ru,
        contains("if (o.v === 0 && mod(o.i, 10) === 1 && "
            "mod(o.i, 100) !== 11) return 'one';"),
      );
      expect(ru, contains('inRange(mod(o.i, 10), 2, 4)'));
      expect(ru, contains('!inRange(mod(o.i, 100), 12, 14)'));
      final root = tsRuntimeSource(pluralLocales: ['root'], header: '');
      expect(root, contains('export function plural_root(_operands'));
      expect(root, isNot(contains('function inRange')));
    });

    test('every CLDR locale compiles to a distinct function', () {
      final locales = pluralLocales();
      final source = tsRuntimeSource(pluralLocales: locales, header: '');
      for (final locale in locales) {
        expect(source, contains('export function plural_$locale('));
      }
    });
  });
}
