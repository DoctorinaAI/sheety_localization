import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../sheety.dart';

void main() {
  late io.Directory temp;
  late String cwd;
  setUp(() {
    temp = io.Directory.systemTemp.createTempSync('sheety_config_');
    cwd = temp.resolveSymbolicLinksSync();
  });
  tearDown(() => temp.deleteSync(recursive: true));

  GenerateConfig parse(List<String> args) => GenerateConfig.fromArgs(
        generateArgParser().parse(args),
        workingDirectory: cwd,
      );

  Matcher fails(Object message) => throwsA(
      isA<ConfigException>().having((e) => e.message, 'message', message));

  void yaml(String contents, [String name = 'sheety.yaml']) =>
      io.File(p.join(cwd, name))
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(contents);

  group('command line', () {
    test('targets, input and flags', () {
      final c = parse([
        '--sheet=ID',
        '--dart=lib/gen',
        '--ts',
        'web/i18n',
        '--ignore=^help\$,^locales\$',
        '--ts-ignore=^backend',
        '--mustache=^backend-',
        '--strict',
        '--check',
        '--no-format',
        '--legacy-regional-override',
        '--no-include-empty',
        '--diagnostics-format=json',
      ]);
      expect(c.sheet, 'ID');
      expect(c.credentials, p.join(cwd, 'credentials.json'));
      expect([for (final t in c.targets) t.target], [Target.dart, Target.ts]);
      expect(c.targets.first.output, p.join(cwd, 'lib/gen'));
      expect(c.targets.last.ignore.single.pattern, '^backend');
      expect([for (final r in c.ignore) r.pattern], [r'^help$', r'^locales$']);
      expect(c.keeps('help'), isFalse);
      expect(c.selects(c.targets.last, 'backend-x'), isFalse);
      expect(c.selects(c.targets.first, 'backend-x'), isTrue);
      expect(c.mustache.single.pattern, '^backend-');
      expect(c.strict && c.check && c.legacyRegionalOverride, isTrue);
      expect(c.format || c.includeEmpty, isFalse);
      expect(c.diagnosticsFormat, DiagnosticsFormat.json);
      expect(c.readerOptions.legacyRegionalOverride, isTrue);
      expect(c.readerOptions.includeEmpty, isFalse);
      expect(c.header, EmitOptions.defaultHeader);
    });

    test('defaults', () {
      final c = parse(['--snapshot=s.json', '--python=py']);
      expect(c.snapshot, p.join(cwd, 's.json'));
      expect(c.format, isTrue);
      expect(c.includeEmpty, isTrue);
      expect(c.legacyRegionalOverride, isFalse);
      expect(c.strict || c.check || c.verbose, isFalse);
    });

    test('quoted values are unquoted (Docker / Windows)', () {
      final c = parse(['--sheet="ID"', "--dart='out'"]);
      expect(c.sheet, 'ID');
      expect(c.targets.single.output, p.join(cwd, 'out'));
    });

    test('--header strips comment markers', () {
      expect(parse(['--sheet=x', '--dart=o', '--header=// Hi']).header, 'Hi');
      expect(parse(['--sheet=x', '--dart=o', r'--header=// A\n// B']).header,
          'A\nB');
      expect(parse(['--sheet=x', '--dart=o', '--header=']).header, '');
    });

    test('--only restricts the configured targets', () {
      final c = parse(['--sheet=x', '--dart=a', '--ts=b', '--only=ts']);
      expect([for (final t in c.targets) t.target], [Target.ts]);
      expect(() => parse(['--sheet=x', '--dart=a', '--only=python']),
          fails(contains('not configured')));
    });

    test('needs a target and an input', () {
      expect(() => parse(['--sheet=x']), fails(contains('No target')));
      expect(() => parse(['--dart=o']), fails(contains('No input')));
      // Dumping a snapshot alone is fine.
      expect(parse(['--sheet=x', '--dump-snapshot=s.json']).targets, isEmpty);
    });

    test('per-target patterns need the target', () {
      expect(() => parse(['--sheet=x', '--dart=o', '--ts-include=a']),
          fails(contains('ts target is not configured')));
    });

    test('invalid RegExps are reported', () {
      expect(() => parse(['--sheet=x', '--dart=o', '--ignore=(']),
          fails(contains('invalid RegExp')));
    });

    test('two targets cannot share an output directory', () {
      expect(() => parse(['--sheet=x', '--dart=o', '--ts=./o']),
          fails(contains('same output directory')));
    });

    test('target output directories must not be nested', () {
      expect(() => parse(['--sheet=x', '--dart=o', '--python=o/py']),
          fails(contains('is inside the one of the dart target')));
      expect(() => parse(['--sheet=x', '--dart=o/lib', '--ts=o']),
          fails(contains('must not overlap')));
      // Siblings are fine.
      expect(parse(['--sheet=x', '--dart=o/dart', '--ts=o/ts']).targets,
          hasLength(2));
    });

    test('a symbolic link to another target\'s directory is the same one', () {
      io.Directory(p.join(cwd, 'out')).createSync();
      io.Link(p.join(cwd, 'alias')).createSync(p.join(cwd, 'out'));
      expect(() => parse(['--sheet=x', '--ts=out', '--python=alias']),
          fails(contains('same output directory')));
      // A link into it nests: alias/py is out/py, inside out.
      expect(() => parse(['--sheet=x', '--ts=out/ts', '--python=alias']),
          fails(contains('must not overlap')));
      // The directory behind the link does not even need to exist yet.
      expect(() => parse(['--sheet=x', '--ts=out/a/b', '--python=alias/a/b']),
          fails(contains('same output directory')));
    }, testOn: '!windows');

    test(
        'directories differing only in case are the same on a '
        'case-insensitive file system', () {
      io.Directory(p.join(cwd, 'out')).createSync();
      if (!isCaseInsensitiveAt(cwd)) {
        markTestSkipped('the temporary directory is case-sensitive');
        return;
      }
      expect(() => parse(['--sheet=x', '--ts=out', '--python=OUT']),
          fails(contains('same output directory')));
      // Also when neither exists yet.
      expect(() => parse(['--sheet=x', '--ts=new/x', '--python=NEW/X']),
          fails(contains('same output directory')));
      expect(() => parse(['--sheet=x', '--ts=new', '--python=NEW/py']),
          fails(contains('must not overlap')));
    });

    test('RegExp lists split only at top-level commas', () {
      final c = parse([
        '--sheet=x',
        '--dart=o',
        r'--ignore=^a{1,2}$,^(b|c,d)$,[,;]x,^e\,f$',
        r'--ignore=^g$',
        r'--dart-include=^x{2,}$',
      ]);
      expect([for (final r in c.ignore) r.pattern],
          [r'^a{1,2}$', r'^(b|c,d)$', '[,;]x', r'^e,f$', r'^g$']);
      expect(c.targets.single.include.single.pattern, r'^x{2,}$');
      expect(c.keeps('aa'), isFalse);
      expect(c.keeps('e,f'), isFalse);
      expect(c.keeps('a,2'), isTrue);
      expect(splitRegExpList('a,b'), ['a', 'b']);
    });

    test('--sheet and --snapshot cannot be combined', () {
      expect(() => parse(['--sheet=x', '--snapshot=s.json', '--dart=o']),
          fails(contains('cannot be combined')));
    });

    test('--snapshot and --dump-snapshot must differ', () {
      expect(
          () => parse(
              ['--snapshot=s.json', '--dump-snapshot=s.json', '--dart=o']),
          fails(contains('same file')));
    });
  });

  group('0.6.0 compatibility', () {
    test('--lib/--gen map onto the dart target', () {
      final c = parse(['--sheet=x', '--lib=lib', '--gen=src/generated']);
      final dart = c.targets.single;
      expect(dart.target, Target.dart);
      expect(dart.output, p.join(cwd, 'lib'));
      expect(dart.options, {dartGeneratedDirOption: 'src/generated'});
      // Old defaults apply to the missing half; old aliases still work.
      expect(parse(['--sheet=x', '--output=pkg/lib']).targets.single.options,
          {dartGeneratedDirOption: 'src/generated'});
      expect(parse(['--sheet=x', '-g', 'gen']).targets.single.output,
          p.join(cwd, 'lib'));
    });

    test('--lib and --dart cannot be combined', () {
      expect(() => parse(['--sheet=x', '--lib=lib', '--dart=lib']),
          fails(contains('cannot be combined')));
    });

    for (final (args, name) in [
      (['--arb=src/l10n'], 'arb'),
      (['-a', 'x'], 'arb'),
      (['--arb-dir=x'], 'arb'),
      (['--prefix=app'], 'prefix'),
      (['--author=me'], 'author'),
      (['--meta-author=me'], 'author'),
      (['--comment=c'], 'comment'),
      (['--modified=2025-01-01'], 'modified'),
      (['--timestamp=2025-01-01'], 'modified'),
      (['--no-last-modified'], 'last-modified'),
      (['--last-modified'], 'last-modified'),
      (['--context=1.2.3'], 'context'),
    ]) {
      test('${args.first} fails with a migration hint', () {
        expect(
          () => parse(['--sheet=x', '--dart=o', ...args]),
          fails(allOf(
            startsWith('--$name was removed in 1.0.0.'),
            contains(removedOptions[name]),
          )),
        );
      });
    }
  });

  group('sheety.yaml', () {
    const example = r'''
sheet: SHEET
credentials: secrets/key.json
ignore: ['^help$', '^locales$']
syntax:
  mustache: '^backend-billing$'
header: |-
  Generated.
  Do not edit.
strict: true
format: false
include_empty: false
legacy_regional_override: true
targets:
  dart:   { output: dart/lib, ignore: ['^backend', '^bot'], options: { directory: src/generated, nested: [1, {a: b}] } }
  python: { output: python/src/app_localization, include: ['^backend'] }
  ts:     { output: web/src/generated, ignore: '^backend', header: TS only }
''';

    test('is read from the working directory by default', () {
      yaml(example);
      final c = parse(const []);
      expect(c.configFile, p.join(cwd, 'sheety.yaml'));
      expect(c.sheet, 'SHEET');
      expect(c.credentials, p.join(cwd, 'secrets/key.json'));
      expect([for (final r in c.ignore) r.pattern], [r'^help$', r'^locales$']);
      expect(c.mustache.single.pattern, r'^backend-billing$');
      expect(c.header, 'Generated.\nDo not edit.');
      expect(c.strict && c.legacyRegionalOverride, isTrue);
      expect(c.format || c.includeEmpty, isFalse);
      final [dart, ts, python] = c.targets;
      expect(dart.output, p.join(cwd, 'dart/lib'));
      expect(dart.options, {
        'directory': 'src/generated',
        'nested': [
          1,
          {'a': 'b'},
        ],
      });
      expect(dart.options, isA<Map<String, Object?>>());
      expect(python.include.single.pattern, '^backend');
      expect(ts.ignore.single.pattern, '^backend');
      expect(ts.header, 'TS only');
      expect(c.selects(python, 'backend-2025-01-15-regions'), isTrue);
      expect(c.selects(python, 'app'), isFalse);
      expect(c.selects(dart, 'bot-commands'), isFalse);
      expect(c.selects(dart, 'help'), isFalse);
      expect(c.anySelects('locales'), isFalse);
    });

    test('paths are relative to the file, CLI paths to the cwd', () {
      yaml('snapshot: s.json\ntargets:\n  ts: {output: out}\n',
          'conf/sheety.yaml');
      final c = parse(['--config=conf/sheety.yaml', '--python=py']);
      expect(c.snapshot, p.join(cwd, 'conf/s.json'));
      expect(c.targets.first.output, p.join(cwd, 'conf/out'));
      expect(c.targets.last.output, p.join(cwd, 'py'));
    });

    test('the command line overrides the file', () {
      yaml(example);
      final c = parse([
        '--sheet=OTHER',
        '--no-strict',
        '--format',
        '--dart=elsewhere',
        '--dart-ignore=^x',
        '--ignore=^only\$',
        '--header=CLI',
      ]);
      expect(c.sheet, 'OTHER');
      expect(c.strict, isFalse);
      expect(c.format, isTrue);
      final dart = c.targets.first;
      expect(dart.output, p.join(cwd, 'elsewhere'));
      expect(dart.ignore.single.pattern, '^x');
      expect(dart.options['directory'], 'src/generated'); // kept
      expect(c.ignore.single.pattern, r'^only$');
      expect(c.header, 'CLI');
      expect(c.targets, hasLength(3));
    });

    test('--sheet replaces a snapshot of the file and the other way round', () {
      yaml('snapshot: s.json\ntargets:\n  ts: {output: out}\n');
      final fromSheet = parse(['--sheet=LIVE']);
      expect(fromSheet.sheet, 'LIVE');
      expect(fromSheet.snapshot, isNull);

      yaml('sheet: SHEET\ntargets:\n  ts: {output: out}\n');
      final fromSnapshot = parse(['--snapshot=cli.json']);
      expect(fromSnapshot.snapshot, p.join(cwd, 'cli.json'));
      expect(fromSnapshot.sheet, isNull);
    });

    test('"sheet" and "snapshot" in the same file are an error', () {
      yaml('sheet: SHEET\nsnapshot: s.json\ntargets:\n  ts: {output: o}\n');
      expect(() => parse(const []), fails(contains('cannot both be set')));
      // The command line decides.
      expect(parse(['--sheet=X']).snapshot, isNull);
    });

    test('an explicit missing --config is an error', () {
      expect(() => parse(['--config=nope.yaml']), fails(contains('not found')));
    });

    for (final (source, message) in [
      ('sheeet: x\n', 'unknown key "sheeet" (did you mean "sheet"?)'),
      (
        'targets:\n  dart: {outptu: o}\n',
        'unknown key "targets.dart.outptu" '
            '(did you mean "targets.dart.output"?)'
      ),
      (
        'targets:\n  typescript: {output: o}\n',
        'unknown key "targets.typescript"'
      ),
      ('targets:\n  dart: {ignore: [a]}\n', 'targets.dart.output is required'),
      ('syntax: {mustach: [a]}\n', 'unknown key "syntax.mustach"'),
      ('strict: yes please\n', 'strict must be true or false'),
      ('ignore: [1]\n', 'ignore must be a RegExp string or a list'),
      ('ignore: ["("]\n', 'invalid RegExp'),
      ('- a\n', 'the document must be a mapping'),
      ('targets: [dart]\n', 'targets must be a mapping'),
      ('sheet: [x\n', 'Invalid YAML'),
      ('sheet: ""\n', 'sheet must be a non-empty string'),
    ]) {
      test('rejects ${source.trim().split('\n').first}', () {
        yaml(source);
        expect(() => parse(['--snapshot=s.json', '--dart=o']),
            fails(contains(message)));
      });
    }

    test('an empty file is allowed', () {
      yaml('');
      expect(parse(['--sheet=x', '--dart=o']).targets, hasLength(1));
    });
  });
}
