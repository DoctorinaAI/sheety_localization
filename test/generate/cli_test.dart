@Timeout(Duration(minutes: 5))
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../sheety.dart';
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

    group('errors before the pipeline still follow --diagnostics-format', () {
      Map<String, Object?> decode(String out) =>
          jsonDecode(out) as Map<String, Object?>;
      List<String> codes(Map<String, Object?> json) => [
            for (final i
                in (json['issues']! as List).cast<Map<String, Object?>>())
              i['code'] as String,
          ];

      void credentials(String contents) =>
          io.File(p.join(cwd, 'key.json')).writeAsStringSync(contents);
      const badKey = '{"type": "service_account", "private_key": '
          '"-----BEGIN PRIVATE KEY-----\\nPRIVATESENTINEL\\n", }';
      final google = ['--sheet=x', '--credentials=key.json', '--ts=o'];

      test('json: bad credentials, without quoting the key', () async {
        credentials(badKey);
        final r = await cli([...google, '--diagnostics-format=json']);
        expect(r.code, exitErrors);
        final json = decode(r.out);
        expect(json['ok'], isFalse);
        expect(json['exitCode'], exitErrors);
        expect(codes(json), ['source-error']);
        expect(json['diagnostics'], isEmpty);
        expect(r.out + r.err, isNot(contains('PRIVATESENTINEL')));
        expect(r.err, contains('error: Credentials file'));
      });

      test('json: missing credentials', () async {
        final r = await cli([...google, '--diagnostics-format=json']);
        expect(r.code, exitErrors);
        expect(codes(decode(r.out)), ['source-error']);
      });

      test('json: an invalid sheety.yaml and an invalid option', () async {
        io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('targts: {}\n');
        final yaml = await cli(const ['--diagnostics-format=json']);
        expect(yaml.code, exitUsage);
        final json = decode(yaml.out);
        expect(json['exitCode'], exitUsage);
        expect(codes(json), ['config-error']);
        final usage =
            await cli(const ['--frobnicate', '--diagnostics-format', 'json']);
        expect(usage.code, exitUsage);
        expect(codes(decode(usage.out)), ['usage-error']);
        expect(usage.err, contains('frobnicate'));
      });

      test('github: bad credentials and an invalid sheety.yaml', () async {
        credentials(badKey);
        final source = await cli([...google, '--diagnostics-format=github']);
        expect(source.code, exitErrors);
        expect(source.out, startsWith('::error title=sheety source-error::'));
        expect(source.out, isNot(contains('PRIVATESENTINEL')));
        io.File(p.join(cwd, 'sheety.yaml')).writeAsStringSync('targts: {}\n');
        final yaml = await cli(const ['--diagnostics-format=github']);
        expect(yaml.code, exitUsage);
        expect(yaml.out, startsWith('::error title=sheety config-error::'));
      });

      test('text mode keeps stdout clean', () async {
        final r = await cli(google);
        expect(r.code, exitErrors);
        expect(r.out, isEmpty);
        expect(r.err, contains('Credentials file not found'));
      });
    });

    test('an unexpected exception is an internal-error with exit 2', () async {
      Future<({int code, String out, String err})> crash(
          List<String> args) async {
        final out = StringBuffer(), err = StringBuffer();
        final code = await runGenerate(
          ['--snapshot=s.json', '--ts=o', ...args],
          registry: fakeRegistry(),
          sourceFor: (_) async => throw StateError('kaboom'),
          out: out,
          err: err,
          workingDirectory: cwd,
        );
        return (code: code, out: '$out', err: '$err');
      }

      final text = await crash(const []);
      expect(text.code, exitErrors);
      expect(text.err, contains('kaboom'));
      final json = await crash(const ['--diagnostics-format=json']);
      expect(json.code, exitErrors);
      final decoded = jsonDecode(json.out) as Map<String, Object?>;
      expect((decoded['issues']! as List).single,
          containsPair('code', 'internal-error'));
      final verbose = await crash(const ['-v']);
      expect(verbose.err, contains('cli_test.dart'), reason: 'stack trace');
    });

    test('an unreadable snapshot is a source-error, not a crash', () async {
      io.File(p.join(cwd, 'bad.json')).writeAsBytesSync([0x7B, 0xFF, 0x7D]);
      final r = await cli(const ['--snapshot=bad.json', '--ts=o']);
      expect(r.code, exitErrors);
      expect(r.err, contains('Cannot read the snapshot'));
    });

    test('usage errors exit with 64', () async {
      final unknown = await cli(const ['--frobnicate']);
      expect(unknown.code, exitUsage);
      expect(unknown.err, contains('frobnicate'));
      final removed = await cli(const ['--sheet=x', '--dart=o', '--arb=l10n']);
      expect(removed.code, exitUsage);
      expect(removed.err, contains('--arb was removed in 0.7.0-dev'));
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
  mustache: ['^backend-billing\$']
targets:
  dart:   { output: dart/lib, ignore: ['^backend', '^bot'] }
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
