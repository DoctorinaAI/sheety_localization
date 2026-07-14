// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'profiles_localization_af.dart';
import 'profiles_localization_am.dart';
import 'profiles_localization_ar.dart';
import 'profiles_localization_az.dart';
import 'profiles_localization_be.dart';
import 'profiles_localization_bg.dart';
import 'profiles_localization_bn.dart';
import 'profiles_localization_ca.dart';
import 'profiles_localization_cs.dart';
import 'profiles_localization_da.dart';
import 'profiles_localization_de.dart';
import 'profiles_localization_el.dart';
import 'profiles_localization_en.dart';
import 'profiles_localization_es.dart';
import 'profiles_localization_fa.dart';
import 'profiles_localization_fr.dart';
import 'profiles_localization_gu.dart';
import 'profiles_localization_he.dart';
import 'profiles_localization_hi.dart';
import 'profiles_localization_hu.dart';
import 'profiles_localization_id.dart';
import 'profiles_localization_it.dart';
import 'profiles_localization_ja.dart';
import 'profiles_localization_kk.dart';
import 'profiles_localization_km.dart';
import 'profiles_localization_kn.dart';
import 'profiles_localization_ko.dart';
import 'profiles_localization_lo.dart';
import 'profiles_localization_ml.dart';
import 'profiles_localization_mr.dart';
import 'profiles_localization_ms.dart';
import 'profiles_localization_my.dart';
import 'profiles_localization_ne.dart';
import 'profiles_localization_nl.dart';
import 'profiles_localization_pa.dart';
import 'profiles_localization_pl.dart';
import 'profiles_localization_ps.dart';
import 'profiles_localization_pt.dart';
import 'profiles_localization_ro.dart';
import 'profiles_localization_ru.dart';
import 'profiles_localization_si.dart';
import 'profiles_localization_sk.dart';
import 'profiles_localization_sw.dart';
import 'profiles_localization_ta.dart';
import 'profiles_localization_te.dart';
import 'profiles_localization_th.dart';
import 'profiles_localization_tl.dart';
import 'profiles_localization_tr.dart';
import 'profiles_localization_uk.dart';
import 'profiles_localization_ur.dart';
import 'profiles_localization_uz.dart';
import 'profiles_localization_vi.dart';
import 'profiles_localization_zh.dart';
import 'profiles_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ProfilesLocalization
/// returned by `ProfilesLocalization.of(context)`.
///
/// Applications need to include `ProfilesLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'profiles/profiles_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ProfilesLocalization.localizationsDelegates,
///   supportedLocales: ProfilesLocalization.supportedLocales,
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
/// be consistent with the languages listed in the ProfilesLocalization.supportedLocales
/// property.
abstract class ProfilesLocalization {
  ProfilesLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ProfilesLocalization of(BuildContext context) {
    return Localizations.of<ProfilesLocalization>(
        context, ProfilesLocalization)!;
  }

  static const LocalizationsDelegate<ProfilesLocalization> delegate =
      _ProfilesLocalizationDelegate();

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

  /// Title for side menu section
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get chatDrawerTitle;

  /// Badge that indicates new profile
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get chatDrawerBadgeNew;

  /// Title for banner on side menu
  ///
  /// In en, this message translates to:
  /// **'Create your Health Record'**
  String get bannerTitle;

  /// Description for banner on side menu
  ///
  /// In en, this message translates to:
  /// **'At the end of your consultation, add your profile.'**
  String get bannerSubtitle;

  /// Title for banner on side menu for add more prfiles
  ///
  /// In en, this message translates to:
  /// **'Add more profiles'**
  String get bannerMoreProfilesTitle;

  /// Description for banner on side menu for add more profiles
  ///
  /// In en, this message translates to:
  /// **'Start a consultation for someone else to create their profile.'**
  String get bannerMoreProfilesSubtitle;

  /// Title for banner on side menu for anonymous user
  ///
  /// In en, this message translates to:
  /// **'Sign up to create your Health Record'**
  String get bannerSignUp;

  /// No description provided for @errorRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorRetryButton;

  /// Error snackbar shown when profile deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete profile'**
  String get dashboardDeleteError;

  /// Error snackbar shown when profile summary loading fails
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile summary'**
  String get dashboardSummaryLoadError;

