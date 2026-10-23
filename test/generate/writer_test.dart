import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../sheety.dart';

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
    expect(result.issues, isEmpty);
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
      // Every takeover is reported.
      final takeover =
          result.issues.singleWhere((i) => i.code == 'took-over-file');
      expect(takeover.severity, Severity.warning);
      expect(takeover.message, contains('2 existing file(s)'));
      expect(takeover.message, contains('localization.dart'));
      expect(takeover.message,
          contains('src/generated/app/app_localization.dart'));
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
    // Absolute, so a GitHub annotation points at the file.
    expect(result.issues.map((i) => i.path),
        everyElement(predicate<String?>((path) => p.isAbsolute(path!))));
  });

  test('an edited file that is no longer generated is kept and disowned', () {
    write(v1);
    put('app/de.ts', 'edited by hand');
    final result = write([v1.first, v1[1]]);
    final issue = result.issues.single;
    expect(issue.code, 'modified-generated-file');
    expect(issue.severity, Severity.warning);
    expect(issue.path, endsWith(p.join('app', 'de.ts')));
    expect(issue.message, contains('kept'));
    expect(result.removed, isEmpty);
    expect(read('app/de.ts'), 'edited by hand');
    expect(Manifest.parse(read(manifestFileName)).files.keys,
        isNot(contains('app/de.ts')));
    // From then on it is a foreign file: left alone, quietly.
    final again = write([v1.first, v1[1]]);
    expect(again.issues, isEmpty);
    expect(again.hasChanges, isFalse);
    expect(read('app/de.ts'), 'edited by hand');
  });

  test('overwriting an edited generated file warns', () {
    write(v1);
    put('app/de.ts', 'edited by hand');
    final result = write([...v1.take(2), GeneratedFile('app/de.ts', 'v2')]);
    final issue = result.issues.single;
    expect(issue.code, 'modified-generated-file');
    expect(issue.path, endsWith(p.join('app', 'de.ts')));
    expect(issue.message, contains('overwritten'));
    expect(read('app/de.ts'), 'v2');
    // An unedited file that changes is rewritten without a warning.
    expect(write([...v1.take(2), GeneratedFile('app/de.ts', 'v3')]).issues,
        isEmpty);
  });

  group('a custom header marks only real generated headers', () {
    const writer = OutputWriter(markers: ['Generated', 'Two\nlines']);

    for (final contents in [
      'Generated by hand, with care\n',
      '/* Generated */\n',
      'const generated = "// Generated";\n',
      '# Two\nconst x = 1;\n',
    ]) {
      test('${contents.split('\n').first} is not taken over', () {
        put('index.ts', contents);
        final result = plan(v1, writer: writer);
        expect([for (final i in result.issues) i.code], ['unowned-file']);
      });
    }

    for (final contents in [
      '// Generated\nexport {};\n',
      '#Generated\n',
      '/* eslint-disable */\n// Two\n// lines\n',
    ]) {
      test('${contents.split('\n').first} is taken over with a warning', () {
        put('index.ts', contents);
        final result = write(v1, writer: writer);
        final issue = result.issues.single;
        expect(issue.code, 'took-over-file');
        expect(issue.severity, Severity.warning);
        expect(issue.path, p.join(out, 'index.ts'));
        expect(read('index.ts'), v1.first.contents);
      });
    }
  });

  test('Windows device names are rejected on every platform', () {
    for (final rel in [
      'con/en.ts',
      'app/NUL.ts',
      'app/com1.d.ts',
      'Lpt9',
      'aux .py',
    ]) {
      final result = plan([GeneratedFile(rel, 'x')]);
      expect([for (final i in result.issues) i.code], ['reserved-file-name'],
          reason: rel);
      expect(result.issues.single.path, p.join(out, rel));
    }
    for (final rel in ['console/en.ts', 'app/com10.ts', 'app/nul_x.ts']) {
      expect(plan([GeneratedFile(rel, 'x')]).issues, isEmpty, reason: rel);
    }
  });
  group('canonicalPath', () {
    test('resolves symbolic links, also of missing directories\' parents', () {
      io.Directory(out).createSync();
      final alias = p.join(temp.path, 'alias');
      io.Link(alias).createSync(out);
      expect(canonicalPath(alias), canonicalPath(out));
      expect(canonicalPath(p.join(alias, 'a', 'b')),
          canonicalPath(p.join(out, 'a', 'b')));
      expect(
          canonicalPath(p.join(temp.path, 'other')), isNot(canonicalPath(out)));
    }, testOn: '!windows');

    test('ignores case exactly when the file system does', () {
      io.Directory(out).createSync();
      final upper = p.join(temp.path, 'OUT');
      final insensitive = io.Directory(upper).existsSync();
      expect(isCaseInsensitiveAt(out), insensitive);
      expect(canonicalPath(upper) == canonicalPath(out), insensitive);
      expect(
        canonicalPath(p.join(upper, 'New')) ==
            canonicalPath(p.join(out, 'new')),
        insensitive,
      );
    });
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
      // A file where the second staging directory goes: staging fails there
      // (also as root, unlike a read-only directory).
      final blocker = io.File(p.join(second, stagingDirName))
        ..writeAsStringSync('x');
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
      expect(
          io.Directory(second).listSync().map((e) => e.path), [blocker.path]);
      expect(blocker.readAsStringSync(), 'x');
    }, testOn: '!windows');

    test('a failure while committing names the written and partial targets',
        () {
      write([...v1, GeneratedFile('old/x.ts', 'x')]);
      // `old/x.ts` is stale now. Its directory is then swapped for a link
      // out of the output directory: the first plan commits, deleting the
      // stale file of the second one is refused (also as root).
      final plans = [
        planIn(second, v1),
        plan(v1),
      ];
      final outside = p.join(temp.path, 'outside');
      io.Directory(p.join(out, 'old')).renameSync(outside);
      io.Link(p.join(out, 'old')).createSync(outside);
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
      expect(io.File(p.join(outside, 'x.ts')).readAsStringSync(), 'x',
          reason: 'nothing outside the output directory is touched');
    }, testOn: '!windows');

    test('each target stages into a directory of its own', () {
      expect(stagingDirNameFor('ts'), '.sheety-staging-ts');
      expect(stagingDirNameFor(null), stagingDirName);
      final ts = const OutputWriter().plan(
          outputDir: out, files: v1, manifest: manifest(v1), target: 'ts');
      expect(ts.target, 'ts');
      // A leftover staging directory of another target is not touched.
      final other = io.Directory(p.join(out, stagingDirNameFor('python')))
        ..createSync(recursive: true);
      io.File(p.join(other.path, 'keep')).writeAsStringSync('x');
      const OutputWriter().apply(ts);
      expect(io.File(p.join(other.path, 'keep')).existsSync(), isTrue);
      expect(io.Directory(p.join(out, stagingDirNameFor('ts'))).existsSync(),
          isFalse);
    });

    test('refuses plans whose directories overlap through a symlink', () {
      io.Directory(out).createSync();
      final alias = p.join(temp.path, 'alias');
      io.Link(alias).createSync(out);
      for (final dir in [alias, p.join(alias, 'nested')]) {
        expect(
          () =>
              const OutputWriter().applyAll([planIn(out, v1), planIn(dir, v1)]),
          throwsStateError,
          reason: dir,
        );
      }
      expect(io.Directory(out).listSync(), isEmpty);
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
