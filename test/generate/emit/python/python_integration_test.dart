@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

import 'python_test_helpers.dart';

/// Integration tests of the generated Python package.
///
/// * `SHEETY_PYTHON` — interpreter to compile and run with (default
///   `python3`; e.g. a Python 3.9 to check the minimum version).
/// * `SHEETY_MYPY_PYTHON` — interpreter that has mypy (default: the one
///   above, when `-m mypy` works there); mypy is skipped otherwise.
/// * `SHEETY_PYRIGHT` — pyright executable (default `pyright` on the
///   `PATH`); skipped when missing.
/// * `SHEETY_REAL_SNAPSHOT` — the real spreadsheet snapshot.
void main() {
  final python = findPython();
  final skip = python == null ? 'python3 is not available' : null;

  group('fixture', () {
    late final _Run run;
    setUpAll(() {
      final read = readPythonCatalog(pythonFixturePath);
      run = _Run.generate(python!, read.catalog, 'fixture');
    });
    tearDownAll(() => run.dispose());

    test('compiles', () => run.compile());
    test('mypy --strict', () => run.mypy());
    test('pyright (strict)', () => run.pyright());
    test('renders like the Dart reference', () {
      final labels = [
        // Raw sheet labels are sanitized by format().
        [
          'backend-2026-09-23-country-names',
          'pt_BR',
          'country.name.ad',
          <String, Object?>{},
          'Andorra',
        ],
        [
          'backend_monetization',
          'ru',
          'monetization.price',
          {'price': r'$5', 'avg_cost': 4.5},
          r'Всего $5 в месяц (4.5 в среднем)',
        ],
      ];
      run.check(
        labels: labels,
        negotiate: {
          'pt-BR': 'pt_BR',
          'PT_br': 'pt_BR',
          'pt': 'pt',
          'pt-PT': 'pt',
          'es-MX': 'es',
          'es-419': 'es_419',
          'fr-CA, de;q=0.9, en;q=0.8': 'de',
          'fr, *;q=0.5': 'en',
          'iw-IL': 'he',
          'en_US.UTF-8': 'en',
          'zh-Hant-TW': 'en',
          'C': 'en',
          '': 'en',
        },
        acceptLanguage: {
          'fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5': [
            'fr-CH',
            'fr',
            'en',
            'de',
          ],
          'en;q=0.5, ru': ['ru', 'en'],
          'de;q=0, en': ['en'],
          'a;q=0.5,b;q=0.5, c;q=bad': ['a', 'b'],
          '': [],
        },
      );
    });
  }, skip: skip);

  group('messages named like builtins, lone surrogates', () {
    late final _Run run;
    setUpAll(() {
      final read = readCatalog([
        (
          title: 'realty',
          values: [
            ['label', 'description', 'meta', 'en', 'de'],
            ['aProperty', 'bad \uD800 description', '', 'A', 'A'],
            for (final key in [
              'property', 'str', 'int', 'float', 'object', 'frozenset', //
              'bool', 'staticmethod', 'classmethod', 'dict', 'tuple',
            ])
              [key, '', '', key.toUpperCase(), key],
            [
              'typed',
              '',
              '{"placeholders": {"i": {"type": "int"}, '
                  '"f": {"type": "double"}, "o": {"type": "Object"}}}',
              '{s} {i} {f} {o} {i, plural, one{one} other{many}}',
              '{s} {i} {f} {o} \uDC00',
            ],
            ['zTitle', '', '', 'Z', 'Z'],
          ],
        ),
      ]);
      expect(read.diagnostics.where((d) => d.isError), isEmpty);
      run = _Run.generate(python!, read.catalog, 'builtins');
    });
    tearDownAll(() => run.dispose());

    test('compiles', () => run.compile());
    test('mypy --strict', () => run.mypy());
    test('pyright (strict)', () => run.pyright());
    test('renders like the Dart reference', () => run.check());
  }, skip: skip);

  final real = io.Platform.environment['SHEETY_REAL_SNAPSHOT'];
  group('real snapshot', () {
    late final _Run run;
    late final List<String> excluded;
    setUpAll(() {
      final read = readPythonCatalog(
        real!,
        options: ReaderOptions(mustacheSheets: [RegExp('^backend')]),
      );
      final broken = {
        for (final d in read.diagnostics)
          if (d.code == DiagnosticCode.icuSyntax && d.scope != null) d.scope!,
      };
      excluded = broken.toList()..sort();
      final catalog = read.catalog.where((s) => !broken.contains(s.name));
      print('Python real snapshot: ${catalog.scopes.length} scopes, '
          '${catalog.locales.length} locales; excluded (ICU errors): '
          '${excluded.isEmpty ? 'none' : excluded.join(', ')}');
      run = _Run.generate(python!, catalog, 'real');
    });
    tearDownAll(() => run.dispose());

    test('compiles', () => run.compile());
    test('mypy --strict', () => run.mypy());
    test('pyright (strict)', () => run.pyright());
    test('renders like the Dart reference', () => run.check());
  }, skip: skip ?? (real == null ? 'SHEETY_REAL_SNAPSHOT is not set' : null));
}