  /// More menu item label to open full profile record
  ///
  /// In en, this message translates to:
  /// **'View Full Record'**
  String get dashboardMenuViewFullRecord;

  /// More menu item label to share profile
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get dashboardMenuShare;

  /// More menu item label to delete profile
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get dashboardMenuDelete;

  /// Health metric label for age
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get dashboardMetricAgeLabel;

  /// Health metric label for age as number
  ///
  /// In en, this message translates to:
  /// **'{value, plural, one{{value} year} other{{value} years}}'**
  String dashboardMetricAgeNumLabel(num value);

  /// Health metric label for weight
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get dashboardMetricWeightLabel;

  /// Health metric label for weight as number
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String dashboardMetricWeightNumLabel(num value);

  /// Health metric label for height
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get dashboardMetricHeightLabel;

  /// Health metric label for height as number
  ///
  /// In en, this message translates to:
  /// **'{value} cm'**
  String dashboardMetricHeightNumLabel(num value);

  /// Fallback text when metric data is missing
  ///
  /// In en, this message translates to:
  /// **'-'**
  String get dashboardMetricNotAvailable;

  /// Medical info row title for allergies
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get dashboardInfoAllergiesTitle;

  /// Medical info row title for chronic conditions
  ///
  /// In en, this message translates to:
  /// **'Chronic'**
  String get dashboardInfoChronicTitle;

  /// Medical info row title for medication
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get dashboardInfoMedicationTitle;

  /// Medical info row title for devices
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get dashboardInfoDevicesTitle;

  /// Navigation card label for consultations
  ///
  /// In en, this message translates to:
  /// **'Consultations'**
  String get dashboardNavigationConsultations;

  /// Navigation card label for documents
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get dashboardNavigationDocuments;

  /// No description provided for @dashboardDeleteRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Health Record?'**
  String get dashboardDeleteRecordTitle;

  /// No description provided for @dashboardDeleteRecordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove your health data and can’t be undone. You’ll lose the context we use to guide you.'**
  String get dashboardDeleteRecordSubtitle;

  /// No description provided for @dashboardDeleteRecordCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dashboardDeleteRecordCancel;

  /// No description provided for @dashboardDeleteRecordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get dashboardDeleteRecordConfirm;

  /// No description provided for @dashboardDeleteRecordLoading.
  ///
  /// In en, this message translates to:
  /// **'Deleting your health record...'**
  String get dashboardDeleteRecordLoading;

  /// No description provided for @dashboardDeleteRecordError.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete profile'**
  String get dashboardDeleteRecordError;

  /// No description provided for @dashboardDeleteRecordSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Health record deleted'**
  String get dashboardDeleteRecordSuccessTitle;

  /// No description provided for @dashboardDeleteRecordSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can create a new one anytime by chatting with the assistant.'**
  String get dashboardDeleteRecordSuccessSubtitle;

  /// No description provided for @dashboardDeleteRecordSuccessButton.
  ///
  /// In en, this message translates to:
  /// **'Return to Chat'**
  String get dashboardDeleteRecordSuccessButton;

  /// Title for screen with health records in edit mode
  ///
  /// In en, this message translates to:
  /// **'Editing'**
  String get dataEditingScreenTitle;

  /// Error message on failed load data
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile data'**
  String get dataFailedToLoadError;

  /// No description provided for @dataRecordSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes saved'**
  String get dataRecordSavedTitle;

  /// No description provided for @dataRecordSavedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your information has been successfully updated.'**
  String get dataRecordSavedSubtitle;

  /// No description provided for @dataRecordSavedButton.
  ///
  /// In en, this message translates to:
  /// **'Return to profile'**
  String get dataRecordSavedButton;

  /// No description provided for @dataRecordUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile data'**
  String get dataRecordUpdateError;

  /// No description provided for @dataRecordDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get dataRecordDiscardTitle;

  /// No description provided for @dataRecordDiscardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You made some changes to your profile. Save them before you go, or discard them.'**
  String get dataRecordDiscardSubtitle;

  /// No description provided for @dataRecordDiscardCancel.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get dataRecordDiscardCancel;

  /// No description provided for @dataRecordDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get dataRecordDiscardConfirm;

