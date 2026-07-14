// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'chat_localization_af.dart';
import 'chat_localization_am.dart';
import 'chat_localization_ar.dart';
import 'chat_localization_az.dart';
import 'chat_localization_be.dart';
import 'chat_localization_bg.dart';
import 'chat_localization_bn.dart';
import 'chat_localization_ca.dart';
import 'chat_localization_cs.dart';
import 'chat_localization_da.dart';
import 'chat_localization_de.dart';
import 'chat_localization_el.dart';
import 'chat_localization_en.dart';
import 'chat_localization_es.dart';
import 'chat_localization_fa.dart';
import 'chat_localization_fr.dart';
import 'chat_localization_gu.dart';
import 'chat_localization_he.dart';
import 'chat_localization_hi.dart';
import 'chat_localization_hu.dart';
import 'chat_localization_id.dart';
import 'chat_localization_it.dart';
import 'chat_localization_ja.dart';
import 'chat_localization_kk.dart';
import 'chat_localization_km.dart';
import 'chat_localization_kn.dart';
import 'chat_localization_ko.dart';
import 'chat_localization_lo.dart';
import 'chat_localization_ml.dart';
import 'chat_localization_mr.dart';
import 'chat_localization_ms.dart';
import 'chat_localization_my.dart';
import 'chat_localization_ne.dart';
import 'chat_localization_nl.dart';
import 'chat_localization_pa.dart';
import 'chat_localization_pl.dart';
import 'chat_localization_ps.dart';
import 'chat_localization_pt.dart';
import 'chat_localization_ro.dart';
import 'chat_localization_ru.dart';
import 'chat_localization_si.dart';
import 'chat_localization_sk.dart';
import 'chat_localization_sw.dart';
import 'chat_localization_ta.dart';
import 'chat_localization_te.dart';
import 'chat_localization_th.dart';
import 'chat_localization_tl.dart';
import 'chat_localization_tr.dart';
import 'chat_localization_uk.dart';
import 'chat_localization_ur.dart';
import 'chat_localization_uz.dart';
import 'chat_localization_vi.dart';
import 'chat_localization_zh.dart';
import 'chat_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ChatLocalization
/// returned by `ChatLocalization.of(context)`.
///
/// Applications need to include `ChatLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'chat/chat_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ChatLocalization.localizationsDelegates,
///   supportedLocales: ChatLocalization.supportedLocales,
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
/// be consistent with the languages listed in the ChatLocalization.supportedLocales
/// property.
abstract class ChatLocalization {
  ChatLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ChatLocalization of(BuildContext context) {
    return Localizations.of<ChatLocalization>(context, ChatLocalization)!;
  }

  static const LocalizationsDelegate<ChatLocalization> delegate =
      _ChatLocalizationDelegate();

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

  /// No description provided for @drawerTooltipNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get drawerTooltipNotifications;

  /// No description provided for @drawerTooltipHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get drawerTooltipHelp;

  /// No description provided for @drawerTooltipClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get drawerTooltipClose;

  /// No description provided for @drawerSectionTitleAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get drawerSectionTitleAccount;

  /// No description provided for @drawerSectionProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get drawerSectionProfile;

  /// No description provided for @drawerSectionAccountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get drawerSectionAccountSettings;

  /// No description provided for @drawerSectionDonateToSupport.
  ///
  /// In en, this message translates to:
  /// **'Donate to Support'**
  String get drawerSectionDonateToSupport;

  /// No description provided for @drawerSectionSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get drawerSectionSubscription;

  /// No description provided for @drawerSectionTitleChats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get drawerSectionTitleChats;

  /// История чатов, имеется ввиду список чатов пользователя
  ///
  /// In en, this message translates to:
  /// **'Chat History'**
  String get drawerSectionChatHistory;

  /// No description provided for @drawerSectionAttachedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Attached Documents'**
  String get drawerSectionAttachedDocuments;

  /// No description provided for @drawerSectionTitleHowToUse.
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get drawerSectionTitleHowToUse;

  /// No description provided for @drawerSectionVideoTutorials.
  ///
  /// In en, this message translates to:
  /// **'Video Tutorials'**
  String get drawerSectionVideoTutorials;

  /// No description provided for @drawerSectionTitleLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get drawerSectionTitleLegal;

  /// No description provided for @drawerSectionContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get drawerSectionContactUs;

  /// No description provided for @drawerSectionBugReport.
  ///
  /// In en, this message translates to:
  /// **'Bug Report'**
  String get drawerSectionBugReport;

