// The TypeScript and Python runtimes negotiate locales with one algorithm:
// both run the shared table test/fixtures/locale_negotiation.json (skipped
// when node >= 22 / python3 is missing).
@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/src/generate/emit/python/python_runtime.dart';
import 'package:test/test.dart';

import '../sheety.dart';

const String _table = 'test/fixtures/locale_negotiation.json';

void main() {
  final table =
      jsonDecode(io.File(_table).readAsStringSync()) as Map<String, Object?>;
  final groups =
      (table['groups']! as List<Object?>).cast<Map<String, Object?>>();
  final acceptLanguage =
      (table['accept_language']! as List<Object?>).cast<List<Object?>>();
  final normalize =
      (table['normalize']! as List<Object?>).cast<List<Object?>>();

  late io.Directory temp;
  setUp(() => temp = io.Directory.systemTemp.createTempSync('sheety_neg_'));
  tearDown(() => temp.deleteSync(recursive: true));

  /// Runs [script] (reading the table from argv) and returns its JSON output.
  Map<String, Object?> run(String executable, List<String> args) {
    final result = io.Process.runSync(executable, args,
        workingDirectory: temp.path, stdoutEncoding: utf8);
    expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
    return jsonDecode(result.stdout as String) as Map<String, Object?>;
  }

  void verify(Map<String, Object?> got, {required bool bcp47}) {
    String? form(Object? code) => code == null
        ? null
        : bcp47
            ? (code as String).replaceAll('_', '-')
            : code as String;
    final negotiated =
        (got['negotiate']! as List<Object?>).cast<List<Object?>>();
    final mismatches = <String>[];
    for (final (g, group) in groups.indexed) {
      final cases = (group['cases']! as List<Object?>).cast<List<Object?>>();
      for (final (c, entry) in cases.indexed) {
        final want = form(entry[1]);
        final have = negotiated[g][c];
        if (have != want) {
          mismatches.add('${jsonEncode(entry[0])} in ${group['supported']}: '
              'got ${jsonEncode(have)}, want ${jsonEncode(want)}');
        }
      }
    }
    expect(mismatches, isEmpty, reason: mismatches.join('\n'));
    expect(got['accept_language'], [for (final e in acceptLanguage) e[1]]);
    expect(got['normalize'], [for (final e in normalize) e[1]]);
  }

  test('TypeScript runtime', () {
    final version = _nodeMajor();
    if (version == null || version < 22) {
      markTestSkipped('node >= 22 (TypeScript type stripping) is not on PATH');
      return;
    }
    io.File(p.join(temp.path, 'runtime.ts')).writeAsStringSync(
        tsRuntimeSource(pluralLocales: const [], header: ''));
    io.File(p.join(temp.path, 'package.json'))
        .writeAsStringSync('{"type": "module"}');
    io.File(p.join(temp.path, 'run.mjs')).writeAsStringSync(r'''
import { readFileSync } from 'node:fs';
import { negotiateLocale, normalizeLocale, parseAcceptLanguage } from './runtime.ts';
const table = JSON.parse(readFileSync(process.argv[2], 'utf8'));
const bcp47 = (code) => code.replace(/_/g, '-');
console.log(JSON.stringify({
  negotiate: table.groups.map((g) => g.cases.map(([requested]) =>
    negotiateLocale(requested, g.supported.map(bcp47), bcp47(g.default)))),
  accept_language: table.accept_language.map(([h]) => parseAcceptLanguage(h)),
  normalize: table.normalize.map(([t]) => normalizeLocale(t) ?? null),
}));
''');
    verify(
      run('node', [
        if (version < 23) '--experimental-strip-types',
        '--no-warnings',
        'run.mjs',
        p.absolute(_table),
      ]),
      bcp47: true,
    );
  });

  test('Python runtime', () {
    final python = io.Platform.environment['SHEETY_PYTHON'] ?? 'python3';
    try {
      io.Process.runSync(python, ['--version']);
    } on io.ProcessException {
      markTestSkipped('$python is not available');
      return;
    }
    io.File(p.join(temp.path, '_runtime.py'))
        .writeAsStringSync(pythonRuntime('', const []));
    io.File(p.join(temp.path, 'run.py')).writeAsStringSync(r'''
import json, sys
sys.path.insert(0, sys.argv[1])
from _runtime import negotiate_locale, normalize_locale, parse_accept_language
table = json.load(open(sys.argv[2], encoding="utf-8"))
print(json.dumps({
    "negotiate": [
        [negotiate_locale(c[0], g["supported"], g["default"]) for c in g["cases"]]
        for g in table["groups"]
    ],
    "accept_language": [parse_accept_language(e[0]) for e in table["accept_language"]],
    "normalize": [normalize_locale(e[0]) for e in table["normalize"]],
}))
''');
    verify(
      run(python, ['-I', 'run.py', temp.path, p.absolute(_table)]),
      bcp47: false,
    );
  });
}

int? _nodeMajor() {
  try {
    final result = io.Process.runSync('node', ['--version']);
    if (result.exitCode != 0) return null;
    return int.tryParse((result.stdout as String)
        .trim()
        .replaceFirst('v', '')
        .split('.')
        .first);
  } on io.ProcessException {
    return null;
  }
}