  /// No description provided for @dataRecordEditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get dataRecordEditTooltip;

  /// Tooltip for add record button
  ///
  /// In en, this message translates to:
  /// **'Add record'**
  String get dataRecordAddTag;

  /// Search field on consultations screen
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get consultationsSearch;

  /// Nothing was found
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get consultationsSearchEmpty;

  /// More menu item label to download document
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get documentsMenuDownload;

  /// More menu item label to share document
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get documentsMenuShare;

  /// More menu item label to delete document
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get documentsMenuDelete;

  /// Placeholder for empty documents list
  ///
  /// In en, this message translates to:
  /// **'No documents found'**
  String get documentsEmptyList;

  /// No description provided for @documentsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this document?'**
  String get documentsDeleteTitle;

  /// No description provided for @documentsDeleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This file will be permanently removed'**
  String get documentsDeleteSubtitle;

  /// No description provided for @documentsDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get documentsDeleteCancel;

  /// No description provided for @documentsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get documentsDeleteButton;

  /// No description provided for @documentsMoreActionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get documentsMoreActionsTooltip;

  /// No description provided for @profilesSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get profilesSearch;

  /// No description provided for @profilesEmptyList.
  ///
  /// In en, this message translates to:
  /// **'No profiles found'**
  String get profilesEmptyList;

  /// No description provided for @profilesViewMore.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get profilesViewMore;

  /// No description provided for @profilesMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get profilesMore;

  /// No description provided for @profilesAnnouncementTitle1.
  ///
  /// In en, this message translates to:
  /// **'Doctorina now remembers your health'**
  String get profilesAnnouncementTitle1;

  /// No description provided for @profilesAnnouncementSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Your consultations now build and update your Health Record automatically.'**
  String get profilesAnnouncementSubtitle1;

  /// No description provided for @profilesAnnouncementTitle2.
  ///
  /// In en, this message translates to:
  /// **'Your Health Record, your rules'**
  String get profilesAnnouncementTitle2;

  /// No description provided for @profilesAnnouncementSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'View, edit, or add symptoms, medications, history, or documents anytime.'**
  String get profilesAnnouncementSubtitle2;

  /// No description provided for @profilesAnnouncementTitle3.
  ///
  /// In en, this message translates to:
  /// **'Care for your whole family'**
  String get profilesAnnouncementTitle3;

  /// No description provided for @profilesAnnouncementSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Create a Health Record for your loved ones, your kids, parents, or partner.'**
  String get profilesAnnouncementSubtitle3;

  /// No description provided for @profilesAnnouncementTitle4.
  ///
  /// In en, this message translates to:
  /// **'Ready to save your Health Record?'**
  String get profilesAnnouncementTitle4;

  /// No description provided for @profilesAnnouncementSubtitle4.
  ///
  /// In en, this message translates to:
  /// **'After your consultation, tap “Add profile” to save it.'**
  String get profilesAnnouncementSubtitle4;

  /// No description provided for @profilesNextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get profilesNextButton;

  /// No description provided for @profilesStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start a consultation'**
  String get profilesStartButton;

  /// No description provided for @profilesLaterButton.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get profilesLaterButton;

  /// Кнопка «Закрыть» на диалогах успеха (сохранение / удаление профиля)
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get profileSuccessCloseButton;

  /// Заголовок шапки PDF-файла с медицинской картой пациента (без имени)
  ///
  /// In en, this message translates to:
  /// **'Health Record'**
  String get pdfHeaderTitle;

  /// Заголовок шапки PDF-файла с медицинской картой пациента, включая имя пациента
  ///
  /// In en, this message translates to:
  /// **'Health Record — {name}'**
  String pdfHeaderTitleWithName(String name);

  /// text button for show more text
  ///
  /// In en, this message translates to:
  /// **'...more'**
  String get expandableFieldMore;

  /// text button for show less text
  ///
  /// In en, this message translates to:
  /// **'...less'**
  String get expandableFieldLess;

  /// No description provided for @profiles_button_addnew.
  ///
  /// In en, this message translates to:
  /// **'Add new profile'**
  String get profiles_button_addnew;