  /// No description provided for @drawerSectionTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get drawerSectionTermsAndConditions;

  /// No description provided for @drawerSectionPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get drawerSectionPrivacyPolicy;

  /// No description provided for @drawerSectionTitleFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get drawerSectionTitleFeedback;

  /// No description provided for @drawerSectionRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get drawerSectionRateApp;

  /// No description provided for @drawerSectionShareWithFriends.
  ///
  /// In en, this message translates to:
  /// **'Share with Friends'**
  String get drawerSectionShareWithFriends;

  /// No description provided for @drawerButtonLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get drawerButtonLogOut;

  /// No description provided for @drawerBannerHelpOthersReceiveMedicalCare.
  ///
  /// In en, this message translates to:
  /// **'Help others receive medical care'**
  String get drawerBannerHelpOthersReceiveMedicalCare;

  /// Если нет имени пользователя, емейла, телефона - по умолчанию.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get drawerPlaceholderUser;

  /// No description provided for @drawerSubscriptionLabelPremiumFeaturesWithDoctorina.
  ///
  /// In en, this message translates to:
  /// **'Premium Features\nwith Doctorina'**
  String get drawerSubscriptionLabelPremiumFeaturesWithDoctorina;

  /// No description provided for @drawerSubscriptionButtonGetPremiumFeatures.
  ///
  /// In en, this message translates to:
  /// **'Get'**
  String get drawerSubscriptionButtonGetPremiumFeatures;

  /// Надпись перед иконками социальных сетей
  ///
  /// In en, this message translates to:
  /// **'Join Us'**
  String get drawerLabelJoinUs;

  /// Подсказка при наведении на версию приложения
  ///
  /// In en, this message translates to:
  /// **'App version:'**
  String get drawerTooltipVersion;

  /// Заголовок секции недавних чатов в боковом меню
  ///
  /// In en, this message translates to:
  /// **'Recent Chats'**
  String get drawerSectionRecentChats;

  /// Плейсхолдер профиля в боковом меню
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get drawerPlaceholderProfile;

  /// Плейсхолдер недавнего чата в боковом меню
  ///
  /// In en, this message translates to:
  /// **'Recent chat'**
  String get drawerPlaceholderRecentChat;

  /// Заголовок секции скачивания приложений в боковом меню
  ///
  /// In en, this message translates to:
  /// **'Download Apps'**
  String get drawerSectionDownloadApps;

  /// Подсказка в поле ввода чата
  ///
  /// In en, this message translates to:
  /// **'Enter message'**
  String get chatInputHintEnterMessage;

  /// No description provided for @chatInputTooltipAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file'**
  String get chatInputTooltipAttachFile;

  /// Надиктовать голосовое сообщение
  ///
  /// In en, this message translates to:
  /// **'Dictate'**
  String get chatInputTooltipDictateMessage;

  /// Закончить запись голосового сообщения и распознать в текст
  ///
  /// In en, this message translates to:
  /// **'Finish & Transcribe'**
  String get chatInputTooltipDictateFinishMessage;

  /// No description provided for @chatInputTooltipSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get chatInputTooltipSendMessage;

  /// No description provided for @chatListSnackBarErrorFailedToFetchMessages.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch messages'**
  String get chatListSnackBarErrorFailedToFetchMessages;

  /// No description provided for @chatListLabelErrorFailedToFetchMessagesPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch messages. Please try again.'**
  String get chatListLabelErrorFailedToFetchMessagesPleaseTryAgain;

  /// No description provided for @chatListTooltipFetchMessages.
  ///
  /// In en, this message translates to:
  /// **'Fetch messages'**
  String get chatListTooltipFetchMessages;

  /// No description provided for @chatListLabelNoMessagesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No messages available.\nPlease send a message to start the conversation.'**
  String get chatListLabelNoMessagesAvailable;

  /// No description provided for @chatListHasConnection.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get chatListHasConnection;

  /// No description provided for @chatListNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No connection'**
  String get chatListNoConnection;

  /// No description provided for @chatActionButtonTooltipSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get chatActionButtonTooltipSearch;

  /// No description provided for @chatActionButtonTooltipFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get chatActionButtonTooltipFavorites;

  /// No description provided for @chatActionButtonTooltipDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get chatActionButtonTooltipDownload;

  /// No description provided for @chatActionButtonTooltipPrintPdf.
  ///
  /// In en, this message translates to:
  /// **'Print PDF'**
  String get chatActionButtonTooltipPrintPdf;