/// A generated package inside a dummy package in a temporary directory.
final class _Run {
  _Run._(this.python, this.catalog, this.root);

  factory _Run.generate(String python, Catalog catalog, String name) {
    final root = io.Directory.systemTemp.createTempSync('sheety_py_$name');
    final package = io.Directory('${root.path}/dummy_pkg')..createSync();
    io.File('${package.path}/__init__.py').writeAsStringSync('');
    writeFiles(
      io.Directory('${package.path}/l10n'),
      const PythonEmitter().emit(catalog, const EmitOptions()),
    );
    return _Run._(python, catalog, root);
  }

  final String python;
  final Catalog catalog;
  final io.Directory root;

  void dispose() => root.deleteSync(recursive: true);

  void compile() {
    runChecked(
        python, ['-I', '-W', 'error', '-m', 'compileall', '-q', 'dummy_pkg'],
        workingDirectory: root.path);
  }

  void mypy() {
    final env = io.Platform.environment['SHEETY_MYPY_PYTHON'];
    final interpreter = env ?? python;
    if (!hasPythonModule(interpreter, 'mypy')) {
      markTestSkipped('mypy is not available (set SHEETY_MYPY_PYTHON)');
      return;
    }
    runChecked(
      interpreter,
      ['-m', 'mypy', '--strict', '--no-incremental', '-p', 'dummy_pkg'],
      workingDirectory: root.path,
    );
  }

  void pyright() {
    final executable = io.Platform.environment['SHEETY_PYRIGHT'] ?? 'pyright';
    try {
      io.Process.runSync(executable, ['--version']);
    } on io.ProcessException {
      markTestSkipped('pyright is not available (set SHEETY_PYRIGHT)');
      return;
    }
    io.File('${root.path}/pyrightconfig.json').writeAsStringSync(jsonEncode({
      'typeCheckingMode': 'strict',
      'pythonVersion': '3.9',
      'include': ['dummy_pkg'],
    }));
    runChecked(executable, ['--pythonpath', _which(python)],
        workingDirectory: root.path);
  }