  /// No description provided for @profiles_label_addnew.
  ///
  /// In en, this message translates to:
  /// **'Create a profile to save the details of this consultation.'**
  String get profiles_label_addnew;

  /// No description provided for @profiles_label_health_records_hint.
  ///
  /// In en, this message translates to:
  /// **'You can assess it anytime in your Health Records'**
  String get profiles_label_health_records_hint;

  /// No description provided for @profiles_label_keep_talking_hint.
  ///
  /// In en, this message translates to:
  /// **'If you have more questions about this or anything related, feel free to keep talking with me. I\'m here to help'**
  String get profiles_label_keep_talking_hint;

  /// No description provided for @profile_section_basic_title.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get profile_section_basic_title;

  /// No description provided for @profile_section_basic_name_label.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profile_section_basic_name_label;

  /// No description provided for @profile_section_basic_name_placeholder.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get profile_section_basic_name_placeholder;

  /// No description provided for @profile_section_basic_first_name_label.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get profile_section_basic_first_name_label;

  /// No description provided for @profile_section_basic_first_name_placeholder.
  ///
  /// In en, this message translates to:
  /// **'John'**
  String get profile_section_basic_first_name_placeholder;

  /// No description provided for @profile_section_basic_last_name_label.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get profile_section_basic_last_name_label;

  /// No description provided for @profile_section_basic_last_name_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Doe'**
  String get profile_section_basic_last_name_placeholder;

  /// No description provided for @profile_section_basic_sex_label.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get profile_section_basic_sex_label;

  /// No description provided for @profile_section_basic_sex_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Please select'**
  String get profile_section_basic_sex_placeholder;

  /// No description provided for @profile_section_basic_sex_options_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get profile_section_basic_sex_options_male;

  /// No description provided for @profile_section_basic_sex_options_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get profile_section_basic_sex_options_female;

  /// No description provided for @profile_section_basic_sex_options_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get profile_section_basic_sex_options_other;

  /// No description provided for @profile_section_basic_date_of_birth_label.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profile_section_basic_date_of_birth_label;

  /// No description provided for @profile_section_basic_date_of_birth_placeholder.
  ///
  /// In en, this message translates to:
  /// **'YYYY-MM-DD'**
  String get profile_section_basic_date_of_birth_placeholder;

  /// No description provided for @profile_section_basic_age_str_label.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get profile_section_basic_age_str_label;

  /// No description provided for @profile_section_basic_age_str_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 30'**
  String get profile_section_basic_age_str_placeholder;

  /// No description provided for @profile_section_basic_phonenumber_label.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get profile_section_basic_phonenumber_label;

  /// No description provided for @profile_section_basic_phonenumber_placeholder.
  ///
  /// In en, this message translates to:
  /// **'+xxx xxx xxx xxx'**
  String get profile_section_basic_phonenumber_placeholder;

  /// No description provided for @profile_section_basic_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profile_section_basic_email_label;

  /// No description provided for @profile_section_basic_email_placeholder.
  ///
  /// In en, this message translates to:
  /// **'example@example.com'**
  String get profile_section_basic_email_placeholder;

  /// No description provided for @profile_section_basic_location_label.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get profile_section_basic_location_label;

  /// No description provided for @profile_section_basic_location_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. City, Country'**
  String get profile_section_basic_location_placeholder;

  /// No description provided for @profile_section_body_diet_title.
  ///
  /// In en, this message translates to:
  /// **'Body & Diet'**
  String get profile_section_body_diet_title;

  /// No description provided for @profile_section_body_diet_height_str_label.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get profile_section_body_diet_height_str_label;

  /// No description provided for @profile_section_body_diet_height_str_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 180 cm'**
  String get profile_section_body_diet_height_str_placeholder;

  /// No description provided for @profile_section_body_diet_weight_str_label.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get profile_section_body_diet_weight_str_label;

  /// No description provided for @profile_section_body_diet_weight_str_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 75 kg'**
  String get profile_section_body_diet_weight_str_placeholder;

  /// No description provided for @profile_section_body_diet_menstrual_cycle_label.
  ///
  /// In en, this message translates to:
  /// **'Menstrual Cycle'**
  String get profile_section_body_diet_menstrual_cycle_label;

