/// Sheet layout shared by `localize` and `generate`.
///
/// Both executables read the same layout:
/// `label | description | meta | <source> | <locale> ...` — row 1 is the
/// header, the fourth column is the base (source) language and every later
/// column is a target locale.
library;

import '../localize/language_names.dart';

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

/// Whether [header] describes a localization sheet.
///
/// The expected layout is `label | description | meta | source | locale ...`,
/// so the fourth column is the source language the rest are translated from.
/// It does not have to be English: `ru`, `de`, `pt_BR` and any other
/// recognized language code are equally valid sources.
///
/// A spreadsheet usually holds other sheets too — reference tables, notes —
/// whose columns are ordinary data. Localizing those would overwrite them with
/// translations, so a sheet whose fourth column is not a recognized language
/// (e.g. a `Family` or `Region` data column) is left alone.
///
/// [minimumLocales] is how many locale columns (the source included) the
/// header needs: `localize` needs a target to translate into (2, the
/// default); `generate` accepts a sheet with the base language only (1).
bool isLocalizationHeader(List<Object?> header, {int minimumLocales = 2}) {
  if (header.length < 3 + minimumLocales || header.length < 4) return false;
  final source = header[3];
  if (source is! String) return false;
  return resolveLanguageName(source) != null;
}
