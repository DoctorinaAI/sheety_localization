// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'settings_localization_af.dart';
import 'settings_localization_am.dart';
import 'settings_localization_ar.dart';
import 'settings_localization_az.dart';
import 'settings_localization_be.dart';
import 'settings_localization_bg.dart';
import 'settings_localization_bn.dart';
import 'settings_localization_ca.dart';
import 'settings_localization_cs.dart';
import 'settings_localization_da.dart';
import 'settings_localization_de.dart';
import 'settings_localization_el.dart';
import 'settings_localization_en.dart';
import 'settings_localization_es.dart';
import 'settings_localization_fa.dart';
import 'settings_localization_fr.dart';
import 'settings_localization_gu.dart';
import 'settings_localization_he.dart';
import 'settings_localization_hi.dart';
import 'settings_localization_hu.dart';
import 'settings_localization_id.dart';
import 'settings_localization_it.dart';
import 'settings_localization_ja.dart';
import 'settings_localization_kk.dart';
import 'settings_localization_km.dart';
import 'settings_localization_kn.dart';
import 'settings_localization_ko.dart';
import 'settings_localization_lo.dart';
import 'settings_localization_ml.dart';
import 'settings_localization_mr.dart';
import 'settings_localization_ms.dart';
import 'settings_localization_my.dart';
import 'settings_localization_ne.dart';
import 'settings_localization_nl.dart';
import 'settings_localization_pa.dart';
import 'settings_localization_pl.dart';
import 'settings_localization_ps.dart';
import 'settings_localization_pt.dart';
import 'settings_localization_ro.dart';
import 'settings_localization_ru.dart';
import 'settings_localization_si.dart';
import 'settings_localization_sk.dart';
import 'settings_localization_sw.dart';
import 'settings_localization_ta.dart';
import 'settings_localization_te.dart';
import 'settings_localization_th.dart';
import 'settings_localization_tl.dart';
import 'settings_localization_tr.dart';
import 'settings_localization_uk.dart';
import 'settings_localization_ur.dart';
import 'settings_localization_uz.dart';
import 'settings_localization_vi.dart';
import 'settings_localization_zh.dart';
import 'settings_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SettingsLocalization
/// returned by `SettingsLocalization.of(context)`.
///
/// Applications need to include `SettingsLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'settings/settings_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SettingsLocalization.localizationsDelegates,
///   supportedLocales: SettingsLocalization.supportedLocales,
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
/// be consistent with the languages listed in the SettingsLocalization.supportedLocales
/// property.
abstract class SettingsLocalization {
  SettingsLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SettingsLocalization of(BuildContext context) {
    return Localizations.of<SettingsLocalization>(
        context, SettingsLocalization)!;
  }

  static const LocalizationsDelegate<SettingsLocalization> delegate =
      _SettingsLocalizationDelegate();

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

  /// Заголовок карточки
  ///
  /// In en, this message translates to:
  /// **'Clear All Chats'**
  String get sectionClearAllChatsTitle;

  /// Подзаголовок карточки
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your chat history.'**
  String get sectionClearAllChatsSubtitle;

  /// Надпись на кнопке
  ///
  /// In en, this message translates to:
  /// **'Clear All Chats'**
  String get sectionClearAllChatsButton;

  /// Тема e-mail письма
  ///
  /// In en, this message translates to:
  /// **'Clear All Chats'**
  String get sectionClearAllChatsEmailTheme;

  /// Заголовок карточки
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get sectionDeleteAccountTitle;

  /// Подзаголовок карточки
  ///
  /// In en, this message translates to:
  /// **'Deleting your account is a permanent action and cannot be undone.'**
  String get sectionDeleteAccountSubtitle;

  /// Надпись на кнопке
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get sectionDeleteAccountButton;

  /// Тема e-mail письма
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get sectionDeleteAccountTheme;

  /// Заголовок карточки
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sectionLogOutTitle;

