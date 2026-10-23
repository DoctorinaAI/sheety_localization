// Fails when a test run skipped anything other than the tests that need the
// internal real-sheet snapshot. A skip looks like a pass in the summary, so
// a toolchain that silently disappeared from the CI image (node, tsc,
// python, mypy, pyright, flutter) would otherwise go unnoticed. The helpers
// already fail under SHEETY_REQUIRE_TOOLS=1; this catches the probes that do
// not go through them.
//
// Usage: dart .github/scripts/check_skips.dart <json-reporter-output>...
// (produced by `dart test --file-reporter=json:<file>`).
import 'dart:convert';
import 'dart:io';

/// Skip reasons that are expected on every CI run: the real sheet is
/// internal and never available there, and the Linux runners have no
/// case-insensitive file system (the case-only rename tests run on macOS).
final RegExp _allowed = RegExp(
  r'SHEETY_REAL_(SNAPSHOT|REFERENCE)'
  '|the temporary directory is case-sensitive',
);

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('usage: check_skips.dart <json-report>...');
    exit(64);
  }
  final unexpected = <String>[];
  var skipped = 0;
  for (final path in args) {
    final names = <int, String>{};
    final reasons = <int, List<String>>{};
    for (final line in File(path).readAsLinesSync()) {
      if (line.trim().isEmpty) continue;
      final Object? decoded;
      try {
        decoded = jsonDecode(line);
      } on FormatException {
        continue;
      }
      if (decoded is! Map<String, Object?>) continue;
      switch (decoded['type']) {
        case 'testStart':
          final test = decoded['test']! as Map<String, Object?>;
          final id = test['id']! as int;
          names[id] = test['name']! as String;
          final metadata = test['metadata'] as Map<String, Object?>?;
          if (metadata?['skipReason'] case final String reason) {
            (reasons[id] ??= []).add(reason);
          }
        case 'print' when decoded['messageType'] == 'skip':
          final id = decoded['testID']! as int;
          (reasons[id] ??= []).add(decoded['message']! as String);
        case 'testDone' when decoded['skipped'] == true:
          final id = decoded['testID']! as int;
          skipped++;
          final why = (reasons[id] ?? const ['(no reason)']).join(' / ');
          if (!_allowed.hasMatch(why)) {
            unexpected.add('${names[id] ?? '#$id'}: $why');
          }
      }
    }
  }
  if (unexpected.isNotEmpty) {
    for (final entry in unexpected) {
      stdout.writeln('::error::Unexpected skip: $entry');
    }
    stdout.writeln('${unexpected.length} of $skipped skipped tests were not '
        'expected to skip on the CI (only the real-snapshot and the '
        'case-insensitive file system tests may).');
    exit(1);
  }
  stdout.writeln('$skipped skipped tests, all of them expected.');
}