  /// No description provided for @profile_section_body_diet_menstrual_cycle_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Regular, Irregular'**
  String get profile_section_body_diet_menstrual_cycle_placeholder;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_label.
  ///
  /// In en, this message translates to:
  /// **'Dietary Restrictions'**
  String get profile_section_body_diet_dietary_restrictions_label;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Please select'**
  String get profile_section_body_diet_dietary_restrictions_placeholder;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_hint.
  ///
  /// In en, this message translates to:
  /// **'Let us know what you eat and any restrictions you have'**
  String get profile_section_body_diet_dietary_restrictions_hint;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get profile_section_body_diet_dietary_restrictions_options_none;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get profile_section_body_diet_dietary_restrictions_options_vegetarian;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get profile_section_body_diet_dietary_restrictions_options_vegan;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_gluten_free.
  ///
  /// In en, this message translates to:
  /// **'Gluten Free'**
  String get profile_section_body_diet_dietary_restrictions_options_gluten_free;

  /// No description provided for @profile_section_body_diet_bmi_label.
  ///
  /// In en, this message translates to:
  /// **'Body Mass Index (BMI)'**
  String get profile_section_body_diet_bmi_label;

  /// No description provided for @profile_section_body_diet_bmi_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. 24.5'**
  String get profile_section_body_diet_bmi_placeholder;

  /// No description provided for @profile_section_health_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Health Profile'**
  String get profile_section_health_profile_title;

  /// No description provided for @profile_section_health_profile_chronic_illnesses_label.
  ///
  /// In en, this message translates to:
  /// **'Chronic Illnesses'**
  String get profile_section_health_profile_chronic_illnesses_label;

  /// No description provided for @profile_section_health_profile_chronic_illnesses_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Diabetes Type 2 '**
  String get profile_section_health_profile_chronic_illnesses_placeholder;

  /// No description provided for @profile_section_health_profile_chronic_illnesses_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list all chronic diseases and include when they were diagnosed and any complications.'**
  String get profile_section_health_profile_chronic_illnesses_hint;

  /// No description provided for @profile_section_health_profile_past_illnesses_label.
  ///
  /// In en, this message translates to:
  /// **'Past Illnesses'**
  String get profile_section_health_profile_past_illnesses_label;

  /// No description provided for @profile_section_health_profile_past_illnesses_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Frequent common cold'**
  String get profile_section_health_profile_past_illnesses_placeholder;

  /// No description provided for @profile_section_health_profile_past_illnesses_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list serious illnesses you had in the past, even if you recovered.'**
  String get profile_section_health_profile_past_illnesses_hint;

  /// No description provided for @profile_section_health_profile_surgical_history_label.
  ///
  /// In en, this message translates to:
  /// **'Surgical History'**
  String get profile_section_health_profile_surgical_history_label;

  /// No description provided for @profile_section_health_profile_surgical_history_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Appendectomy'**
  String get profile_section_health_profile_surgical_history_placeholder;

  /// No description provided for @profile_section_health_profile_surgical_history_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list all surgeries and include the year and whether there were any complications.'**
  String get profile_section_health_profile_surgical_history_hint;

  /// No description provided for @profile_section_health_profile_occasional_medications_label.
  ///
  /// In en, this message translates to:
  /// **'Occasionally used Medications'**
  String get profile_section_health_profile_occasional_medications_label;

  /// No description provided for @profile_section_health_profile_occasional_medications_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ibuprofen '**
  String get profile_section_health_profile_occasional_medications_placeholder;

  /// No description provided for @profile_section_health_profile_occasional_medications_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list medications you take from time to time (for example: painkillers, allergy medications), including the dose and reason for use.'**
  String get profile_section_health_profile_occasional_medications_hint;

  /// No description provided for @profile_section_health_profile_regular_medications_label.
  ///
  /// In en, this message translates to:
  /// **'Regular Medications'**
  String get profile_section_health_profile_regular_medications_label;

  /// No description provided for @profile_section_health_profile_regular_medications_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Metformin '**
  String get profile_section_health_profile_regular_medications_placeholder;

  /// No description provided for @profile_section_health_profile_regular_medications_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list all medications you take regularly, including the name, dose, how many times per day you take it, and what condition it is for.'**
  String get profile_section_health_profile_regular_medications_hint;