  /// No description provided for @chatActionButtonTooltipShareWithFriends.
  ///
  /// In en, this message translates to:
  /// **'Share with Friends'**
  String get chatActionButtonTooltipShareWithFriends;

  /// No description provided for @chatActionButtonTooltipNewChat.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get chatActionButtonTooltipNewChat;

  /// No description provided for @chatActionButtonNewChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatActionButtonNewChat;

  /// No description provided for @chatActionButtonTooltipChatList.
  ///
  /// In en, this message translates to:
  /// **'Select Chat'**
  String get chatActionButtonTooltipChatList;

  /// Leading кнопка AppBar открывающая панель Drawer'а
  ///
  /// In en, this message translates to:
  /// **'Show drawer'**
  String get chatActionButtonTooltipShowDrawer;

  /// No description provided for @chatLabelNoChatAvailableRefresh.
  ///
  /// In en, this message translates to:
  /// **'No chats available. Please refresh or create a new chat.'**
  String get chatLabelNoChatAvailableRefresh;

  /// No description provided for @chatButtonRefreshChats.
  ///
  /// In en, this message translates to:
  /// **'Refresh chats'**
  String get chatButtonRefreshChats;

  /// No description provided for @chatButtonCreateNewChat.
  ///
  /// In en, this message translates to:
  /// **'Create new chat'**
  String get chatButtonCreateNewChat;

  /// Контекстное меню "скопировать текст сообщения"
  ///
  /// In en, this message translates to:
  /// **'Copy text'**
  String get chatContextMenuCopyMessage;

  /// ⚠️⚠️⚠️ Каждая новая строка - следующее сообщение,
  /// о том что ответ задерживается. ⚠️⚠️⚠️
  ///
  /// In en, this message translates to:
  /// **'Typing\nJust a moment'**
  String get chatStatusProcessingMessages;

  /// ⚠️⚠️⚠️ Каждая новая строка - следующее сообщение,
  /// о том что интернета все еще нет. ⚠️⚠️⚠️
  ///
  /// In en, this message translates to:
  /// **'Updating...\nPlease check your internet connection'**
  String get chatNoConnectionLabel;

  /// No description provided for @chatErrorMessageAlreadyProcessed.
  ///
  /// In en, this message translates to:
  /// **'The message is already being processed right now.'**
  String get chatErrorMessageAlreadyProcessed;

  /// No description provided for @chatErrorMessageTooLong.
  ///
  /// In en, this message translates to:
  /// **'Message is too long.'**
  String get chatErrorMessageTooLong;

  /// No description provided for @chatRemoveAttachmentTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove attachment'**
  String get chatRemoveAttachmentTooltip;

  /// Сообщение отображаемое на статус-ошибку с BE.
  ///
  /// In en, this message translates to:
  /// **'Failed to process message'**
  String get chatStatusFailedMessage;

  /// Подсказка для кнопки открывающей боттом шит по экспорту саммари в PDF
  ///
  /// In en, this message translates to:
  /// **'Export to PDF'**
  String get chatActionButtonTooltipExportSummary;

  /// No description provided for @chatActionExportToPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get chatActionExportToPdfTitle;

  /// Надпись в меню для выбора из галлереи
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get chatPickerPhotos;

  /// Надпись в меню для прикрепления фото с помощью камеры
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get chatPickerCamera;

  /// Надпись в меню для выбора файлов
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get chatPickerFiles;

  /// Надпись в меню для выбора фотографий и файлов
  ///
  /// In en, this message translates to:
  /// **'Photos and Files'**
  String get chatPickerPhotosFiles;

  /// No description provided for @chatRecommendationYIAG.
  ///
  /// In en, this message translates to:
  /// **'Hope that helped! Was this explanation useful to you?'**
  String get chatRecommendationYIAG;

  /// Кнопка отображаемая после финальных рекомендаций, для пользователей без подписки
  ///
  /// In en, this message translates to:
  /// **'Yes, it\'s all good!'**
  String get chatRecommendationButtonDonate;

  /// No description provided for @failedToRetrieveChatSummary.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve chat summary'**
  String get failedToRetrieveChatSummary;

  /// No description provided for @chatSummaryCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Chat summary copied to clipboard'**
  String get chatSummaryCopiedToClipboard;

  /// Надпись предлагающая попробывать нейтивные мобильные приложения вместо веба
  ///
  /// In en, this message translates to:
  /// **'Try Doctorina in the mobile app!'**
  String get tryDoctorinaInTheMobileApp;

  /// Лейбл как часть надписи "Download on the App Store", должен быть емким, чтоб помещаться в кнопку.
  ///
  /// In en, this message translates to:
  /// **'Download on the'**
  String get getAppStoreLogoLabel;

