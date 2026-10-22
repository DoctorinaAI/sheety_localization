/// Locale codes as written in a sheet header (`pt_BR`, `zh-Hant-TW`).
///
/// Shared by `localize` and `generate`, so both read the same header cells
/// as the same locales.
library;

/// A locale: language with optional script and country, e.g. `pt_BR`,
/// `zh_Hant`, `zh_Hant_TW`, `es_419`.
final class LocaleTag implements Comparable<LocaleTag> {
  /// Creates a tag from already-normalized components.
  const LocaleTag(this.language, {this.script, this.country});

  /// Parses `en`, `pt_BR`, `pt-BR`, `pt-br`, `zh_Hant`, `zh-Hant-TW`,
  /// `es_419`; returns `null` for anything else.
  ///
  /// Components are normalized: language lower case, script title case,
  /// country upper case.
  static LocaleTag? tryParse(String input) {
    final parts = input.trim().split(RegExp('[-_]'));
    if (parts.isEmpty || parts.length > 3) return null;
    final language = parts.first.toLowerCase();
    if (!_language.hasMatch(language)) return null;
    String? script;
    String? country;
    for (final part in parts.skip(1)) {
      if (script == null && country == null && _script.hasMatch(part)) {
        script = part[0].toUpperCase() + part.substring(1).toLowerCase();
      } else if (country == null && _country.hasMatch(part)) {
        country = part.toUpperCase();
      } else {
        return null;
      }
    }
    return LocaleTag(language, script: script, country: country);
  }

  /// Like [tryParse], but throws a [FormatException].
  factory LocaleTag.parse(String input) =>
      tryParse(input) ?? (throw FormatException('Invalid locale', input));

  static final RegExp _language = RegExp(r'^[a-z]{2,3}$');
  static final RegExp _script = RegExp(r'^[A-Za-z]{4}$');
  static final RegExp _country = RegExp(r'^(?:[A-Za-z]{2}|[0-9]{3})$');

  /// ISO 639 language code, lower case (`pt`).
  final String language;

  /// ISO 15924 script code, title case (`Hant`), if any.
  final String? script;

  /// ISO 3166 country or UN M.49 region code, upper case (`BR`), if any.
  final String? country;

  /// `_` separated code, as used in file names and by gen-l10n: `pt_BR`.
  String get code => _parts.join('_');

  /// BCP 47 tag: `pt-BR`.
  String get bcp47 => _parts.join('-');

  List<String> get _parts => [
        language,
        if (script != null) script!,
        if (country != null) country!,
      ];

  /// Whether this is a bare language (`pt`).
  bool get isLanguageOnly => script == null && country == null;

  /// The language-only parent (`pt` for `pt_BR` and `zh_Hant_TW`), or
  /// `null` for a bare language. This is gen-l10n's notion of a parent: its
  /// subclasses always extend the bare-language class.
  LocaleTag? get parent => isLanguageOnly ? null : LocaleTag(language);

  /// Class-name suffix exactly as gen-l10n's `LocaleInfo.camelCase()`
  /// derives it: every `_` separated part capitalized, the rest lower case
  /// (`pt_BR` -> `PtBr`, `zh_Hant_TW` -> `ZhHantTw`, `es_419` -> `Es419`).
  String get camelCase => code
      .split('_')
      .map(
          (p) => p.substring(0, 1).toUpperCase() + p.substring(1).toLowerCase())
      .join();

  @override
  int compareTo(LocaleTag other) => code.compareTo(other.code);

  @override
  bool operator ==(Object other) => other is LocaleTag && other.code == code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => code;
}
