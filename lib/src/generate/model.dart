/// In-memory model of the localization sheets: the input of every emitter.
///
/// Everything is immutable and ordered the way the sheet is: scopes in sheet
/// order, locales in header order, messages in row order.
library;

import 'dart:convert';

import 'icu/ast.dart';
import 'icu/mustache.dart';

/// Type of a placeholder, as declared in the ARB-style meta JSON.
enum PlaceholderType {
  /// `String`
  string('String'),

  /// `int`
  int('int'),

  /// `num`
  num('num'),

  /// `double`
  double('double'),

  /// `Object` — the type of placeholders without a declared type, rendered
  /// with `toString()`.
  object('Object');

  const PlaceholderType(this.arbName);

  /// Name used in the meta JSON and by gen-l10n (`String`, `int`, ...).
  final String arbName;

  /// Whether values of this type are numbers.
  bool get isNumeric => this == int || this == num || this == double;

  /// Parses an ARB type name; `null` when it is not supported.
  static PlaceholderType? fromArb(String name) {
    for (final type in values) if (type.arbName == name) return type;
    return null;
  }
}

/// A placeholder of a message.
final class Placeholder {
  /// Creates a placeholder.
  const Placeholder({
    required this.name,
    required this.type,
    this.example,
    this.description,
    this.declared = true,
    this.isPluralCount = false,
    this.isSelectChoice = false,
  });

  /// Name, as used in `{name}`.
  final String name;

  /// Type after gen-l10n's inference: declared type, else `num` for a plural
  /// count, `String` for a select choice, `Object` otherwise.
  final PlaceholderType type;

  /// Example value from the meta JSON.
  final String? example;

  /// Description from the meta JSON.
  final String? description;

  /// Whether the placeholder is declared in the meta JSON (otherwise it was
  /// inferred from the message text).
  final bool declared;

  /// Whether some translation uses it as a plural count.
  final bool isPluralCount;

  /// Whether some translation uses it as a select choice.
  final bool isSelectChoice;

  /// Canonical JSON form.
  Map<String, Object?> toJson() => {
        'name': name,
        'type': type.arbName,
        if (example != null) 'example': example,
        if (description != null) 'description': description,
        'declared': declared,
        if (isPluralCount) 'plural': true,
        if (isSelectChoice) 'select': true,
      };

  @override
  String toString() => '${type.arbName} $name';
}

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

/// A locale of a scope and where its texts come from.
final class ScopeLocale {
  /// Creates a scope locale.
  const ScopeLocale(
    this.tag, {
    this.column,
    this.syntheticFrom,
  });

  /// The locale.
  final LocaleTag tag;

  /// Column letter of the locale in the sheet; `null` for a synthetic
  /// locale.
  final String? column;

  /// For a synthetic parent locale (`pt`, which has no column), the
  /// regional locale its texts are copied from (`pt_BR`).
  final LocaleTag? syntheticFrom;

  /// Whether the locale has no column of its own.
  bool get isSynthetic => syntheticFrom != null;

  /// Canonical JSON form.
  Map<String, Object?> toJson() => {
        'code': tag.code,
        if (syntheticFrom != null) 'syntheticFrom': syntheticFrom!.code,
      };

  @override
  String toString() => isSynthetic ? '$tag<-$syntheticFrom' : '$tag';
}

/// The text of a message in one locale.
final class Translation {
  /// Creates a translation.
  const Translation({
    required this.locale,
    required this.source,
    required this.raw,
    required this.ast,
    this.isFallback = false,
    this.row,
    this.column,
  });

  /// The locale this translation is used for.
  final LocaleTag locale;

  /// The locale (column) the text was taken from. Equal to [locale] for an
  /// ordinary cell; differs for synthetic locales (`pt` from `pt_BR`), for
  /// parents overridden by a regional column (legacy behaviour, `ar` from
  /// `ar_EG`) and for fallbacks.
  final LocaleTag source;

  /// The ICU source text, exactly as in the cell.
  final String raw;

  /// The parsed text.
  final IcuMessage ast;

  /// Whether the locale has no text of its own and this one was taken from
  /// the parent locale or the base language.
  final bool isFallback;

  /// 1-based sheet row of the cell the text comes from.
  final int? row;

  /// Column letter of the cell the text comes from.
  final String? column;

  /// For a fallback, the locale the text was taken from.
  LocaleTag? get fallbackFrom => isFallback ? source : null;

  /// Copy used for [locale] as a fallback.
  Translation asFallbackFor(LocaleTag locale) => Translation(
        locale: locale,
        source: source,
        raw: raw,
        ast: ast,
        isFallback: true,
        row: row,
        column: column,
      );

  /// Canonical JSON form.
  Map<String, Object?> toJson() => {
        'raw': raw,
        if (source != locale) 'source': source.code,
        if (isFallback) 'fallback': true,
      };

  @override
  String toString() =>
      '$locale${isFallback ? ' (fallback from $source)' : ''}: $raw';
}

/// One row of a sheet: a key with its texts in every locale.
final class Message {
  /// Creates a message.
  Message({
    required this.key,
    required this.baseLocale,
    required List<Placeholder> placeholders,
    required Map<LocaleTag, Translation> translations,
    this.description,
    this.row,
  })  : placeholders = List.unmodifiable(placeholders),
        translations = Map.unmodifiable(translations) {
    if (!translations.containsKey(baseLocale)) {
      throw ArgumentError.value(
        translations.keys.toList(),
        'translations',
        'Must contain the base locale $baseLocale',
      );
    }
  }

  /// Sanitized label, e.g. `drawerTooltipClose`.
  final String key;

  /// The scope's base language.
  final LocaleTag baseLocale;

  /// Description (meta JSON `description`, else the description column).
  final String? description;