  /// Лейбл как часть надписи "GET IT ON Google Play", должен быть емким, чтоб помещаться в кнопку.
  ///
  /// In en, this message translates to:
  /// **'GET IT ON'**
  String get getGooglePlayLogoLabel;

  /// Подсказка к кнопке "Download on the App Store"
  ///
  /// In en, this message translates to:
  /// **'Download on the App Store'**
  String get getAppStoreLogoTooltip;

  /// Подсказка к кнопке "Get it on Google Play"
  ///
  /// In en, this message translates to:
  /// **'Get it on Google Play'**
  String get getGooglePlayLogoTooltip;

  /// Заголовок диалога жалобы на сообщение
  ///
  /// In en, this message translates to:
  /// **'Report Message'**
  String get reportMessageDialogTitle;

  /// Диалог жалобы на сообщение, текст вопроса
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this message?'**
  String get reportMessageDialogSubtitle;

  /// Хинт поля ввода в диалоге жалобы на сообщение
  ///
  /// In en, this message translates to:
  /// **'Optional: Describe what\'s wrong with this message...'**
  String get reportMessageDialogTextFieldHint;

  /// Диалог жалобы на сообщение, почему это важно
  ///
  /// In en, this message translates to:
  /// **'This will help us improve our AI responses.'**
  String get reportMessageDialogWhyImportant;

  /// Диалог жалобы на сообщение, кнопка отмены
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get reportMessageDialogCancelButton;

  /// Диалог жалобы на сообщение, кнопка отправить жалобу
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get reportMessageDialogReportButton;

  /// Снэкбар об успешной отправке жалобы
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback! Report has been submitted.'**
  String get reportMessageSnackbarSuccess;

  /// Снэкбар о не успешной отправке жалобы
  ///
  /// In en, this message translates to:
  /// **'Failed to submit report'**
  String get reportMessageSnackbarFailed;

  /// Снэкбар об успешном копировании в буфер обмена
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copyMessageSnackbarSuccess;

  /// Снэкбар о не успешном копировании в буфер обмена
  ///
  /// In en, this message translates to:
  /// **'Failed to copy message'**
  String get copyMessageSnackbarFailed;

  /// Контекстное меню "пожаловаться на сообщение"
  ///
  /// In en, this message translates to:
  /// **'Report Message'**
  String get chatContextMenuReportMessage;

  /// No description provided for @chatDropZoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload to the Doctorina chat'**
  String get chatDropZoneTitle;

  /// No description provided for @chatDropZoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Drag and drop files here to add to chat'**
  String get chatDropZoneSubtitle;

  /// No description provided for @chatDropZoneText.
  ///
  /// In en, this message translates to:
  /// **'You can add up to 15 files to one message'**
  String get chatDropZoneText;

  /// Текст предлагающий пользователю включить пуш уведомления
  ///
  /// In en, this message translates to:
  /// **'Would you like me to notify you if something important comes up about your health?'**
  String get notificationBannerText;

  /// Кнопка разрешающая включить уведомления
  ///
  /// In en, this message translates to:
  /// **'Yes, notify me'**
  String get notificationBannerButtonEnable;

  /// Кнопка временно скрывающая баннер запроса пуш уведомлений
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get notificationBannerButtonDisable;

  /// Кнопка временно скрывающая баннер запроса пуш уведомлений
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get notificationBannerButtonClose;

  /// Сообщение об ошибке, уведомления отключены для приложения в пермишенах операционной системы
  ///
  /// In en, this message translates to:
  /// **'Notifications are blocked at the system level. Enable them in system settings before activating Doctorina’s notifications.'**
  String get notificationAreBlockedSystem;

  /// Сообщение об ошибке, уведомления отключены для приложения в пермишенах браузера
  ///
  /// In en, this message translates to:
  /// **'Notifications are blocked at the system level. Enable them in browser settings before activating Doctorina’s notifications.'**
  String get notificationAreBlockedBrowser;

  /// Title for notification dialog
  ///
  /// In en, this message translates to:
  /// **'Stay updated about your consultation'**
  String get notificationDialogTitle;

  /// Description for notification dialog
  ///
  /// In en, this message translates to:
  /// **'Doctorina can notify you when new insights or updates about your health are available.'**
  String get notificationDialogDescription;

  /// Title for button to enable notifications
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get notificationDialogEnableButton;

  /// Title for button to skip enable notifications
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get notificationDialogLaterButton;

