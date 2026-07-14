// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'errors_localization_af.dart';
import 'errors_localization_am.dart';
import 'errors_localization_ar.dart';
import 'errors_localization_az.dart';
import 'errors_localization_be.dart';
import 'errors_localization_bg.dart';
import 'errors_localization_bn.dart';
import 'errors_localization_ca.dart';
import 'errors_localization_cs.dart';
import 'errors_localization_da.dart';
import 'errors_localization_de.dart';
import 'errors_localization_el.dart';
import 'errors_localization_en.dart';
import 'errors_localization_es.dart';
import 'errors_localization_fa.dart';
import 'errors_localization_fr.dart';
import 'errors_localization_gu.dart';
import 'errors_localization_he.dart';
import 'errors_localization_hi.dart';
import 'errors_localization_hu.dart';
import 'errors_localization_id.dart';
import 'errors_localization_it.dart';
import 'errors_localization_ja.dart';
import 'errors_localization_kk.dart';
import 'errors_localization_km.dart';
import 'errors_localization_kn.dart';
import 'errors_localization_ko.dart';
import 'errors_localization_lo.dart';
import 'errors_localization_ml.dart';
import 'errors_localization_mr.dart';
import 'errors_localization_ms.dart';
import 'errors_localization_my.dart';
import 'errors_localization_ne.dart';
import 'errors_localization_nl.dart';
import 'errors_localization_pa.dart';
import 'errors_localization_pl.dart';
import 'errors_localization_ps.dart';
import 'errors_localization_pt.dart';
import 'errors_localization_ro.dart';
import 'errors_localization_ru.dart';
import 'errors_localization_si.dart';
import 'errors_localization_sk.dart';
import 'errors_localization_sw.dart';
import 'errors_localization_ta.dart';
import 'errors_localization_te.dart';
import 'errors_localization_th.dart';
import 'errors_localization_tl.dart';
import 'errors_localization_tr.dart';
import 'errors_localization_uk.dart';
import 'errors_localization_ur.dart';
import 'errors_localization_uz.dart';
import 'errors_localization_vi.dart';
import 'errors_localization_zh.dart';
import 'errors_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ErrorsLocalization
/// returned by `ErrorsLocalization.of(context)`.
///
/// Applications need to include `ErrorsLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'errors/errors_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ErrorsLocalization.localizationsDelegates,
///   supportedLocales: ErrorsLocalization.supportedLocales,
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
/// be consistent with the languages listed in the ErrorsLocalization.supportedLocales
/// property.
abstract class ErrorsLocalization {
  ErrorsLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ErrorsLocalization of(BuildContext context) {
    return Localizations.of<ErrorsLocalization>(context, ErrorsLocalization)!;
  }

