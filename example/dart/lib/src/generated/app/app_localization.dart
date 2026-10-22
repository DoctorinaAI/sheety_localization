// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import '../localization_meta.dart';
import 'app_localization_ar.dart';
import 'app_localization_de.dart';
import 'app_localization_en.dart';
import 'app_localization_pt.dart';
import 'app_localization_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalization
/// returned by `AppLocalization.of(context)`.
///
/// Applications need to include `AppLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'app/app_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalization.localizationsDelegates,
///   supportedLocales: AppLocalization.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalization.supportedLocales
/// property.
abstract class AppLocalization implements LocalizationBundle {
  AppLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

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
    Locale('ar'),
    Locale('ar', 'EG'),
    Locale('de'),
    Locale('en'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Sheety Notes'**
  String get title;

  /// Greets the user on the home screen
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String greeting(String name);

  /// Number of notes in the list
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No notes} one{One note} other{{count} notes}}'**
  String notes(int count);

  /// Who shared a note
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{{name} shared his note} female{{name} shared her note} other{{name} shared their note}}'**
  String sharedBy(String gender, String name);

  /// Inline markup is passed through as text
  ///
  /// In en, this message translates to:
  /// **'I accept the <b>terms</b>'**
  String get terms;

  /// Undeclared placeholder: typed Object
  ///
  /// In en, this message translates to:
  /// **'Last synced {time}'**
  String lastSync(Object time);

  /// Metadata of every message of [AppLocalization], in sheet order.
  static const List<LocalizationMessage> messages = <LocalizationMessage>[
    LocalizationMessage('title', description: 'Application title'),
    LocalizationMessage(
      'greeting',
      description: 'Greets the user on the home screen',
      placeholders: <LocalizationPlaceholder>[
        LocalizationPlaceholder(
          'name',
          type: 'String',
          example: 'Alice',
          description: 'First name of the user',
        ),
      ],
    ),
    LocalizationMessage(
      'notes',
      description: 'Number of notes in the list',
      placeholders: <LocalizationPlaceholder>[
        LocalizationPlaceholder('count', type: 'int', example: '3'),
      ],
    ),
    LocalizationMessage(
      'sharedBy',
      description: 'Who shared a note',
      placeholders: <LocalizationPlaceholder>[
        LocalizationPlaceholder('gender', type: 'String', example: 'female'),
        LocalizationPlaceholder('name', type: 'String', example: 'Alice'),
      ],
    ),
    LocalizationMessage(
      'terms',
      description: 'Inline markup is passed through as text',
    ),
    LocalizationMessage(
      'lastSync',
      description: 'Undeclared placeholder: typed Object',
      placeholders: <LocalizationPlaceholder>[
        LocalizationPlaceholder('time', type: 'Object'),
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
        'title' => title,
        'greeting' => greeting(localizationArgument<String>(args, key, 'name')),
        'notes' => notes(localizationArgument<int>(args, key, 'count')),
        'sharedBy' => sharedBy(
            localizationArgument<String>(args, key, 'gender'),
            localizationArgument<String>(args, key, 'name'),
          ),
        'terms' => terms,
        'lastSync' => lastSync(localizationArgument<Object>(args, key, 'time')),
        _ => throw ArgumentError.value(
            key,
            'key',
            'Not a message of AppLocalization',
          ),
      };
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(lookupAppLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'de', 'en', 'pt', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}

AppLocalization lookupAppLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return AppLocalizationArEg();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationAr();
    case 'de':
      return AppLocalizationDe();
    case 'en':
      return AppLocalizationEn();
    case 'pt':
      return AppLocalizationPt();
    case 'ru':
      return AppLocalizationRu();
  }

  throw FlutterError(
    'AppLocalization.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