  /// Подзаголовок карточки
  ///
  /// In en, this message translates to:
  /// **'You will be signed out of your account.'**
  String get sectionLogOutSubtitle;

  /// Надпись на кнопке
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get sectionLogOutButton;

  /// No description provided for @sendBugReportButton.
  ///
  /// In en, this message translates to:
  /// **'Send Bug Report'**
  String get sendBugReportButton;

  /// Отправить сообщение с [⏎ Enter]
  ///
  /// In en, this message translates to:
  /// **'Send message with [⏎ Enter]'**
  String get sectionSendMessageWithEnterTitle;

  /// Отправьте сообщение с [⏎ Enter] и новую строку с [Shift] + [⏎ Enter]
  ///
  /// In en, this message translates to:
  /// **'Send a message with [⏎ Enter] and a new line with [Shift] + [⏎ Enter]'**
  String get sectionSendMessageWithEnterSubtitle;

  /// Короткий текст для опции отправить сообщение с [⏎ Enter]
  ///
  /// In en, this message translates to:
  /// **'Send with [⏎ Enter]'**
  String get sectionSendMessageEnter;

  /// Короткий текст для секции политики конфиденциальности
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get sectionPrivacyPolicy;

  /// No description provided for @sectionSelectLocaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get sectionSelectLocaleTitle;

  /// No description provided for @sectionSelectLocaleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language for the app interface'**
  String get sectionSelectLocaleSubtitle;

  /// No description provided for @sectionSwitchThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get sectionSwitchThemeTitle;

  /// No description provided for @sectionSwitchThemeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable dark mode for a comfortable viewing experience in low light'**
  String get sectionSwitchThemeSubtitle;

  /// No description provided for @sectionLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get sectionLogsTitle;

  /// No description provided for @sectionLogsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and manage application logs for debugging'**
  String get sectionLogsSubtitle;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @bugReportDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get bugReportDialogTitle;

  /// No description provided for @bugReportDialogHintText.
  ///
  /// In en, this message translates to:
  /// **'Please describe the bug you encountered'**
  String get bugReportDialogHintText;

  /// No description provided for @attachFilesButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Attach files'**
  String get attachFilesButtonTooltip;

  /// No description provided for @filePickerError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick files'**
  String get filePickerError;

  /// No description provided for @emptyBugReportError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a bug report first'**
  String get emptyBugReportError;

  /// No description provided for @failedToSendBugReportError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send bug report'**
  String get failedToSendBugReportError;

  /// No description provided for @sectionManageSubscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get sectionManageSubscriptionTitle;

  /// No description provided for @sectionManageSubscriptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your subscription settings'**
  String get sectionManageSubscriptionSubtitle;

  /// No description provided for @sectionHapticFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get sectionHapticFeedbackTitle;

  /// No description provided for @sectionHapticFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable haptic feedback (vibration) on supported devices'**
  String get sectionHapticFeedbackSubtitle;

  /// Включить пуш уведомления
  ///
  /// In en, this message translates to:
  /// **'Turn on notifications'**
  String get sectionNotificationTitle;

  /// Включить пуш уведомления для приложения
  ///
  /// In en, this message translates to:
  /// **'Stay updated when Doctorina finds something important in your chats, reports, or symptoms.'**
  String get sectionNotificationSubtitle;

  /// Заголовок секции аккаунта на экране настроек
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get sectionAccountTitle;

  /// Заголовок секции приложения на экране настроек
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get sectionAppTitle;

  /// Заголовок секции информации на экране настроек
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sectionAboutTitle;

  /// Название пункта настроек уведомлений
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get sectionNotificationsTitle;

  /// Название пункта с видеоуроками
  ///
  /// In en, this message translates to:
  /// **'Video tutorials'**
  String get sectionVideoTutorialsTitle;

  /// Лейбл телефона в информации аккаунта
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get accountPhoneLabel;

  /// Лейбл email в информации аккаунта
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountEmailLabel;

  /// Лейбл имени в информации аккаунта
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get accountNameLabel;

