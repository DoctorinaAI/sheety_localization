/// Shared helpers of the localization pipeline.
library;

import 'dart:io' as io;

export '../common/sheet_layout.dart' show columnFromIndex, sanitizer;

/// Log a line to stdout. Replaceable in tests.
void Function(Object? message) $log = io.stdout.writeln;

/// Log a line to stderr. Replaceable in tests.
void Function(Object? message) $err = io.stderr.writeln;
