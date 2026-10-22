// This file is generated, do not edit it manually!
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';

import 'app/app_localization.dart';
import 'sign_up/sign_up_localization.dart';

/// A placeholder of a [LocalizationMessage].
final class LocalizationPlaceholder {
  /// Creates the metadata of a placeholder.
  const LocalizationPlaceholder(
    this.name, {
    required this.type,
    this.example,
    this.description,
  });

  /// Name of the placeholder: the parameter name of the generated method
  /// and the key of the argument in [LocalizationBundle.format].
  final String name;

  /// Dart type of the argument: `String`, `int`, `num`, `double` or
  /// `Object`.
  final String type;

  /// Example value from the sheet, if any.
  final String? example;

  /// Description from the sheet, if any.
  final String? description;

  /// A value of [type] for tests: [example] parsed as a number for numeric
  /// types (`1` when it is missing or not a number), otherwise [example] or,
  /// without one, [name].
  Object get exampleValue => switch (type) {
        'int' => int.tryParse(example ?? '') ?? 1,
        'double' => double.tryParse(example ?? '') ?? 1.0,
        'num' => num.tryParse(example ?? '') ?? 1,
        _ => example ?? name,
      };
}

/// A message of a scope: what a test needs to render it.
final class LocalizationMessage {
  /// Creates the metadata of a message.
  const LocalizationMessage(
    this.key, {
    this.description,
    this.placeholders = const <LocalizationPlaceholder>[],
  });

  /// Key of the message: the name of its getter or method.
  final String key;

  /// Description from the sheet, if any.
  final String? description;

  /// Placeholders in parameter order; empty for a getter.
  final List<LocalizationPlaceholder> placeholders;

  /// Whether the message is a getter (it has no placeholders).
  bool get isGetter => placeholders.isEmpty;

  /// Arguments for [LocalizationBundle.format] made of the
  /// [LocalizationPlaceholder.exampleValue]s.
  Map<String, Object> get exampleArguments => <String, Object>{
        for (final placeholder in placeholders)
          placeholder.name: placeholder.exampleValue,
      };
}

/// What every generated localization class offers besides its messages.
abstract interface class LocalizationBundle {
  /// The canonicalized locale of this instance (`pt_BR`).
  String get localeName;

  /// The ICU text of every message in this locale, by key.
  Map<String, String> get templates;

  /// Keys of the messages this locale has no text of its own for.
  Set<String> get fallbackKeys;

  /// Renders the message [key] with the named [args].
  String format(String key, [Map<String, Object?> args]);
}

/// A generated scope (one sheet): its messages, locales and lookup.
final class LocalizationScope {
  /// Creates the metadata of a scope.
  const LocalizationScope({
    required this.name,
    required this.baseLocale,
    required this.supportedLocales,
    required this.messages,
    required this.delegate,
    required this.lookup,
  });

  /// Name of the scope (the sanitized sheet title, `sign_up`).
  final String name;

  /// The base language of the sheet.
  final Locale baseLocale;

  /// The supported locales, as in the generated class.
  final List<Locale> supportedLocales;

  /// Every message, in sheet order.
  final List<LocalizationMessage> messages;

  /// The localizations delegate of the scope.
  final LocalizationsDelegate<LocalizationBundle> delegate;

  /// Returns the localization of a supported locale (the generated
  /// `lookup...` function).
  final LocalizationBundle Function(Locale locale) lookup;
}

/// The argument [name] of message [key] from [args], checked to be a [T].
///
/// Throws an [ArgumentError] when it is missing or of another type.
T localizationArgument<T extends Object>(
  Map<String, Object?> args,
  String key,
  String name,
) {
  final value = args[name];
  if (value is T) return value;
  throw ArgumentError.value(
    value,
    name,
    args.containsKey(name)
        ? 'Argument "$name" of message "$key" must be a $T'
        : 'Missing argument "$name" of message "$key"',
  );
}

/// Every generated scope, in sheet order.
const List<LocalizationScope> localizationScopes = <LocalizationScope>[
  LocalizationScope(
    name: 'app',
    baseLocale: Locale('en'),
    supportedLocales: AppLocalization.supportedLocales,
    messages: AppLocalization.messages,
    delegate: AppLocalization.delegate,
    lookup: lookupAppLocalization,
  ),
  LocalizationScope(
    name: 'sign_up',
    baseLocale: Locale('de'),
    supportedLocales: SignUpLocalization.supportedLocales,
    messages: SignUpLocalization.messages,
    delegate: SignUpLocalization.delegate,
    lookup: lookupSignUpLocalization,
  ),
];
