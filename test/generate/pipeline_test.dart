import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../sheety.dart';
import '../fixtures/infra/fake_emitter.dart';

const _multi = 'test/fixtures/infra/multi_snapshot.json';
const _errors = 'test/fixtures/infra/error_snapshot.json';

void main() {
  late io.Directory temp;
  late String cwd;
  setUp(() {
    temp = io.Directory.systemTemp.createTempSync('sheety_pipeline_');
    cwd = temp.resolveSymbolicLinksSync();
  });
  tearDown(() => temp.deleteSync(recursive: true));

  GenerateConfig config(List<String> args) => GenerateConfig.fromArgs(
        generateArgParser().parse(args),
        workingDirectory: cwd,
      );

  Future<GenerateResult> run(
    List<String> args, {
    TargetRegistry? registry,
    CodeFormatter? formatter,
    List<String>? log,
    void Function(String line)? verbose,
  }) {
    final c = config(args);
    return GeneratePipeline(
      registry: registry ?? fakeRegistry(),
      dartFormatter: formatter ?? FakeFormatter(),
      log: log?.add,
      verbose: verbose ?? log?.add,
    ).run(c, SnapshotSource(c.snapshot!));
  }

  String read(String rel) => io.File(p.join(cwd, rel)).readAsStringSync();
  bool exists(String rel) => io.File(p.join(cwd, rel)).existsSync();

  final multi = p.absolute(_multi);
  final errors = p.absolute(_errors);
  final targetsArgs = [
    '--snapshot=$multi',
    '--ignore=^help\$',
    '--mustache=^backend-',
    '--dart=out/dart',
    '--dart-ignore=^backend',
    '--ts=out/ts',
    '--ts-ignore=^backend',
    '--python=out/py',
    '--python-include=^backend',
  ];

  test('generates every target with its own selection of sheets', () async {
    final formatter = FakeFormatter();
    final result = await run(targetsArgs, formatter: formatter);
    expect(result.hasErrors, isFalse, reason: formatResultText(result));
    expect(result.exitCode, exitOk);
    expect(result.written, isTrue);
    expect({
      for (final t in result.targets) t.target.id: t.scopes
    }, {
      'dart': ['app', 'sign_up'],
      'ts': ['app', 'sign_up'],
      'python': ['backend_mail'],
    });
    expect(read('out/dart/index.txt'), contains('app\nsign_up'));
    expect(read('out/py/backend_mail/backend_mail.txt'), contains('subject'));
    expect(exists('out/py/app/app.txt'), isFalse);
    // Dart output is formatted; the other targets are not.
    expect(formatter.calls, 1);
    expect(read('out/dart/scopes.dart'), endsWith('// formatted\n'));
    // Each target has its own manifest with its own scopes.
    final manifest = jsonDecode(read('out/py/$manifestFileName')) as Map;
    expect([for (final s in manifest['scopes'] as List) (s as Map)['name']],
        ['backend_mail']);
    expect((manifest['files'] as Map).keys,
        ['backend_mail/backend_mail.txt', 'index.txt']);
  });

  test('a second run changes nothing; --check is clean', () async {
    await run(targetsArgs);
    final again = await run(targetsArgs);
    expect([for (final t in again.targets) t.plan!.hasChanges],
        [false, false, false]);
    final check = await run([...targetsArgs, '--check']);
    expect(check.isStale, isFalse);
    expect(check.exitCode, exitOk);
    expect(formatResultText(check), contains('up to date'));
  });

  test('--check reports stale output and writes nothing', () async {
    await run(targetsArgs);
    io.File(p.join(cwd, 'out/ts/index.txt')).writeAsStringSync('edited');
    io.File(p.join(cwd, 'out/ts/app/app.txt')).deleteSync();
    final check = await run([...targetsArgs, '--check']);
    expect(check.exitCode, exitStale);
    final ts = check.targets.firstWhere((t) => t.target == Target.ts).plan!;
    expect(ts.changed, ['index.txt']);
    expect(ts.added, ['app/app.txt']);
    expect(read('out/ts/index.txt'), 'edited');
    final text = formatResultText(check);
    expect(text, contains('OUT OF DATE'));
    expect(text, contains('  ~ index.txt'));
    expect(text, contains('  + app/app.txt'));
  });

  test('a scope that leaves a target is deleted from its output', () async {
    await run(targetsArgs);
    expect(exists('out/dart/sign_up/sign_up.txt'), isTrue);
    final result =
        await run([...targetsArgs, '--dart-ignore=^backend,^sign-up']);
    final dart = result.targets.first.plan!;
    expect(dart.removed, ['sign_up/sign_up.txt']);
    expect(exists('out/dart/sign_up/sign_up.txt'), isFalse);
  });

  test('sheet errors stop everything and are all reported', () async {
    final result = await run(['--snapshot=$errors', '--ts=out/ts']);
    expect(result.exitCode, exitErrors);
    expect(result.written, isFalse);
    expect(io.Directory(p.join(cwd, 'out')).existsSync(), isFalse);
    expect(result.diagnostics.where((d) => d.isError).map((d) => d.code.id),
        contains('icu-syntax'));
    expect(result.diagnostics.map((d) => d.code.id),
        contains('plural-missing-category'));
    final text = formatResultText(result);
    expect(text, contains('icu-syntax'));
    expect(text, contains('nothing was written'));
  });

  test('warnings pass, unless --strict', () async {
    final ok = await run(['--snapshot=$errors', '--ignore=^app\$', '--ts=o']);
    expect(ok.exitCode, exitOk, reason: formatResultText(ok));
    expect(ok.diagnostics.where((d) => d.severity == Severity.warning),
        isNotEmpty);
    final strict = await run(
        ['--snapshot=$errors', '--ignore=^app\$', '--ts=o2', '--strict']);
    expect(strict.exitCode, exitErrors);
    expect(exists('o2/index.txt'), isFalse);
  });

  test('sheets used by no target are not even read', () async {
    // The broken `app` sheet is ignored by the only target.
    final result =
        await run(['--snapshot=$errors', '--ts=o', '--ts-include=^chat\$']);
    expect(result.diagnostics.map((d) => d.code.id),
        isNot(contains('icu-syntax')));
    expect(result.targets.single.scopes, ['chat']);
  });

  test('identifier checks use the target reserved names', () async {
    final snapshot = io.File(p.join(cwd, 's.json'))
      ..writeAsStringSync(jsonEncode({
        'sheets': [
          {
            'title': 'app',
            'values': [
              ['label', 'description', 'meta', 'en'],
              ['reservedByFake', '', '', 'x'],
            ],
          },
        ],
      }));
    final result = await run(['--snapshot=${snapshot.path}', '--ts=o']);
    expect(result.exitCode, exitErrors);
    expect(
      result.diagnostics.where((d) => d.isError).map((d) => d.target),
      contains('ts'),
    );
  });

  test('a target selecting nothing is an error', () async {
    final result =
        await run(['--snapshot=$multi', '--ts=o', '--ts-include=^nothing']);
    expect(result.issues.map((i) => i.code), ['no-scopes']);
    expect(result.exitCode, exitErrors);
  });

  test('an unavailable target or a failing emitter is an error', () async {
    final none = await run(['--snapshot=$multi', '--ts=o'],
        registry: TargetRegistry(const []));
    expect(none.issues.map((i) => i.code), ['target-unavailable']);
    final failing = await run(
        ['--snapshot=$multi', '--ignore=^backend', '--ts=o', '--dart=d'],
        registry: fakeRegistry(failing: {Target.ts}));
    expect(failing.issues.map((i) => i.code), ['emitter-failed']);
    // All or nothing: the dart target is not written either.
    expect(exists('d/index.txt'), isFalse);
  });

  test('unknown target options are reported when the emitter lists them',
      () async {
    io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('''
snapshot: $multi
targets:
  ts: {output: o, options: {barel: x}}
''');
    final result = await run(const [],
        registry: fakeRegistry(options: {'barrel': OptionKind.string}));
    expect(result.issues.single.message, contains('"barel"'));
  });

  test('options and header reach the emitter', () async {
    final result = await run([
      '--snapshot=$multi',
      '--lib=pkg/lib',
      '--gen=src/gen',
      '--header=// Custom',
      '--dart-ignore=^backend',
    ]);
    expect(result.exitCode, exitOk);
    final text = read('pkg/lib/app/app.txt');
    expect(text, startsWith('# Custom\n'));
    expect(text, contains('directory: src/gen'));
  });

  test('takes over 0.6.0 output and lists what it leaves behind', () async {
    final lib = p.join(cwd, 'lib');
    for (final (rel, contents) in [
      ('index.txt', '# ${EmitOptions.defaultHeader}\nold'),
      ('src/l10n/app/app_en.arb', '{}'),
      (
        'src/generated/app/app_localization.dart',
        '// ${EmitOptions.defaultHeader}\n'
      ),
      ('pubspec.yaml', 'name: mine'),
    ]) {
      io.File(p.join(lib, rel))
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(contents);
    }
    final result = await run(
        ['--snapshot=$multi', '--dart=lib', '--dart-ignore=^backend']);
    expect(result.exitCode, exitOk, reason: formatResultText(result));
    final legacy = result.issues.singleWhere((i) => i.code == 'legacy-output');
    expect(legacy.message, contains('src/l10n/app/app_en.arb'));
    expect(legacy.message, contains('app_localization.dart'));
    expect(legacy.message, isNot(contains('pubspec.yaml')));
    expect(read('lib/index.txt'), contains('sign_up'));
    expect(read('lib/pubspec.yaml'), 'name: mine');
  });

  test('--dump-snapshot writes everything that was read', () async {
    final out = p.join(cwd, 'dump.json');
    final result = await run(['--snapshot=$multi', '--dump-snapshot=$out']);
    expect(result.exitCode, exitOk);
    expect(result.sheets, 4);
    expect(
      encodeSnapshot(await SnapshotSource(out).fetchAll()),
      encodeSnapshot(await SnapshotSource(multi).fetchAll()),
    );
  });

  test('a broken source is an issue, not a crash', () async {
    final result =
        await run(['--snapshot=${p.join(cwd, 'none.json')}', '--ts=o']);
    expect(result.issues.single.code, 'source-error');
    expect(result.exitCode, exitErrors);
  });

  test('a failing formatter blocks the dart target', () async {
    final result = await run(
        ['--snapshot=$multi', '--ignore=^backend', '--dart=o'],
        formatter: _ThrowingFormatter());
    expect(result.issues.single.code, 'format-failed');
    expect(result.exitCode, exitErrors);
  });

  group('reports', () {
    test('JSON is machine-readable', () async {
      final result = await run(['--snapshot=$errors', '--ts=o']);
      final json = jsonDecode(jsonEncode(result.toJson())) as Map;
      expect(json['ok'], isFalse);
      expect(json['exitCode'], exitErrors);
      expect((json['summary'] as Map)['errors'], greaterThan(0));
      final first = (json['diagnostics'] as List).first as Map;
      expect(first.keys, containsAll(['code', 'severity', 'message']));
    });

    test('GitHub annotations escape their payload', () async {
      final result = await run(['--snapshot=$errors', '--ts=o']);
      final lines = githubAnnotations(result);
      expect(lines, isNotEmpty);
      final error = lines.firstWhere((l) => l.contains('icu-syntax'));
      expect(error, startsWith('::error title=sheety icu-syntax app!D2::'));
      expect(lines.any((l) => l.startsWith('::warning ')), isTrue);
      for (final l in lines) expect(l, isNot(contains('\n')));
    });

    test('GitHub annotations name files relative to the workspace', () async {
      io.File(p.join(cwd, 'out/ts/index.txt'))
        ..createSync(recursive: true)
        ..writeAsStringSync('hand-written');
      final result =
          await run(['--snapshot=$multi', '--ignore=^backend', '--ts=out/ts']);
      final line = githubAnnotations(result, workspace: cwd)
          .singleWhere((l) => l.contains('unowned-file'));
      expect(line, startsWith('::error file=out/ts/index.txt,title='));
      // Outside the workspace, the path stays absolute.
      final outside =
          githubAnnotations(result, workspace: p.join(cwd, 'elsewhere'))
              .singleWhere((l) => l.contains('unowned-file'));
      expect(
          outside,
          contains('file=${p.join(cwd, 'out', 'ts', 'index.txt')}'
              .replaceAll(':', '%3A')));
    });

    test('verbose logs every written file', () async {
      final log = <String>[];
      await run(['--snapshot=$multi', '--ts=o', '--ts-ignore=^backend'],
          log: log);
      expect(log, contains('  ts: + app/app.txt'));
    });
  });

  group('writing', () {
    test('a write failure says precisely what was written', () async {
      // A file where the ts staging directory goes: staging fails there
      // (also as root, unlike a read-only directory), so the dart target
      // (staged fine) is not written either.
      final ts = io.Directory(p.join(cwd, 'out/ts'))
        ..createSync(recursive: true);
      final blocker = io.File(p.join(ts.path, stagingDirNameFor('ts')))
        ..writeAsStringSync('x');
      final result = await run([
        '--snapshot=$multi',
        '--ignore=^backend',
        '--dart=out/d',
        '--ts=out/ts'
      ]);
      expect(result.exitCode, exitErrors);
      final issue = result.issues.single;
      expect(issue.code, 'write-failed');
      expect(issue.message, contains('Nothing was written'));
      expect(result.written, isFalse);
      expect(result.targets.any((t) => t.written), isFalse);
      expect(io.Directory(p.join(cwd, 'out/d')).existsSync(), isFalse);
      expect(ts.listSync().map((e) => e.path), [blocker.path],
          reason: 'no staging leftovers');
      final text = formatResultText(result);
      expect(text, contains('nothing was written'));
      expect(text, isNot(contains(' added,')));
    }, testOn: '!windows');

    test('a target left partly written is reported as such', () async {
      final args = [
        '--snapshot=$multi',
        '--ignore=^help\$',
        '--mustache=^backend-',
        '--ts=out/ts',
      ];
      expect((await run(args)).exitCode, exitOk);
      // backend_mail is stale now. After planning (the verbose log runs
      // between planning and writing) its directory is swapped for a link
      // out of the output directory, so deleting it is refused half-way
      // through the commit (also as root, unlike a read-only directory).
      final stale = p.join(cwd, 'out/ts/backend_mail');
      final outside = p.join(cwd, 'outside');
      void swap(String _) {
        if (io.FileSystemEntity.isLinkSync(stale)) return;
        io.Directory(stale).renameSync(outside);
        io.Link(stale).createSync(outside);
      }

      final result = await run([...args, '--ts-ignore=^backend', '--verbose'],
          verbose: swap);
      expect(result.exitCode, exitErrors);
      expect(result.issues.single.message, contains('partly written'));
      final ts = result.targets.single;
      expect(ts.written, isFalse);
      expect(ts.partial, isTrue);
      expect(ts.toJson()['partial'], isTrue);
      final text = formatResultText(result);
      expect(text, isNot(contains('nothing was written')));
      expect(text, contains('partly writing ts'));
      expect(text, contains('- partly written'));
    }, testOn: '!windows');

    test('two targets in one directory by case or symlink are refused',
        () async {
      io.Directory(p.join(cwd, 'out')).createSync();
      io.Link(p.join(cwd, 'alias')).createSync(p.join(cwd, 'out'));
      expect(
        () => config([
          '--snapshot=$multi',
          '--ts=out',
          '--python=alias',
        ]),
        throwsA(isA<ConfigException>()),
      );
      if (isCaseInsensitiveAt(cwd)) {
        expect(
          () => config(['--snapshot=$multi', '--ts=out', '--python=OUT']),
          throwsA(isA<ConfigException>()),
        );
      }
    }, testOn: '!windows');

    test('a hand-written file mentioning a custom header is not taken over',
        () async {
      io.File(p.join(cwd, 'out/ts/index.txt'))
        ..createSync(recursive: true)
        ..writeAsStringSync('Generated for tests. Then edited by hand.\n');
      final args = [
        '--snapshot=$multi',
        '--ignore=^backend',
        '--ts=out/ts',
        '--header=Generated for tests.',
      ];
      final conflict = await run(args);
      expect(conflict.issues.map((i) => i.code), ['unowned-file']);
      expect(read('out/ts/index.txt'), startsWith('Generated for tests. Then'));
      // The same header as a comment is the generator's: taken over, with a
      // warning.
      io.File(p.join(cwd, 'out/ts/index.txt'))
          .writeAsStringSync('# Generated for tests.\nold\n');
      final takeover = await run(args);
      expect(takeover.exitCode, exitOk);
      expect(takeover.issues.map((i) => i.code), ['took-over-file']);
    });

    test('after a conflict the summary does not claim changes as done',
        () async {
      io.File(p.join(cwd, 'out/ts/index.txt'))
        ..createSync(recursive: true)
        ..writeAsStringSync('hand-written');
      final result =
          await run(['--snapshot=$multi', '--ignore=^backend', '--ts=out/ts']);
      expect(result.issues.map((i) => i.code), ['unowned-file']);
      final text = formatResultText(result);
      expect(text, contains('would add'));
      expect(text, contains('not written'));
      expect(text, isNot(contains(' added,')));
      expect(text, contains('nothing was written'));
    });
  });

  test('--check does not write the --dump-snapshot file', () async {
    final dump = p.join(cwd, 'dump.json');
    await run([...targetsArgs]);
    final check =
        await run([...targetsArgs, '--check', '--dump-snapshot=$dump']);
    expect(check.exitCode, exitOk, reason: formatResultText(check));
    expect(io.File(dump).existsSync(), isFalse);
  });

  group('target options', () {
    void config(String options) =>
        io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('''
snapshot: $multi
ignore: ['^backend']
targets:
  dart: {output: o, options: $options}
''');

    test('a value of the wrong kind is an error', () async {
      config('{metadata: "false", page_width: "100", barrel: ../x.dart}');
      final result = await run(const [], registry: defaultTargets());
      expect(result.exitCode, exitErrors);
      expect(result.issues.map((i) => i.code),
          ['invalid-option', 'invalid-option', 'invalid-option']);
      expect(result.issues.first.message,
          contains('"metadata" of the dart target must be true or false'));
      expect(exists('o/localization.dart'), isFalse);
    });

    test('the ts and python targets have no options', () async {
      io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('''
snapshot: $multi
ignore: ['^backend']
targets:
  ts: {output: t, options: {directory: x}}
  python: {output: py, options: {metadata: false}}
''');
      final result = await run(const [], registry: defaultTargets());
      expect(result.issues.map((i) => i.code),
          ['unknown-option', 'unknown-option']);
      expect(result.issues.first.message, contains('has no options'));
    });
  });

  test('the language version of the nearest pubspec reaches the formatter',
      () async {
    io.File(p.join(cwd, 'pkg/pubspec.yaml'))
      ..createSync(recursive: true)
      ..writeAsStringSync('name: pkg\nenvironment:\n  sdk: ">=3.0.0 <4.0.0"\n');
    final formatter = FakeFormatter();
    await run(['--snapshot=$multi', '--ignore=^backend', '--dart=pkg/lib'],
        formatter: formatter);
    expect(formatter.languageVersion, '3.0');
    // The nearest pubspec wins; without an SDK constraint: the latest.
    io.File(p.join(cwd, 'other/pubspec.yaml'))
      ..createSync(recursive: true)
      ..writeAsStringSync('name: other\n');
    await run(['--snapshot=$multi', '--ignore=^backend', '--dart=other/lib'],
        formatter: formatter);
    expect(formatter.languageVersion, isNull);
  });

  test('an old-SDK package gets short-style output and a stable --check',
      () async {
    io.File(p.join(cwd, 'old/pubspec.yaml'))
      ..createSync(recursive: true)
      ..writeAsStringSync('name: old\nenvironment:\n  sdk: ">=3.0.0 <4.0.0"\n');
    final args = ['--snapshot=$multi', '--ignore=^backend', '--dart=old/lib'];
    Future<GenerateResult> real(List<String> extra) {
      final c = config([...args, ...extra]);
      return GeneratePipeline(registry: defaultTargets())
          .run(c, SnapshotSource(c.snapshot!));
    }

    final first = await real(const []);
    expect(first.exitCode, exitOk, reason: formatResultText(first));
    final check = await real(['--check']);
    expect(check.exitCode, exitOk, reason: formatResultText(check));
    // The same code formatted for the latest version differs (tall style).
    final file = read('old/lib/src/generated/app/app_localization.dart');
    final tall = await DartFormatter()
        .format([GeneratedFile('a.dart', file)], languageVersion: 'latest');
    expect(tall.single.contents, isNot(file));
  });

  group('plural-rules-mismatch', () {
    String snapshot() {
      final file = io.File(p.join(cwd, 'gd.json'))
        ..writeAsStringSync(jsonEncode({
          'sheets': [
            {
              'title': 'app',
              'values': [
                ['label', 'description', 'meta', 'en', 'gd', 'de'],
                [
                  'files',
                  '',
                  '',
                  '{n, plural, one{one} other{{n} files}}',
                  '{n, plural, one{1} two{2} few{f} other{o}}',
                  '{n, plural, one{eine} other{{n}}}',
                ],
                ['title', '', '', 'Title', 'Tiotal', 'Titel'],
              ],
            },
          ],
        }));
      return file.path;
    }

    test('warns when dart and ts/python render a locale differently', () async {
      final result = await run(
          ['--snapshot=${snapshot()}', '--dart=d', '--ts=t', '--python=py']);
      final warnings = [
        for (final d in result.diagnostics)
          if (d.code == DiagnosticCode.pluralRulesMismatch) d,
      ];
      expect(warnings, hasLength(1));
      expect(warnings.single.severity, Severity.warning);
      expect(warnings.single.locale, 'gd');
      expect(warnings.single.column, 'E');
      expect(warnings.single.message, contains('ts and python'));
      expect(warnings.single.message, contains('files'));
      expect(result.exitCode, exitOk);
    });

    test('is quiet for the dart target alone', () async {
      final result = await run(['--snapshot=${snapshot()}', '--dart=d']);
      expect(result.diagnostics.map((d) => d.code),
          isNot(contains(DiagnosticCode.pluralRulesMismatch)));
    });
  });

  group('lone surrogates', () {
    test('warn, and Dart --no-format output is stable under --check', () async {
      final file = io.File(p.join(cwd, 'sg.json'))
        ..writeAsStringSync(jsonEncode({
          'sheets': [
            {
              'title': 'sg',
              'values': [
                ['label', 'description', 'meta', 'en'],
                ['a', 'bad \uD800 desc', '', 'A \uDC00 text'],
              ],
            },
          ],
        }));
      final args = [
        '--snapshot=${file.path}',
        '--dart=d',
        '--ts=t',
        '--python=py',
        '--no-format',
      ];
      final first = await run(args, registry: defaultTargets());
      expect(first.exitCode, exitOk, reason: formatResultText(first));
      expect(
        [
          for (final d in first.diagnostics)
            if (d.code == DiagnosticCode.invalidUnicode) '${d.column}${d.row}',
        ],
        ['B2', 'D2'],
      );
      final check = await run([...args, '--check'], registry: defaultTargets());
      expect(check.exitCode, exitOk, reason: formatResultText(check));
      final dart = read('d/src/generated/sg/sg_localization.dart');
      expect(dart, contains('/// bad � desc'));
      expect(read('t/sg/types.ts'), contains('bad � desc'));
      expect(read('py/sg/__init__.py'), contains('bad � desc'));
      // The values keep the lone surrogate, escaped.
      expect(read('t/sg/en.ts'), contains(r'\uDC00'));
      expect(read('py/sg/_en.py'), contains(r'\udc00'));
    });
  });

  test('DartFormatter formats through a temporary directory', () async {
    final files = await DartFormatter().format([
      GeneratedFile('a/b.dart', 'const  x=1;'),
      GeneratedFile('c.txt', 'const  x=1;'),
    ]);
    expect(files.first.contents, 'const x = 1;\n');
    expect(files.last.contents, 'const  x=1;');
    // An old language version selects the short (pre-3.7) style, which
    // keeps a trailing comma's split; the tall style collapses it.
    const code = 'f() {\n  g(\n    1,\n  );\n}\n';
    final short = await DartFormatter()
        .format([GeneratedFile('a.dart', code)], languageVersion: '3.6');
    final tall = await DartFormatter()
        .format([GeneratedFile('a.dart', code)], languageVersion: '3.8');
    expect(short.single.contents, 'f() {\n  g(\n    1,\n  );\n}\n');
    expect(tall.single.contents, 'f() {\n  g(1);\n}\n');
    await expectLater(
      DartFormatter().format([GeneratedFile('bad.dart', 'class {')]),
      throwsA(isA<FormatterException>()),
    );
  });
}

final class _ThrowingFormatter implements CodeFormatter {
  @override
  Future<List<GeneratedFile>> format(
    List<GeneratedFile> files, {
    int pageWidth = 80,
    String? languageVersion,
  }) =>
      throw const FormatterException('nope');
}
