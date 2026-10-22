/// Writes generated files into a target's output directory, owning only the
/// files it generated.
///
/// Ownership is recorded in the output directory's [manifestFileName]: the
/// writer rewrites only files whose content changed, deletes files it
/// generated earlier that are no longer generated, and never touches any
/// other file (a `pubspec.yaml`, `package.json`, `README.md` placed next to
/// the generated code stays as it is).
///
/// Without a manifest (the first run, e.g. over the output of 0.6.0) an
/// existing file at a path about to be generated is taken over only when it
/// is byte-identical or looks generated (it contains the header comment);
/// anything else is a conflict and nothing is written. Files that look
/// generated but are no longer produced (0.6.0's ARB files, files of
/// removed scopes) are left alone and reported, since nothing proves the
/// generator wrote them.
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;

import 'diagnostics.dart' show Severity;
import 'emitter.dart';
import 'manifest.dart';

/// A problem found outside the sheet: configuration, output directory,
/// emitters. (Sheet problems are `Diagnostic`s.)
final class GenerateIssue {
  /// Creates an issue.
  const GenerateIssue(
    this.code,
    this.message, {
    this.severity = Severity.error,
    this.target,
    this.path,
  });

  /// Stable kebab-case id, e.g. `unowned-file`.
  final String code;

  /// Human-readable description.
  final String message;

  /// Severity.
  final Severity severity;

  /// Target id, if the issue belongs to one.
  final String? target;

  /// File system path the issue is about, if any.
  final String? path;

  /// Whether this issue blocks generation.
  bool get isError => severity == Severity.error;

  /// JSON form.
  Map<String, Object?> toJson() => {
        'code': code,
        'severity': severity.name,
        'message': message,
        if (target != null) 'target': target,
        if (path != null) 'path': path,
      };

  @override
  String toString() => '${severity.name}[$code]'
      '${target == null ? '' : ' ($target)'}: $message';
}

/// Name of the directory inside an output directory where [OutputWriter]
/// stages new files before moving them into place. Removed after every
/// write; a leftover of an interrupted run is replaced by the next one.
const String stagingDirName = '.sheety-staging';

/// Writing to the file system failed in [OutputWriter.applyAll].
final class WriteFailure implements Exception {
  /// Creates a failure.
  const WriteFailure(
    this.cause, {
    required this.written,
    required this.notWritten,
    this.partial,
  });

  /// The underlying error.
  final io.FileSystemException cause;

  /// Output directories that were written completely.
  final List<String> written;

  /// The output directory that was left partly written, if any.
  final String? partial;

  /// Output directories nothing was written to.
  final List<String> notWritten;

  @override
  String toString() => 'WriteFailure: ${cause.message} (${cause.path}); '
      'written: $written, partial: $partial, not written: $notWritten';
}

/// What happens to one file.
enum FileChange {
  /// New file.
  added,

  /// Existing file with different content.
  changed,

  /// Previously generated file that is no longer generated; deleted.
  removed,

  /// Same content; not touched.
  unchanged,
}

/// One planned file operation, [path] relative to the output directory.
final class FileAction {
  /// Creates an action.
  const FileAction(this.path, this.change, {this.contents, this.adopted});

  /// Relative POSIX path.
  final String path;

  /// The kind of change.
  final FileChange change;

  /// New contents (not for [FileChange.removed]).
  final String? contents;

  /// Whether an existing file not recorded in the manifest is taken over.
  final bool? adopted;

  @override
  String toString() => '${change.name} $path';
}

/// The planned operations for one output directory.
final class WritePlan {
  /// Creates a plan.
  WritePlan({
    required this.outputDir,
    required this.actions,
    required this.issues,
  });

  /// Absolute output directory.
  final String outputDir;

  /// Every action, sorted by path; the manifest is last.
  final List<FileAction> actions;

  /// Conflicts (errors) and notes (warnings, infos).
  final List<GenerateIssue> issues;

  /// Whether any issue is an error (the plan must not be applied).
  bool get hasErrors => issues.any((i) => i.isError);

  /// Paths of [FileChange.added] files.
  List<String> get added => _paths(FileChange.added);