  /// No description provided for @profile_section_health_profile_allergies_label.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get profile_section_health_profile_allergies_label;

  /// No description provided for @profile_section_health_profile_allergies_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Penicillin – causes rash'**
  String get profile_section_health_profile_allergies_placeholder;

  /// No description provided for @profile_section_health_profile_allergies_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list all allergies (medications, food, environmental), and describe what reaction you have (for example: rash, swelling, breathing problems).'**
  String get profile_section_health_profile_allergies_hint;

  /// No description provided for @profile_section_health_profile_special_conditions_label.
  ///
  /// In en, this message translates to:
  /// **'Special Conditions'**
  String get profile_section_health_profile_special_conditions_label;

  /// No description provided for @profile_section_health_profile_special_conditions_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Pregnancy, Disability'**
  String get profile_section_health_profile_special_conditions_placeholder;

  /// No description provided for @profile_section_health_profile_special_conditions_hint.
  ///
  /// In en, this message translates to:
  /// **'If you have any important medical conditions that doctors should always know about (for example: pregnancy, implanted devices, disabilities, anticoagulation therapy), please describe them. If none, you can leave this blank.'**
  String get profile_section_health_profile_special_conditions_hint;

  /// No description provided for @profile_section_health_profile_family_history_label.
  ///
  /// In en, this message translates to:
  /// **'Family History'**
  String get profile_section_health_profile_family_history_label;

  /// No description provided for @profile_section_health_profile_family_history_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Heart Disease, Cancer'**
  String get profile_section_health_profile_family_history_placeholder;

  /// No description provided for @profile_section_health_profile_family_history_hint.
  ///
  /// In en, this message translates to:
  /// **'Please describe important diseases in your family (for example: diabetes, hypertension, heart disease, cancer, genetic diseases) and specify which family member had the condition.'**
  String get profile_section_health_profile_family_history_hint;

  /// No description provided for @profile_section_health_profile_social_lifestyle_factors_label.
  ///
  /// In en, this message translates to:
  /// **'Social & Lifestyle Factors'**
  String get profile_section_health_profile_social_lifestyle_factors_label;

  /// No description provided for @profile_section_health_profile_social_lifestyle_factors_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Smoking, Alcohol consumption'**
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder;

  /// No description provided for @profile_section_health_profile_social_lifestyle_factors_hint.
  ///
  /// In en, this message translates to:
  /// **'Please describe lifestyle factors that can affect your health, such as smoking, alcohol, physical activity, diet, sleep, and occupation.'**
  String get profile_section_health_profile_social_lifestyle_factors_hint;

  /// No description provided for @profile_section_health_profile_devices_label.
  ///
  /// In en, this message translates to:
  /// **'Medical Devices'**
  String get profile_section_health_profile_devices_label;

  /// No description provided for @profile_section_health_profile_devices_placeholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Pacemaker, Hearing aid, Insulin pump'**
  String get profile_section_health_profile_devices_placeholder;

  /// No description provided for @profile_section_health_profile_devices_hint.
  ///
  /// In en, this message translates to:
  /// **'Please list any medical devices you use or have implanted, such as pacemakers, insulin pumps, hearing aids, prosthetics, or other assistive or monitoring devices. Include relevant details if applicable.'**
  String get profile_section_health_profile_devices_hint;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_omnivorous.
  ///
  /// In en, this message translates to:
  /// **'Omnivorous'**
  String get profile_section_body_diet_dietary_restrictions_options_omnivorous;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_fast_food.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get profile_section_body_diet_dietary_restrictions_options_fast_food;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_pescatarian.
  ///
  /// In en, this message translates to:
  /// **'Pescatarian'**
  String get profile_section_body_diet_dietary_restrictions_options_pescatarian;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_lactose_free.
  ///
  /// In en, this message translates to:
  /// **'Lactose-Free'**
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_low_sodium.
  ///
  /// In en, this message translates to:
  /// **'Low-sodium diet'**
  String get profile_section_body_diet_dietary_restrictions_options_low_sodium;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_low_sugar.
  ///
  /// In en, this message translates to:
  /// **'Low-sugar diet'**
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_cardiac.
  ///
  /// In en, this message translates to:
  /// **'Cardiac diet'**
  String get profile_section_body_diet_dietary_restrictions_options_cardiac;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_renal.
  ///
  /// In en, this message translates to:
  /// **'Renal diet'**
  String get profile_section_body_diet_dietary_restrictions_options_renal;

