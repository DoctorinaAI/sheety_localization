// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class ProfilesLocalizationBn extends ProfilesLocalization {
  ProfilesLocalizationBn([String locale = 'bn']) : super(locale);

  @override
  String get chatDrawerTitle => 'স্বাস্থ্য রেকর্ড';

  @override
  String get chatDrawerBadgeNew => 'নতুন';

  @override
  String get bannerTitle => 'আপনার স্বাস্থ্য রেকর্ড তৈরি করুন';

  @override
  String get bannerSubtitle => 'আপনার পরামর্শের শেষে, আপনার প্রোফাইল যোগ করুন।';

  @override
  String get bannerMoreProfilesTitle => 'আরও প্রোফাইল যোগ করুন';

  @override
  String get bannerMoreProfilesSubtitle =>
      'অন্যের জন্য পরামর্শ শুরু করুন যাতে তাদের প্রোফাইল তৈরি করা যায়।';

  @override
  String get bannerSignUp => 'আপনার স্বাস্থ্য রেকর্ড তৈরি করতে সাইন আপ করুন';

  @override
  String get errorRetryButton => 'পুনরায় চেষ্টা করুন';

  @override
  String get dashboardDeleteError => 'প্রোফাইল মুছতে ব্যর্থ';

  @override
  String get dashboardSummaryLoadError => 'প্রোফাইল সারাংশ লোড করতে ব্যর্থ';

  @override
  String get dashboardMenuViewFullRecord => 'সম্পূর্ণ রেকর্ড দেখুন';

  @override
  String get dashboardMenuShare => 'শেয়ার';

  @override
  String get dashboardMenuDelete => 'মুছুন';

  @override
  String get dashboardMetricAgeLabel => 'বয়স';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value বছর',
      one: '$value বছর',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'ওজন';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'উচ্চতা';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value সেমি';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'অ্যালার্জি';

  @override
  String get dashboardInfoChronicTitle => 'ক্রনিক';

  @override
  String get dashboardInfoMedicationTitle => 'ঔষধ';

  @override
  String get dashboardInfoDevicesTitle => 'ডিভাইস';

  @override
  String get dashboardNavigationConsultations => 'পরামর্শ';

  @override
  String get dashboardNavigationDocuments => 'নথি';

  @override
  String get dashboardDeleteRecordTitle => 'স্বাস্থ্য রেকর্ড মুছে ফেলবেন?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'এটি আপনার স্বাস্থ্য তথ্য স্থায়ীভাবে মুছে ফেলবে এবং এটি পূর্বাবস্থায় ফিরিয়ে আনা যাবে না। আপনি আমাদের আপনাকে নির্দেশনা দিতে ব্যবহৃত প্রেক্ষাপট হারাবেন।';

  @override
  String get dashboardDeleteRecordCancel => 'বাতিল';

  @override
  String get dashboardDeleteRecordConfirm => 'মুছে ফেলুন';

  @override
  String get dashboardDeleteRecordLoading =>
      'আপনার স্বাস্থ্য রেকর্ড মুছে ফেলা হচ্ছে...';

  @override
  String get dashboardDeleteRecordError => 'প্রোফাইল মুছতে ব্যর্থ';

  @override
  String get dashboardDeleteRecordSuccessTitle =>
      'স্বাস্থ্য রেকর্ড মুছে ফেলা হয়েছে';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'আপনি যেকোনো সময় সহকারীর সাথে চ্যাট করে একটি নতুন তৈরি করতে পারেন।';

  @override
  String get dashboardDeleteRecordSuccessButton => 'চ্যাটে ফিরে যান';

  @override
  String get dataEditingScreenTitle => 'সম্পাদনা';

  @override
  String get dataFailedToLoadError => 'প্রোফাইল ডেটা লোড করতে ব্যর্থ';

  @override
  String get dataRecordSavedTitle => 'পরিবর্তনগুলি সংরক্ষিত হয়েছে';

  @override
  String get dataRecordSavedSubtitle => 'আপনার তথ্য সফলভাবে আপডেট করা হয়েছে।';

  @override
  String get dataRecordSavedButton => 'প্রোফাইলে ফিরে যান';

  @override
  String get dataRecordUpdateError => 'প্রোফাইল ডেটা আপডেট করতে ব্যর্থ';

  @override
  String get dataRecordDiscardTitle => 'পরিবর্তনগুলি বাতিল করবেন?';

  @override
  String get dataRecordDiscardSubtitle =>
      'আপনি আপনার প্রোফাইলে কিছু পরিবর্তন করেছেন। যাওয়ার আগে সেগুলি সংরক্ষণ করুন, অথবা বাতিল করুন।';

  @override
  String get dataRecordDiscardCancel => 'সম্পাদনা চালিয়ে যান';

  @override
  String get dataRecordDiscardConfirm => 'বাতিল করুন';

  @override
  String get dataRecordEditTooltip => 'সম্পাদনা';

  @override
  String get dataRecordAddTag => 'রেকর্ড যোগ করুন';

  @override
  String get consultationsSearch => 'অনুসন্ধান';

  @override
  String get consultationsSearchEmpty => 'কোন ফলাফল পাওয়া যায়নি';

  @override
  String get documentsMenuDownload => 'ডাউনলোড';

  @override
  String get documentsMenuShare => 'শেয়ার';

  @override
  String get documentsMenuDelete => 'মুছুন';

  @override
  String get documentsEmptyList => 'কোনো নথি পাওয়া যায়নি';

  @override
  String get documentsDeleteTitle => 'এই নথিটি মুছে ফেলতে চান?';

  @override
  String get documentsDeleteSubtitle => 'এই ফাইলটি স্থায়ীভাবে মুছে ফেলা হবে';

  @override
  String get documentsDeleteCancel => 'বাতিল';

  @override
  String get documentsDeleteButton => 'মুছে ফেলুন';

  @override
  String get documentsMoreActionsTooltip => 'আরও অ্যাকশন';

  @override
  String get profilesSearch => 'অনুসন্ধান';

  @override
  String get profilesEmptyList => 'কোনো প্রোফাইল পাওয়া যায়নি';

  @override
  String get profilesViewMore => 'আরও দেখুন';

  @override
  String get profilesMore => 'আরও';

  @override
  String get profilesAnnouncementTitle1 =>
      'ডক্টরিনা এখন আপনার স্বাস্থ্য মনে রাখে';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'আপনার পরামর্শগুলি এখন স্বয়ংক্রিয়ভাবে আপনার স্বাস্থ্য রেকর্ড তৈরি এবং আপডেট করে।';

  @override
  String get profilesAnnouncementTitle2 =>
      'আপনার স্বাস্থ্য রেকর্ড, আপনার নিয়ম';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'কোনও সময়ে লক্ষণ, ওষুধ, ইতিহাস বা নথি দেখুন, সম্পাদনা করুন বা যোগ করুন।';

  @override
  String get profilesAnnouncementTitle3 => 'আপনার পুরো পরিবারের যত্ন নিন';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'আপনার প্রিয়জন, আপনার সন্তান, বাবা-মা বা সঙ্গীর জন্য একটি স্বাস্থ্য রেকর্ড তৈরি করুন।';

  @override
  String get profilesAnnouncementTitle4 =>
      'আপনার স্বাস্থ্য রেকর্ড সংরক্ষণের জন্য প্রস্তুত?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'আপনার পরামর্শের পরে, এটি সংরক্ষণ করতে \"প্রোফাইল যোগ করুন\" ট্যাপ করুন।';

  @override
  String get profilesNextButton => 'পরবর্তী';

  @override
  String get profilesStartButton => 'একটি পরামর্শ শুরু করুন';

  @override
  String get profilesLaterButton => 'পরে হয়তো';

  @override
  String get profileSuccessCloseButton => 'বন্ধ করুন';

  @override
  String get pdfHeaderTitle => 'স্বাস্থ্য রেকর্ড';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'স্বাস্থ্য রেকর্ড — $name';
  }

  @override
  String get expandableFieldMore => '...আরও';

  @override
  String get expandableFieldLess => '...কম';

  @override
  String get profiles_button_addnew => 'নতুন প্রোফাইল যোগ করুন';

  @override
  String get profiles_label_addnew =>
      'এই পরামর্শের বিস্তারিত তথ্য সংরক্ষণ করতে একটি প্রোফাইল তৈরি করুন।';

  @override
  String get profiles_label_health_records_hint =>
      'আপনি এটি যে কোনো সময় আপনার Health Records-এ অ্যাক্সেস করতে পারবেন';

  @override
  String get profiles_label_keep_talking_hint =>
      'যদি এ সম্পর্কে বা এ সংক্রান্ত যেকোনো বিষয়ে আপনার আরও প্রশ্ন থাকে, বিনা দ্বিধায় আমার সঙ্গে কথা বলতে থাকুন। আমি সাহায্য করার জন্য এখানে আছি';

  @override
  String get profile_section_basic_title => 'সাধারণ তথ্য';

  @override
  String get profile_section_basic_name_label => 'নাম';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'প্রথম নাম';

  @override
  String get profile_section_basic_first_name_placeholder => 'জন';

  @override
  String get profile_section_basic_last_name_label => 'নামের শেষাংশ';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'লিঙ্গ';

  @override
  String get profile_section_basic_sex_placeholder =>
      'অনুগ্রহ করে নির্বাচন করুন';

  @override
  String get profile_section_basic_sex_options_male => 'পুরুষ';

  @override
  String get profile_section_basic_sex_options_female => 'নারী';

  @override
  String get profile_section_basic_sex_options_other => 'অন্যান্য';

  @override
  String get profile_section_basic_date_of_birth_label => 'জন্ম তারিখ';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'বয়স';

  @override
  String get profile_section_basic_age_str_placeholder => 'যেমন 30';

  @override
  String get profile_section_basic_phonenumber_label => 'ফোন নম্বর';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'ইমেল';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'অবস্থান';

  @override
  String get profile_section_basic_location_placeholder => 'যেমন শহর, দেশ';

  @override
  String get profile_section_body_diet_title => 'শরীর & খাদ্য';

  @override
  String get profile_section_body_diet_height_str_label => 'উচ্চতা';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'যেমন 180 সেমি';

  @override
  String get profile_section_body_diet_weight_str_label => 'ওজন';

  @override
  String get profile_section_body_diet_weight_str_placeholder =>
      'উদাহরণ: 75 কেজি';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => 'মাসিক চক্র';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'যেমন: নিয়মিত, অনিয়মিত';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'খাদ্যগত সীমাবদ্ধতা';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'অনুগ্রহ করে নির্বাচন করুন';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'আপনি কী খান এবং আপনার কোনো সীমাবদ্ধতা আছে কি তা আমাদের জানান';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'কোনোটাই নেই';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'শাকাহারী';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'ভেগান';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'গ্লুটেন মুক্ত';

  @override
  String get profile_section_body_diet_bmi_label => 'শরীরের ভর সূচক (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'যেমন 24.5';

  @override
  String get profile_section_health_profile_title => 'স্বাস্থ্য প্রোফাইল';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'দীর্ঘস্থায়ী রোগ';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'যেমন: টাইপ ২ ডায়াবেটিস';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'দয়া করে সমস্ত দীর্ঘস্থায়ী রোগের তালিকা করুন এবং কখন সেগুলি নির্ণয় করা হয়েছিল এবং কোনও জটিলতা অন্তর্ভুক্ত করুন।';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'পূর্ববর্তী অসুস্থতা';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'যেমন: ঘন ঘন সাধারণ সর্দি';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'আপনি যে গুরুতর রোগগুলি অতীতে ভুগেছেন সেগুলি তালিকাভুক্ত করুন, এমনকি আপনি সুস্থ হয়ে উঠলেও।';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'অস্ত্রোপচারের ইতিহাস';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'যেমন অ্যাপেনডেকটমি';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'সমস্ত সার্জারি তালিকাভুক্ত করুন এবং বছর এবং কোনও জটিলতা ছিল কিনা তা অন্তর্ভুক্ত করুন।';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'কখনও কখনও ব্যবহৃত ওষুধ';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'যেমন: আইবুপ্রোফেন';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'আপনি কখনও কখনও যে ওষুধগুলি নেন (যেমন: ব্যথানাশক, অ্যালার্জির ওষুধ) সেগুলি, ডোজ এবং ব্যবহারের কারণ সহ তালিকাভুক্ত করুন';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'নিয়মিত ওষুধ';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'যেমন: মেটফর্মিন';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'আপনি নিয়মিত যে সমস্ত ওষুধ গ্রহণ করেন, তার নাম, ডোজ, দিনে কতবার গ্রহণ করেন এবং এটি কোন অবস্থার জন্য তা তালিকাভুক্ত করুন';

  @override
  String get profile_section_health_profile_allergies_label => 'অ্যালার্জি';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'যেমন: পেনিসিলিন – র্যাশ সৃষ্টি করে';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'সমস্ত অ্যালার্জি (ওষুধ, খাবার, পরিবেশ) তালিকাভুক্ত করুন এবং আপনি কী ধরনের প্রতিক্রিয়া দেখান তা বর্ণনা করুন (যেমন: র্যাশ, ফোলা, শ্বাসকষ্ট)।';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'বিশেষ অবস্থা';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'যেমন গর্ভাবস্থা, প্রতিবন্ধতা';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'যদি আপনার কোনো গুরুত্বপূর্ণ চিকিৎসা অবস্থান থাকে যা ডাক্তারদের সর্বদা জানা উচিত (যেমন: গর্ভাবস্থা, প্রতিস্থাপিত ডিভাইস, অক্ষমতা, অ্যান্টিকোঅ্যাগুলেশন থেরাপি), দয়া করে সেগুলি বর্ণনা করুন। যদি না থাকে, আপনি এটি খালি রাখতে পারেন।';

  @override
  String get profile_section_health_profile_family_history_label =>
      'পারিবারিক ইতিহাস';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'উদাহরণ: হৃদরোগ, ক্যান্সার';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'আপনার পরিবারের গুরুত্বপূর্ণ রোগগুলি বর্ণনা করুন (যেমন: ডায়াবেটিস, উচ্চ রক্তচাপ, হৃদরোগ, ক্যান্সার, জেনেটিক রোগ) এবং নির্দিষ্ট করুন কোন পরিবারের সদস্যের এই অবস্থাটি ছিল।';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'সামাজিক & জীবনধারা উপাদানসমূহ';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'যেমন: ধূমপান, মদ্যপান';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'আপনার স্বাস্থ্যের উপর প্রভাব ফেলতে পারে এমন জীবনযাত্রার উপাদানগুলি বর্ণনা করুন, যেমন ধূমপান, মদ্যপান, শারীরিক কার্যকলাপ, খাদ্য, ঘুম এবং পেশা।';

  @override
  String get profile_section_health_profile_devices_label =>
      'চিকিৎসা যন্ত্রপাতি';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'যেমন পেসমেকার, শ্রবণ সহায়ক, ইনসুলিন পাম্প';

  @override
  String get profile_section_health_profile_devices_hint =>
      'আপনি যে কোনও চিকিৎসা ডিভাইস ব্যবহার করেন বা প্রতিস্থাপন করেছেন, যেমন পেসমেকার, ইনসুলিন পাম্প, শ্রবণযন্ত্র, প্রতিস্থাপন বা অন্যান্য সহায়ক বা পর্যবেক্ষণ ডিভাইসের তালিকা করুন। প্রযোজ্য হলে প্রাসঙ্গিক বিবরণ অন্তর্ভুক্ত করুন।';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'সর্বাহারী';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'ফাস্ট ফুড';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'পেস্কাটেরিয়ান';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'ল্যাকটোজ-মুক্ত';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'কম সোডিয়াম আহার';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'কম চিনি ডায়েট';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'হৃদরোগের খাদ্য';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'কিডনি ডায়েট';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'অন্যান্য';
}
