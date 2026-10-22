import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:sheety_localization/sheety_localization.dart';
import 'package:test/test.dart';

/// Reads a snapshot (`{"sheets":[{"title":..,"values":[[..]]}]}`).
List<SheetData> loadSnapshot(String path) {
  final json =
      jsonDecode(io.File(path).readAsStringSync()) as Map<String, Object?>;
  return [
    for (final sheet
        in (json['sheets']! as List<Object?>).cast<Map<String, Object?>>())
      (
        title: sheet['title']! as String,
        values: [
          for (final row in sheet['values']! as List<Object?>)
            (row! as List<Object?>).toList(),
        ],
      ),
  ];
}

/// A one-sheet input.
List<SheetData> sheet(String title, List<List<Object?>> values) =>
    [(title: title, values: values)];

/// Codes of [diagnostics].
List<String> codes(Iterable<Diagnostic> diagnostics) =>
    [for (final d in diagnostics) d.code.id];

/// Whether a missing toolchain fails the test run instead of skipping
/// (`SHEETY_REQUIRE_TOOLS=1`). The integration job of the CI sets it, so a
/// tool that silently disappeared cannot turn into a green run of skips.
/// Skips for a missing real-sheet snapshot stay skips.
bool get requireTools => io.Platform.environment['SHEETY_REQUIRE_TOOLS'] == '1';

/// Reports that the tool described by [what] is missing: returns normally
/// (the caller skips) unless [requireTools] is set, then it fails.
void reportMissingTool(String what) {
  if (requireTools) {
    fail('$what, and SHEETY_REQUIRE_TOOLS=1 turns that skip into a failure');
  }
}

/// Whether goldens are rewritten instead of compared (`UPDATE_GOLDENS=1`).
///
/// Refuses on a CI (`CI` set): a run that rewrites its own expectations
/// always passes.
bool get updateGoldens {
  final env = io.Platform.environment;
  if (env['UPDATE_GOLDENS'] != '1') return false;
  if ((env['CI'] ?? '').isNotEmpty) {
    throw StateError('UPDATE_GOLDENS=1 is not allowed when CI is set: '
        'goldens must be compared, not rewritten, on a CI run');
  }
  return true;
}

/// The absolute path of the executable [name] on the `PATH`, or `null`.
///
/// A pure-Dart lookup (no `which`, which Windows lacks) that honours
/// `PATHEXT` on Windows (`npx` is `npx.cmd` there).
String? lookupExecutable(String name) {
  final env = io.Platform.environment;
  final windows = io.Platform.isWindows;
  final path = env['PATH'] ?? env['Path'] ?? '';
  // On Windows an extensionless file (e.g. the `flutter` shell script next
  // to `flutter.bat`) is not runnable, so it is only the last resort.
  final extensions = windows
      ? [
          for (final e in (env['PATHEXT'] ?? '.COM;.EXE;.BAT;.CMD').split(';'))
            if (e.isNotEmpty) e.toLowerCase(),
          '',
        ]
      : const [''];
  for (final dir in path.split(windows ? ';' : ':')) {
    if (dir.isEmpty) continue;
    for (final extension in extensions) {
      final candidate = p.join(dir, '$name$extension');
      final file = io.File(candidate);
      if (!file.existsSync()) continue;
      // Any of u+x, g+x, o+x; Windows has no execute bit.
      if (windows || file.statSync().mode & 0x49 != 0) return candidate;
    }
  }
  return null;
}

/// Probes the optional tool [name] on the `PATH`: its path, or `null` when
/// it is missing (the caller skips) - a failure instead under
/// [requireTools].
String? findExecutable(String name) {
  final found = lookupExecutable(name);
  if (found == null) reportMissingTool('`$name` is not on the PATH');
  return found;
}

/// Whether the optional tool [name] is on the `PATH` (see [findExecutable]).
bool hasTool(String name) => findExecutable(name) != null;