  /// Соглашение на обработку персональных данных.
  /// В тэгах <t>, <c>, <p> указаны кликабельн спан, он должны присутсвовать во всех языках.
  ///
  /// In en, this message translates to:
  /// **'By continuing you consenting to the processing of personal data, the use of <c>cookies</c>, agree to the <t>terms and conditions</t>, and acknowledge the <p>privacy policy</p>. Also you acknowledging that your consultation is with an AI and not a licensed medical professional'**
  String get termsAndConditionBannerText;

  /// Tooltip for dimiss banner
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get termsAndConditionBannerDismissTooltip;

  /// When anon users tries to create new chat, they would get warning dialog that they would lose chat history
  ///
  /// In en, this message translates to:
  /// **'Save this chat first?'**
  String get anonUserNewChatCreationWarningTitle;

  /// When anon users tries to create new chat, they would get warning dialog that they would lose chat history
  ///
  /// In en, this message translates to:
  /// **'Sign up for free to save this consultation before starting a new one'**
  String get anonUserNewChatCreationWarningText;

  /// When anon users tries to create new chat, they would get warning dialog that they would lose chat history
  ///
  /// In en, this message translates to:
  /// **'Start without saving'**
  String get anonUserNewChatCreationWarningContinueBtn;

  /// When anon users tries to create new chat, they would get warning dialog that they would lose chat history
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get anonUserNewChatCreationWarningContinueLoginOrSignUpBtn;

  /// Message shown when chat input is blocked, prompting user to choose an option
  ///
  /// In en, this message translates to:
  /// **'To continue the conversation, choose an option above'**
  String get inputBlockerContinueMessage;

  /// Tooltip for dimiss banner
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get chatServerDialogCloseBtnTooltip;

  /// Tooltip for remove attachment button on attachment card/chip
  ///
  /// In en, this message translates to:
  /// **'Remove attachment'**
  String get chatAttachmentRemoveTooltip;

  /// Error when picking files from drop zone fails
  ///
  /// In en, this message translates to:
  /// **'Failed to pick files from drop zone'**
  String get chatAttachmentErrorPickFilesDropZone;

  /// Error when sending with empty message and no attachments
  ///
  /// In en, this message translates to:
  /// **'Please enter a message or attach a file'**
  String get chatAttachmentErrorEnterMessageOrAttach;

  /// Error when send is pressed while uploads are in progress
  ///
  /// In en, this message translates to:
  /// **'Please wait for uploads to complete'**
  String get chatAttachmentErrorWaitForUploads;

  /// Error when message is already being processed
  ///
  /// In en, this message translates to:
  /// **'Message is being processed'**
  String get chatAttachmentErrorMessageProcessing;

  /// Error when message exceeds max length
  ///
  /// In en, this message translates to:
  /// **'Message is too long'**
  String get chatAttachmentErrorMessageTooLong;

  /// Send button tooltip when message is already being processed
  ///
  /// In en, this message translates to:
  /// **'The message is already being processed right now.'**
  String get chatAttachmentErrorMessageAlreadyProcessing;

  /// Error when connection is permanently closed
  ///
  /// In en, this message translates to:
  /// **'The connection is permanently closed'**
  String get chatAttachmentErrorConnectionClosed;

  /// Error when there is no connection to server
  ///
  /// In en, this message translates to:
  /// **'No connection to server'**
  String get chatAttachmentErrorNoConnection;

  /// Error when file picker fails
  ///
  /// In en, this message translates to:
  /// **'Failed to pick files'**
  String get chatAttachmentErrorPickFiles;

  /// Error when image picker fails
  ///
  /// In en, this message translates to:
  /// **'Failed to pick images'**
  String get chatAttachmentErrorPickImages;

  /// Error when camera capture fails
  ///
  /// In en, this message translates to:
  /// **'Failed to capture photo from camera'**
  String get chatAttachmentErrorCapturePhoto;

  /// Error when attachment limit is reached at pick
  ///
  /// In en, this message translates to:
  /// **'You can attach up to {count} files at once.'**
  String chatAttachmentErrorMaxFiles(int count);

  /// Tooltip for clear recognized text button
  ///
  /// In en, this message translates to:
  /// **'Clear recognized text'**
  String get chatInputTooltipClearRecognizedText;

  /// Send button tooltip when message is too long
  ///
  /// In en, this message translates to:
  /// **'Message is too long.'**
  String get chatInputTooltipMessageTooLong;

  /// Send button tooltip when uploads are pending
  ///
  /// In en, this message translates to:
  /// **'Please wait for uploads to complete.'**
  String get chatInputTooltipWaitForUploads;

