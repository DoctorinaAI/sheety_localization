import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';
import 'package:sheety_localization/src/generate/emit/python/python_code.dart';
import 'package:sheety_localization/src/generate/emit/python/python_runtime.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import 'python_test_helpers.dart';

const String _goldenDir = 'test/golden/python';

void main() {
  const emitter = PythonEmitter();
  final fixture = readPythonCatalog(pythonFixturePath);
  final files = emitter.emit(fixture.catalog, const EmitOptions());
  String file(String path) =>
      files.firstWhere((f) => f.relativePath == path).contents;

  group('fixture', () {
    test(
        'has no errors; warnings only for the deliberately incomplete '
        'plurals', () {
      final problems = fixture.diagnostics
          .where((d) => d.severity.isAtLeast(Severity.warning))
          .where((d) => d.code != DiagnosticCode.pluralMissingCategory)
          .toList();
      expect(problems, isEmpty, reason: formatDiagnostics(problems));
    });

    test('covers every feature', () {
      final app = fixture.catalog.scope('app')!;
      final selectors = {
        for (final m in app.messages)
          for (final t in m.translations.values)
            for (final p in t.ast.plurals)
              for (final b in p.branches) b.selector,
      };
      expect(
        selectors,
        containsAll(['=0', '=1', 'zero', 'one', 'two', 'few', 'many', 'other']),
      );
      expect(app.syntheticLocales,
          {const LocaleTag('pt'): const LocaleTag('pt_BR')});
      expect(app.fallbackCount(const LocaleTag('ar')), greaterThan(0));
      final countries = fixture.catalog.scope(
        'backend_2026_09_23_country_names',
      )!;
      expect(
        countries
            .message('country_name_br')!
            .translationFor(const LocaleTag('pt', country: 'BR'))
            .fallbackFrom,
        const LocaleTag('pt'),
      );
      expect(
        fixture.catalog.scope('backend_monetization')!.syntax,
        MessageSyntax.mustache,
      );
    });
  });

  group('golden', () {
    test('output matches test/golden/python', () {
      final update = io.Platform.environment['UPDATE_GOLDENS'] == '1';
      final root = io.Directory(_goldenDir);
      if (update) {
        if (root.existsSync()) root.deleteSync(recursive: true);
        writeFiles(root, files);
      }
      final expected = {
        for (final entity in root.listSync(recursive: true))
          if (entity is io.File)
            entity.path.substring(root.path.length + 1):
                entity.readAsStringSync(),
      };
      expect(
        files.map((f) => f.relativePath).toSet(),
        expected.keys.toSet(),
        reason: 'Run with UPDATE_GOLDENS=1 to regenerate the goldens',
      );
      for (final f in files) {
        expect(
          f.contents,
          expected[f.relativePath],
          reason: '${f.relativePath} differs; run with UPDATE_GOLDENS=1',
        );
      }
    });
  });

  group('layout', () {
    test('root, runtime, one package per scope, one module per locale', () {
      expect(files.map((f) => f.relativePath), [
        '__init__.py',
        'py.typed',
        '_runtime.py',
        'app/__init__.py',
        for (final l in ['en', 'ru', 'pt_BR', 'ar', 'sl', 'he', 'de', 'ja'])
          'app/_$l.py',
        'app/_pt.py',
        'backend_2026_09_23_country_names/__init__.py',
        for (final l in ['en', 'ru', 'pt', 'pt_BR', 'es_419', 'es'])
          'backend_2026_09_23_country_names/_$l.py',
        'backend_monetization/__init__.py',
        'backend_monetization/_en.py',
        'backend_monetization/_ru.py',
      ]);
    });

    test('is deterministic', () {
      final again = emitter.emit(
        readPythonCatalog(pythonFixturePath).catalog,
        const EmitOptions(),
      );
      expect(
        [for (final f in again) '${f.relativePath}\n${f.contents}'],
        [for (final f in files) '${f.relativePath}\n${f.contents}'],
      );
    });

    test('every module starts with the header; imports are relative', () {
      for (final f in files.where((f) => f.relativePath.endsWith('.py'))) {
        expect(
          f.contents,
          startsWith('# This file is generated, do not edit it manually!\n'),
          reason: f.relativePath,
        );
        expect(
          RegExp(
                  r'^\s*(from|import) (?!\.|__future__|typing|abc|importlib|'
                  r'math|re|types|dataclasses)',
                  multiLine: true)
              .hasMatch(f.contents),
          isFalse,
          reason: '${f.relativePath} imports something non-relative',
        );
      }
    });

    test('header is configurable and can be empty', () {
      final custom = emitter.emit(
        fixture.catalog,
        const EmitOptions(header: 'Line one\n\nLine three'),
      );
      expect(
        custom.first.contents,
        startsWith('# Line one\n#\n# Line three\n# ruff: noqa\n'),
      );
      final none = emitter.emit(fixture.catalog, const EmitOptions(header: ''));
      expect(none.first.contents, startsWith('# ruff: noqa\n'));
    });

    test('empty catalog', () {
      final out = emitter.emit(Catalog(const []), const EmitOptions());
      expect(out.map((f) => f.relativePath),
          ['__init__.py', 'py.typed', '_runtime.py']);
      expect(
          out.first.contents, contains('SCOPES: _typing.Tuple[str, ...] = ()'));
    });
  });

  group('generated code', () {
    test('snake_case properties and keyword-only typed methods', () {
      final base = file('app/__init__.py');
      expect(base, contains('class AppLocalization(Localization):'));
      expect(base, contains('    def title(self) -> str:'));
      expect(base, contains('def greeting(self, *, user_name: str) -> str:'));
      expect(base, contains('def get_http_error(self, *, status_code: int)'));
      expect(base, contains('def step2_title(self) -> str:'));
      expect(base, contains('def type(self, *, id: str) -> str:'));
      expect(base, contains('def distance(self, *, km: float) -> str:'));
      expect(base, contains('def price(self, *, amount: float) -> str:'));
      expect(base, contains('def last_seen(self, *, when: object) -> str:'));
      expect(
        base,
        contains('def pronoun(self, *, gender: str, count: int) -> str:'),
      );
    });

    test('scope titles become package names, labels sanitized keys', () {
      final countries = file('backend_2026_09_23_country_names/__init__.py');
      expect(
        countries,
        contains('class Backend20260923CountryNamesLocalization'),
      );
      expect(countries, contains('key="country_name_ad"'));
      expect(
          countries,
          contains('SHEET_TITLE = '
              '"backend-2026-09-23-country-names"'));
    });

    test('plural with intl selection, per-locale CLDR rule', () {
      final ru = file('app/_ru.py');
      expect(
        ru,
        contains('_c0 = _plural_case(count, _rule, '
            '("zero", "one", "few", "many", "other"))'),
      );
      expect(
        ru,
        contains('from .._runtime import cardinal_ru as _rule, '
            'plural_case as _plural_case, select_case as _select_case, '
            'to_str as _to_str'),
      );
      expect(file('app/_pt_BR.py'), contains('cardinal_pt as _rule'));
      expect(file('app/_ja.py'), contains('_t0 = f"{_to_str(count)} 個"'));
    });

    test('fallbacks are resolved at generation time and listed', () {
      final ar = file('app/_ar.py');
      expect(ar, contains('"distance",'));
      expect(ar, contains('FALLBACK_KEYS = frozenset('));
      final ptBr = file('backend_2026_09_23_country_names/_pt_BR.py');
      expect(ptBr, contains('return "Brasil"'));
      expect(
          ptBr,
          contains('FALLBACK_KEYS = frozenset(("country_name_br", '
              '"country_name_us"))'));
      expect(ptBr, contains('return "Estados Unidos"'));
    });

    test('synthetic parent locale', () {
      expect(file('app/_pt.py'), contains('copied from pt_BR'));
      expect(
          file('app/__init__.py'),
          contains('"pt_BR", "ar", "sl", "he", '
              '"de", "ja", "pt")'));
    });

    test('mustache scope', () {
      final en = file('backend_monetization/_en.py');
      expect(
        en,
        contains('"monetization_price": "Only {{price}} per month '
            '({{ avg_cost }} on average)",'),
      );
      expect(
        en,
        contains('return f"Only {_to_str(price)} per month '
            '({_to_str(avg_cost)} on average)"'),
      );
      expect(en, contains('return "Support {consult}"'));
      expect(file('backend_monetization/__init__.py'),
          contains('SYNTAX = "mustache"'));
    });

    test('runtime compiles only the rules in use', () {
      final runtime = file('_runtime.py');
      for (final name in [
        'en',
        'ru',
        'pt',
        'ar',
        'sl',
        'he',
        'de',
        'ja',
        'es',
        'root'
      ]) {
        expect(runtime, contains('def cardinal_$name('), reason: name);
      }
      expect(runtime, isNot(contains('def cardinal_fr(')));
      expect(runtime, contains('    "pt_BR": cardinal_pt,'));
      expect(runtime, contains('    "es_419": cardinal_es,'));
    });
  });

  group('identifiers', () {
    List<Diagnostic> diagnosticsOf(List<List<Object?>> rows,
        {String title = 'scope'}) {
      final read = readCatalog(sheet(title, rows));
      return validateIdentifiers(
        read.catalog,
        Target.python,
        reserved: PythonEmitter.reservedNames,
      );
    }

    const header = ['label', 'description', 'meta', 'en'];

    test('keywords, API names and collisions are errors', () {
      final d = diagnosticsOf([
        header,
        ['class', '', '', 'x'],
        ['format', '', '', 'x'],
        ['fooBar', '', '', 'x'],
        ['foo_bar', '', '', 'y'],
        ['ok', '', '', '{self}'],
      ]);
      expect(codes(d), containsAll(['reserved-word', 'name-collision']));
      expect(d.where((x) => x.key == 'class'), isNotEmpty);
      expect(d.where((x) => x.key == 'format'), isNotEmpty);
      expect(d.where((x) => x.key == 'ok'), isNotEmpty);
    });

    test('a scope named like a root API name is an error', () {
      final d = diagnosticsOf([
        header,
        ['a', '', '', 'x']
      ], title: 'get');
      expect(codes(d), ['reserved-word']);
    });

    test('builtins and soft keywords are fine', () {
      final d = diagnosticsOf([
        header,
        ['type', '', '', '{id} {match} {case}'],
        ['match', '', '', 'x'],
        ['id', '', '', 'x'],
        ['locale', '', '', 'x'],
      ]);
      expect(d, isEmpty);
    });

    test('emit refuses an invalid catalog', () {
      final read = readCatalog(sheet('s', [
        header,
        ['format', '', '', 'x']
      ]));
      expect(
        () => emitter.emit(read.catalog, const EmitOptions()),
        throwsStateError,
      );
    });

    test('naming', () {
      expect(pyMessageName('drawerTooltipHelp'), 'drawer_tooltip_help');
      expect(pyMessageName('getHTTPError'), 'get_http_error');
      expect(pyMessageName('openAIKey'), 'open_ai_key');
      expect(pyMessageName('step2Title'), 'step2_title');
      expect(pyMessageName('country_name_ad'), 'country_name_ad');
      expect(pyParameterName('maxFiles'), 'max_files');
      expect(pyLocaleModule(const LocaleTag('pt', country: 'BR')), '_pt_BR');
      expect(pyLocaleModule(const LocaleTag('es', country: '419')), '_es_419');
    });
  });

  group('literals', () {
    test('pyString escapes what Python needs', () {
      expect(pyString(''), '""');
      expect(pyString('a"b'), r'"a\"b"');
      expect(pyString("it's"), '"it\'s"');
      expect(pyString(r'a\b'), r'"a\\b"');
      expect(pyString('a\nb\r\tc'), r'"a\nb\r\tc"');
      expect(pyString('\x00\x1b\x7f\x85'), r'"\x00\x1b\x7f\x85"');
      expect(pyString('\u2028\u2029\ufeff'), r'"\u2028\u2029\ufeff"');
      expect(pyString(r'$x {y}'), r'"$x {y}"');
      expect(pyString('Привет 👋🏽 مثال'), '"Привет 👋🏽 مثال"');
      expect(pyString('\ud800x'), r'"\ud800x"');
      expect(pyString('x\udc00'), r'"x\udc00"');
    });

    test('f-string text doubles braces', () {
      expect(pyFStringText('{a} "b"'), r'{{a}} \"b\"');
    });

    test('docstrings', () {
      expect(pyDocText('a "b" \\\nc', '    '), 'a "b" \\\\\n    c');
      expect(pyDocText('say "hi"', ''), r'say "hi\"');
      expect(pyDocText('a """ b', ''), r'a \"\"" b');
      expect(pyDocText('x\n\n  y  \n', '  '), 'x\n\n    y\n');
    });

    test('tuples', () {
      expect(pyStringTuple([]), '()');
      expect(pyStringTuple(['a']), '("a",)');
      expect(pyStringTuple(['a', 'b']), '("a", "b")');
    });

    test('types', () {
      expect(pyType(PlaceholderType.string), 'str');
      expect(pyType(PlaceholderType.int), 'int');
      expect(pyType(PlaceholderType.num), 'float');
      expect(pyType(PlaceholderType.double), 'float');
      expect(pyType(PlaceholderType.object), 'object');
    });
  });

  group('plural rule compiler', () {
    test('ru', () {
      expect(compilePluralFunction('ru'), '''
def cardinal_ru(i: int, v: int, f: int, t: int) -> str:
    """CLDR $cldrVersion cardinal rules of "ru"."""
    if v == 0 and i % 10 == 1 and i % 100 != 11:
        return "one"
    if v == 0 and 2 <= i % 10 <= 4 and not 12 <= i % 100 <= 14:
        return "few"
    if (v == 0 and i % 10 == 0) or (v == 0 and 5 <= i % 10 <= 9) or (v == 0 and 11 <= i % 100 <= 14):
        return "many"
    return "other"
''');
    });

    test('n relations require an integral value', () {
      expect(compilePluralFunction('en'), contains('if i == 1 and v == 0:'));
      expect(compilePluralFunction('de'), contains('if i == 1 and v == 0:'));
      expect(compilePluralFunction('ak'),
          contains('if (f == 0 and 0 <= i <= 1):'));
    });

    test('w and e are folded (always 0 in intl)', () {
      final fr = compilePluralFunction('fr');
      expect(fr, isNot(contains(' e ')));
      expect(fr, contains('return "many"'));
      // `e = 0 and i != 0 and i % 1000000 = 0 and v = 0 or e != 0..5`
      expect(fr, contains('if i != 0 and i % 1000000 == 0 and v == 0:'));
    });

    test('root and locales without categories', () {
      expect(compilePluralFunction(null), contains('def cardinal_root('));
      expect(compilePluralFunction('ja'), endsWith('    return "other"\n'));
      expect(pyPluralFunctionFor(const LocaleTag('xx')), 'cardinal_root');
      expect(pyPluralFunctionFor(const LocaleTag('pt', country: 'PT')),
          'cardinal_pt_PT');
    });
  });

  group('reference renderer', () {
    test('matches the Dart semantics', () {
      final app = fixture.catalog.scope('app')!;
      final items = app.message('items')!;
      const sl = LocaleTag('sl');
      // sl has no `two` branch: two -> few (intl quirk).
      expect(referenceRender(items, sl, {'count': 2}), '2 izdelki');
      expect(referenceRender(items, sl, {'count': 102}), '102 izdelki');
      expect(referenceRender(items, const LocaleTag('en'), {'count': 0}),
          'No items');
      expect(referenceRender(items, const LocaleTag('ru'), {'count': 21}),
          '21 товар');
      final distance = app.message('distance')!;
      // intl rounds: 1.5 -> i = 2 in pt.
      expect(
        referenceRender(
            distance, const LocaleTag('pt', country: 'BR'), {'km': 1.5}),
        '1.5 quilômetros',
      );
      expect(referenceRender(distance, const LocaleTag('en'), {'km': 1.0}),
          '1.0 kilometer');
      final pronoun = app.message('pronoun')!;
      expect(
        referenceRender(pronoun, const LocaleTag('en'),
            {'gender': 'Gender.female', 'count': 1}),
        'She has one cat',
      );
    });
  });
  group('robust class bodies', () {
    List<GeneratedFile> emitSheet(List<List<Object?>> rows) => emitter.emit(
          readCatalog([
            (
              title: 'realty',
              values: [
                ['label', 'description', 'meta', 'en'],
                ...rows,
              ],
            ),
          ]).catalog,
          const EmitOptions(),
        );
    String of(List<GeneratedFile> files, String path) =>
        files.firstWhere((f) => f.relativePath == path).contents;

    test('builtins a message hides are used as _builtins.<name>', () {
      final files = emitSheet([
        ['aProperty', '', '', 'A'],
        ['property', '', '', 'P'],
        ['str', '', '', 'S'],
        ['n', '', '', '{c, plural, one{1} other{n}}'],
      ]);
      final scope = of(files, 'realty/__init__.py');
      expect(scope, contains('import builtins as _builtins\n'));
      expect(scope, contains('    @_builtins.property\n'));
      expect(scope, contains('def a_property(self) -> _builtins.str:'));
      expect(scope, contains('def n(self, *, c: float) -> _builtins.str:'));
      expect(scope, isNot(contains('    @property\n')));
      final en = of(files, 'realty/_en.py');
      expect(en, contains('import builtins as _builtins\n'));
      expect(en, contains('    @_builtins.property\n'));
      expect(en, contains('FALLBACK_KEYS = frozenset()'));
    });

    test('other scopes stay as they were', () {
      final files = emitSheet([
        ['title', '', '', 'T'],
      ]);
      expect(of(files, 'realty/__init__.py'), isNot(contains('_builtins')));
      expect(of(files, 'realty/_en.py'), contains('    @property\n'));
    });

    test('docstrings show U+FFFD for lone surrogates, values keep them', () {
      final files = emitSheet([
        ['a', 'bad \uD800 desc', '', 'A \uDC00'],
      ]);
      final scope = of(files, 'realty/__init__.py');
      expect(scope, contains('bad � desc'));
      expect(scope, contains('In en: A �'));
      expect(scope, isNot(contains(r'"""bad \ud800')));
      expect(scope, contains(r'description="bad \ud800 desc"'));
      expect(of(files, 'realty/_en.py'), contains(r'return "A \udc00"'));
    });
  });
}