  /// Renders every scope x locale x message x argument set in Python and
  /// compares with [referenceRender]; also the metadata, the plural rules
  /// (over 0..1000 and decimals), `to_str` and locale negotiation.
  void check({
    List<List<Object?>> labels = const [],
    Map<String, String> negotiate = const {},
    Map<String, List<String>> acceptLanguage = const {},
  }) {
    final render = <List<Object?>>[];
    final expected = <String>[];
    for (final scope in catalog.scopes) {
      for (final locale in scope.localeTags) {
        for (final message in scope.messages) {
          for (final args in argumentSets(message)) {
            render.add([scope.name, locale.code, message.key, args]);
            expected.add(referenceRender(message, locale, args));
          }
        }
      }
    }
    final numbers = <num>[
      for (var i = 0; i <= 1000; i++) i,
      for (var i = 0; i <= 100; i++) i / 10,
      for (var i = 0; i <= 300; i += 7) i / 100,
      1e6, 2e6, 1.5, 21.5, 100.05, 1.005, -1, -1.5, 1e-7, 0.999, //
    ];
    final values = <num>[
      0.0, -0.0, 1.0, 1.5, 0.1, 1e20, 1e21, 1.5e21, 1e-6, 1e-7, 1.5e-7, //
      0.000123, 1e16, 2.5e15, 100.0, 1 / 3, 1e300, 5e-324, 0.1 + 0.2,
      123456789.125, -42.5, 7, -3, 9007199254740993, 1.7976931348623157e308,
    ];
    final cases = io.File('${root.path}/cases.json')
      ..writeAsStringSync(jsonEncode({
        'render': render,
        'labels': labels,
        'numbers': numbers,
        'values': values,
        'negotiate': negotiate.keys.toList(),
        'accept_language': acceptLanguage.keys.toList(),
      }));
    final out = io.File('${root.path}/out.json');
    final script = io.File('test/fixtures/python/check_package.py').absolute;
    runChecked(python, [
      '-I',
      script.path,
      root.path,
      'dummy_pkg.l10n',
      cases.path,
      out.path,
    ]);
    final result = jsonDecode(out.readAsStringSync()) as Map<String, Object?>;

    final rendered = (result['render']! as List<Object?>).cast<String>();
    expect(rendered.length, expected.length);
    final mismatches = [
      for (var i = 0; i < expected.length; i++)
        if (rendered[i] != expected[i])
          '${render[i]}: python ${jsonEncode(rendered[i])} != '
              'dart ${jsonEncode(expected[i])}',
    ];
    expect(mismatches, isEmpty, reason: mismatches.take(20).join('\n'));
    print('${expected.length} renderings agree');

    expect(result['scopes'], [for (final s in catalog.scopes) s.name]);
    expect(result['supported'], [for (final l in catalog.locales) l.code]);
    final meta = result['meta']! as Map<String, Object?>;
    for (final scope in catalog.scopes) {
      final scopeMeta = meta[scope.name]! as Map<String, Object?>;
      expect(scopeMeta['keys'], [for (final m in scope.messages) m.key]);
      final locales = scopeMeta['locales']! as Map<String, Object?>;
      expect(locales.keys, [for (final l in scope.localeTags) l.code]);
      for (final locale in scope.localeTags) {
        final data = locales[locale.code]! as Map<String, Object?>;
        expect(data['templates'], {
          for (final m in scope.messages) m.key: m.translationFor(locale).raw,
        });
        expect(
          data['fallback'],
          [
            for (final m in scope.messages)
              if (m.translationFor(locale).isFallback) m.key,
          ]..sort(),
        );
      }
    }

    final plural = result['plural']! as Map<String, Object?>;
    final pluralMismatches = <String>[];
    for (final locale in catalog.locales) {
      final rules = pluralRulesFor(locale.code);
      final got = (plural[locale.code]! as List<Object?>).cast<String>();
      for (var i = 0; i < numbers.length; i++) {
        final want = rules.select(PluralOperands.intl(numbers[i])).name;
        if (got[i] != want) {
          pluralMismatches.add('$locale ${numbers[i]}: python ${got[i]}, '
              'dart $want');
        }
      }
    }
    expect(pluralMismatches, isEmpty,
        reason: pluralMismatches.take(20).join('\n'));

    expect(result['to_str'], [for (final v in values) dartString(v)]);
    expect(result['negotiate'], negotiate.values.toList());
    expect(result['accept_language'], acceptLanguage.values.toList());
  }
}

String _which(String python) {
  final result = io.Process.runSync(
    python,
    ['-c', 'import sys; print(sys.executable)'],
  );
  return (result.stdout as String).trim();
}
