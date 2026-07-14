/// Data model of the localization table.
library;

/// Represents a cell to be localized
class LocalizeCell {
  /// Creates a cell for the locale [code] in the spreadsheet [column].
  LocalizeCell({
    required this.column,
    required this.code,
    required this.text,
  });

  /// Zero-based column index in the sheet.
  int column;

  /// Locale code of the column, e.g. `uk`, `pt_BR`.
  String code;

  /// Localized text, empty until the cell is translated.
  String text;

  /// Whether the cell is still not localized.
  bool get isEmpty => text.isEmpty;
}

/// Represents a row to be localized
class LocalizeRow {
  /// Creates a row with the [cells] that still need a translation.
  LocalizeRow({
    required this.row,
    required this.label,
    required this.description,
    required this.meta,
    required this.english,
    required this.cells,
  });

  /// Zero-based row index in the sheet.
  int row;

  /// Sanitized key of the row.
  String label;

  /// Optional human description of the string, used as translation context.
  String? description;

  /// Optional ICU/intl placeholder description.
  String? meta;

  /// English source text.
  String english;

  /// Cells (locales) that have to be localized.
  List<LocalizeCell> cells;

  /// Whether the row has nothing to localize.
  bool get isEmpty => cells.isEmpty;

  /// Whether at least one cell of the row has been localized.
  bool get hasLocalizedCells => cells.any((cell) => !cell.isEmpty);

  /// Returns the cell for the locale [code], or `null` when the row has none.
  LocalizeCell? cellFor(String code) {
    for (final cell in cells) if (cell.code == code) return cell;
    return null;
  }
}
