import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

const _header = '// ${EmitOptions.defaultHeader}\n';

void main() {
  late io.Directory temp;
  late String out;
  setUp(() {
    temp = io.Directory.systemTemp.createTempSync('sheety_writer_');
    out = p.join(temp.path, 'out');
  });
  tearDown(() => temp.deleteSync(recursive: true));

  final empty = Catalog(const []);
  Manifest manifest(List<GeneratedFile> files) =>
      Manifest.build(Target.ts, empty, files);

  WritePlan plan(
    List<GeneratedFile> files, {
    OutputWriter writer = const OutputWriter(),
  }) =>
      writer.plan(outputDir: out, files: files, manifest: manifest(files));

  WritePlan write(
    List<GeneratedFile> files, {
    OutputWriter writer = const OutputWriter(),
  }) {
    final result = plan(files, writer: writer);
    expect(result.issues.where((i) => i.isError), isEmpty);
    writer.apply(result);
    return result;
  }

  String read(String rel) => io.File(p.join(out, rel)).readAsStringSync();
  bool exists(String rel) => io.File(p.join(out, rel)).existsSync();
  void put(String rel, String contents) => io.File(p.join(out, rel))
    ..parent.createSync(recursive: true)
    ..writeAsStringSync(contents);

  final v1 = [
    GeneratedFile('index.ts', '${_header}export {};\n'),
    GeneratedFile('app/en.ts', '${_header}en\n'),
    GeneratedFile('app/de.ts', '${_header}de\n'),
  ];

  test('first write adds every file and the manifest', () {
    final result = write(v1);
    expect(
        result.added, ['app/de.ts', 'app/en.ts', 'index.ts', manifestFileName]);
    expect(read('app/en.ts'), '${_header}en\n');
    final m = Manifest.parse(read(manifestFileName));
    expect(m.files.keys, ['app/de.ts', 'app/en.ts', 'index.ts']);
    expect(m.files['index.ts'], sha256Hex('${_header}export {};\n'));
  });

  test('an identical second run changes nothing and touches nothing', () {
    write(v1);
    final stamp = DateTime(2000);
    io.File(p.join(out, 'app/en.ts')).setLastModifiedSync(stamp);
    final result = write(v1);
    expect(result.hasChanges, isFalse);
    expect(result.unchanged, hasLength(4));
    expect(io.File(p.join(out, 'app/en.ts')).lastModifiedSync(), stamp);
  });

  test('rewrites changed files and deletes stale owned ones', () {
    write(v1);
    final result = write([
      GeneratedFile('index.ts', '${_header}export const x = 1;\n'),
      GeneratedFile('app/en.ts', '${_header}en\n'),
    ]);
    expect(result.changed, ['index.ts', manifestFileName]);
    expect(result.removed, ['app/de.ts']);
    expect(exists('app/de.ts'), isFalse);
    expect(read('index.ts'), contains('x = 1'));
  });

  test('prunes directories emptied by deletions', () {
    write([...v1, GeneratedFile('chat/en.ts', 'x')]);
    write(v1);
    expect(io.Directory(p.join(out, 'chat')).existsSync(), isFalse);
    expect(io.Directory(out).existsSync(), isTrue);
  });

  test('never deletes or overwrites files it does not own', () {
    write(v1);
    put('package.json', '{"name": "x"}');
    put('app/README.md', 'docs');
    final result = write([GeneratedFile('index.ts', 'new')]);
    expect(result.removed, ['app/de.ts', 'app/en.ts']);
    expect(read('package.json'), '{"name": "x"}');
    expect(read('app/README.md'), 'docs');
    expect(io.Directory(p.join(out, 'app')).existsSync(), isTrue);
  });

  test('an unowned file in the way is a conflict; nothing is written', () {
    put('index.ts', 'hand-written');
    final result = plan(v1);
    expect([for (final i in result.issues) i.code], ['unowned-file']);
    expect(result.hasErrors, isTrue);
    expect(() => const OutputWriter().apply(result), throwsStateError);
    expect(read('index.ts'), 'hand-written');
  });

  test('an identical unowned file is taken over', () {
    put('index.ts', '${_header}export {};\n');
    final result = write(v1);
    final action = result.actions.firstWhere((a) => a.path == 'index.ts');
    expect(action.change, FileChange.unchanged);
    expect(action.adopted, isTrue);
  });

  group('migration from 0.6.0 (no manifest)', () {
    test('takes over files with the generated header, reports leftovers', () {
      put('localization.dart', '${_header}library;\n');
      put('src/generated/app/app_localization.dart', '${_header}old\n');
      put('src/generated/app/app_localization_xx.dart', '${_header}gone\n');
      put('src/l10n/app/app_en.arb', '{"title": "x"}');
      put('notes.md', 'mine');
      final files = [
        GeneratedFile('localization.dart', '${_header}library; // new\n'),
        GeneratedFile(
            'src/generated/app/app_localization.dart', '${_header}new\n'),
      ];
      final result = write(
        files,
        writer: const OutputWriter(looksGenerated: isLegacyDartFile),
      );
      expect(result.changed,
          ['localization.dart', 'src/generated/app/app_localization.dart']);
      final legacy =
          result.issues.singleWhere((i) => i.code == 'legacy-output');
      expect(legacy.severity, Severity.warning);
      expect(legacy.message, contains('src/l10n/app/app_en.arb'));
      expect(legacy.message,
          contains('src/generated/app/app_localization_xx.dart'));
      expect(legacy.message, isNot(contains('notes.md')));
      // Leftovers are not deleted.
      expect(exists('src/l10n/app/app_en.arb'), isTrue);
      expect(exists('src/generated/app/app_localization_xx.dart'), isTrue);

      // With the manifest in place, the second run is quiet.
      final again = plan(
        files,
        writer: const OutputWriter(looksGenerated: isLegacyDartFile),
      );
      expect(again.issues, isEmpty);
      expect(again.hasChanges, isFalse);
    });
  });

  test('check mode: plan reports differences without writing', () {
    write(v1);
    final result = plan([
      GeneratedFile('index.ts', 'changed'),
      GeneratedFile('app/en.ts', '${_header}en\n'),
      GeneratedFile('app/fr.ts', 'fr'),
    ]);
    expect(result.added, ['app/fr.ts']);
    expect(result.changed, ['index.ts', manifestFileName]);
    expect(result.removed, ['app/de.ts']);
    expect(exists('app/fr.ts'), isFalse);
    expect(exists('app/de.ts'), isTrue);
  });

  test('a manifest entry pointing outside is never deleted', () {
    write(v1);
    final victim = io.File(p.join(temp.path, 'victim.txt'))
      ..writeAsStringSync('keep');
    put(
      manifestFileName,
      '{"generator": "sheety_localization", '
      '"files": {"../victim.txt": "x", "index.ts": "y"}}',
    );
    final result = plan([GeneratedFile('index.ts', 'z')]);
    expect(result.issues.map((i) => i.code), contains('path-traversal'));
    expect(result.removed, isEmpty);
    expect(victim.readAsStringSync(), 'keep');
  });

  test('refuses to write through a symlink leading outside', () {
    final outside = io.Directory(p.join(temp.path, 'outside'))..createSync();
    io.Directory(out).createSync();
    io.Link(p.join(out, 'app')).createSync(outside.path);
    final result = plan(v1);
    expect(result.issues.map((i) => i.code), contains('path-traversal'));
    expect(outside.listSync(), isEmpty);
  });

  test('an unreadable manifest is an error', () {
    put(manifestFileName, 'not json');
    final result = plan(v1);
    expect(result.issues.map((i) => i.code), ['invalid-manifest']);
  });

  test('case collisions and the manifest name are errors', () {
    final result = plan([
      GeneratedFile('App.ts', 'a'),
      GeneratedFile('app.ts', 'b'),
      GeneratedFile(manifestFileName, '{}'),
    ]);
    expect(result.issues.map((i) => i.code),
        containsAll(['case-collision', 'duplicate-output']));
  });

  test('deleting an edited generated file warns', () {
    write(v1);
    put('app/de.ts', 'edited by hand');
    final result = write([v1.first]);
    expect(result.issues.map((i) => i.code), ['modified-generated-file']);
    expect(exists('app/de.ts'), isFalse);
  });
  group('renaming by case only (chat -> Chat)', () {
    final lower = [GeneratedFile('chat/en.ts', '${_header}en\n')];
    final upper = [GeneratedFile('Chat/en.ts', '${_header}en\n')];

    test('keeps the file and records the new name', () {
      write(lower);
      final result = write(upper);
      expect(result.removed, ['chat/en.ts']);
      expect(read('Chat/en.ts'), '${_header}en\n');
      expect(Manifest.parse(read(manifestFileName)).files.keys, ['Chat/en.ts']);
      // The directory itself carries the new case (also on case-insensitive
      // file systems, where `chat` and `Chat` are the same directory).
      expect(
        [for (final e in io.Directory(out).listSync()) p.basename(e.path)],
        contains('Chat'),
      );
      expect(plan(upper).hasChanges, isFalse);
    });

    test('works back and forth', () {
      write(lower);
      write(upper);
      write(lower);
      expect(read('chat/en.ts'), '${_header}en\n');
      expect(Manifest.parse(read(manifestFileName)).files.keys, ['chat/en.ts']);
    });
  });

  group('foreign manifest', () {
    test('a manifest of another target is an error, nothing is deleted', () {
      final py = [GeneratedFile('app/_en.py', '# x\n')];
      final result = const OutputWriter().plan(
        outputDir: out,
        files: py,
        manifest: Manifest.build(Target.python, empty, py),
        target: 'python',
      );
      const OutputWriter().apply(result);
      final ts = const OutputWriter().plan(
        outputDir: out,
        files: v1,
        manifest: manifest(v1),
        target: 'ts',
      );
      expect(ts.issues.map((i) => i.code), ['foreign-manifest']);
      expect(ts.issues.single.message, contains('python'));
      expect(ts.removed, isEmpty);
      expect(() => const OutputWriter().apply(ts), throwsStateError);
      expect(exists('app/_en.py'), isTrue);
    });
  });

  group('applyAll stages every plan first', () {
    late String second;
    setUp(() => second = p.join(temp.path, 'second'));

    WritePlan planIn(String dir, List<GeneratedFile> files) =>
        const OutputWriter()
            .plan(outputDir: dir, files: files, manifest: manifest(files));

    test('a failure while staging writes nothing and leaves no temp files', () {
      io.Directory(second).createSync();
      final plans = [planIn(out, v1), planIn(second, v1)];
      // The second output directory is read-only: staging fails there.
      io.Process.runSync('chmod', ['555', second]);
      addTearDown(() => io.Process.runSync('chmod', ['755', second]));
      final failure = () {
        try {
          const OutputWriter().applyAll(plans);
        } on WriteFailure catch (e) {
          return e;
        }
        return null;
      }();
      expect(failure, isNotNull);
      expect(failure!.written, isEmpty);
      expect(failure.partial, isNull);
      expect(io.Directory(out).existsSync(), isFalse,
          reason: 'the first output directory was created only to stage');
      expect(io.Directory(second).listSync(), isEmpty);
    }, testOn: '!windows');

    test('a failure while committing names the written and partial targets',
        () {
      write([...v1, GeneratedFile('old/x.ts', 'x')]);
      // `old/x.ts` is stale now and its directory is read-only: the first
      // plan commits, deleting the stale file of the second one fails.
      final plans = [
        planIn(second, v1),
        plan(v1),
      ];
      final oldDir = p.join(out, 'old');
      io.Process.runSync('chmod', ['555', oldDir]);
      addTearDown(() => io.Process.runSync('chmod', ['755', oldDir]));
      final failure = () {
        try {
          const OutputWriter().applyAll(plans);
        } on WriteFailure catch (e) {
          return e;
        }
        return null;
      }();
      expect(failure, isNotNull);
      expect(failure!.written, [p.normalize(p.absolute(second))]);
      expect(failure.partial, p.normalize(p.absolute(out)));
      expect(failure.notWritten, isEmpty);
      expect(io.File(p.join(second, 'index.ts')).existsSync(), isTrue);
      // No staging directory and no temporary file is left behind.
      expect(io.Directory(p.join(out, stagingDirName)).existsSync(), isFalse);
      expect(
          io.Directory(p.join(second, stagingDirName)).existsSync(), isFalse);
    }, testOn: '!windows');

    test('a successful run leaves no staging directory', () {
      write(v1);
      expect(io.Directory(p.join(out, stagingDirName)).existsSync(), isFalse);
      expect(
        io.Directory(out)
            .listSync(recursive: true)
            .where((e) => e.path.endsWith('.sheety-tmp')),
        isEmpty,
      );
    });
  });
}
