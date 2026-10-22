// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import '../localization_meta.dart';
import 'sign_up_localization_de.dart';
import 'sign_up_localization_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SignUpLocalization
/// returned by `SignUpLocalization.of(context)`.
///
/// Applications need to include `SignUpLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'sign_up/sign_up_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SignUpLocalization.localizationsDelegates,
///   supportedLocales: SignUpLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the SignUpLocalization.supportedLocales
/// property.
abstract class SignUpLocalization implements LocalizationBundle {
  SignUpLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SignUpLocalization of(BuildContext context) {
    return Localizations.of<SignUpLocalization>(context, SignUpLocalization)!;
  }

  static const LocalizationsDelegate<SignUpLocalization> delegate =
      _SignUpLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// Button
  ///
  /// In de, this message translates to:
  /// **'Registrieren'**
  String get signUp;

  /// No description provided for @codeSent.
  ///
  /// In de, this message translates to:
  /// **'Code an {phone} gesendet, erneut in {seconds} s'**
  String codeSent(String phone, int seconds);

  /// Metadata of every message of [SignUpLocalization], in sheet order.
  static const List<LocalizationMessage> messages = <LocalizationMessage>[
    LocalizationMessage('signUp', description: 'Button'),
    LocalizationMessage(
      'codeSent',
      placeholders: <LocalizationPlaceholder>[
        LocalizationPlaceholder(
          'phone',
          type: 'String',
          example: '+49 30 1234567',
        ),
        LocalizationPlaceholder('seconds', type: 'int', example: '30'),
      ],
    ),
  ];

  /// The ICU text of every message in this locale, by key.
  @override
  Map<String, String> get templates;

  /// Keys of the messages this locale has no text of its own for
  /// (they use the text of the parent locale or the base language).
  @override
  Set<String> get fallbackKeys;

  /// Renders the message [key] with the named [args] (placeholder
  /// name -> value), like calling its getter or method.
  ///
  /// Throws an [ArgumentError] for an unknown key, a missing argument
  /// or an argument of the wrong type.
  @override
  String format(
    String key, [
    Map<String, Object?> args = const <String, Object?>{},
  ]) =>
      switch (key) {
        'signUp' => signUp,
        'codeSent' => codeSent(
            localizationArgument<String>(args, key, 'phone'),
            localizationArgument<int>(args, key, 'seconds'),
          ),
        _ => throw ArgumentError.value(
            key,
            'key',
            'Not a message of SignUpLocalization',
          ),
      };
}

class _SignUpLocalizationDelegate
    extends LocalizationsDelegate<SignUpLocalization> {
  const _SignUpLocalizationDelegate();

  @override
  Future<SignUpLocalization> load(Locale locale) {
    return SynchronousFuture<SignUpLocalization>(
      lookupSignUpLocalization(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SignUpLocalizationDelegate old) => false;
}

SignUpLocalization lookupSignUpLocalization(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return SignUpLocalizationDe();
    case 'en':
      return SignUpLocalizationEn();
  }

  throw FlutterError(
    'SignUpLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