  /// Версия приложения на экране настроек
  ///
  /// In en, this message translates to:
  /// **'Doctorina v{version}'**
  String appVersionLabel(String version);

  /// Сообщение о пропущенных дубликатах файлов в диалоге отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Skipped {count} files due to duplicate with existing files'**
  String duplicateAttachmentFilesError(String count);

  /// Заголовок секции выбора типа отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get bugReportTypeSectionLabel;

  /// Заголовок поля описания в диалоге отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get bugReportDescriptionSectionLabel;

  /// Заголовок секции вложений в диалоге отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get bugReportAttachmentsSectionLabel;

  /// Вариант типа отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get bugReportTypeBug;

  /// Вариант типа отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Crash'**
  String get bugReportTypeCrash;

  /// Вариант типа отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'UI issue'**
  String get bugReportTypeUiIssue;

  /// Вариант типа отчета об ошибке
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get bugReportTypeOther;

  /// Предупреждение на экране удаления аккаунта о безвозвратном удалении данных
  ///
  /// In en, this message translates to:
  /// **'Deleting your account will permanently remove your data from Doctorina.'**
  String get deleteAccountWarningMessage;

  /// Подзаголовок блока «Перед удалением» на экране удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Before you delete'**
  String get deleteAccountBeforeYouDeleteTitle;

  /// Уведомление, что удаление аккаунта не отменит активную подписку в сторе
  ///
  /// In en, this message translates to:
  /// **'You have an active subscription through the {store}. Deleting your account will not cancel it.'**
  String deleteAccountActiveSubscriptionNotice(String store);

  /// Ссылка отмены подписки в сторе на экране удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription in the {store}'**
  String deleteAccountCancelSubscriptionLink(String store);

  /// Кнопка «Continue» на экране удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get deleteAccountContinueButton;

  /// Вступительный текст на экране выбора причины удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'We are sorry to see you go. Are you sure you want to delete your account? Once you confirm, your data will be gone.'**
  String get deleteAccountFormDescription;

  /// Причина удаления: больше не пользуюсь приложением
  ///
  /// In en, this message translates to:
  /// **'I don\'t use the app anymore'**
  String get deleteAccountReasonDontUseAnymore;

  /// Причина удаления: нашёл вариант лучше
  ///
  /// In en, this message translates to:
  /// **'Found something better'**
  String get deleteAccountReasonFoundBetter;

  /// Причина удаления: технические проблемы
  ///
  /// In en, this message translates to:
  /// **'Technical issues'**
  String get deleteAccountReasonTechnicalIssues;

  /// Причина удаления: неудобно пользоваться
  ///
  /// In en, this message translates to:
  /// **'Ease of use issues'**
  String get deleteAccountReasonEaseOfUse;

  /// Причина удаления: не хватает функций
  ///
  /// In en, this message translates to:
  /// **'Missing features'**
  String get deleteAccountReasonMissingFeatures;

  /// Причина удаления: беспокойство о приватности
  ///
  /// In en, this message translates to:
  /// **'Privacy concerns'**
  String get deleteAccountReasonPrivacy;

  /// Причина удаления: просто хотел очистить свои данные
  ///
  /// In en, this message translates to:
  /// **'I just wanted to clear my data'**
  String get deleteAccountReasonClearData;

  /// Причина удаления: другое
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get deleteAccountReasonOther;

  /// Плейсхолдер поля обратной связи на экране удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Share your feedback'**
  String get deleteAccountFeedbackHint;

  /// Сообщение во время выполнения удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Deleting your account...'**
  String get deleteAccountProgressMessage;

  /// Состояние кнопки во время удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Deleting'**
  String get deleteAccountDeletingButton;

  /// Кнопка отмены удаления во время обратного отсчёта
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get deleteAccountUndoButton;

  /// Тост об успешном удалении аккаунта
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted.'**
  String get deleteAccountSuccessToast;

  /// Тост об ошибке удаления аккаунта
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account. Please try again.'**
  String get deleteAccountErrorToast;

