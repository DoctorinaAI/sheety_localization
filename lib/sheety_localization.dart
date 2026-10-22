/// Localization pipeline behind the `localize` and `generate` executables.
///
/// The model (`LocalizationClient`) and the spreadsheet (`SheetsGateway`) sit
/// behind interfaces, so the pipeline can be unit-tested without network
/// access.
library;

export 'src/common/sheet_layout.dart';
export 'src/localize/client.dart';
export 'src/localize/google_sheets.dart';
export 'src/localize/language_names.dart';
export 'src/localize/localizer.dart';
export 'src/localize/models.dart';
export 'src/localize/prompt.dart';
export 'src/localize/sheets.dart';
export 'src/localize/utils.dart';
export 'src/localize/validation.dart';
export 'src/generate/cldr/plural_rules.dart';
export 'src/generate/config.dart';
export 'src/generate/diagnostics.dart';
export 'src/generate/emit/dart/dart_emitter.dart';
export 'src/generate/emit/python/python_emitter.dart';
export 'src/generate/emit/ts/ts_emitter.dart';
export 'src/generate/emitter.dart';
export 'src/generate/icu/ast.dart';
export 'src/generate/icu/mustache.dart';
export 'src/generate/icu/parser.dart';
export 'src/generate/manifest.dart';
export 'src/generate/model.dart';
export 'src/generate/naming.dart';
export 'src/generate/pipeline.dart';
export 'src/generate/reader.dart';
export 'src/generate/source.dart';
export 'src/generate/targets.dart';
export 'src/generate/validate.dart';
export 'src/generate/writer.dart';
