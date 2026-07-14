/// Localization pipeline used by the `localize` executable.
///
/// Everything here is pure Dart with no Google Sheets dependency, so it can be
/// unit-tested without network access.
library;

export 'src/localize/client.dart';
export 'src/localize/google_sheets.dart';
export 'src/localize/language_names.dart';
export 'src/localize/localizer.dart';
export 'src/localize/models.dart';
export 'src/localize/prompt.dart';
export 'src/localize/sheets.dart';
export 'src/localize/utils.dart';
export 'src/localize/validation.dart';
