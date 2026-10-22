import 'dart:io' as io;

import 'package:path/path.dart' as p;

/// Whether goldens are rewritten instead of compared.
bool get updateGoldens => io.Platform.environment['UPDATE_GOLDENS'] == '1';

/// The Flutter SDK root: `FLUTTER_ROOT`, else the parent of the `flutter`
/// executable found on PATH; `null` when there is none.
String? flutterSdkRoot() {
  final env = io.Platform.environment['FLUTTER_ROOT'];
  if (env != null && io.Directory(env).existsSync()) return env;
  final executable = findExecutable('flutter');
  if (executable == null) return null;
  final resolved = io.File(executable).resolveSymbolicLinksSync();
  return p.dirname(p.dirname(resolved));
}

/// The absolute path of [name] on PATH, or `null`.
String? findExecutable(String name) {
  final path = io.Platform.environment['PATH'] ?? '';
  final separator = io.Platform.isWindows ? ';' : ':';
  for (final dir in path.split(separator)) {
    if (dir.isEmpty) continue;
    for (final candidate in [
      p.join(dir, name),
      if (io.Platform.isWindows) p.join(dir, '$name.bat'),
    ]) {
      if (io.File(candidate).existsSync()) return candidate;
    }
  }
  return null;
}

/// Runs `dart format` on [paths]; returns the paths it changed.
Future<io.ProcessResult> dartFormat(
  List<String> paths, {
  int? pageWidth,
  bool setExitIfChanged = false,
  bool dryRun = false,
}) =>
    io.Process.run(io.Platform.resolvedExecutable, [
      'format',
      if (pageWidth != null) '--page-width=$pageWidth',
      if (setExitIfChanged) '--set-exit-if-changed',
      if (dryRun) '--output=none',
      '--show=changed',
      ...paths,
    ]);

/// Every file under [root], relative POSIX path -> contents.
Map<String, String> readTree(String root) => {
      for (final file
          in io.Directory(root)
              .listSync(recursive: true)
              .whereType<io.File>()
              .toList()
            ..sort((a, b) => a.path.compareTo(b.path)))
        p.posix.joinAll(p.split(p.relative(file.path, from: root))):
            file.readAsStringSync(),
    };

/// Writes [files] (relative POSIX path -> contents) under [root].
void writeTree(String root, Map<String, String> files) {
  for (final MapEntry(:key, :value) in files.entries) {
    final file = io.File(p.joinAll([root, ...key.split('/')]));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(value);
  }
}