  /// Paths of [FileChange.changed] files.
  List<String> get changed => _paths(FileChange.changed);

  /// Paths of [FileChange.removed] files.
  List<String> get removed => _paths(FileChange.removed);

  /// Paths of [FileChange.unchanged] files.
  List<String> get unchanged => _paths(FileChange.unchanged);

  /// Whether applying the plan would change anything on disk.
  bool get hasChanges => actions.any((a) => a.change != FileChange.unchanged);

  List<String> _paths(FileChange change) => [
        for (final a in actions)
          if (a.change == change) a.path
      ];
}

/// Plans and applies writes of [GeneratedFile]s.
final class OutputWriter {
  /// Creates a writer.
  ///
  /// A file not owned by the generator "looks generated" when its first
  /// 2 KiB contain one of [markers] (header texts), or when
  /// [looksGenerated] says so (e.g. 0.6.0 ARB files for Dart).
  const OutputWriter({
    this.markers = const [EmitOptions.defaultHeader],
    this.looksGenerated,
    this.skipDirs = const [],
  });

  /// Header texts that mark a file as generated.
  final List<String> markers;

  /// Extra test for "looks generated", given the relative path.
  final bool Function(String relativePath)? looksGenerated;

  /// Absolute directories inside the output directory that the scan for
  /// leftovers skips (e.g. another target's output nested in this one).
  final List<String> skipDirs;