  static const LocalizationsDelegate<ErrorsLocalization> delegate =
      _ErrorsLocalizationDelegate();

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
    Locale('af'),
    Locale('am'),
    Locale('ar'),
    Locale('ar', 'EG'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kk'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('lo'),
    Locale('ml'),
    Locale('mr'),
    Locale('ms'),
    Locale('my'),
    Locale('ne'),
    Locale('nl'),
    Locale('pa'),
    Locale('pa', 'PK'),
    Locale('pl'),
    Locale('ps'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zu')
  ];

  /// Ошибка
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get error;

  /// Произошла какая то ошибка
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// Сообщение об успешной отправке баг репорта
  ///
  /// In en, this message translates to:
  /// **'Bug report sent successfully.'**
  String get bugReportSentText;
}

class _ErrorsLocalizationDelegate
    extends LocalizationsDelegate<ErrorsLocalization> {
  const _ErrorsLocalizationDelegate();

  @override
  Future<ErrorsLocalization> load(Locale locale) {
    return SynchronousFuture<ErrorsLocalization>(
        lookupErrorsLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'am',
        'ar',
        'az',
        'be',
        'bg',
        'bn',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'fa',
        'fr',
        'gu',
        'he',
        'hi',
        'hu',
        'id',
        'it',
        'ja',
        'kk',
        'km',
        'kn',
        'ko',
        'lo',
        'ml',
        'mr',
        'ms',
        'my',
        'ne',
        'nl',
        'pa',
        'pl',
        'ps',
        'pt',
        'ro',
        'ru',
        'si',
        'sk',
        'sw',
        'ta',
        'te',
        'th',
        'tl',
        'tr',
        'uk',
        'ur',
        'uz',
        'vi',
        'zh',
        'zu'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_ErrorsLocalizationDelegate old) => false;
}

ErrorsLocalization lookupErrorsLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return ErrorsLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return ErrorsLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return ErrorsLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return ErrorsLocalizationZhCn();
          case 'HK':
            return ErrorsLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return ErrorsLocalizationAf();
    case 'am':
      return ErrorsLocalizationAm();
    case 'ar':
      return ErrorsLocalizationAr();
    case 'az':
      return ErrorsLocalizationAz();
    case 'be':
      return ErrorsLocalizationBe();
    case 'bg':
      return ErrorsLocalizationBg();
    case 'bn':
      return ErrorsLocalizationBn();
    case 'ca':
      return ErrorsLocalizationCa();
    case 'cs':
      return ErrorsLocalizationCs();
    case 'da':
      return ErrorsLocalizationDa();
    case 'de':
      return ErrorsLocalizationDe();
    case 'el':
      return ErrorsLocalizationEl();
    case 'en':
      return ErrorsLocalizationEn();
    case 'es':
      return ErrorsLocalizationEs();
    case 'fa':
      return ErrorsLocalizationFa();
    case 'fr':
      return ErrorsLocalizationFr();
    case 'gu':
      return ErrorsLocalizationGu();
    case 'he':
      return ErrorsLocalizationHe();
    case 'hi':
      return ErrorsLocalizationHi();
    case 'hu':
      return ErrorsLocalizationHu();
    case 'id':
      return ErrorsLocalizationId();
    case 'it':
      return ErrorsLocalizationIt();
    case 'ja':
      return ErrorsLocalizationJa();
    case 'kk':
      return ErrorsLocalizationKk();
    case 'km':
      return ErrorsLocalizationKm();
    case 'kn':
      return ErrorsLocalizationKn();
    case 'ko':
      return ErrorsLocalizationKo();
    case 'lo':
      return ErrorsLocalizationLo();
    case 'ml':
      return ErrorsLocalizationMl();
    case 'mr':
      return ErrorsLocalizationMr();
    case 'ms':
      return ErrorsLocalizationMs();
    case 'my':
      return ErrorsLocalizationMy();
    case 'ne':
      return ErrorsLocalizationNe();
    case 'nl':
      return ErrorsLocalizationNl();
    case 'pa':
      return ErrorsLocalizationPa();
    case 'pl':
      return ErrorsLocalizationPl();
    case 'ps':
      return ErrorsLocalizationPs();
    case 'pt':
      return ErrorsLocalizationPt();
    case 'ro':
      return ErrorsLocalizationRo();
    case 'ru':
      return ErrorsLocalizationRu();
    case 'si':
      return ErrorsLocalizationSi();
    case 'sk':
      return ErrorsLocalizationSk();
    case 'sw':
      return ErrorsLocalizationSw();
    case 'ta':
      return ErrorsLocalizationTa();
    case 'te':
      return ErrorsLocalizationTe();
    case 'th':
      return ErrorsLocalizationTh();
    case 'tl':
      return ErrorsLocalizationTl();
    case 'tr':
      return ErrorsLocalizationTr();
    case 'uk':
      return ErrorsLocalizationUk();
    case 'ur':
      return ErrorsLocalizationUr();
    case 'uz':
      return ErrorsLocalizationUz();
    case 'vi':
      return ErrorsLocalizationVi();
    case 'zh':
      return ErrorsLocalizationZh();
    case 'zu':
      return ErrorsLocalizationZu();
  }

  throw FlutterError(
      'ErrorsLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
