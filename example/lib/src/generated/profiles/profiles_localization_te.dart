// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class ProfilesLocalizationTe extends ProfilesLocalization {
  ProfilesLocalizationTe([String locale = 'te']) : super(locale);

  @override
  String get chatDrawerTitle => 'ఆరోగ్య రికార్డులు';

  @override
  String get chatDrawerBadgeNew => 'కొత్త';

  @override
  String get bannerTitle => 'మీ ఆరోగ్య రికార్డు సృష్టించండి';

  @override
  String get bannerSubtitle =>
      'మీ సంప్రదింపుల ముగింపులో, మీ ప్రొఫైల్‌ను చేర్చండి.';

  @override
  String get bannerMoreProfilesTitle => 'మరిన్ని ప్రొఫైల్స్ జోడించండి';

  @override
  String get bannerMoreProfilesSubtitle =>
      'ఇంకా ఎవరికైనా వారి ప్రొఫైల్ సృష్టించడానికి సంప్రదింపులు ప్రారంభించండి.';

  @override
  String get bannerSignUp =>
      'మీ ఆరోగ్య రికార్డు సృష్టించడానికి సైన్ అప్ చేయండి';

  @override
  String get errorRetryButton => 'మళ్లీ ప్రయత్నించండి';

  @override
  String get dashboardDeleteError => 'ప్రొఫైల్ తొలగించడంలో విఫలమైంది';

  @override
  String get dashboardSummaryLoadError =>
      'ప్రొఫైల్ సమ్మరీని లోడ్ చేయడంలో విఫలమైంది';

  @override
  String get dashboardMenuViewFullRecord => 'పూర్తి రికార్డు చూడండి';

  @override
  String get dashboardMenuShare => 'షేర్';

  @override
  String get dashboardMenuDelete => 'తొలగించు';

  @override
  String get dashboardMetricAgeLabel => 'వయస్సు';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value సంవత్సరాలు',
      one: '$value సంవత్సరం',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'బరువు';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value కిలోగ్రాములు';
  }

  @override
  String get dashboardMetricHeightLabel => 'ఎత్తు';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value సం.మీ.';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'అలర్జీలు';

  @override
  String get dashboardInfoChronicTitle => 'దీర్ఘకాలిక';

  @override
  String get dashboardInfoMedicationTitle => 'మందులు';

  @override
  String get dashboardInfoDevicesTitle => 'ఉపకరణాలు';

  @override
  String get dashboardNavigationConsultations => 'సలహాలు';

  @override
  String get dashboardNavigationDocuments => 'పత్రాలు';

  @override
  String get dashboardDeleteRecordTitle => 'ఆరోగ్య రికార్డు తొలగించాలా?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'ఇది మీ ఆరోగ్య డేటాను శాశ్వతంగా తొలగిస్తుంది మరియు తిరిగి పొందలేరు. మేము మీకు మార్గనిర్దేశం చేయడానికి ఉపయోగించే సందర్భాన్ని కోల్పోతారు.';

  @override
  String get dashboardDeleteRecordCancel => 'రద్దు';

  @override
  String get dashboardDeleteRecordConfirm => 'తొలగించు';

  @override
  String get dashboardDeleteRecordLoading =>
      'మీ ఆరోగ్య రికార్డును తొలగిస్తున్నాము...';

  @override
  String get dashboardDeleteRecordError => 'ప్రొఫైల్ తొలగించడంలో విఫలమైంది';

  @override
  String get dashboardDeleteRecordSuccessTitle =>
      'ఆరోగ్య రికార్డు తొలగించబడింది';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'మీరు సహాయకుడితో చాటింగ్ చేసి ఎప్పుడైనా కొత్తది సృష్టించవచ్చు.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'చాట్‌కు తిరిగి వెళ్ళండి';

  @override
  String get dataEditingScreenTitle => 'సవరించడం';

  @override
  String get dataFailedToLoadError => 'ప్రొఫైల్ డేటా లోడ్ చేయడంలో విఫలమైంది';

  @override
  String get dataRecordSavedTitle => 'మార్పులు సేవ్ చేయబడ్డాయి';

  @override
  String get dataRecordSavedSubtitle => 'మీ సమాచారం విజయవంతంగా నవీకరించబడింది.';

  @override
  String get dataRecordSavedButton => 'ప్రొఫైల్కు తిరిగి వెళ్ళండి';

  @override
  String get dataRecordUpdateError => 'ప్రొఫైల్ డేటాను నవీకరించడంలో విఫలమైంది';

  @override
  String get dataRecordDiscardTitle => 'మార్పులను వదులుతారా?';

  @override
  String get dataRecordDiscardSubtitle =>
      'మీ ప్రొఫైల్‌లో కొన్ని మార్పులు చేశారు. మీరు వెళ్లే ముందు వాటిని సేవ్ చేయండి లేదా వదిలేయండి.';

  @override
  String get dataRecordDiscardCancel => 'సవరించడాన్ని కొనసాగించండి';

  @override
  String get dataRecordDiscardConfirm => 'తిరస్కరించు';

  @override
  String get dataRecordEditTooltip => 'సవరించు';

  @override
  String get dataRecordAddTag => 'రికార్డు జోడించు';

  @override
  String get consultationsSearch => 'శోధన';

  @override
  String get consultationsSearchEmpty => 'ఫలితాలు లేవు';

  @override
  String get documentsMenuDownload => 'డౌన్‌లోడ్';

  @override
  String get documentsMenuShare => 'షేర్';

  @override
  String get documentsMenuDelete => 'తొలగించు';

  @override
  String get documentsEmptyList => 'ఏ డాక్యుమెంట్లు లభించలేదు';

  @override
  String get documentsDeleteTitle => 'ఈ పత్రాన్ని తొలగించాలా?';

  @override
  String get documentsDeleteSubtitle => 'ఈ ఫైల్ శాశ్వతంగా తొలగించబడుతుంది';

  @override
  String get documentsDeleteCancel => 'రద్దు';

  @override
  String get documentsDeleteButton => 'తొలగించు';

  @override
  String get documentsMoreActionsTooltip => 'మరిన్ని చర్యలు';

  @override
  String get profilesSearch => 'శోధన';

  @override
  String get profilesEmptyList => 'ప్రొఫైల్‌లు ఏవీ కనబడలేదు';

  @override
  String get profilesViewMore => 'మరిన్ని చూడండి';

  @override
  String get profilesMore => 'మరింత';

  @override
  String get profilesAnnouncementTitle1 =>
      'డాక్టర్‌నా మీ ఆరోగ్యాన్ని గుర్తుంచుకుంటుంది';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'మీ సంప్రదింపులు ఇప్పుడు మీ ఆరోగ్య రికార్డును ఆటోమేటిక్‌గా నిర్మించు మరియు నవీకరించు.';

  @override
  String get profilesAnnouncementTitle2 => 'మీ ఆరోగ్య రికార్డు, మీ నియమాలు';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'సమయానుకూలంగా లక్షణాలు, మందులు, చరిత్ర లేదా పత్రాలను చూడండి, సవరించండి లేదా జోడించండి.';

  @override
  String get profilesAnnouncementTitle3 => 'మీ మొత్తం కుటుంబానికి సంరక్షణ';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'మీ ప్రియమైన వారికోసం, మీ పిల్లలు, తల్లిదండ్రులు లేదా భాగస్వామి కోసం ఆరోగ్య రికార్డు సృష్టించండి.';

  @override
  String get profilesAnnouncementTitle4 =>
      'మీ ఆరోగ్య రికార్డును సేవ్ చేయడానికి సిద్ధమా?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'మీ సంప్రదింపుల తర్వాత, దాన్ని సేవ్ చేయడానికి \"ప్రొఫైల్ జోడించు\" పై ట్యాప్ చేయండి.';

  @override
  String get profilesNextButton => 'తదుపరి';

  @override
  String get profilesStartButton => 'సలహా ప్రారంభించండి';

  @override
  String get profilesLaterButton => 'తర్వాత కావచ్చు';

  @override
  String get profileSuccessCloseButton => 'మూసు';

  @override
  String get pdfHeaderTitle => 'ఆరోగ్య రికార్డు';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'ఆరోగ్య రికార్డు — $name';
  }

  @override
  String get expandableFieldMore => '...మరింత';

  @override
  String get expandableFieldLess => '...తక్కువ';

  @override
  String get profiles_button_addnew => 'కొత్త ప్రొఫైల్ జోడించండి';

  @override
  String get profiles_label_addnew =>
      'ఈ సలహా యొక్క వివరాలను సేవ్ చేయడానికి ఒక ప్రొఫైల్ సృష్టించండి.';

  @override
  String get profiles_label_health_records_hint =>
      'మీ ఆరోగ్య రికార్డుల్లో దీన్ని మీరు ఎప్పుడైనా మూల్యాంకనం చేయవచ్చు';

  @override
  String get profiles_label_keep_talking_hint =>
      'ఈ విషయం లేదా దీనితో సంబంధం ఉన్న ఏదైనా గురించి మీకు ఇంకా ప్రశ్నలు ఉంటే, సంకోచించకుండా నాతో మాట్లాడుతూనే ఉండండి. నేను సహాయం చేయడానికి ఇక్కడ ఉన్నాను';

  @override
  String get profile_section_basic_title => 'సాధారణ సమాచారం';

  @override
  String get profile_section_basic_name_label => 'పేరు';

  @override
  String get profile_section_basic_name_placeholder => 'జాన్ డో';

  @override
  String get profile_section_basic_first_name_label => 'మొదటి పేరు';

  @override
  String get profile_section_basic_first_name_placeholder => 'జాన్';

  @override
  String get profile_section_basic_last_name_label => 'చివరి పేరు';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'లింగం';

  @override
  String get profile_section_basic_sex_placeholder => 'దయచేసి ఎంచుకోండి';

  @override
  String get profile_section_basic_sex_options_male => 'పురుషుడు';

  @override
  String get profile_section_basic_sex_options_female => 'స్త్రీ';

  @override
  String get profile_section_basic_sex_options_other => 'ఇతర';

  @override
  String get profile_section_basic_date_of_birth_label => 'పుట్టిన తేదీ';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'వయస్సు';

  @override
  String get profile_section_basic_age_str_placeholder => 'ఉదా. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'ఫోన్ నంబర్';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'ఈమెయిల్';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'స్థానం';

  @override
  String get profile_section_basic_location_placeholder => 'ఉదా. నగరం, దేశం';

  @override
  String get profile_section_body_diet_title => 'శరీరం & ఆహారం';

  @override
  String get profile_section_body_diet_height_str_label => 'ఎత్తు';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'ఉదా. 180 సెం.మీ';

  @override
  String get profile_section_body_diet_weight_str_label => 'బరువు';

  @override
  String get profile_section_body_diet_weight_str_placeholder =>
      'ఉదాహరణకు 75 కిలోలు';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => 'మాసిక చక్రం';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'ఉదాహరణకు నియమిత, అనియమిత';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'ఆహార పరిమితులు';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'దయచేసి ఎంచుకోండి';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'మీరు ఏమి తింటారో మరియు మీకు ఉన్న పరిమితులు మాకు తెలియజేయండి';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'ఏమీ లేదు';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'శాకాహారి';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'వీగన్';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'గ్లూటెన్ రహితం';

  @override
  String get profile_section_body_diet_bmi_label => 'బాడీ మాస్ ఇండెక్స్ (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'ఉదాహరణకు 24.5';

  @override
  String get profile_section_health_profile_title => 'ఆరోగ్య ప్రొఫైల్';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'దీర్ఘకాలిక రోగాలు';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'ఉదాహరణకు, డయాబెటిస్ టైప్ 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'దయచేసి అన్ని దీర్ఘకాలిక వ్యాధులను జాబితా చేయండి మరియు అవి ఎప్పుడు నిర్ధారించబడ్డాయో మరియు ఏదైనా సంక్లిష్టతలను చేర్చండి.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'గత వ్యాధులు';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'ఉదాహరణకు, తరచుగా సాధారణ జలుబు';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'మీరు గతంలో అనుభవించిన తీవ్రమైన వ్యాధులను జాబితా చేయండి, మీరు కోలుకున్నా కూడా.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'శస్త్రచికిత్సల చరిత్ర';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'ఉదా. అపెండెక్టమీ';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'దయచేసి అన్ని శస్త్రచికిత్సలను జాబితా చేయండి మరియు సంవత్సరాన్ని మరియు ఏవైనా సంక్లిష్టతలు ఉన్నాయా అని చేర్చండి.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'అప్పుడప్పుడు ఉపయోగించే మందులు';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'ఉదాహరణకు: ఐబుప్రోఫెన్';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'మీరు కొన్నిసార్లు తీసుకునే మందులను (ఉదాహరణకు: నొప్పి మందులు, అలర్జీ మందులు) జాబితా చేయండి, డోసు మరియు ఉపయోగం కారణం సహితంగా.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'నియమిత ఔషధాలు';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'ఉదాహరణకు: మెట్ఫార్మిన్';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'మీరు రెగ్యులర్‌గా తీసుకునే అన్ని మందుల పేర్లు, డోసు, రోజుకు ఎంతసార్లు తీసుకుంటారో మరియు అది ఏ పరిస్థితికి సంబంధించినదో జాబితా చేయండి.';

  @override
  String get profile_section_health_profile_allergies_label => 'అలర్జీలు';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'ఉదాహరణ: పెనిసిలిన్ - చర్మరాషి కలిగిస్తుంది';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'మీ అన్ని అలర్జీలను (మందులు, ఆహారం, పర్యావరణం) జాబితా చేయండి, మరియు మీరు ఏ రకమైన ప్రతిస్పందనను కలిగి ఉన్నారో వివరించండి (ఉదాహరణకు: చర్మరోగం, వాపు, శ్వాస సమస్యలు).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'ప్రత్యేక పరిస్థితులు';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'ఉదా. గర్భధారణ, దివ్యాంగత';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'మీకు ఎలాంటి ముఖ్యమైన వైద్య పరిస్థితులు ఉన్నాయా, డాక్టర్లు ఎప్పుడూ తెలుసుకోవాలి (ఉదాహరణకు: గర్భధారణ, అమర్చిన పరికరాలు, అంగవైకల్యాలు, యాంటికొగులేషన్ థెరపీ), దయచేసి వాటిని వివరించండి. లేకపోతే, మీరు దీన్ని ఖాళీగా ఉంచవచ్చు.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'కుటుంబ చరిత్ర';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'ఉదా. హృదయ వ్యాధి, క్యాన్సర్';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'మీ కుటుంబంలో ముఖ్యమైన వ్యాధులను వివరించండి (ఉదాహరణకు: మధుమేహం, రక్తపోటు, హృదయ వ్యాధి, కేన్సర్, జన్యు వ్యాధులు) మరియు ఆ పరిస్థితిని కలిగిన కుటుంబ సభ్యుడిని స్పష్టంగా చెప్పండి.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'సామాజిక & జీవనశైలి అంశాలు';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'ఉదాహరణకు పొగాకు, మద్యపానం';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'మీ ఆరోగ్యాన్ని ప్రభావితం చేసే జీవనశైలి అంశాలను వివరించండి, ఉదాహరణకు పొగాకు, మద్యం, శారీరక కార్యకలాపం, ఆహారం, నిద్ర మరియు వృత్తి.';

  @override
  String get profile_section_health_profile_devices_label => 'వైద్య పరికరాలు';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'e.g. పేస్‌మేకర్, శ్రవణ సహాయక పరికరం, ఇన్సులిన్ పంప్';

  @override
  String get profile_section_health_profile_devices_hint =>
      'మీరు ఉపయోగిస్తున్న లేదా ఇంప్లాంట్ చేసిన ఏదైనా వైద్య పరికరాలను జాబితా చేయండి, ఉదాహరణకు పేస్‌మేకర్లు, ఇన్సులిన్ పంపులు, వినికిడి సహాయ పరికరాలు, ప్రోస్టెటిక్స్ లేదా ఇతర సహాయక లేదా పర్యవేక్షణ పరికరాలు. వర్తించే వివరాలను చేర్చండి.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'సర్వాహారి';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'ఫాస్ట్ ఫుడ్';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'చేపలు తినే శాకాహారి';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'లాక్టోజ్-రహితం';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'తక్కువ సోడియం ఆహారం';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'తక్కువ చక్కర ఆహారం';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'హృదయానికి అనుకూల ఆహారం';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'మూత్రపిండాల ఆహారం';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'ఇతర';
}
