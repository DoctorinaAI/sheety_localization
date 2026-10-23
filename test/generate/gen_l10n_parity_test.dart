// Differential test: our ICU parser against Flutter's gen-l10n parser
// (`flutter_tools/lib/src/localizations/message_parser.dart`).
//
// Runs only when a Flutter SDK with resolved flutter_tools dependencies is
// found (FLUTTER_ROOT, or `flutter` on PATH). Inputs: the corpus in
// test/fixtures/icu_corpus.txt (one message per line, `\n` for newlines),
// every cell of the fixture snapshot and, when SHEETY_REAL_SNAPSHOT is set,
// every cell of the real snapshot.
import 'dart:convert';
import 'dart:io' as io;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Inputs where we deliberately differ from gen-l10n (see parser.dart).
const _knownDeviations = {
  // gen-l10n silently drops everything after an unmatched "}".
  'abc } def',
  '{n, plural, other{a}} tail}',
  '}',
  // gen-l10n's parser accepts these, its code generator then fails.
  '{n, plural, =3{x} other{y}}',
  '{n, plural, =00{x} other{y}}',
  // gen-l10n generates `Object a|b` — uncompilable Dart.
  '{a|b}',
  // DateTime arguments are not supported by `generate`.
  '{x, date, ::yMd}',
  '{x, time, ::Hm}',
};

String? _flutterTools() {
  var root = io.Platform.environment['FLUTTER_ROOT'];
  if (root == null) {
    try {
      final which = io.Process.runSync('which', ['flutter']);
      if (which.exitCode == 0) {
        root = p.dirname(p.dirname(
          io.File((which.stdout as String).trim()).resolveSymbolicLinksSync(),
        ));
      }
    } on Object {
      return null;
    }
  }
  if (root == null) return null;
  final config = p.join(
      root, 'packages', 'flutter_tools', '.dart_tool', 'package_config.json');
  return io.File(config).existsSync() ? config : null;
}

const _script = r'''
import 'dart:convert';
import 'dart:io';
import 'package:flutter_tools/src/localizations/message_parser.dart';
import 'PARSER';
import 'AST';

String g(Node n) {
  switch (n.type) {
    case ST.message:
      return n.children.map(g).join();
    case ST.string:
      return 'T(${n.value})';
    case ST.placeholderExpr:
      return 'A(${n.children[1].value})';
    case ST.pluralExpr:
      return 'P(${n.children[1].value};' + n.children[5].children.map((p) {
        final exact = p.children[0].value == '=';
        final sel = exact ? '=${p.children[1].value}' : p.children[0].value;
        return '$sel[${g(exact ? p.children[3] : p.children[2])}]';
      }).join() + ')';
    case ST.selectExpr:
      return 'S(${n.children[1].value};' + n.children[5].children
          .map((p) => '${p.children[0].value}[${g(p.children[2])}]')
          .join() + ')';
    default:
      return '?${n.type}';
  }
}

String m(IcuMessage msg) => msg.parts.map((p) => switch (p) {
  IcuText(:final text) => 'T($text)',
  IcuArgument(:final name) => 'A($name)',
  IcuPlural(:final argument, :final branches) => 'P($argument;' +
      branches.map((b) => '${b.selector}[${m(b.message)}]').join() + ')',
  IcuSelect(:final argument, :final branches) => 'S($argument;' +
      branches.map((b) => '${b.value}[${m(b.message)}]').join() + ')',
}).join();

void main() {
  final inputs = (jsonDecode(stdin.readLineSync()!) as List).cast<String>();
  final out = <Map<String, String>>[];
  for (final s in inputs) {
    String a, b;
    try { a = 'OK ${g(Parser('id', 'f', s).parse())}'; } on Object { a = 'ERR'; }
    try { b = 'OK ${m(parseIcu(s))}'; } on IcuSyntaxException { b = 'ERR'; }
    if (a != b) out.add({'input': s, 'genL10n': a, 'ours': b});
  }
  stdout.write(jsonEncode({'count': inputs.length, 'diffs': out}));
}
''';

void main() {
  final config = _flutterTools();
  test(
    'our parser accepts and structures exactly what gen-l10n does',
    () async {
      final inputs = <String>{
        for (final line
            in io.File('test/fixtures/icu_corpus.txt').readAsLinesSync())
          line.replaceAll(r'\n', '\n'),
        ..._cells('test/fixtures/basic_snapshot.json'),
        if (io.Platform.environment['SHEETY_REAL_SNAPSHOT'] case final path?)
          ..._cells(path),
      }.toList();
      final dir = io.Directory.systemTemp.createTempSync('sheety_parity');
      addTearDown(() => dir.deleteSync(recursive: true));
      final lib = p.absolute('lib', 'src', 'generate', 'icu');
      final script = io.File(p.join(dir.path, 'parity.dart'))
        ..writeAsStringSync(_script
            .replaceFirst(
                'PARSER', p.toUri(p.join(lib, 'parser.dart')).toString())
            .replaceFirst('AST', p.toUri(p.join(lib, 'ast.dart')).toString()));
      final process = await io.Process.start(
        io.Platform.resolvedExecutable,
        ['--packages=$config', 'run', script.path],
      );
      process.stdin.writeln(jsonEncode(inputs));
      await process.stdin.close();
      final stdout = await process.stdout.transform(utf8.decoder).join();
      final stderr = await process.stderr.transform(utf8.decoder).join();
      expect(await process.exitCode, 0, reason: stderr);
      final result = jsonDecode(stdout) as Map<String, Object?>;
      expect(result['count'], inputs.length);
      final diffs = [
        for (final d
            in (result['diffs']! as List<Object?>).cast<Map<String, Object?>>())
          if (!_knownDeviations.contains(d['input'])) d,
      ];
      expect(diffs, isEmpty,
          reason: const JsonEncoder.withIndent(' ').convert(diffs));
    },
    skip: config == null ? 'no Flutter SDK with flutter_tools found' : false,
    timeout: const Timeout(Duration(minutes: 3)),
  );
}

Iterable<String> _cells(String path) sync* {
  final json =
      jsonDecode(io.File(path).readAsStringSync()) as Map<String, Object?>;
  for (final sheet
      in (json['sheets']! as List<Object?>).cast<Map<String, Object?>>()) {
    final rows = (sheet['values']! as List<Object?>).cast<List<Object?>>();
    for (final row in rows.skip(1)) {
      for (final cell in row.skip(3)) {
        if (cell is String && cell.isNotEmpty) yield cell;
      }
    }
  }
}
