// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class ProfilesLocalizationNe extends ProfilesLocalization {
  ProfilesLocalizationNe([String locale = 'ne']) : super(locale);

  @override
  String get chatDrawerTitle => 'स्वास्थ्य रेकर्ड';

  @override
  String get chatDrawerBadgeNew => 'नयाँ';

  @override
  String get bannerTitle => 'आफ्नो स्वास्थ्य रेकर्ड बनाउनुहोस्';

  @override
  String get bannerSubtitle =>
      'तपाईंको परामर्शको अन्त्यमा, आफ्नो प्रोफाइल थप्नुहोस्।';

  @override
  String get bannerMoreProfilesTitle => 'थप प्रोफाइलहरू थप्नुहोस्';

  @override
  String get bannerMoreProfilesSubtitle =>
      'अरूको प्रोफाइल बनाउनको लागि परामर्श सुरु गर्नुहोस्।';

  @override
  String get bannerSignUp => 'स्वास्थ्य रेकर्ड बनाउन साइन अप गर्नुहोस्';

  @override
  String get errorRetryButton => 'पुनः प्रयास गर्नुहोस्';

  @override
  String get dashboardDeleteError => 'प्रोफाइल मेट्न असफल';

  @override
  String get dashboardSummaryLoadError => 'प्रोफाइल संक्षेप लोड गर्न असफल';

  @override
  String get dashboardMenuViewFullRecord => 'पूर्ण रेकर्ड हेर्नुहोस्';

  @override
  String get dashboardMenuShare => 'साझा गर्नुहोस्';

  @override
  String get dashboardMenuDelete => 'हटाउनुहोस्';

  @override
  String get dashboardMetricAgeLabel => 'उमेर';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value वर्ष',
      one: '$value वर्ष',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'वजन';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value किग्रा';
  }

  @override
  String get dashboardMetricHeightLabel => 'उचाई';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value से.मी.';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'एलर्जी';

  @override
  String get dashboardInfoChronicTitle => 'क्रोनिक';

  @override
  String get dashboardInfoMedicationTitle => 'औषधि';

  @override
  String get dashboardInfoDevicesTitle => 'उपकरणहरू';

  @override
  String get dashboardNavigationConsultations => 'परामर्श';

  @override
  String get dashboardNavigationDocuments => 'कागजात';

  @override
  String get dashboardDeleteRecordTitle => 'स्वास्थ्य रेकर्ड मेट्ने? ';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'यसले तपाईंको स्वास्थ्य डेटा स्थायी रूपमा हटाउनेछ र यसलाई फिर्ता गर्न सकिँदैन। तपाईंले हामीले तपाईंलाई मार्गदर्शन गर्न प्रयोग गर्ने सन्दर्भ गुमाउनु हुनेछ।';

  @override
  String get dashboardDeleteRecordCancel => 'रद्द गर्नुहोस्';

  @override
  String get dashboardDeleteRecordConfirm => 'हटाउनुहोस्';

  @override
  String get dashboardDeleteRecordLoading =>
      'तपाईंको स्वास्थ्य रेकर्ड मेटाइँदैछ...';

  @override
  String get dashboardDeleteRecordError => 'प्रोफाइल मेट्न असफल';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'स्वास्थ्य रेकर्ड मेटियो';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'तपाईं सहायकसँग कुरा गरेर कुनै पनि समयमा नयाँ बनाउन सक्नुहुन्छ।';

  @override
  String get dashboardDeleteRecordSuccessButton => 'च्याटमा फर्कनुहोस्';

  @override
  String get dataEditingScreenTitle => 'सम्पादन';

  @override
  String get dataFailedToLoadError => 'प्रोफाइल डेटा लोड गर्न असफल';

  @override
  String get dataRecordSavedTitle => 'परिवर्तनहरू सुरक्षित गरियो';

  @override
  String get dataRecordSavedSubtitle =>
      'तपाईंको जानकारी सफलतापूर्वक अपडेट गरिएको छ।';

  @override
  String get dataRecordSavedButton => 'प्रोफाइलमा फर्कनुहोस्';

  @override
  String get dataRecordUpdateError => 'प्रोफाइल डेटा अपडेट गर्न असफल';

  @override
  String get dataRecordDiscardTitle => 'परिवर्तनहरू मेटाउने? ';

  @override
  String get dataRecordDiscardSubtitle =>
      'तपाईंले आफ्नो प्रोफाइलमा केही परिवर्तन गर्नुभएको छ। जानु अघि तिनीहरूलाई बचत गर्नुहोस्, वा तिनीहरूलाई फाल्नुहोस्।';

  @override
  String get dataRecordDiscardCancel => 'सम्पादन जारी राख्नुहोस्';

  @override
  String get dataRecordDiscardConfirm => 'फाल्नुहोस्';

  @override
  String get dataRecordEditTooltip => 'सम्पादन';

  @override
  String get dataRecordAddTag => 'रेकर्ड थप्नुहोस्';

  @override
  String get consultationsSearch => 'खोज्नुहोस्';

  @override
  String get consultationsSearchEmpty => 'कुनै परिणाम फेला परेन';

  @override
  String get documentsMenuDownload => 'डाउनलोड';

  @override
  String get documentsMenuShare => 'साझा गर्नुहोस्';

  @override
  String get documentsMenuDelete => 'हटाउनुहोस्';

  @override
  String get documentsEmptyList => 'कुनै पनि कागजात फेला परेन';

  @override
  String get documentsDeleteTitle => 'यो कागजात मेट्ने हो?';

  @override
  String get documentsDeleteSubtitle => 'यो फाइल स्थायी रूपमा हटाइनेछ';

  @override
  String get documentsDeleteCancel => 'रद्द गर्नुहोस्';

  @override
  String get documentsDeleteButton => 'हटाउनुहोस्';

  @override
  String get documentsMoreActionsTooltip => 'थप कार्यहरू';

  @override
  String get profilesSearch => 'खोज्नुहोस्';

  @override
  String get profilesEmptyList => 'कुनै प्रोफाइल फेला परेन';

  @override
  String get profilesViewMore => 'थप हेर्नुहोस्';

  @override
  String get profilesMore => 'थप';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina अब तपाईंको स्वास्थ्य सम्झन्छ';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'तपाईंको परामर्शले अब तपाईंको स्वास्थ्य रेकर्डलाई स्वचालित रूपमा निर्माण र अद्यावधिक गर्दछ।';

  @override
  String get profilesAnnouncementTitle2 =>
      'तपाईंको स्वास्थ्य रेकर्ड, तपाईंका नियम';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'कुनै पनि समयमा लक्षण, औषधि, इतिहास, वा कागजातहरू हेर्नुहोस्, सम्पादन गर्नुहोस्, वा थप्नुहोस्।';

  @override
  String get profilesAnnouncementTitle3 =>
      'तपाईंको सम्पूर्ण परिवारको हेरचाह गर्नुहोस्';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'तपाईंका प्रियजनहरूको लागि स्वास्थ्य रेकर्ड बनाउनुहोस्, तपाईंका बच्चाहरू, आमाबाबु, वा साथी।';

  @override
  String get profilesAnnouncementTitle4 =>
      'तपाईंको स्वास्थ्य रेकर्ड बचत गर्न तयार हुनुहुन्छ?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'तपाईंको परामर्शपछि, यसलाई बचत गर्न “प्रोफाइल थप्नुहोस्” मा थिच्नुहोस्।';

  @override
  String get profilesNextButton => 'अगाडि';

  @override
  String get profilesStartButton => 'परामर्श सुरु गर्नुहोस्';

  @override
  String get profilesLaterButton => 'शायद पछि';

  @override
  String get profileSuccessCloseButton => 'बन्द गर्नुहोस्';

  @override
  String get pdfHeaderTitle => 'स्वास्थ्य रेकर्ड';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'स्वास्थ्य रेकर्ड — $name';
  }

  @override
  String get expandableFieldMore => '...थप';

  @override
  String get expandableFieldLess => '...कम';

  @override
  String get profiles_button_addnew => 'नयाँ प्रोफाइल थप्नुहोस्';

  @override
  String get profiles_label_addnew =>
      'यस परामर्शको विवरणहरू बचत गर्न प्रोफाइल सिर्जना गर्नुहोस्।';

  @override
  String get profiles_label_health_records_hint =>
      'तपाईं यसलाई आफ्नो स्वास्थ्य अभिलेखमा कुनै पनि समयमा जाँच गर्न सक्नुहुन्छ';

  @override
  String get profiles_label_keep_talking_hint =>
      'यदि तपाईंलाई यसको बारेमा वा यससँग सम्बन्धित अरू प्रश्नहरू छन् भने, निःसंकोच मसँग कुरा जारी राख्न सक्नुहुन्छ। म मद्दत गर्न यहाँ छु';

  @override
  String get profile_section_basic_title => 'सामान्य जानकारी';

  @override
  String get profile_section_basic_name_label => 'नाम';

  @override
  String get profile_section_basic_name_placeholder => 'जॉन डो';

  @override
  String get profile_section_basic_first_name_label => 'पहिलो नाम';

  @override
  String get profile_section_basic_first_name_placeholder => 'जॉन';

  @override
  String get profile_section_basic_last_name_label => 'थर';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'लिङ्ग';

  @override
  String get profile_section_basic_sex_placeholder => 'कृपया चयन गर्नुहोस्';

  @override
  String get profile_section_basic_sex_options_male => 'पुरुष';

  @override
  String get profile_section_basic_sex_options_female => 'महिला';

  @override
  String get profile_section_basic_sex_options_other => 'अन्य';

  @override
  String get profile_section_basic_date_of_birth_label => 'जन्म मिति';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'उमेर';

  @override
  String get profile_section_basic_age_str_placeholder => 'जस्तै 30';

  @override
  String get profile_section_basic_phonenumber_label => 'फोन नम्बर';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'इमेल';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'स्थान';

  @override
  String get profile_section_basic_location_placeholder => 'उदा. शहर, देश';

  @override
  String get profile_section_body_diet_title => 'शरीर र आहार';

  @override
  String get profile_section_body_diet_height_str_label => 'ऊँचाइ';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'उदा. 180 सेमी';

  @override
  String get profile_section_body_diet_weight_str_label => 'वजन';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'उदा. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'मासिक धर्म चक्र';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'उदाहरण: नियमित, अनियमित';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'आहार प्रतिबन्धहरू';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'कृपया छान्नुहोस्';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'तपाईं के खाने हुनुहुन्छ र तपाईंसँग भएका कुनै पनि प्रतिबन्धहरू हामीलाई बताउनुहोस्';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'कुनै छैन';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'शाकाहारी';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'वीगन';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'ग्लुटेन मुक्त';

  @override
  String get profile_section_body_diet_bmi_label =>
      'शरीर द्रव्यमान सूचकांक (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'उदा. 24.5';

  @override
  String get profile_section_health_profile_title => 'स्वास्थ्य प्रोफाइल';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'दीर्घकालीन रोगहरू';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'जस्तै: मधुमेह प्रकार 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'कृपया सबै पुराना रोगहरूको सूची बनाउनुहोस् र कहिले निदान गरिएको र कुनै जटिलताहरू समावेश गर्नुहोस्।';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'पहिलाका रोगहरू';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'जस्तै, बारम्बारको साधारण ज्वरो';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'कृपया तपाईंले अतीतमा भोगेका गम्भीर रोगहरूको सूची दिनुहोस्, यद्यपि तपाईं निको हुनुभएको छ।';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'शल्यक्रिया इतिहास';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'उदा. Appendectomy';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'कृपया सबै शल्यक्रियाहरूको सूची बनाउनुहोस् र वर्ष र कुनै जटिलताहरू थिए कि छैनन् भन्ने कुरा समावेश गर्नुहोस्';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'कहिलेकाहीँ प्रयोग गरिने औषधिहरू';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'जस्तै: Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'कृपया तपाईंले कहिलेकाहीं लिने औषधिहरूको सूची दिनुहोस् (उदाहरणका लागि: पीडा निवारक, एलर्जी औषधिहरू), डोज र प्रयोगको कारण सहित।';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'नियमित औषधिहरू';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'जस्तै: Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'कृपया तपाईंले नियमित रूपमा लिने सबै औषधिहरूको नाम, मात्रा, दिनमा कति पटक लिन्छन्, र यो कुन अवस्थाको लागि हो भनेर सूचीबद्ध गर्नुहोस्।';

  @override
  String get profile_section_health_profile_allergies_label => 'एलर्जीहरू';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'जस्तै: पेनिसिलिन – चामल ल्याउँछ';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'कृपया सबै एलर्जीहरू (औषधिहरू, खाना, वातावरण) सूचीबद्ध गर्नुहोस्, र तपाईंले कस्तो प्रतिक्रिया देखाउनुहुन्छ भनेर वर्णन गर्नुहोस् (उदाहरणका लागि: चर्मरोग, सुजन, श्वासप्रश्वासको समस्या)।';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'विशेष अवस्थाहरू';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'उदा. गर्भावस्था, अपाङ्गता';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'यदि तपाईंसँग कुनै महत्त्वपूर्ण चिकित्सा अवस्थाहरू छन् जुन डाक्टरहरूले सधैं थाहा पाउनु पर्छ (उदाहरणका लागि: गर्भावस्था, इम्प्लान्ट गरिएका उपकरणहरू, अपाङ्गता, एन्टिकोआगुलन थेरापी), कृपया तिनीहरूलाई वर्णन गर्नुहोस्। यदि छैन भने, तपाईं यसलाई खालि छोड्न सक्नुहुन्छ।';

  @override
  String get profile_section_health_profile_family_history_label =>
      'पारिवारिक इतिहास';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'उदा. मुटु रोग, क्यान्सर';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'कृपया आफ्नो परिवारमा महत्त्वपूर्ण रोगहरूको वर्णन गर्नुहोस् (उदाहरणका लागि: मधुमेह, उच्च रक्तचाप, हृदय रोग, क्यान्सर, आनुवंशिक रोगहरू) र कुन परिवारका सदस्यले यो अवस्था पाएको छ भनेर निर्दिष्ट गर्नुहोस्।';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'सामाजिक र जीवनशैलीका कारकहरू';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'उदा. धूम्रपान, मद्यपान';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'कृपया जीवनशैलीका तत्त्वहरू वर्णन गर्नुहोस् जसले तपाईंको स्वास्थ्यमा असर पार्न सक्छ, जस्तै धूम्रपान, मदिरा, शारीरिक गतिविधि, आहार, निद्रा, र पेशा।';

  @override
  String get profile_section_health_profile_devices_label =>
      'चिकित्सा उपकरणहरू';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'उदा. पेसमेकर, सुनाइ सहायक, इन्सुलिन पम्प';

  @override
  String get profile_section_health_profile_devices_hint =>
      'कृपया कुनै पनि चिकित्सा उपकरणहरूको सूची दिनुहोस् जुन तपाईंले प्रयोग गर्नुहुन्छ वा इम्प्लान्ट गरिएको छ, जस्तै पेसमेकर, इन्सुलिन पम्प, सुन्ने उपकरण, कृत्रिम अंग, वा अन्य सहायक वा अनुगमन उपकरणहरू। लागू हुने भएमा सम्बन्धित विवरणहरू समावेश गर्नुहोस्।';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'सर्वाहारी';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'फास्ट फूड';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'मत्स्याहारी';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'लैक्टोज-मुक्त';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'कम सोडियम आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'कम-चिनी आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'हृदय सम्बन्धी आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'गुर्दाको आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'अन्य';
}
