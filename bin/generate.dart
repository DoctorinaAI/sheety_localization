import 'dart:io' as io;

import 'package:sheety_localization/src/generate/pipeline.dart';

/// Generates localization code (Dart, TypeScript, Python) from a Google
/// Sheet. Run `dart run sheety_localization:generate --help` for usage.
Future<void> main(List<String> arguments) async {
  final code = await runGenerate(arguments);
  await Future.wait([io.stdout.flush(), io.stderr.flush()]);
  io.exit(code);
}
