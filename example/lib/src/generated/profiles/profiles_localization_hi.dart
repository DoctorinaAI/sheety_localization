// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class ProfilesLocalizationHi extends ProfilesLocalization {
  ProfilesLocalizationHi([String locale = 'hi']) : super(locale);

  @override
  String get chatDrawerTitle => 'स्वास्थ्य रिकॉर्ड';

  @override
  String get chatDrawerBadgeNew => 'नया';

  @override
  String get bannerTitle => 'अपना स्वास्थ्य रिकॉर्ड बनाएं';

  @override
  String get bannerSubtitle =>
      'अपनी परामर्श के अंत में, अपना प्रोफ़ाइल जोड़ें।';

  @override
  String get bannerMoreProfilesTitle => 'अधिक प्रोफाइल जोड़ें';

  @override
  String get bannerMoreProfilesSubtitle =>
      'किसी और के लिए प्रोफ़ाइल बनाने के लिए परामर्श शुरू करें।';

  @override
  String get bannerSignUp => 'अपनी स्वास्थ्य रिकॉर्ड बनाने के लिए साइन अप करें';

  @override
  String get errorRetryButton => 'पुनः प्रयास करें';

  @override
  String get dashboardDeleteError => 'प्रोफ़ाइल हटाने में विफल';

  @override
  String get dashboardSummaryLoadError => 'प्रोफ़ाइल सारांश लोड करने में विफल';

  @override
  String get dashboardMenuViewFullRecord => 'पूर्ण रिकॉर्ड देखें';

  @override
  String get dashboardMenuShare => 'शेयर करें';

  @override
  String get dashboardMenuDelete => 'हटाएँ';

  @override
  String get dashboardMetricAgeLabel => 'उम्र';

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
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'ऊँचाई';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'एलर्जी';

  @override
  String get dashboardInfoChronicTitle => 'क्रोनिक';

  @override
  String get dashboardInfoMedicationTitle => 'दवा';

  @override
  String get dashboardInfoDevicesTitle => 'डिवाइस';

  @override
  String get dashboardNavigationConsultations => 'परामर्श';

  @override
  String get dashboardNavigationDocuments => 'दस्तावेज़';

  @override
  String get dashboardDeleteRecordTitle => 'स्वास्थ्य रिकॉर्ड हटाएँ?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'यह आपके स्वास्थ्य डेटा को स्थायी रूप से हटा देगा और इसे पूर्ववत नहीं किया जा सकता। आप उस संदर्भ को खो देंगे जिसका हम आपको मार्गदर्शन करने के लिए उपयोग करते हैं।';

  @override
  String get dashboardDeleteRecordCancel => 'रद्द करें';

  @override
  String get dashboardDeleteRecordConfirm => 'हटाएँ';

  @override
  String get dashboardDeleteRecordLoading =>
      'आपका स्वास्थ्य रिकॉर्ड हटाया जा रहा है...';

  @override
  String get dashboardDeleteRecordError => 'प्रोफ़ाइल हटाने में विफल';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'स्वास्थ्य रिकॉर्ड हटाया गया';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'आप कभी भी सहायक से बात करके एक नया बना सकते हैं।';

  @override
  String get dashboardDeleteRecordSuccessButton => 'चैट पर लौटें';

  @override
  String get dataEditingScreenTitle => 'संपादन';

  @override
  String get dataFailedToLoadError => 'प्रोफ़ाइल डेटा लोड करने में विफल';

  @override
  String get dataRecordSavedTitle => 'परिवर्तन सहेजे गए';

  @override
  String get dataRecordSavedSubtitle =>
      'आपकी जानकारी सफलतापूर्वक अपडेट कर दी गई है।';

  @override
  String get dataRecordSavedButton => 'प्रोफ़ाइल पर लौटें';

  @override
  String get dataRecordUpdateError => 'प्रोफ़ाइल डेटा को अपडेट करने में विफल';

  @override
  String get dataRecordDiscardTitle => 'परिवर्तनों को त्यागें?';

  @override
  String get dataRecordDiscardSubtitle =>
      'आपने अपने प्रोफ़ाइल में कुछ बदलाव किए हैं। उन्हें सहेजें या उन्हें छोड़ दें।';

  @override
  String get dataRecordDiscardCancel => 'संपादन जारी रखें';

  @override
  String get dataRecordDiscardConfirm => 'खारिज करें';

  @override
  String get dataRecordEditTooltip => 'संपादित करें';

  @override
  String get dataRecordAddTag => 'रिकॉर्ड जोड़ें';

  @override
  String get consultationsSearch => 'खोजें';

  @override
  String get consultationsSearchEmpty => 'कोई परिणाम नहीं मिला';

  @override
  String get documentsMenuDownload => 'डाउनलोड';

  @override
  String get documentsMenuShare => 'शेयर करें';

  @override
  String get documentsMenuDelete => 'हटाएँ';

  @override
  String get documentsEmptyList => 'कोई दस्तावेज़ नहीं मिला';

  @override
  String get documentsDeleteTitle => 'क्या इस दस्तावेज़ को हटाना है?';

  @override
  String get documentsDeleteSubtitle => 'यह फ़ाइल स्थायी रूप से हटा दी जाएगी';

  @override
  String get documentsDeleteCancel => 'रद्द करें';

  @override
  String get documentsDeleteButton => 'हटाएँ';

  @override
  String get documentsMoreActionsTooltip => 'और कार्रवाइयाँ';

  @override
  String get profilesSearch => 'खोजें';

  @override
  String get profilesEmptyList => 'कोई प्रोफ़ाइल नहीं मिली';

  @override
  String get profilesViewMore => 'और देखें';

  @override
  String get profilesMore => 'और';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina अब आपकी सेहत को याद रखता है';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'आपकी परामर्श अब स्वचालित रूप से आपके स्वास्थ्य रिकॉर्ड का निर्माण और अद्यतन करते हैं।';

  @override
  String get profilesAnnouncementTitle2 => 'आपका स्वास्थ्य रिकॉर्ड, आपके नियम';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'किसी भी समय लक्षण, दवाएं, इतिहास या दस्तावेज़ देखें, संपादित करें या जोड़ें।';

  @override
  String get profilesAnnouncementTitle3 => 'अपने पूरे परिवार की देखभाल करें';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'अपने प्रियजनों, अपने बच्चों, माता-पिता या साथी के लिए एक स्वास्थ्य रिकॉर्ड बनाएं।';

  @override
  String get profilesAnnouncementTitle4 =>
      'क्या आप अपनी स्वास्थ्य रिकॉर्ड को सहेजने के लिए तैयार हैं?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'अपनी सलाह के बाद, इसे सहेजने के लिए \"प्रोफ़ाइल जोड़ें\" पर टैप करें।';

  @override
  String get profilesNextButton => 'अगला';

  @override
  String get profilesStartButton => 'परामर्श शुरू करें';

  @override
  String get profilesLaterButton => 'शायद बाद में';

  @override
  String get profileSuccessCloseButton => 'बंद करें';

  @override
  String get pdfHeaderTitle => 'स्वास्थ्य रिकॉर्ड';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'स्वास्थ्य रिकॉर्ड — $name';
  }

  @override
  String get expandableFieldMore => '...और';

  @override
  String get expandableFieldLess => '...कम';

  @override
  String get profiles_button_addnew => 'नया प्रोफ़ाइल जोड़ें';

  @override
  String get profiles_label_addnew =>
      'इस परामर्श के विवरण को सहेजने के लिए एक प्रोफ़ाइल बनाएं।';

  @override
  String get profiles_label_health_records_hint =>
      'आप इसे कभी भी अपने Health Records में देख सकते हैं';

  @override
  String get profiles_label_keep_talking_hint =>
      'यदि इस बारे में या इससे संबंधित किसी भी विषय पर आपके और भी प्रश्न हैं, तो बेझिझक मुझसे बातचीत जारी रखें। मैं मदद के लिए यहाँ हूँ';

  @override
  String get profile_section_basic_title => 'सामान्य जानकारी';

  @override
  String get profile_section_basic_name_label => 'नाम';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'पहला नाम';

  @override
  String get profile_section_basic_first_name_placeholder => 'जॉन';

  @override
  String get profile_section_basic_last_name_label => 'उपनाम';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'लिंग';

  @override
  String get profile_section_basic_sex_placeholder => 'कृपया चुनें';

  @override
  String get profile_section_basic_sex_options_male => 'पुरुष';

  @override
  String get profile_section_basic_sex_options_female => 'महिला';

  @override
  String get profile_section_basic_sex_options_other => 'अन्य';

  @override
  String get profile_section_basic_date_of_birth_label => 'जन्मतिथि';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'उम्र';

  @override
  String get profile_section_basic_age_str_placeholder => 'उदा. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'फ़ोन नंबर';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'ईमेल';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'स्थान';

  @override
  String get profile_section_basic_location_placeholder => 'उदा. शहर, देश';

  @override
  String get profile_section_body_diet_title => 'शरीर और आहार';

  @override
  String get profile_section_body_diet_height_str_label => 'ऊंचाई';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'उदा. 180 सेमी';

  @override
  String get profile_section_body_diet_weight_str_label => 'वज़न';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'उदा. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'मासिक धर्म चक्र';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'उदा. नियमित, अनियमित';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'आहार प्रतिबंध';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'कृपया चुनें';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'हमें बताएं कि आप क्या खाते हैं और आपके पास कौन सी पाबंदियाँ हैं';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'कोई नहीं';

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
          'ग्लूटेन मुक्त';

  @override
  String get profile_section_body_diet_bmi_label =>
      'शरीर द्रव्यमान सूचकांक (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'उदा. 24.5';

  @override
  String get profile_section_health_profile_title => 'स्वास्थ्य प्रोफ़ाइल';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'दीर्घकालिक बीमारियाँ';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'जैसे कि मधुमेह प्रकार 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'कृपया सभी पुरानी बीमारियों की सूची बनाएं और बताएं कि उन्हें कब निदान किया गया और कोई जटिलताएँ हैं या नहीं।';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'पिछली बीमारियाँ';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'जैसे कि बार-बार सामान्य सर्दी';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'कृपया गंभीर बीमारियों की सूची बनाएं जो आपने अतीत में अनुभव की हैं, भले ही आप ठीक हो गए हों।';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'शल्य चिकित्सा का इतिहास';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'उदा. Appendectomy';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'कृपया सभी सर्जरी की सूची बनाएं और वर्ष और यदि कोई जटिलताएँ थीं तो उन्हें शामिल करें।';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'कभी-कभार ली जाने वाली दवाएँ';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'जैसे कि इबुप्रोफेन';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'कृपया उन दवाओं की सूची बनाएं जो आप कभी-कभी लेते हैं (उदाहरण: दर्द निवारक, एलर्जी की दवाएं), जिसमें खुराक और उपयोग का कारण शामिल है।';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'नियमित दवाएं';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'जैसे कि मेटफॉर्मिन';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'कृपया सभी दवाओं की सूची बनाएं जो आप नियमित रूप से लेते हैं, जिसमें नाम, खुराक, आप इसे दिन में कितनी बार लेते हैं, और यह किस स्थिति के लिए है।';

  @override
  String get profile_section_health_profile_allergies_label => 'एलर्जी';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'जैसे कि पेनिसिलिन - दाने का कारण बनता है';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'कृपया सभी एलर्जी (दवाएं, खाद्य, पर्यावरण) सूचीबद्ध करें, और बताएं कि आपकी क्या प्रतिक्रिया है (उदाहरण के लिए: दाने, सूजन, सांस लेने में समस्या)।';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'विशेष स्थितियाँ';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'उदा. गर्भावस्था, विकलांगता';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'यदि आपके पास कोई महत्वपूर्ण चिकित्सा स्थितियाँ हैं जिनके बारे में डॉक्टरों को हमेशा पता होना चाहिए (उदाहरण के लिए: गर्भावस्था, प्रत्यारोपित उपकरण, विकलांगता, एंटीकोआगुलेंट चिकित्सा), तो कृपया उनका वर्णन करें। यदि कोई नहीं है, तो आप इसे खाली छोड़ सकते हैं।';

  @override
  String get profile_section_health_profile_family_history_label =>
      'पारिवारिक इतिहास';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'उदा. हृदय रोग, कैंसर';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'कृपया अपने परिवार में महत्वपूर्ण बीमारियों का वर्णन करें (उदाहरण: मधुमेह, उच्च रक्तचाप, हृदय रोग, कैंसर, आनुवंशिक बीमारियाँ) और यह बताएं कि किस परिवार के सदस्य को यह स्थिति थी।';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'सामाजिक और जीवनशैली कारक';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'उदा. धूम्रपान, शराब का सेवन';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'कृपया जीवनशैली के कारकों का वर्णन करें जो आपकी सेहत को प्रभावित कर सकते हैं, जैसे धूम्रपान, शराब, शारीरिक गतिविधि, आहार, नींद और पेशा।';

  @override
  String get profile_section_health_profile_devices_label => 'चिकित्सा उपकरण';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'उदा. पेसमेकर, हियरिंग एड, इंसुलिन पंप';

  @override
  String get profile_section_health_profile_devices_hint =>
      'कृपया किसी भी चिकित्सा उपकरणों की सूची बनाएं जो आप उपयोग करते हैं या जिनका प्रत्यारोपण किया गया है, जैसे कि पेसमेकर, इंसुलिन पंप, श्रवण यंत्र, कृत्रिम अंग, या अन्य सहायक या निगरानी उपकरण। यदि लागू हो तो संबंधित विवरण शामिल करें।';

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
          'पेस्केटेरियन';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'लैक्टोज़ मुक्त';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'कम सोडियम आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'कम चीनी वाला आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'हृदय आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'गुर्दे के लिए आहार';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'अन्य';
}