  /// Placeholders: the declared ones in meta order, then the inferred
  /// (undeclared) ones sorted by name — gen-l10n's order, which is also the
  /// parameter order of the generated methods.
  final List<Placeholder> placeholders;

  /// Texts that exist in the sheet (directly, through a synthetic parent or
  /// the legacy regional override), in scope locale order. Fallbacks are not
  /// stored; use [translationFor].
  final Map<LocaleTag, Translation> translations;

  /// 1-based sheet row.
  final int? row;

  /// The base-language translation.
  Translation get base => translations[baseLocale]!;

  /// Whether the message has placeholders (a method, not a getter, in Dart).
  bool get hasPlaceholders => placeholders.isNotEmpty;

  /// The placeholder called [name], if any.
  Placeholder? placeholder(String name) {
    for (final p in placeholders) if (p.name == name) return p;
    return null;
  }

  /// The text used for [locale], following gen-l10n's fallback chain:
  /// the locale itself, then its language-only parent (`pt_BR` -> `pt`),
  /// then the base language. A text taken from elsewhere is marked
  /// [Translation.isFallback].
  Translation translationFor(LocaleTag locale) {
    final own = translations[locale];
    if (own != null) return own;
    final parent = locale.parent;
    if (parent != null) {
      final inherited = translations[parent];
      if (inherited != null) return inherited.asFallbackFor(locale);
    }
    return base.asFallbackFor(locale);
  }

  /// Canonical JSON form.
  Map<String, Object?> toJson() => {
        'key': key,
        if (description != null) 'description': description,
        'placeholders': [for (final p in placeholders) p.toJson()],
        'translations': {
          for (final MapEntry(:key, :value) in translations.entries)
            key.code: value.toJson(),
        },
      };

  @override
  String toString() => 'Message($key)';
}

/// One localization sheet: a class / module / package per target.
final class Scope {
  /// Creates a scope.
  Scope({
    required this.name,
    required this.sheetTitle,
    required this.baseLocale,
    required List<ScopeLocale> locales,
    required List<Message> messages,
    this.syntax = MessageSyntax.icu,
  })  : locales = List.unmodifiable(locales),
        messages = List.unmodifiable(messages);

  /// Sanitized sheet title (`sign_up` for `sign-up`).
  final String name;

  /// Original sheet title.
  final String sheetTitle;

  /// Syntax every text of the scope was parsed with. Raw texts
  /// ([Translation.raw]) keep the original string in either syntax.
  final MessageSyntax syntax;

  /// Base language: the fourth column of the header.
  final LocaleTag baseLocale;

  /// Locales: header order, then synthetic parents in the order their first
  /// regional column appears (the previous generator's order).
  final List<ScopeLocale> locales;

  /// Messages in row order.
  final List<Message> messages;

  /// The locale tags, in [locales] order.
  List<LocaleTag> get localeTags => [for (final l in locales) l.tag];

  /// Locales without a column of their own, keyed by tag, with the regional
  /// locale they are filled from.
  Map<LocaleTag, LocaleTag> get syntheticLocales => {
        for (final l in locales)
          if (l.syntheticFrom != null) l.tag: l.syntheticFrom!,
      };

  /// The [ScopeLocale] of [tag], if the scope has it.
  ScopeLocale? locale(LocaleTag tag) {
    for (final l in locales) if (l.tag == tag) return l;
    return null;
  }

  /// The message with [key], if any.
  Message? message(String key) {
    for (final m in messages) if (m.key == key) return m;
    return null;
  }

  /// Locale tags sorted by code (gen-l10n's `supportedLocales` order).
  List<LocaleTag> get sortedLocaleTags => localeTags..sort();

  /// Number of messages of [locale] that use a fallback text.
  int fallbackCount(LocaleTag locale) =>
      messages.where((m) => m.translationFor(locale).isFallback).length;

  /// Canonical JSON form.
  Map<String, Object?> toJson() => {
        'name': name,
        'sheetTitle': sheetTitle,
        'baseLocale': baseLocale.code,
        if (syntax != MessageSyntax.icu) 'syntax': syntax.name,
        'locales': [for (final l in locales) l.toJson()],
        'messages': [for (final m in messages) m.toJson()],
      };

  @override
  String toString() => 'Scope($name, ${messages.length} messages, '
      '${locales.length} locales)';
}

/// Everything read from the spreadsheet.
final class Catalog {
  /// Creates a catalog.
  Catalog(List<Scope> scopes) : scopes = List.unmodifiable(scopes);

  /// Scopes in sheet order.
  final List<Scope> scopes;

  /// The scope called [name], if any.
  Scope? scope(String name) {
    for (final s in scopes) if (s.name == name) return s;
    return null;
  }

  /// Union of every scope's locales, in order of first appearance.
  List<LocaleTag> get locales => {
        for (final scope in scopes) ...scope.localeTags,
      }.toList();

  /// The base locale shared by every scope, or `null` when scopes disagree
  /// (or there are none).
  LocaleTag? get baseLocale {
    final bases = {for (final s in scopes) s.baseLocale};
    return bases.length == 1 ? bases.single : null;
  }

  /// A catalog with only the scopes [test] accepts (per-target selection).
  Catalog where(bool Function(Scope scope) test) =>
      Catalog(scopes.where(test).toList());

  /// Canonical JSON form: stable key order, no sheet positions, suitable for
  /// hashing.
  Map<String, Object?> toJson() => {
        'scopes': [for (final s in scopes) s.toJson()],
      };

  /// [toJson] encoded without whitespace: identical catalogs produce
  /// byte-identical strings.
  String toCanonicalJson() => jsonEncode(toJson());

  @override
  String toString() => 'Catalog(${scopes.map((s) => s.name).join(', ')})';
}
