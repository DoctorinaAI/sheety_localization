// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localization_af.dart';
import 'app_localization_am.dart';
import 'app_localization_ar.dart';
import 'app_localization_az.dart';
import 'app_localization_be.dart';
import 'app_localization_bg.dart';
import 'app_localization_bn.dart';
import 'app_localization_ca.dart';
import 'app_localization_cs.dart';
import 'app_localization_da.dart';
import 'app_localization_de.dart';
import 'app_localization_el.dart';
import 'app_localization_en.dart';
import 'app_localization_es.dart';
import 'app_localization_fa.dart';
import 'app_localization_fr.dart';
import 'app_localization_gu.dart';
import 'app_localization_he.dart';
import 'app_localization_hi.dart';
import 'app_localization_hu.dart';
import 'app_localization_id.dart';
import 'app_localization_it.dart';
import 'app_localization_ja.dart';
import 'app_localization_kk.dart';
import 'app_localization_km.dart';
import 'app_localization_kn.dart';
import 'app_localization_ko.dart';
import 'app_localization_lo.dart';
import 'app_localization_ml.dart';
import 'app_localization_mr.dart';
import 'app_localization_ms.dart';
import 'app_localization_my.dart';
import 'app_localization_ne.dart';
import 'app_localization_nl.dart';
import 'app_localization_pa.dart';
import 'app_localization_pl.dart';
import 'app_localization_ps.dart';
import 'app_localization_pt.dart';
import 'app_localization_ro.dart';
import 'app_localization_ru.dart';
import 'app_localization_si.dart';
import 'app_localization_sk.dart';
import 'app_localization_sw.dart';
import 'app_localization_ta.dart';
import 'app_localization_te.dart';
import 'app_localization_th.dart';
import 'app_localization_tl.dart';
import 'app_localization_tr.dart';
import 'app_localization_uk.dart';
import 'app_localization_ur.dart';
import 'app_localization_uz.dart';
import 'app_localization_vi.dart';
import 'app_localization_zh.dart';
import 'app_localization_zu.dart';

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
abstract class AppLocalization {
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

  /// No description provided for @lang.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get lang;

  /// No description provided for @langEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langEn;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Doctorina'**
  String get title;

  /// Кнопка обновиться
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get checkVersionUpdateNowButton;

  /// Кнопка отложить обновление
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get checkVersionMaybeLaterButton;

  /// Заголовок можешь обновиться
  ///
  /// In en, this message translates to:
  /// **'New update available'**
  String get checkVersionUpdateOptionalTitle;

  /// Заголовок обязан обновиться
  ///
  /// In en, this message translates to:
  /// **'Update Required'**
  String get checkVersionUpdateRequiredTitle;

  /// Сообщение о доступности новой версии
  /// приложения с приглашением обновиться
  ///
  /// In en, this message translates to:
  /// **'A new version (v{version}) of the app is available. Please update to continue for the best experience.'**
  String checkVersionUpdateOptionalText(String version);

  /// Сообщение с требованием обновиться
  ///
  /// In en, this message translates to:
  /// **'To continue, please update the app. This update includes important fixes and improvements.'**
  String get checkVersionUpdateRequiredText;

  /// Menu item for downloading attachment
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get chatContextMenuDownload;

  /// Body text prompting to log in or sign up
  ///
  /// In en, this message translates to:
  /// **'Log in if you already have a Doctorina account, or sign up to get started.'**
  String get welcomeBackDialogText;

  /// Primary button to open log in
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get welcomeBackDialogLogInButton;

  /// Secondary button to open sign up
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get welcomeBackDialogSignUpButton;

  /// Link to continue as guest
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get welcomeBackDialogContinueAsGuestButton;

  /// No description provided for @titleLogin.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get titleLogin;

  /// No description provided for @titleLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get titleLogout;

  /// Заголовок экрана
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get titleSignIn;

  /// No description provided for @titleDialog.
  ///
  /// In en, this message translates to:
  /// **'Dialog'**
  String get titleDialog;

  /// No description provided for @titleChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get titleChat;

  /// Заголовок экрана
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get titleSettings;

  /// История чатов, имеется ввиду список чатов пользователя
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get titleChatHistory;

  /// Заголовок экрана
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get titlePayment;

  /// No description provided for @titleManageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get titleManageSubscription;

  /// No description provided for @titleMonthlySubscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscription'**
  String get titleMonthlySubscription;

  /// Заголовок экрана
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get titleOnboarding;

  /// Title of the welcome-back dialog shown when the user had an account before
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get titleWelcomeBack;