  /// PickerException: file already attached (merge duplicate)
  ///
  /// In en, this message translates to:
  /// **'The {kind} \"{name}\" is already attached and was not added again.'**
  String chatAttachmentErrorMergeAlreadyAttached(String kind, String name);

  /// PickerException: file is duplicate of existing
  ///
  /// In en, this message translates to:
  /// **'The {kind} \"{name}\" is a duplicate of {exist} and was not added.'**
  String chatAttachmentErrorMergeDuplicate(
      String kind, String name, String exist);

  /// PickerException: limit exceeded when adding file
  ///
  /// In en, this message translates to:
  /// **'The {kind} \"{name}\" was not added because the maximum number of attachments has been exceeded.'**
  String chatAttachmentErrorMergeLimit(String kind, String name);

  /// Snackbar: file is empty (with name)
  ///
  /// In en, this message translates to:
  /// **'The file \"{name}\" is empty.'**
  String chatAttachmentErrorFileEmptyWithName(String name);

  /// Snackbar: file is empty
  ///
  /// In en, this message translates to:
  /// **'The file is empty.'**
  String get chatAttachmentErrorFileEmpty;

  /// Snackbar: file exceeds max size (with name)
  ///
  /// In en, this message translates to:
  /// **'The file \"{name}\" exceeds the maximum allowed size.'**
  String chatAttachmentErrorFileSizeWithName(String name);

  /// Snackbar: file exceeds max size
  ///
  /// In en, this message translates to:
  /// **'The file exceeds the maximum allowed size.'**
  String get chatAttachmentErrorFileSize;

  /// Snackbar: error processing file (with name)
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing the file \"{name}\".'**
  String chatAttachmentErrorFileProcessingWithName(String name);

  /// Snackbar: error processing file
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing the file.'**
  String get chatAttachmentErrorFileProcessing;

  /// Snackbar: file not added, limit exceeded (with name)
  ///
  /// In en, this message translates to:
  /// **'The file \"{name}\" was not added because the maximum number of attachments has been exceeded.'**
  String chatAttachmentErrorFileLimitWithName(String name);

  /// Snackbar: multiple files not added, limit exceeded
  ///
  /// In en, this message translates to:
  /// **'A file(s) was not added because the maximum number of attachments has been exceeded.'**
  String get chatAttachmentErrorFileLimitMultiple;

  /// Snackbar: one file not added, limit exceeded
  ///
  /// In en, this message translates to:
  /// **'A file was not added because the maximum number of attachments has been exceeded.'**
  String get chatAttachmentErrorFileLimitSingle;

  /// Snackbar: file without name
  ///
  /// In en, this message translates to:
  /// **'A file without a name was attempted to be added.'**
  String get chatAttachmentErrorFileMissingName;

  /// Snackbar: unsupported extension (with name)
  ///
  /// In en, this message translates to:
  /// **'A file with an unsupported extension was attempted to be added: \"{name}\".'**
  String chatAttachmentErrorFileExtensionWithName(String name);

  /// Snackbar: unsupported extension
  ///
  /// In en, this message translates to:
  /// **'A file with an unsupported extension was attempted to be added.'**
  String get chatAttachmentErrorFileExtension;

  /// Snackbar: impossible to add file
  ///
  /// In en, this message translates to:
  /// **'Impossible to add a file.'**
  String get chatAttachmentErrorFileNull;

  /// Snackbar: file invalid (with name)
  ///
  /// In en, this message translates to:
  /// **'The file \"{name}\" is invalid and cannot be added.'**
  String chatAttachmentErrorFileInvalidWithName(String name);

  /// Snackbar: file invalid
  ///
  /// In en, this message translates to:
  /// **'A file is invalid and cannot be added.'**
  String get chatAttachmentErrorFileInvalid;

  /// Snackbar: item not valid file (with name)
  ///
  /// In en, this message translates to:
  /// **'The item \"{name}\" is not a valid file.'**
  String chatAttachmentErrorItemNotFileWithName(String name);

  /// Snackbar: item not valid file
  ///
  /// In en, this message translates to:
  /// **'An item is not a valid file.'**
  String get chatAttachmentErrorItemNotFile;

  /// Snackbar: error processing item (single)
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing an item.'**
  String get chatAttachmentErrorItemProcessingSingle;

  /// Snackbar: error processing items (multiple)
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing an item(s).'**
  String get chatAttachmentErrorItemProcessingMultiple;

