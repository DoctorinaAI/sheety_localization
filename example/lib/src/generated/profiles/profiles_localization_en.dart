// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ProfilesLocalizationEn extends ProfilesLocalization {
  ProfilesLocalizationEn([String locale = 'en']) : super(locale);

  @override
  String get chatDrawerTitle => 'Health Records';

  @override
  String get chatDrawerBadgeNew => 'NEW';

  @override
  String get bannerTitle => 'Create your Health Record';

  @override
  String get bannerSubtitle =>
      'At the end of your consultation, add your profile.';

  @override
  String get bannerMoreProfilesTitle => 'Add more profiles';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Start a consultation for someone else to create their profile.';

  @override
  String get bannerSignUp => 'Sign up to create your Health Record';

  @override
  String get errorRetryButton => 'Retry';

  @override
  String get dashboardDeleteError => 'Failed to delete profile';

  @override
  String get dashboardSummaryLoadError => 'Failed to load profile summary';

  @override
  String get dashboardMenuViewFullRecord => 'View Full Record';

  @override
  String get dashboardMenuShare => 'Share';

  @override
  String get dashboardMenuDelete => 'Delete';

  @override
  String get dashboardMetricAgeLabel => 'Age';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value years',
      one: '$value year',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Weight';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Height';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'Allergies';

  @override
  String get dashboardInfoChronicTitle => 'Chronic';

  @override
  String get dashboardInfoMedicationTitle => 'Medication';

  @override
  String get dashboardInfoDevicesTitle => 'Devices';

  @override
  String get dashboardNavigationConsultations => 'Consultations';

  @override
  String get dashboardNavigationDocuments => 'Documents';

  @override
  String get dashboardDeleteRecordTitle => 'Delete Health Record?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'This will permanently remove your health data and can’t be undone. You’ll lose the context we use to guide you.';

  @override
  String get dashboardDeleteRecordCancel => 'Cancel';

  @override
  String get dashboardDeleteRecordConfirm => 'Delete';

  @override
  String get dashboardDeleteRecordLoading => 'Deleting your health record...';

  @override
  String get dashboardDeleteRecordError => 'Failed to delete profile';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Health record deleted';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'You can create a new one anytime by chatting with the assistant.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Return to Chat';

  @override
  String get dataEditingScreenTitle => 'Editing';

  @override
  String get dataFailedToLoadError => 'Failed to load profile data';

  @override
  String get dataRecordSavedTitle => 'Changes saved';

  @override
  String get dataRecordSavedSubtitle =>
      'Your information has been successfully updated.';

  @override
  String get dataRecordSavedButton => 'Return to profile';

  @override
  String get dataRecordUpdateError => 'Failed to update profile data';

  @override
  String get dataRecordDiscardTitle => 'Discard changes?';

  @override
  String get dataRecordDiscardSubtitle =>
      'You made some changes to your profile. Save them before you go, or discard them.';

  @override
  String get dataRecordDiscardCancel => 'Keep editing';

  @override
  String get dataRecordDiscardConfirm => 'Discard';

  @override
  String get dataRecordEditTooltip => 'Edit';

  @override
  String get dataRecordAddTag => 'Add record';

  @override
  String get consultationsSearch => 'Search';

  @override
  String get consultationsSearchEmpty => 'No results found';

  @override
  String get documentsMenuDownload => 'Download';

  @override
  String get documentsMenuShare => 'Share';

  @override
  String get documentsMenuDelete => 'Delete';

  @override
  String get documentsEmptyList => 'No documents found';

  @override
  String get documentsDeleteTitle => 'Delete this document?';

  @override
  String get documentsDeleteSubtitle => 'This file will be permanently removed';

  @override
  String get documentsDeleteCancel => 'Cancel';

  @override
  String get documentsDeleteButton => 'Delete';

  @override
  String get documentsMoreActionsTooltip => 'More actions';

  @override
  String get profilesSearch => 'Search';

  @override
  String get profilesEmptyList => 'No profiles found';

  @override
  String get profilesViewMore => 'View more';

  @override
  String get profilesMore => 'More';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina now remembers your health';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Your consultations now build and update your Health Record automatically.';

  @override
  String get profilesAnnouncementTitle2 => 'Your Health Record, your rules';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'View, edit, or add symptoms, medications, history, or documents anytime.';

  @override
  String get profilesAnnouncementTitle3 => 'Care for your whole family';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Create a Health Record for your loved ones, your kids, parents, or partner.';

  @override
  String get profilesAnnouncementTitle4 => 'Ready to save your Health Record?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'After your consultation, tap “Add profile” to save it.';

  @override
  String get profilesNextButton => 'Next';

  @override
  String get profilesStartButton => 'Start a consultation';

  @override
  String get profilesLaterButton => 'Maybe later';

  @override
  String get profileSuccessCloseButton => 'Close';

  @override
  String get pdfHeaderTitle => 'Health Record';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Health Record — $name';
  }

  @override
  String get expandableFieldMore => '...more';

  @override
  String get expandableFieldLess => '...less';

  @override
  String get profiles_button_addnew => 'Add new profile';

  @override
  String get profiles_label_addnew =>
      'Create a profile to save the details of this consultation.';

  @override
  String get profiles_label_health_records_hint =>
      'You can assess it anytime in your Health Records';

  @override
  String get profiles_label_keep_talking_hint =>
      'If you have more questions about this or anything related, feel free to keep talking with me. I\'m here to help';

  @override
  String get profile_section_basic_title => 'General Information';

  @override
  String get profile_section_basic_name_label => 'Name';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'First name';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => 'Last name';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Sex';

  @override
  String get profile_section_basic_sex_placeholder => 'Please select';

  @override
  String get profile_section_basic_sex_options_male => 'Male';

  @override
  String get profile_section_basic_sex_options_female => 'Female';

  @override
  String get profile_section_basic_sex_options_other => 'Other';

  @override
  String get profile_section_basic_date_of_birth_label => 'Date of Birth';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Age';

  @override
  String get profile_section_basic_age_str_placeholder => 'e.g. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Phone number';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'Email';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Location';

  @override
  String get profile_section_basic_location_placeholder => 'e.g. City, Country';

  @override
  String get profile_section_body_diet_title => 'Body & Diet';

  @override
  String get profile_section_body_diet_height_str_label => 'Height';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'e.g. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Weight';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'e.g. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menstrual Cycle';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'e.g. Regular, Irregular';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Dietary Restrictions';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Please select';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Let us know what you eat and any restrictions you have';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'None';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetarian';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegan';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Gluten Free';

  @override
  String get profile_section_body_diet_bmi_label => 'Body Mass Index (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'e.g. 24.5';

  @override
  String get profile_section_health_profile_title => 'Health Profile';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Chronic Illnesses';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'e.g. Diabetes Type 2 ';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Please list all chronic diseases and include when they were diagnosed and any complications.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Past Illnesses';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'e.g. Frequent common cold';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Please list serious illnesses you had in the past, even if you recovered.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Surgical History';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'e.g. Appendectomy';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Please list all surgeries and include the year and whether there were any complications.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Occasionally used Medications';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'e.g. Ibuprofen ';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Please list medications you take from time to time (for example: painkillers, allergy medications), including the dose and reason for use.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Regular Medications';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'e.g. Metformin ';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Please list all medications you take regularly, including the name, dose, how many times per day you take it, and what condition it is for.';

  @override
  String get profile_section_health_profile_allergies_label => 'Allergies';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'e.g. Penicillin – causes rash';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Please list all allergies (medications, food, environmental), and describe what reaction you have (for example: rash, swelling, breathing problems).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Special Conditions';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'e.g. Pregnancy, Disability';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'If you have any important medical conditions that doctors should always know about (for example: pregnancy, implanted devices, disabilities, anticoagulation therapy), please describe them. If none, you can leave this blank.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Family History';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'e.g. Heart Disease, Cancer';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Please describe important diseases in your family (for example: diabetes, hypertension, heart disease, cancer, genetic diseases) and specify which family member had the condition.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Social & Lifestyle Factors';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'e.g. Smoking, Alcohol consumption';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Please describe lifestyle factors that can affect your health, such as smoking, alcohol, physical activity, diet, sleep, and occupation.';

  @override
  String get profile_section_health_profile_devices_label => 'Medical Devices';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'e.g. Pacemaker, Hearing aid, Insulin pump';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Please list any medical devices you use or have implanted, such as pacemakers, insulin pumps, hearing aids, prosthetics, or other assistive or monitoring devices. Include relevant details if applicable.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Omnivorous';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Fast Food';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescatarian';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Lactose-Free';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Low-sodium diet';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Low-sugar diet';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Cardiac diet';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Renal diet';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Other';
}
