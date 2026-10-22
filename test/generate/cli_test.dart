@Timeout(Duration(minutes: 5))
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

import '../fixtures/infra/fake_emitter.dart';

final _fixtures = p.absolute('test/fixtures/infra');

void main() {
  late io.Directory temp;
  late String cwd;
  setUp(() {
    temp = io.Directory.systemTemp.createTempSync('sheety_cli_');
    cwd = temp.resolveSymbolicLinksSync();
  });
  tearDown(() => temp.deleteSync(recursive: true));

  Future<({int code, String out, String err})> cli(
    List<String> args, {
    TargetRegistry? registry,
  }) async {
    final out = StringBuffer(), err = StringBuffer();
    final code = await runGenerate(
      args,
      registry: registry ?? fakeRegistry(),
      dartFormatter: FakeFormatter(),
      out: out,
      err: err,
      workingDirectory: cwd,
    );
    return (code: code, out: '$out', err: '$err');
  }

  void copyYaml() {
    io.File(p.join(_fixtures, 'sheety.yaml'))
        .copySync(p.join(cwd, 'sheety.yaml'));
    io.File(p.join(_fixtures, 'multi_snapshot.json'))
        .copySync(p.join(cwd, 'multi_snapshot.json'));
  }

  group('in process (fake emitters)', () {
    test('sheety.yaml from the working directory, then --check', () async {
      copyYaml();
      final first = await cli(const []);
      expect(first.code, exitOk, reason: first.err);
      expect(first.out, contains('Using ${p.join(cwd, 'sheety.yaml')}'));
      expect(first.err, contains('Done.'));
      for (final dir in ['out/dart', 'out/ts', 'out/python']) {
        expect(
            io.File(p.join(cwd, dir, manifestFileName)).existsSync(), isTrue);
      }
      expect(
        io.File(p.join(cwd, 'out/python/index.txt')).readAsStringSync(),
        '# Generated for tests.\nbackend_mail\n',
      );

      final clean = await cli(const ['--check']);
      expect(clean.code, exitOk, reason: clean.err);
      expect(clean.err, contains('Generated code is up to date.'));

      io.File(p.join(cwd, 'out/ts/index.txt')).writeAsStringSync('stale');
      final stale = await cli(const ['--check']);
      expect(stale.code, exitStale);
      expect(stale.err, contains('ts: 2 scope(s)'));
      expect(stale.err, contains('  ~ index.txt'));
      expect(
          io.File(p.join(cwd, 'out/ts/index.txt')).readAsStringSync(), 'stale');
    });

    test('--diagnostics-format=json prints one JSON document', () async {
      final r = await cli([
        '--snapshot=${p.join(_fixtures, 'error_snapshot.json')}',
        '--ts=o',
        '--diagnostics-format=json',
      ]);
      expect(r.code, exitErrors);
      final json = jsonDecode(r.out) as Map<String, Object?>;
      expect(json['exitCode'], exitErrors);
      expect(r.err, contains('Reading snapshot'));
    });

    test('--diagnostics-format=github prints annotations', () async {
      final r = await cli([
        '--snapshot=${p.join(_fixtures, 'error_snapshot.json')}',
        '--ts=o',
        '--diagnostics-format=github',
      ]);
      expect(r.code, exitErrors);
      expect(r.out, contains('::error title=sheety icu-syntax'));
    });

    test('usage errors exit with 64', () async {
      final unknown = await cli(const ['--frobnicate']);
      expect(unknown.code, exitUsage);
      expect(unknown.err, contains('frobnicate'));
      final removed = await cli(const ['--sheet=x', '--dart=o', '--arb=l10n']);
      expect(removed.code, exitUsage);
      expect(removed.err, contains('--arb was removed in 1.0.0'));
      io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('targts: {}\n');
      final yaml = await cli(const []);
      expect(yaml.code, exitUsage);
      expect(yaml.err, contains('did you mean "targets"'));
    });

    test('--help documents the options and sheety.yaml', () async {
      final r = await cli(const ['--help']);
      expect(r.code, exitOk);
      for (final text in [
        '--dart',
        '--ts',
        '--python',
        '--check',
        'strict',
        '--snapshot',
        '--dump-snapshot',
        '--diagnostics-format',
        'sheety.yaml',
        'targets:',
        'Migrating from 0.6.0',
      ]) {
        expect(r.out, contains(text));
      }
      // Removed and compatibility options stay out of the list.
      final options = r.out.substring(r.out.indexOf('Options:'));
      expect(options, isNot(contains('--prefix')));
      expect(options, isNot(contains('--lib')));
    });
  });

  group('executable', () {
    Future<io.ProcessResult> generate(List<String> args) => io.Process.run(
          io.Platform.resolvedExecutable,
          ['run', p.absolute('bin/generate.dart'), ...args],
          workingDirectory: cwd,
        );

    test('--help', () async {
      final r = await generate(const ['--help']);
      expect(r.exitCode, exitOk, reason: '${r.stderr}');
      expect(r.stdout, contains('sheety.yaml'));
    });

    test('removed flags and invalid yaml fail with a hint', () async {
      final removed =
          await generate(const ['--sheet=x', '--dart=o', '--no-last-modified']);
      expect(removed.exitCode, exitUsage);
      expect(removed.stderr, contains('no timestamps'));
      io.File(p.join(cwd, 'sheety.yaml'))
          .writeAsStringSync('targets:\n  dart: {outpt: o}\n');
      final yaml = await generate(const []);
      expect(yaml.exitCode, exitUsage);
      expect(yaml.stderr, contains('did you mean "targets.dart.output"'));
    });

    final available = defaultTargets().available;
    test(
      'end to end with the real emitters: generate, check, stale check',
      () async {
        final snapshot = p.absolute('test/fixtures/basic_snapshot.json');
        final args = [
          '--snapshot=$snapshot',
          '--ignore=^help\$',
          for (final t in available) '--${t.id}=out/${t.id}',
        ];
        final first = await generate(args);
        expect(first.exitCode, exitOk,
            reason: '${first.stdout}${first.stderr}');
        final check = await generate([...args, '--check']);
        expect(check.exitCode, exitOk, reason: '${check.stderr}');
        final manifest =
            p.join(cwd, 'out', available.first.id, manifestFileName);
        final files = (jsonDecode(io.File(manifest).readAsStringSync())
            as Map)['files'] as Map;
        io.File(p.join(
                cwd, 'out', available.first.id, files.keys.first as String))
            .writeAsStringSync('edited');
        final stale = await generate([...args, '--check']);
        expect(stale.exitCode, exitStale);
      },
      skip: available.isEmpty ? 'no emitter is registered yet' : false,
    );
  });

  group('real snapshot', () {
    final real = io.Platform.environment['SHEETY_REAL_SNAPSHOT'];
    final skip = real == null ? 'SHEETY_REAL_SNAPSHOT is not set' : false;

    test('the dump format round-trips byte for byte', () async {
      final text = io.File(real!).readAsStringSync();
      final sheets = await SnapshotSource(real).fetchAll();
      expect(encodeSnapshot(sheets).trimRight(), text.trimRight());
    }, skip: skip);

    test('the DESIGN.md sheety.yaml runs over the real snapshot', () async {
      io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('''
snapshot: $real
ignore: ['^help\$', '^locales\$']
syntax:
  mustache: ['^backend-monetization\$']
targets:
  dart:   { output: dart/lib, ignore: ['^backend', '^telegram'] }
  python: { output: python/src/app_localization, include: ['^backend'] }
  ts:     { output: web/src/generated, ignore: ['^backend'] }
''');
      final registry = defaultTargets();
      final r = await cli(const ['--diagnostics-format=json'],
          registry: registry.available.length == Target.values.length
              ? registry
              : fakeRegistry());
      final json = jsonDecode(r.out) as Map<String, Object?>;
      final targets = (json['targets']! as List).cast<Map<String, Object?>>();
      expect({for (final t in targets) t['target']}, {'dart', 'ts', 'python'});
      final dart = targets.firstWhere((t) => t['target'] == 'dart');
      expect((dart['scopes']! as List).toSet(), {
        'app',
        'chat',
        'errors',
        'pay',
        'paywall',
        'profiles',
        'settings',
        'sign_up',
      });
      final python = targets.firstWhere((t) => t['target'] == 'python');
      expect(python['scopes'] as List, everyElement(startsWith('backend')));
      // The sheet itself has known content errors (duplicate labels, an
      // empty base cell); nothing else may fail.
      final errors = {
        for (final d
            in (json['diagnostics']! as List).cast<Map<String, Object?>>())
          if (d['severity'] == 'error') d['code'],
        for (final i in (json['issues']! as List).cast<Map<String, Object?>>())
          if (i['severity'] == 'error') i['code'],
      };
      expect(errors.difference({'duplicate-label', 'empty-base'}), isEmpty,
          reason: r.err);
      expect(r.code, errors.isEmpty ? exitOk : exitErrors);
    }, skip: skip);
  });
}
