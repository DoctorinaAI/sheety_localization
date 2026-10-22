/// Sheet layout shared by `localize` and `generate`.
///
/// Both executables read the same layout:
/// `label | description | meta | <source> | <locale> ...` — row 1 is the
/// header, the fourth column is the base (source) language and every later
/// column is a target locale.
library;

import '../localize/language_names.dart';
import 'locale_tag.dart';

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

/// Whether [cell] holds no content: `null`, or a string of whitespace only.
///
/// A cell holding just a space looks empty in the spreadsheet, so both
/// executables treat it as empty: an empty row is skipped, an empty
/// translation is (re)translated by `localize` and falls back in `generate`.
bool isBlankCell(Object? cell) =>
    cell == null || (cell is String && cell.trim().isEmpty);

final String Function(String) _sanitize = sanitizer();

/// The locale a header cell names, or `null` when it names none.
///
/// The cell is sanitized like a label first (`pt BR`, `pt-BR` -> `pt_BR`),
/// then parsed and normalized by [LocaleTag.tryParse] (`pt_br` -> `pt_BR`).
LocaleTag? localeOfHeaderCell(Object? cell) =>
    cell is String ? LocaleTag.tryParse(_sanitize(cell)) : null;

/// A locale column of the header: the base column D or a target locale.
final class LocaleColumn {
  /// Creates a column at the 0-based [index] holding [tag].
  const LocaleColumn(this.index, this.tag);

  /// 0-based column index.
  final int index;

  /// The normalized locale.
  final LocaleTag tag;

  /// Column letter (`D`, `AB`).
  String get letter => columnFromIndex(index);
}

/// Why a header cell from column D on is not a [LocaleColumn].
enum HeaderCellProblem {
  /// The cell is empty (or whitespace only).
  blank,

  /// The cell is not text (a number, a boolean).
  notText,

  /// The text is not a locale code (`Notes`, `English`).
  invalid,

  /// The locale is the same as an earlier column's after normalizing
  /// (`pt-BR` and `pt_br`).
  duplicate,
}

/// A header cell from column D on that is not a locale column.
final class SkippedHeaderCell {
  /// Creates a skipped cell.
  const SkippedHeaderCell(
    this.index,
    this.cell,
    this.problem, {
    this.duplicateOf,
  });

  /// 0-based column index.
  final int index;

  /// The header cell as read.
  final Object? cell;

  /// Why the column is skipped.
  final HeaderCellProblem problem;

  /// The earlier column with the same locale, for a
  /// [HeaderCellProblem.duplicate].
  final LocaleColumn? duplicateOf;

  /// Column letter (`D`, `AB`).
  String get letter => columnFromIndex(index);
}

/// The locale columns of a header, as both executables read them.
typedef LocaleHeader = ({
  List<LocaleColumn> columns,
  List<SkippedHeaderCell> skipped,
});

/// Reads the locale columns of [header] (column D and every later one).
///
/// Every cell goes through [localeOfHeaderCell]; a cell that is empty, not
/// text, not a locale code or a locale an earlier column already has is
/// skipped. The columns are in header order, so the base column comes first
/// when it is valid.
LocaleHeader readLocaleHeader(List<Object?> header) {
  final columns = <LocaleColumn>[];
  final skipped = <SkippedHeaderCell>[];
  final seen = <LocaleTag, LocaleColumn>{};
  for (var i = 3; i < header.length; i++) {
    final cell = header[i];
    if (isBlankCell(cell)) {
      skipped.add(SkippedHeaderCell(i, cell, HeaderCellProblem.blank));
      continue;
    }
    if (cell is! String) {
      skipped.add(SkippedHeaderCell(i, cell, HeaderCellProblem.notText));
      continue;
    }
    final tag = localeOfHeaderCell(cell);
    if (tag == null) {
      skipped.add(SkippedHeaderCell(i, cell, HeaderCellProblem.invalid));
      continue;
    }
    final duplicate = seen[tag];
    if (duplicate != null) {
      skipped.add(SkippedHeaderCell(
        i,
        cell,
        HeaderCellProblem.duplicate,
        duplicateOf: duplicate,
      ));
      continue;
    }
    final column = LocaleColumn(i, tag);
    seen[tag] = column;
    columns.add(column);
  }
  return (columns: columns, skipped: skipped);
}

/// Whether [header] describes a localization sheet.
///
/// The expected layout is `label | description | meta | source | locale ...`,
/// so the fourth column is the source language the rest are translated from.
/// It does not have to be English: `ru`, `de`, `pt_BR` and any other
/// recognized language code are equally valid sources. D1 is read like every
/// other locale header cell ([localeOfHeaderCell]), so `pt BR` is `pt_BR`.
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
  final source = localeOfHeaderCell(header[3]);
  return source != null && resolveLanguageName(source.code) != null;
}