  /// No description provided for @titleProfiles.
  ///
  /// In en, this message translates to:
  /// **'Health records profiles'**
  String get titleProfiles;

  /// No description provided for @titleProfilesAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Profiles announcement'**
  String get titleProfilesAnnouncement;

  /// Title for dashboard screen
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get titleDashboardProfile;

  /// Title for screen with full health records data
  ///
  /// In en, this message translates to:
  /// **'Full record'**
  String get titleFullRecord;

  /// No description provided for @titleDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get titleDocuments;

  /// No description provided for @titleConsultations.
  ///
  /// In en, this message translates to:
  /// **'Consultations'**
  String get titleConsultations;

  /// No description provided for @titleAppLaunchPaywall.
  ///
  /// In en, this message translates to:
  /// **'Paywall'**
  String get titleAppLaunchPaywall;

  /// Быстрое действие на иконке приложения для обратной связи перед удалением аккаунта
  ///
  /// In en, this message translates to:
  /// **'Deleting? Tell us why!'**
  String get quickActionDeleteFeedback;

  /// Подзаголовок быстрого действия для создания нового чата
  ///
  /// In en, this message translates to:
  /// **'Start a new health conversation'**
  String get quickActionNewChatSubtitle;

  /// Подзаголовок быстрого действия для отправки обратной связи
  ///
  /// In en, this message translates to:
  /// **'Share an idea or report a problem'**
  String get quickActionFeedbackSubtitle;

  /// Подзаголовок быстрого действия для обратной связи перед удалением приложения
  ///
  /// In en, this message translates to:
  /// **'Tell us how Doctorina can improve'**
  String get quickActionDeleteFeedbackSubtitle;
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(lookupAppLocalization(locale));
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
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return AppLocalizationPaPk();
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
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationZhCn();
          case 'HK':
            return AppLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationAf();
    case 'am':
      return AppLocalizationAm();
    case 'ar':
      return AppLocalizationAr();
    case 'az':
      return AppLocalizationAz();
    case 'be':
      return AppLocalizationBe();
    case 'bg':
      return AppLocalizationBg();
    case 'bn':
      return AppLocalizationBn();
    case 'ca':
      return AppLocalizationCa();
    case 'cs':
      return AppLocalizationCs();
    case 'da':
      return AppLocalizationDa();
    case 'de':
      return AppLocalizationDe();
    case 'el':
      return AppLocalizationEl();
    case 'en':
      return AppLocalizationEn();
    case 'es':
      return AppLocalizationEs();
    case 'fa':
      return AppLocalizationFa();
    case 'fr':
      return AppLocalizationFr();
    case 'gu':
      return AppLocalizationGu();
    case 'he':
      return AppLocalizationHe();
    case 'hi':
      return AppLocalizationHi();
    case 'hu':
      return AppLocalizationHu();
    case 'id':
      return AppLocalizationId();
    case 'it':
      return AppLocalizationIt();
    case 'ja':
      return AppLocalizationJa();
    case 'kk':
      return AppLocalizationKk();
    case 'km':
      return AppLocalizationKm();
    case 'kn':
      return AppLocalizationKn();
    case 'ko':
      return AppLocalizationKo();
    case 'lo':
      return AppLocalizationLo();
    case 'ml':
      return AppLocalizationMl();
    case 'mr':
      return AppLocalizationMr();
    case 'ms':
      return AppLocalizationMs();
    case 'my':
      return AppLocalizationMy();
    case 'ne':
      return AppLocalizationNe();
    case 'nl':
      return AppLocalizationNl();
    case 'pa':
      return AppLocalizationPa();
    case 'pl':
      return AppLocalizationPl();
    case 'ps':
      return AppLocalizationPs();
    case 'pt':
      return AppLocalizationPt();
    case 'ro':
      return AppLocalizationRo();
    case 'ru':
      return AppLocalizationRu();
    case 'si':
      return AppLocalizationSi();
    case 'sk':
      return AppLocalizationSk();
    case 'sw':
      return AppLocalizationSw();
    case 'ta':
      return AppLocalizationTa();
    case 'te':
      return AppLocalizationTe();
    case 'th':
      return AppLocalizationTh();
    case 'tl':
      return AppLocalizationTl();
    case 'tr':
      return AppLocalizationTr();
    case 'uk':
      return AppLocalizationUk();
    case 'ur':
      return AppLocalizationUr();
    case 'uz':
      return AppLocalizationUz();
    case 'vi':
      return AppLocalizationVi();
    case 'zh':
      return AppLocalizationZh();
    case 'zu':
      return AppLocalizationZu();
  }

  throw FlutterError(
      'AppLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
