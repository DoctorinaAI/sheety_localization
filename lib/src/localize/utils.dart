/// Shared helpers of the localization pipeline.
library;

import 'dart:io' as io;

/// Log a line to stdout. Replaceable in tests.
void Function(Object? message) $log = io.stdout.writeln;

/// Log a line to stderr. Replaceable in tests.
void Function(Object? message) $err = io.stderr.writeln;

/// Create sanitizer function to sanitize the localization table keys
String Function(String input) sanitizer() {
  final invalid = RegExp('[^a-zA-Z0-9_]');
  final merge = RegExp('_+');
  final trim = RegExp(r'^_+|_+$');
  return (String input) => input
      .replaceAll(invalid, '_') // replace invalid characters with _
      .replaceAll(merge, '_') // merge multiple _ into one
      .replaceAll(trim, ''); // remove leading and trailing _
}

/// Convert column index to column name (e.g. 0 -> A, 1 -> B, 26 -> AA)
String columnFromIndex(int index) {
  if (index < 0) throw ArgumentError('Index must be non-negative');
  var columnName = '';
  do {
    final remainder = index % 26;
    columnName = String.fromCharCode(65 + remainder) + columnName;
    index = (index / 26).floor() - 1;
  } while (index >= 0);
  return columnName;
}