  /// No description provided for @profile_section_body_diet_dietary_restrictions_options_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get profile_section_body_diet_dietary_restrictions_options_other;
}

class _ProfilesLocalizationDelegate
    extends LocalizationsDelegate<ProfilesLocalization> {
  const _ProfilesLocalizationDelegate();

  @override
  Future<ProfilesLocalization> load(Locale locale) {
    return SynchronousFuture<ProfilesLocalization>(
        lookupProfilesLocalization(locale));
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
  bool shouldReload(_ProfilesLocalizationDelegate old) => false;
}

ProfilesLocalization lookupProfilesLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return ProfilesLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return ProfilesLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return ProfilesLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return ProfilesLocalizationZhCn();
          case 'HK':
            return ProfilesLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return ProfilesLocalizationAf();
    case 'am':
      return ProfilesLocalizationAm();
    case 'ar':
      return ProfilesLocalizationAr();
    case 'az':
      return ProfilesLocalizationAz();
    case 'be':
      return ProfilesLocalizationBe();
    case 'bg':
      return ProfilesLocalizationBg();
    case 'bn':
      return ProfilesLocalizationBn();
    case 'ca':
      return ProfilesLocalizationCa();
    case 'cs':
      return ProfilesLocalizationCs();
    case 'da':
      return ProfilesLocalizationDa();
    case 'de':
      return ProfilesLocalizationDe();
    case 'el':
      return ProfilesLocalizationEl();
    case 'en':
      return ProfilesLocalizationEn();
    case 'es':
      return ProfilesLocalizationEs();
    case 'fa':
      return ProfilesLocalizationFa();
    case 'fr':
      return ProfilesLocalizationFr();
    case 'gu':
      return ProfilesLocalizationGu();
    case 'he':
      return ProfilesLocalizationHe();
    case 'hi':
      return ProfilesLocalizationHi();
    case 'hu':
      return ProfilesLocalizationHu();
    case 'id':
      return ProfilesLocalizationId();
    case 'it':
      return ProfilesLocalizationIt();
    case 'ja':
      return ProfilesLocalizationJa();
    case 'kk':
      return ProfilesLocalizationKk();
    case 'km':
      return ProfilesLocalizationKm();
    case 'kn':
      return ProfilesLocalizationKn();
    case 'ko':
      return ProfilesLocalizationKo();
    case 'lo':
      return ProfilesLocalizationLo();
    case 'ml':
      return ProfilesLocalizationMl();
    case 'mr':
      return ProfilesLocalizationMr();
    case 'ms':
      return ProfilesLocalizationMs();
    case 'my':
      return ProfilesLocalizationMy();
    case 'ne':
      return ProfilesLocalizationNe();
    case 'nl':
      return ProfilesLocalizationNl();
    case 'pa':
      return ProfilesLocalizationPa();
    case 'pl':
      return ProfilesLocalizationPl();
    case 'ps':
      return ProfilesLocalizationPs();
    case 'pt':
      return ProfilesLocalizationPt();
    case 'ro':
      return ProfilesLocalizationRo();
    case 'ru':
      return ProfilesLocalizationRu();
    case 'si':
      return ProfilesLocalizationSi();
    case 'sk':
      return ProfilesLocalizationSk();
    case 'sw':
      return ProfilesLocalizationSw();
    case 'ta':
      return ProfilesLocalizationTa();
    case 'te':
      return ProfilesLocalizationTe();
    case 'th':
      return ProfilesLocalizationTh();
    case 'tl':
      return ProfilesLocalizationTl();
    case 'tr':
      return ProfilesLocalizationTr();
    case 'uk':
      return ProfilesLocalizationUk();
    case 'ur':
      return ProfilesLocalizationUr();
    case 'uz':
      return ProfilesLocalizationUz();
    case 'vi':
      return ProfilesLocalizationVi();
    case 'zh':
      return ProfilesLocalizationZh();
    case 'zu':
      return ProfilesLocalizationZu();
  }

  throw FlutterError(
      'ProfilesLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