  /// Plans writing [files] (plus the [manifest]) into [outputDir].
  ///
  /// Nothing is written. Errors are reported as issues: a path outside the
  /// output directory, an unowned file in the way, an unreadable manifest,
  /// paths differing only in case.
  WritePlan plan({
    required String outputDir,
    required List<GeneratedFile> files,
    required Manifest manifest,
    String? target,
  }) {
    final root = p.normalize(p.absolute(outputDir));
    final issues = <GenerateIssue>[];
    void error(String code, String message, [String? path]) =>
        issues.add(GenerateIssue(code, message, target: target, path: path));

    // Desired files: generated + manifest.
    final desired = <String, String>{};
    final lowerCase = <String, String>{};
    for (final file in [
      ...files,
      GeneratedFile(manifestFileName, manifest.encode()),
    ]) {
      final rel = file.relativePath;
      if (desired.containsKey(rel)) {
        error(
          'duplicate-output',
          rel == manifestFileName
              ? 'The emitter generates "$rel", the name of the manifest'
              : 'The emitter generates "$rel" twice',
          rel,
        );
        continue;
      }
      final other = lowerCase[rel.toLowerCase()];
      if (other != null) {
        error(
          'case-collision',
          '"$rel" and "$other" differ only in case and collide on '
              'case-insensitive file systems',
          rel,
        );
      }
      lowerCase[rel.toLowerCase()] = rel;
      final escape = _escapes(root, rel);
      if (escape != null) {
        error('path-traversal', escape, rel);
        continue;
      }
      desired[rel] = file.contents;
    }

    // Previously owned files.
    final manifestFile = io.File(p.join(root, manifestFileName));
    Map<String, String>? owned;
    if (manifestFile.existsSync()) {
      try {
        final previous = Manifest.parse(manifestFile.readAsStringSync());
        if (target != null &&
            previous.target.isNotEmpty &&
            previous.target != target) {
          error(
            'foreign-manifest',
            '${manifestFile.path} belongs to the ${previous.target} target, '
                'not to $target: the output directories of two targets are '
                'mixed up. Give each target its own directory (or delete the '
                'manifest to let $target take the directory over)',
            manifestFile.path,
          );
          owned = const {};
        } else {
          owned = previous.files;
        }
      } on Object catch (e) {
        error(
          'invalid-manifest',
          '${manifestFile.path} cannot be read ($e); delete it to let the '
              'generator take over the directory again',
          manifestFile.path,
        );
        owned = const {};
      }
    }
    // Owned paths by lower-cased path: on a case-insensitive file system
    // (macOS, Windows) `Chat/en.ts` is the file the manifest lists as
    // `chat/en.ts`.
    final ownedByLowerCase = <String, String>{
      for (final rel in (owned ?? const <String, String>{}).keys)
        rel.toLowerCase(): rel,
    };

    final actions = <FileAction>[];
    for (final MapEntry(key: rel, value: contents) in desired.entries) {
      final file = io.File(p.join(root, rel));
      final type = io.FileSystemEntity.typeSync(file.path, followLinks: false);
      if (type == io.FileSystemEntityType.notFound) {
        actions.add(FileAction(rel, FileChange.added, contents: contents));
        continue;
      }
      if (type != io.FileSystemEntityType.file) {
        error(
          'unowned-file',
          '${file.path} exists and is not a regular file; move it away',
          file.path,
        );
        continue;
      }
      final current = _read(file);
      final ownedAs = rel == manifestFileName
          ? rel
          : (owned?.containsKey(rel) ?? false)
              ? rel
              : ownedByLowerCase[rel.toLowerCase()];
      final isOwned = ownedAs != null;
      // Renamed by case only (`chat/` -> `Chat/`): the old path is deleted
      // first, so the file must be written again, under its new name.
      final renamed = ownedAs != null && ownedAs != rel;
      if (current == contents && !renamed) {
        actions.add(FileAction(rel, FileChange.unchanged,
            contents: contents, adopted: !isOwned));
        continue;
      }
      if (!isOwned && !_looksGenerated(rel, current)) {
        error(
          'unowned-file',
          '${file.path} exists, was not generated by $generatorName and '
              'would be overwritten; move or delete it, or choose another '
              'output directory',
          file.path,
        );
        continue;
      }
      actions.add(FileAction(rel, FileChange.changed,
          contents: contents, adopted: !isOwned));
    }

    // Stale owned files.
    final desiredLowerCase = {
      for (final rel in desired.keys) rel.toLowerCase()
    };
    for (final MapEntry(key: rel, value: hash) in (owned ?? const {}).entries) {
      if (desired.containsKey(rel) || rel == manifestFileName) continue;
      final escape = _escapes(root, rel);
      if (escape != null) {
        error('path-traversal', 'manifest entry: $escape', rel);
        continue;
      }
      final file = io.File(p.join(root, rel));
      if (io.FileSystemEntity.typeSync(file.path, followLinks: false) !=
          io.FileSystemEntityType.file) {
        continue; // already gone (or replaced by a directory: not ours)
      }
      if (!desiredLowerCase.contains(rel.toLowerCase()) &&
          sha256Hex(_read(file)) != hash) {
        issues.add(GenerateIssue(
          'modified-generated-file',
          '$rel was edited after it was generated; it is no longer '
              'generated and is deleted anyway',
          severity: Severity.warning,
          target: target,
          path: file.path,
        ));
      }
      actions.add(FileAction(rel, FileChange.removed));
    }

    // First run: report leftovers that look generated.
    if (owned == null && io.Directory(root).existsSync()) {
      final leftovers = <String>[];
      for (final rel in _scan(root)) {
        if (desired.containsKey(rel)) continue;
        final file = io.File(p.join(root, rel));
        if (looksGenerated?.call(rel) ?? false) {
          leftovers.add(rel);
        } else if (_hasMarker(_head(file))) {
          leftovers.add(rel);
        }
      }
      if (leftovers.isNotEmpty) {
        leftovers.sort();
        issues.add(GenerateIssue(
          'legacy-output',
          'No $manifestFileName in $root yet, and ${leftovers.length} '
              'file(s) there look generated but are not produced any more '
              '(output of an older version?). They are left untouched; '
              'delete them if they are obsolete:\n'
              '${_summarize(leftovers).map((f) => '  $f').join('\n')}',
          severity: Severity.warning,
          target: target,
          path: root,
        ));
      }
    }

    actions.sort((a, b) {
      if (a.path == manifestFileName) return 1;
      if (b.path == manifestFileName) return -1;
      return a.path.compareTo(b.path);
    });
    return WritePlan(outputDir: root, actions: actions, issues: issues);
  }

  /// Applies [plan]; see [applyAll].
  void apply(WritePlan plan) => applyAll([plan]);