  /// Snackbar: no files added
  ///
  /// In en, this message translates to:
  /// **'No files were added.'**
  String get chatAttachmentErrorNoFiles;

  /// Snackbar: files skipped as duplicates
  ///
  /// In en, this message translates to:
  /// **'Some files were skipped due to duplicates with existing files.'**
  String get chatAttachmentErrorFileDuplicates;

  /// Snackbar: unknown error
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get chatAttachmentErrorUnknown;

  /// Snackbar header when multiple attach errors
  ///
  /// In en, this message translates to:
  /// **'The following errors occurred while attaching files:'**
  String get chatAttachmentErrorSnackbarHeader;

  /// Attachment preview: share failed
  ///
  /// In en, this message translates to:
  /// **'Failed to share file: {error}'**
  String chatAttachmentPreviewErrorShare(String error);

  /// Attachment preview app bar close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get chatAttachmentPreviewTooltipClose;

  /// Attachment preview app bar share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get chatAttachmentPreviewTooltipShare;

  /// Attachment preview loading state
  ///
  /// In en, this message translates to:
  /// **'Loading file...'**
  String get chatAttachmentPreviewLoading;

  /// Attachment preview error state title
  ///
  /// In en, this message translates to:
  /// **'Failed to load file'**
  String get chatAttachmentPreviewErrorLoad;

  /// Attachment preview error fallback
  ///
  /// In en, this message translates to:
  /// **'Unknown error occurred'**
  String get chatAttachmentPreviewErrorUnknown;

  /// Attachment preview retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get chatAttachmentPreviewButtonRetry;

  /// Attachment preview unsupported type title
  ///
  /// In en, this message translates to:
  /// **'Unsupported file type'**
  String get chatAttachmentPreviewUnsupportedType;

  /// Attachment preview cannot preview content type
  ///
  /// In en, this message translates to:
  /// **'Cannot preview {contentType}'**
  String chatAttachmentPreviewCannotPreview(String contentType);

  /// Attachment preview share file button
  ///
  /// In en, this message translates to:
  /// **'Share File'**
  String get chatAttachmentPreviewButtonShareFile;

  /// Attachment preview image display failed
  ///
  /// In en, this message translates to:
  /// **'Failed to display image'**
  String get chatAttachmentPreviewErrorImage;

  /// Attachment preview reset zoom FAB
  ///
  /// In en, this message translates to:
  /// **'Reset zoom'**
  String get chatAttachmentPreviewTooltipResetZoom;

  /// Attachment preview PDF load failed
  ///
  /// In en, this message translates to:
  /// **'Failed to load PDF'**
  String get chatAttachmentPreviewErrorPdf;

  /// Attachment preview text decode failed
  ///
  /// In en, this message translates to:
  /// **'Failed to decode text content.'**
  String get chatAttachmentPreviewErrorDecodeText;

  /// Snackbar: N more errors
  ///
  /// In en, this message translates to:
  /// **'And {count} more errors.'**
  String chatAttachmentErrorSnackbarMore(int count);

  /// Attachment preview: file malformed
  ///
  /// In en, this message translates to:
  /// **'File is malformed'**
  String get chatAttachmentPreviewFileMalformed;

  /// Title "Consent Required"
  ///
  /// In en, this message translates to:
  /// **'Consent Required'**
  String get chatConsentRequiredTitle;

  /// Text of "Privacy policy" and "Terms and Conditions"
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our <tc>Terms</tc>, <privacy_policy>Privacy Policy</privacy_policy>, and <cookies>use of cookies</cookies>, and confirm that this consultation is provided by AI, not a licensed medical professional.'**
  String get chatConsentRequiredText;

  /// Tooltip for button close "Consent Required"
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get chatConsentRequiredCloseTooltip;

  /// Popup menu button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get chatHistoryDelete;

  /// Popup menu button
  ///
  /// In en, this message translates to:
  /// **'Delete chat'**
  String get chatDelete;

  /// Snack bar message for successfully deleted chat
  ///
  /// In en, this message translates to:
  /// **'Chat “{title}” deleted successfully.'**
  String chatHistoryDeletedSnackbarSuccess(String title);

  /// Заголовок модального окна подтверждения удаления чата
  ///
  /// In en, this message translates to:
  /// **'Delete chat?'**
  String get chatDeleteConfirmationTitle;

  /// Текст модального окна подтверждения удаления чата
  ///
  /// In en, this message translates to:
  /// **'Your symptoms, diagnosis summary, and any recommendations in this chat will be removed.\nThis action can\'t be undone.'**
  String get chatDeleteConfirmationSubtitle;