  /// Тост, если не удалось открыть почтовый клиент
  ///
  /// In en, this message translates to:
  /// **'No email app is available on this device. Please contact support@doctorina.com.'**
  String get emailClientUnavailableToast;
}

class _SettingsLocalizationDelegate
    extends LocalizationsDelegate<SettingsLocalization> {
  const _SettingsLocalizationDelegate();

  @override
  Future<SettingsLocalization> load(Locale locale) {
    return SynchronousFuture<SettingsLocalization>(
        lookupSettingsLocalization(locale));
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
  bool shouldReload(_SettingsLocalizationDelegate old) => false;
}

SettingsLocalization lookupSettingsLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return SettingsLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return SettingsLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return SettingsLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return SettingsLocalizationZhCn();
          case 'HK':
            return SettingsLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return SettingsLocalizationAf();
    case 'am':
      return SettingsLocalizationAm();
    case 'ar':
      return SettingsLocalizationAr();
    case 'az':
      return SettingsLocalizationAz();
    case 'be':
      return SettingsLocalizationBe();
    case 'bg':
      return SettingsLocalizationBg();
    case 'bn':
      return SettingsLocalizationBn();
    case 'ca':
      return SettingsLocalizationCa();
    case 'cs':
      return SettingsLocalizationCs();
    case 'da':
      return SettingsLocalizationDa();
    case 'de':
      return SettingsLocalizationDe();
    case 'el':
      return SettingsLocalizationEl();
    case 'en':
      return SettingsLocalizationEn();
    case 'es':
      return SettingsLocalizationEs();
    case 'fa':
      return SettingsLocalizationFa();
    case 'fr':
      return SettingsLocalizationFr();
    case 'gu':
      return SettingsLocalizationGu();
    case 'he':
      return SettingsLocalizationHe();
    case 'hi':
      return SettingsLocalizationHi();
    case 'hu':
      return SettingsLocalizationHu();
    case 'id':
      return SettingsLocalizationId();
    case 'it':
      return SettingsLocalizationIt();
    case 'ja':
      return SettingsLocalizationJa();
    case 'kk':
      return SettingsLocalizationKk();
    case 'km':
      return SettingsLocalizationKm();
    case 'kn':
      return SettingsLocalizationKn();
    case 'ko':
      return SettingsLocalizationKo();
    case 'lo':
      return SettingsLocalizationLo();
    case 'ml':
      return SettingsLocalizationMl();
    case 'mr':
      return SettingsLocalizationMr();
    case 'ms':
      return SettingsLocalizationMs();
    case 'my':
      return SettingsLocalizationMy();
    case 'ne':
      return SettingsLocalizationNe();
    case 'nl':
      return SettingsLocalizationNl();
    case 'pa':
      return SettingsLocalizationPa();
    case 'pl':
      return SettingsLocalizationPl();
    case 'ps':
      return SettingsLocalizationPs();
    case 'pt':
      return SettingsLocalizationPt();
    case 'ro':
      return SettingsLocalizationRo();
    case 'ru':
      return SettingsLocalizationRu();
    case 'si':
      return SettingsLocalizationSi();
    case 'sk':
      return SettingsLocalizationSk();
    case 'sw':
      return SettingsLocalizationSw();
    case 'ta':
      return SettingsLocalizationTa();
    case 'te':
      return SettingsLocalizationTe();
    case 'th':
      return SettingsLocalizationTh();
    case 'tl':
      return SettingsLocalizationTl();
    case 'tr':
      return SettingsLocalizationTr();
    case 'uk':
      return SettingsLocalizationUk();
    case 'ur':
      return SettingsLocalizationUr();
    case 'uz':
      return SettingsLocalizationUz();
    case 'vi':
      return SettingsLocalizationVi();
    case 'zh':
      return SettingsLocalizationZh();
    case 'zu':
      return SettingsLocalizationZu();
  }

  throw FlutterError(
      'SettingsLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