  /// Applies [plans] (of different output directories) as one unit, as far
  /// as a file system allows:
  ///
  /// 1. every added or changed file of every plan is written to a staging
  ///    directory ([stagingDirName]) inside its output directory; when that
  ///    fails, the staged files are deleted and nothing was written;
  /// 2. then, plan by plan, the files no longer generated are deleted (and
  ///    the directories that became empty), the staged files are moved into
  ///    place (a rename on the same file system) and the manifest last.
  ///
  /// Deleting before moving makes a rename by case only (`chat/` ->
  /// `Chat/`) work on case-insensitive file systems.
  ///
  /// Throws [StateError] when a plan has errors, and [WriteFailure] (with
  /// what was written) when the file system fails.
  void applyAll(List<WritePlan> plans) {
    if (plans.any((p) => p.hasErrors)) {
      throw StateError('Refusing to apply a plan with errors');
    }
    final staged = <WritePlan, io.Directory>{};
    final createdRoots = <io.Directory>[];
    void discard() {
      for (final dir in staged.values) {
        try {
          if (dir.existsSync()) dir.deleteSync(recursive: true);
        } on io.FileSystemException {
          // Best effort: a leftover staging directory is removed next time.
        }
      }
      staged.clear();
      for (final root in createdRoots.reversed) {
        try {
          if (root.existsSync() && root.listSync().isEmpty) root.deleteSync();
        } on io.FileSystemException {
          // Best effort.
        }
      }
    }

    // 1. Stage.
    try {
      for (final plan in plans) {
        final writes = [
          for (final a in plan.actions)
            if (a.change == FileChange.added || a.change == FileChange.changed)
              a,
        ];
        if (writes.isEmpty) continue;
        final root = io.Directory(plan.outputDir);
        if (!root.existsSync()) {
          var missing = root;
          while (!missing.parent.existsSync() &&
              missing.parent.path != missing.path) {
            missing = missing.parent;
          }
          createdRoots.add(missing);
          root.createSync(recursive: true);
        }
        final staging = io.Directory(p.join(plan.outputDir, stagingDirName));
        if (staging.existsSync()) staging.deleteSync(recursive: true);
        staging.createSync();
        staged[plan] = staging;
        for (final action in writes) {
          final temp = io.File(_staged(staging, action.path));
          temp.parent.createSync(recursive: true);
          temp.writeAsStringSync(action.contents!, flush: true);
        }
      }
    } on io.FileSystemException catch (e) {
      discard();
      throw WriteFailure(e, written: const [], notWritten: [
        for (final p in plans) p.outputDir,
      ]);
    }

    // 2. Commit.
    final written = <String>[];
    for (final (index, plan) in plans.indexed) {
      try {
        _commit(plan, staged[plan]);
        written.add(plan.outputDir);
      } on io.FileSystemException catch (e) {
        discard();
        throw WriteFailure(
          e,
          written: written,
          partial: plan.outputDir,
          notWritten: [for (final p in plans.skip(index + 1)) p.outputDir],
        );
      }
      try {
        staged.remove(plan)?.deleteSync(recursive: true);
      } on io.FileSystemException {
        // Only empty directories are left; the next run replaces them.
      }
    }
  }

  String _staged(io.Directory staging, String rel) =>
      p.joinAll([staging.path, ...rel.split('/')]);

  void _commit(WritePlan plan, io.Directory? staging) {
    final root = plan.outputDir;
    for (final action in plan.actions) {
      if (action.change != FileChange.removed) continue;
      final file = io.File(p.join(root, action.path));
      _checkRealPath(root, file.parent.path);
      if (file.existsSync()) file.deleteSync();
      _pruneEmpty(root, file.parent);
    }
    // The actions are sorted by path with the manifest last.
    for (final action in plan.actions) {
      if (action.change != FileChange.added &&
          action.change != FileChange.changed) {
        continue;
      }
      final file = io.File(p.join(root, action.path));
      _checkRealPath(root, file.parent.path);
      file.parent.createSync(recursive: true);
      _checkRealPath(root, file.parent.path);
      io.File(_staged(staging!, action.path)).renameSync(file.path);
    }
  }

  bool _looksGenerated(String rel, String contents) =>
      (looksGenerated?.call(rel) ?? false) ||
      _hasMarker(
          contents.length > 2048 ? contents.substring(0, 2048) : contents);