  /// Tooltip for zoom in button in preview attachment screen
  ///
  /// In en, this message translates to:
  /// **'Zoom In'**
  String get chatAttachmentPreviewZoomInTooltip;

  /// No description provided for @chatAttachmentPreviewZoomOutTooltip.
  ///
  /// In en, this message translates to:
  /// **'Zoom Out'**
  String get chatAttachmentPreviewZoomOutTooltip;

  /// No description provided for @chatAttachmentPreviewZoomResetTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset Zoom'**
  String get chatAttachmentPreviewZoomResetTooltip;

  /// No description provided for @chatAttachmentPreviewShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get chatAttachmentPreviewShareTooltip;

  /// Запись даты "сегодня"
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// Запись даты "вчера"
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// Уведомление в предпросмотре вложения, если документ показан как превью первой страницы
  ///
  /// In en, this message translates to:
  /// **'First page only. Use Share to download the full file.'**
  String get chatAttachmentPreviewDocumentNotice;
}

class _ChatLocalizationDelegate
    extends LocalizationsDelegate<ChatLocalization> {
  const _ChatLocalizationDelegate();

  @override
  Future<ChatLocalization> load(Locale locale) {
    return SynchronousFuture<ChatLocalization>(lookupChatLocalization(locale));
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
  bool shouldReload(_ChatLocalizationDelegate old) => false;
}

ChatLocalization lookupChatLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return ChatLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return ChatLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return ChatLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return ChatLocalizationZhCn();
          case 'HK':
            return ChatLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return ChatLocalizationAf();
    case 'am':
      return ChatLocalizationAm();
    case 'ar':
      return ChatLocalizationAr();
    case 'az':
      return ChatLocalizationAz();
    case 'be':
      return ChatLocalizationBe();
    case 'bg':
      return ChatLocalizationBg();
    case 'bn':
      return ChatLocalizationBn();
    case 'ca':
      return ChatLocalizationCa();
    case 'cs':
      return ChatLocalizationCs();
    case 'da':
      return ChatLocalizationDa();
    case 'de':
      return ChatLocalizationDe();
    case 'el':
      return ChatLocalizationEl();
    case 'en':
      return ChatLocalizationEn();
    case 'es':
      return ChatLocalizationEs();
    case 'fa':
      return ChatLocalizationFa();
    case 'fr':
      return ChatLocalizationFr();
    case 'gu':
      return ChatLocalizationGu();
    case 'he':
      return ChatLocalizationHe();
    case 'hi':
      return ChatLocalizationHi();
    case 'hu':
      return ChatLocalizationHu();
    case 'id':
      return ChatLocalizationId();
    case 'it':
      return ChatLocalizationIt();
    case 'ja':
      return ChatLocalizationJa();
    case 'kk':
      return ChatLocalizationKk();
    case 'km':
      return ChatLocalizationKm();
    case 'kn':
      return ChatLocalizationKn();
    case 'ko':
      return ChatLocalizationKo();
    case 'lo':
      return ChatLocalizationLo();
    case 'ml':
      return ChatLocalizationMl();
    case 'mr':
      return ChatLocalizationMr();
    case 'ms':
      return ChatLocalizationMs();
    case 'my':
      return ChatLocalizationMy();
    case 'ne':
      return ChatLocalizationNe();
    case 'nl':
      return ChatLocalizationNl();
    case 'pa':
      return ChatLocalizationPa();
    case 'pl':
      return ChatLocalizationPl();
    case 'ps':
      return ChatLocalizationPs();
    case 'pt':
      return ChatLocalizationPt();
    case 'ro':
      return ChatLocalizationRo();
    case 'ru':
      return ChatLocalizationRu();
    case 'si':
      return ChatLocalizationSi();
    case 'sk':
      return ChatLocalizationSk();
    case 'sw':
      return ChatLocalizationSw();
    case 'ta':
      return ChatLocalizationTa();
    case 'te':
      return ChatLocalizationTe();
    case 'th':
      return ChatLocalizationTh();
    case 'tl':
      return ChatLocalizationTl();
    case 'tr':
      return ChatLocalizationTr();
    case 'uk':
      return ChatLocalizationUk();
    case 'ur':
      return ChatLocalizationUr();
    case 'uz':
      return ChatLocalizationUz();
    case 'vi':
      return ChatLocalizationVi();
    case 'zh':
      return ChatLocalizationZh();
    case 'zu':
      return ChatLocalizationZu();
  }

  throw FlutterError(
      'ChatLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
