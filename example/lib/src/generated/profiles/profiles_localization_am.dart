// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class ProfilesLocalizationAm extends ProfilesLocalization {
  ProfilesLocalizationAm([String locale = 'am']) : super(locale);

  @override
  String get chatDrawerTitle => 'የጤና መዝገቦች';

  @override
  String get chatDrawerBadgeNew => 'አዲስ';

  @override
  String get bannerTitle => 'የጤና መዝገብዎን ይፍጠሩ';

  @override
  String get bannerSubtitle => 'እባኮትን የእርዳታዎን መጨረሻ ላይ የእርስዎን መገኛ ያከብሩ።';

  @override
  String get bannerMoreProfilesTitle => 'ተጨማሪ ፕሮፋይሎች አክል';

  @override
  String get bannerMoreProfilesSubtitle => 'ለሌላ ሰው እንዲያወጣ የእርዳታ ሂደት ይጀምሩ.';

  @override
  String get bannerSignUp => 'የጤና መዝግብ ለማድረግ ይመዝገቡ';

  @override
  String get errorRetryButton => 'እንደገና ይሞክሩ';

  @override
  String get dashboardDeleteError => 'መገናኛ መረጃ ማጥፊያ አልተሳካም';

  @override
  String get dashboardSummaryLoadError => 'የፕሮፋይል ማጠቃለያ ማስታወቂያ አልተገኘም';

  @override
  String get dashboardMenuViewFullRecord => 'ሙሉ መዝገብ እይታ';

  @override
  String get dashboardMenuShare => 'አጋራ';

  @override
  String get dashboardMenuDelete => 'አጥፍ';

  @override
  String get dashboardMetricAgeLabel => 'እድሜ';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ዓመታት',
      one: '$value ዓመት',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'ክብደት';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value ኪ.ግ';
  }

  @override
  String get dashboardMetricHeightLabel => 'ከፍታ';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value ሴ.ሜ';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'አለምም';

  @override
  String get dashboardInfoChronicTitle => 'ክሮኒክ';

  @override
  String get dashboardInfoMedicationTitle => 'መድሃኒት';

  @override
  String get dashboardInfoDevicesTitle => 'መሣሪያዎች';

  @override
  String get dashboardNavigationConsultations => 'ኮንስልታሽን';

  @override
  String get dashboardNavigationDocuments => 'ሰነዶች';

  @override
  String get dashboardDeleteRecordTitle => 'የጤና መዝገብ ማጥፋት እባክዎት?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'ይህ የጤና ውሂብዎን በወይዘር ይሰርዝ እና አይታወቅም። እንደ እንደ መመሪያ የምንጠቀምበት አካል ይጠፋል።';

  @override
  String get dashboardDeleteRecordCancel => 'እንደገና ይቆም';

  @override
  String get dashboardDeleteRecordConfirm => 'አጥፍ';

  @override
  String get dashboardDeleteRecordLoading => 'የእንክብካቤ መዝገብዎን እንደሚሰርዝ...';

  @override
  String get dashboardDeleteRecordError => 'መግለጫ መረጃ ማጥፋት አልቻልኩም';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'የጤና መዝገብ ወይዘር ተሰርዟል';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'እባክዎ ከአስተያየት ጋር በመደወል አዲስ አንዱን መፍጠር ይችላሉ።';

  @override
  String get dashboardDeleteRecordSuccessButton => 'ወደ ውይይት ተመለስ';

  @override
  String get dataEditingScreenTitle => 'እንደ እንቅስቃሴ';

  @override
  String get dataFailedToLoadError => 'መገናኛ ውስጥ የማይገኝ መረጃ መግኘት አልቻልኩም';

  @override
  String get dataRecordSavedTitle => 'ለውጦች ተያይዞ ተያይዞ ተያይዞ';

  @override
  String get dataRecordSavedSubtitle => 'መረጃዎት በተሳካ ሁኔታ ተዘጋጅቷል።';

  @override
  String get dataRecordSavedButton => 'መገናኛ ወደ መገኛ ይመለሱ';

  @override
  String get dataRecordUpdateError => 'መገናኛ ውሂብ መረጃ ማዘመን አልቻልኩም';

  @override
  String get dataRecordDiscardTitle => 'ለውጦችን ይወድዱ?';

  @override
  String get dataRecordDiscardSubtitle =>
      'በመገለጫዎ ላይ አንዳንድ ለውጦችን አድርገዋል። ከመውጣትዎ በፊት ያስቀምጧቸው ወይም ይተዉአቸው።';

  @override
  String get dataRecordDiscardCancel => '`ማስተካከያውን ይቀጥሉ`';

  @override
  String get dataRecordDiscardConfirm => '`ተወው`';

  @override
  String get dataRecordEditTooltip => 'አርትዕ';

  @override
  String get dataRecordAddTag => 'መዝግብ ያክል';

  @override
  String get consultationsSearch => 'ፈልግ';

  @override
  String get consultationsSearchEmpty => 'የተገኙ ውጤቶች የለም';

  @override
  String get documentsMenuDownload => 'ዳውንሎድ';

  @override
  String get documentsMenuShare => 'አጋራ';

  @override
  String get documentsMenuDelete => 'አጥፍ';

  @override
  String get documentsEmptyList => 'ምንም ሰነዶች አልተገኙም';

  @override
  String get documentsDeleteTitle => '`ይህን ሰነድ ማጥፋት ይፈልጋሉ?`';

  @override
  String get documentsDeleteSubtitle => '`ይህ ፋይል ለዘላለም ይወገዳል።`';

  @override
  String get documentsDeleteCancel => 'እንደገና ይቆም';

  @override
  String get documentsDeleteButton => 'አጥፍ';

  @override
  String get documentsMoreActionsTooltip => 'ተጨማሪ እርምጃዎች';

  @override
  String get profilesSearch => 'ፈልግ';

  @override
  String get profilesEmptyList => 'ምንም መገለጫ አልተገኘም';

  @override
  String get profilesViewMore => 'ተጨማሪ ይመልከቱ';

  @override
  String get profilesMore => 'ተጨማሪ';

  @override
  String get profilesAnnouncementTitle1 => 'ዶክተሪና እንደ ጤናዎት ይወስዳል';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'የእርዳታዎችዎ አሁን የጤና መዝገብዎን በራስ ማዕከል ይገነባል እና ይዘው ይዘው ይዘው ይዘው.';

  @override
  String get profilesAnnouncementTitle2 => 'የእርግጥ መዝገብ፣ የእርስዎ ደንብ';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'ምርመራዎችን፣ መድሃኒቶችን፣ ታሪክን ወይም ሰነዶችን በየጊዜው ይመልከቱ፣ ይሻሽሉ ወይም ይጨምሩ።';

  @override
  String get profilesAnnouncementTitle3 => 'እርዳታ ለአንድ ቤተሰብ ሁሉ';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'የወዳጆችዎ ጤና መዝገብ ይፍጠሩ፣ ለልጆችዎ፣ እናቶችዎ፣ ወይም ባልዎ።';

  @override
  String get profilesAnnouncementTitle4 => 'የጤና መዝግብዎን ለመያዝ ዝግጁ ነው?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'ከኮንስልታሽንዎ በኋላ \"ፕሮፋይል አክስት\" ይጫኑ እንዲያውም ይቀመጡ።';

  @override
  String get profilesNextButton => 'ቀጣይ';

  @override
  String get profilesStartButton => 'ኮንስልታሽን ይጀምሩ';

  @override
  String get profilesLaterButton => 'አሁን አይደለም';

  @override
  String get profileSuccessCloseButton => 'ዝግጅት';

  @override
  String get pdfHeaderTitle => 'የጤና መዝገብ';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'ጤና መዝገብ — $name';
  }

  @override
  String get expandableFieldMore => '...በተጨማሪ';

  @override
  String get expandableFieldLess => '...አነሱ';

  @override
  String get profiles_button_addnew => 'አዲስ ፕሮፋይል አክል';

  @override
  String get profiles_label_addnew => 'አንድ ፕሮፋይል ይፍጠሩ እንደዚህ የምንኖር ዝርዝር ይቀመጡ.';

  @override
  String get profiles_label_health_records_hint =>
      'በእርስዎ የጤና መዝገቦች ውስጥ እሱን በማንኛውም ጊዜ ማየት ይችላሉ';

  @override
  String get profiles_label_keep_talking_hint =>
      'ይህ ወይም ከዚህ ጋር የተያያዘ ማንኛውም ጥያቄ ካለዎት, ከእኔ ጋር መቀጠል ነፃ ይችላሉ. እርዳታ ለማቅረብ እዚህ ነኝ';

  @override
  String get profile_section_basic_title => 'አጠቃላይ መረጃ';

  @override
  String get profile_section_basic_name_label => 'ስም';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'የመጀመሪያ ስም';

  @override
  String get profile_section_basic_first_name_placeholder => 'ዮሐንስ';

  @override
  String get profile_section_basic_last_name_label => 'የቤተሰብ ስም';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'ፆታ';

  @override
  String get profile_section_basic_sex_placeholder => 'እባክዎ ይምረጡ';

  @override
  String get profile_section_basic_sex_options_male => 'ወንድ';

  @override
  String get profile_section_basic_sex_options_female => 'ሴት';

  @override
  String get profile_section_basic_sex_options_other => 'ሌላ';

  @override
  String get profile_section_basic_date_of_birth_label => 'የትውልድ ቀን';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'ዕድሜ';

  @override
  String get profile_section_basic_age_str_placeholder => 'ለምሳሌ 30';

  @override
  String get profile_section_basic_phonenumber_label => 'ስልክ ቁጥር';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'ኢሜል';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'ቦታ';

  @override
  String get profile_section_basic_location_placeholder => 'ለምሳሌ ከተማ, አገር';

  @override
  String get profile_section_body_diet_title => 'ሰውነት & አመጋገብ';

  @override
  String get profile_section_body_diet_height_str_label => 'ቁመት';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'ለምሳሌ 180 ሴሜ';

  @override
  String get profile_section_body_diet_weight_str_label => 'ክብደት';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'ለምሳሌ 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menstrual Cycle';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'ለምሳሌ መደበኛ, የተለዋዋጭ';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'የምግብ ገደቦች';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'እባክዎን ይምረጡ';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'እባክዎን የምታይ ምግብ እና የሚከበሩ ነገሮች እንዲያውቁን እንደምን እንደምን ይነግሩን';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'የምግብ ገደብ የለም';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'ቬጂታሪያን';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'ቪጋን';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'የግሉቲን ነፃ';

  @override
  String get profile_section_body_diet_bmi_label => 'የአካል ብዛት መጠን (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'ለምሳሌ 24.5';

  @override
  String get profile_section_health_profile_title => 'Առողջության պրոֆիլ';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'ቋሚ ሕመሞች';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'የዳይባትስ ዓይነት 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'እባክዎ ሁሉንም የወቅታዊ ሕመሞች ይዘጋጁ እና የተወሰኑትን ወቅታዊ ሕመሞች እና የተከሰቱትን ይጨምሩ።';

  @override
  String get profile_section_health_profile_past_illnesses_label => 'ያለፉ ሕመሶች';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'እንደ አስቀድሞ የተከሰተ የተወሰነ የበሽታ ዝርዝር';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'እባክዎ በአስቀድሞ የነበሩትን ከባድ በሽታዎች ዝርዝር ያቀርቡ፣ ወይም እንኳን እንደተወው እንኳን.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'የቀርጸ-ቀትር ታሪክ';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'ለምሳሌ አፐንደክቶሚ';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'እባኮትን ሁሉንም ቀደም በተከታታይ የተደረጉ ምርመራዎችን ይዘው ዓመቱን እና የሚኖሩትን ችግኝ ይጨምሩ።';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'አንዳንድ ጊዜ የሚጠቀሙ መድሀኒቶች';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'እንደ ኢቡፕሮፍን';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'እባክዎ ከጊዜ ወደ ጊዜ የምንዛሬ የሚወስዱ መድሃኒቶችን ይዘጋጁ (ለምሳሌ፡ የህመም መድሃኒቶች፣ የአለም መድሃኒቶች)፣ የወሰነ መጠን እና የምንዛሬ ምክንያት ጨምር.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'የተደጋጋሚ መድሃኒቶች';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'እንደ ምሳሌ መትፎርሚን';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'እባክዎ በተደጋጋሚ የምንቀበል መድሃኒቶች ዝርዝር ይዘው ይጻፉ፣ የመድሃኒቱን ስም፣ ድምፅ፣ በየቀኑ ምን ጊዜ ይወስዳሉ እና ለምን ነው የሚያገለግል ይጻፉ።';

  @override
  String get profile_section_health_profile_allergies_label => 'አለርጂዎች';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'እንደ ፔኒሲሊን – በረሃብ ይከሰታል';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'እባኮትን ሁሉንም አለማይ የሚያስከትሉ እንደ መድሃኒቶች፣ ምግብ፣ እና አካባቢ ያለው አለማይ ዝርዝር ይዘው ይጻፉ፣ እና የምን እንደ ምልክት ይገልጹ (ለምሳሌ፡ ቀስተ ቀስተ ወይም እንደ መታወቂያ ችግኝ ወይም እንደ መታወቂያ ችግኝ ወይም እንደ መታወቂያ ችግኝ).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'ልዩ ሁኔታዎች';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'ለምሳሌ እርግዝና, እጥረት';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'ዶክተሮች ሁልጊዜ መረጃ ሊያገኙ የሚገባው ከሚኖርዎት አስፈላጊ የሕክምና ሁኔታዎች አንዳንድ ምሳሌዎች እንደ እንቅልፍ ወይም የተገነባ መሳሪያዎች፣ እንደ አንዳንድ የተወሰኑ የሕክምና ሂደቶች ይገኙ። ከሆነ ይቅርታ ይቀርባሉ።';

  @override
  String get profile_section_health_profile_family_history_label => 'የቤተሰብ ታሪክ';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'ለምሳሌ፣ የልብ በሽታ፣ ካንሰር';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'እባኮትን በቤተሰብዎ ውስጥ ያሉ አስፈላጊ 病 ይገልጹ (ለምሳሌ: ዳይቦቲስ, የደም ግፊት, የልብ በሽታ, ካንሰር, የወርሃዊ በሽታዎች) እና ያንን የተለየ ቤተሰብ አባል ይገልጹ.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'ማህበራዊ እና የሕይወት ልማዶች';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'ለምሳሌ መጥላት, የአልኮል ጥቅም';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'እባኮትን ወደ ጤናዎ የሚያወዳድሩ የእንቅስቃሴ አካላት ይግለጹ፣ እንደ መሳሪያ መጠጣት፣ አልኮል፣ አካል እንቅስቃሴ፣ ዳይት፣ እንቅልፍ እና ሥራ.';

  @override
  String get profile_section_health_profile_devices_label => 'የሕክምና መሣሪያዎች';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'ለምሳሌ ፔስመከር, የጆሮ እርዳታ, የኢንስሊን ፓምፕ';

  @override
  String get profile_section_health_profile_devices_hint =>
      'እባኮትን የምንጭ መሳሪያዎች ወይም የተገነባ መሳሪያዎች ዝርዝር ያቀርቡ፣ እንደ ፓስሜከር፣ የኢንሱሊን ፓም፣ የስም ማስታወቂያዎች፣ ፕሮስቴቲክ ወይም ሌላ የሚያገለግል ወይም የሚከታተል መሳሪያዎች። ከሚገባ ዝርዝር ያካትቱ።';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'ሁሉንም የሚበላ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'ፈጣን ምግብ';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'ፔስካታሪያን';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'የላክቶዝ ነጻ';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'ዝቅተኛ ጨው ያለ የምግብ ስርዓት';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'ዝቅተኛ ስኳር ያለው የምግብ አመጋገብ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'የልብ ምግብ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'የኩስት ምግብ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'ሌላ';
}