  bool _hasMarker(String head) =>
      markers.any((m) => m.isNotEmpty && head.contains(m));

  /// Relative paths of every file under [root], skipping hidden directories,
  /// dependency/build directories and [skipDirs]; symlinks are not followed.
  Iterable<String> _scan(String root) sync* {
    const skipped = {'node_modules', '__pycache__', 'build', '.dart_tool'};
    final pending = [io.Directory(root)];
    while (pending.isNotEmpty) {
      final dir = pending.removeLast();
      final List<io.FileSystemEntity> entries;
      try {
        entries = dir.listSync(followLinks: false);
      } on io.FileSystemException {
        continue;
      }
      for (final entity in entries) {
        final name = p.basename(entity.path);
        if (entity is io.Directory) {
          if (name.startsWith('.') || skipped.contains(name)) continue;
          if (skipDirs.any((d) => p.equals(d, entity.path))) continue;
          pending.add(entity);
        } else if (entity is io.File) {
          yield p.posix.joinAll(p.split(p.relative(entity.path, from: root)));
        }
      }
    }
  }
}

/// [paths] (sorted) with every directory holding more than three of them
/// collapsed into one `dir/ (N files)` line.
List<String> _summarize(List<String> paths) {
  final byDir = <String, List<String>>{};
  for (final path in paths) (byDir[p.posix.dirname(path)] ??= []).add(path);
  return [
    for (final MapEntry(key: dir, value: files) in byDir.entries)
      if (files.length > 3 && dir != '.')
        '$dir/ (${files.length} files)'
      else
        ...files,
  ];
}

/// Why [rel] escapes [root] (lexically or through a symlink), or `null`.
String? _escapes(String root, String rel) {
  if (rel.isEmpty ||
      p.posix.isAbsolute(rel) ||
      p.windows.isAbsolute(rel) ||
      rel.contains(r'\') ||
      rel.split('/').any((s) => s == '..' || s.isEmpty || s == '.')) {
    return '"$rel" is not a relative path inside the output directory';
  }
  final full = p.normalize(p.join(root, rel));
  if (!p.isWithin(root, full)) {
    return '"$rel" resolves outside the output directory $root';
  }
  // A symlinked directory inside the output must not lead outside it.
  var dir = p.dirname(full);
  while (p.isWithin(root, dir) && !io.Directory(dir).existsSync()) {
    dir = p.dirname(dir);
  }
  if (p.isWithin(root, dir) || p.equals(root, dir)) {
    final realRoot = _real(root);
    final realDir = _real(dir);
    if (realRoot != null &&
        realDir != null &&
        !p.equals(realRoot, realDir) &&
        !p.isWithin(realRoot, realDir)) {
      return '"$rel" goes through a symbolic link that leads outside the '
          'output directory ($realDir)';
    }
  }
  return null;
}

void _checkRealPath(String root, String dir) {
  if (!io.Directory(dir).existsSync()) return;
  final realRoot = _real(root);
  final realDir = _real(dir);
  if (realRoot == null || realDir == null) return;
  if (!p.equals(realRoot, realDir) && !p.isWithin(realRoot, realDir)) {
    throw io.FileSystemException(
      'Refusing to write outside the output directory',
      realDir,
    );
  }
}

String? _real(String path) {
  try {
    return io.Directory(path).resolveSymbolicLinksSync();
  } on io.FileSystemException {
    return null;
  }
}

void _pruneEmpty(String root, io.Directory dir) {
  var current = dir;
  while (p.isWithin(root, current.path)) {
    try {
      if (current.listSync().isNotEmpty) return;
      current.deleteSync();
    } on io.FileSystemException {
      return;
    }
    current = current.parent;
  }
}

String _read(io.File file) {
  final bytes = file.readAsBytesSync();
  return utf8.decode(bytes, allowMalformed: true);
}

String _head(io.File file) {
  try {
    final raf = file.openSync();
    try {
      return utf8.decode(raf.readSync(2048), allowMalformed: true);
    } finally {
      raf.closeSync();
    }
  } on io.FileSystemException {
    return '';
  }
}
