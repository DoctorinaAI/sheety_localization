import 'dart:convert';
import 'dart:io' as io;

import 'package:sheety_localization/sheety_localization.dart';

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
