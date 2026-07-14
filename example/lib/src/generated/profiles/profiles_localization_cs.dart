// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class ProfilesLocalizationCs extends ProfilesLocalization {
  ProfilesLocalizationCs([String locale = 'cs']) : super(locale);

  @override
  String get chatDrawerTitle => 'Zdravotní záznamy';

  @override
  String get chatDrawerBadgeNew => 'NOVÉ';

  @override
  String get bannerTitle => 'Vytvořte si zdravotní záznam';

  @override
  String get bannerSubtitle => 'Na konci konzultace přidejte svůj profil.';

  @override
  String get bannerMoreProfilesTitle => 'Přidat další profily';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Začněte konzultaci pro někoho jiného, aby vytvořil svůj profil.';

  @override
  String get bannerSignUp =>
      'Zaregistrujte se a vytvořte si svůj zdravotní záznam';

  @override
  String get errorRetryButton => 'Zkusit znovu';

  @override
  String get dashboardDeleteError => 'Nepodařilo se smazat profil';

  @override
  String get dashboardSummaryLoadError =>
      'Nepodařilo se načíst shrnutí profilu';

  @override
  String get dashboardMenuViewFullRecord => 'Zobrazit úplný záznam';

  @override
  String get dashboardMenuShare => 'Sdílet';

  @override
  String get dashboardMenuDelete => 'Smazat';

  @override
  String get dashboardMetricAgeLabel => 'Věk';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value roky',
      one: '$value rok',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Hmotnost';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Výška';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Alergie';

  @override
  String get dashboardInfoChronicTitle => 'Chronické';

  @override
  String get dashboardInfoMedicationTitle => 'Léky';

  @override
  String get dashboardInfoDevicesTitle => 'Zařízení';

  @override
  String get dashboardNavigationConsultations => 'Konzultace';

  @override
  String get dashboardNavigationDocuments => 'Dokumenty';

  @override
  String get dashboardDeleteRecordTitle => 'Smazat zdravotní záznam?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Toto trvale odstraní vaše zdravotní údaje a nelze to vrátit zpět. Ztratíte kontext, který používáme k tomu, abychom vás vedli.';

  @override
  String get dashboardDeleteRecordCancel => 'Zrušit';

  @override
  String get dashboardDeleteRecordConfirm => 'Smazat';

  @override
  String get dashboardDeleteRecordLoading =>
      'Odstraňuji váš zdravotní záznam...';

  @override
  String get dashboardDeleteRecordError => 'Nepodařilo se smazat profil';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Zdravotní záznam byl smazán';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Nový můžete vytvořit kdykoli tím, že si popovídáte s asistentem.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Vrátit se do chatu';

  @override
  String get dataEditingScreenTitle => 'Úprava';

  @override
  String get dataFailedToLoadError => 'Nepodařilo se načíst profilová data';

  @override
  String get dataRecordSavedTitle => 'Změny uloženy';

  @override
  String get dataRecordSavedSubtitle =>
      'Vaše informace byly úspěšně aktualizovány.';

  @override
  String get dataRecordSavedButton => 'Vrátit se na profil';

  @override
  String get dataRecordUpdateError =>
      'Nepodařilo se aktualizovat profilová data';

  @override
  String get dataRecordDiscardTitle => 'Zrušit změny?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Provedli jste změny ve svém profilu. Uložte je, než odejdete, nebo je zrušte.';

  @override
  String get dataRecordDiscardCancel => 'Pokračovat v úpravách';

  @override
  String get dataRecordDiscardConfirm => 'Zahodit';

  @override
  String get dataRecordEditTooltip => 'Upravit';

  @override
  String get dataRecordAddTag => 'Přidat záznam';

  @override
  String get consultationsSearch => 'Hledat';

  @override
  String get consultationsSearchEmpty => 'Nenašly se žádné výsledky';

  @override
  String get documentsMenuDownload => 'Stáhnout';

  @override
  String get documentsMenuShare => 'Sdílet';

  @override
  String get documentsMenuDelete => 'Smazat';

  @override
  String get documentsEmptyList => 'Žádné dokumenty nenalezeny';

  @override
  String get documentsDeleteTitle => 'Chcete tento dokument smazat?';

  @override
  String get documentsDeleteSubtitle => 'Tento soubor bude trvale odstraněn';

  @override
  String get documentsDeleteCancel => 'Zrušit';

  @override
  String get documentsDeleteButton => 'Smazat';

  @override
  String get documentsMoreActionsTooltip => 'Další akce';

  @override
  String get profilesSearch => 'Hledat';

  @override
  String get profilesEmptyList => 'Nebyly nalezeny žádné profily';

  @override
  String get profilesViewMore => 'Zobrazit více';

  @override
  String get profilesMore => 'Více';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina si nyní pamatuje vaše zdraví';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Vaše konzultace nyní automaticky vytvářejí a aktualizují váš Zdravotní záznam.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Vaše zdravotní záznamy, vaše pravidla';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Zobrazit, upravit nebo přidat příznaky, léky, historii nebo dokumenty kdykoli.';

  @override
  String get profilesAnnouncementTitle3 => 'Péče o celou rodinu';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Vytvořte zdravotní záznam pro své blízké, děti, rodiče nebo partnera.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Připraveni uložit svůj zdravotní záznam?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Po konzultaci klepněte na „Přidat profil“, abyste ho uložili.';

  @override
  String get profilesNextButton => 'Další';

  @override
  String get profilesStartButton => 'Zahájit konzultaci';

  @override
  String get profilesLaterButton => 'Možná později';

  @override
  String get profileSuccessCloseButton => 'Zavřít';

  @override
  String get pdfHeaderTitle => 'Zdravotní záznam';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Zdravotní záznam — $name';
  }

  @override
  String get expandableFieldMore => '...více';

  @override
  String get expandableFieldLess => '...méně';

  @override
  String get profiles_button_addnew => 'Přidat nový profil';

  @override
  String get profiles_label_addnew =>
      'Vytvořte profil pro uložení podrobností této konzultace.';

  @override
  String get profiles_label_health_records_hint =>
      'Můžete to kdykoli posoudit v Health Records';

  @override
  String get profiles_label_keep_talking_hint =>
      'Pokud máte další otázky ohledně toho nebo čehokoli s tím souvisejícího, neváhejte se mnou dál mluvit. Jsem tu, abych vám pomohl';

  @override
  String get profile_section_basic_title => 'Obecné informace';

  @override
  String get profile_section_basic_name_label => 'Jméno';

  @override
  String get profile_section_basic_name_placeholder => 'Jan Novák';

  @override
  String get profile_section_basic_first_name_label => 'Křestní jméno';

  @override
  String get profile_section_basic_first_name_placeholder => 'Jan';

  @override
  String get profile_section_basic_last_name_label => 'Příjmení';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Pohlaví';

  @override
  String get profile_section_basic_sex_placeholder => 'Vyberte prosím';

  @override
  String get profile_section_basic_sex_options_male => 'Muž';

  @override
  String get profile_section_basic_sex_options_female => 'Žena';

  @override
  String get profile_section_basic_sex_options_other => 'Jiné';

  @override
  String get profile_section_basic_date_of_birth_label => 'Datum narození';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Věk';

  @override
  String get profile_section_basic_age_str_placeholder => 'např. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Telefonní číslo';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Místo';

  @override
  String get profile_section_basic_location_placeholder => 'např. Město, Země';

  @override
  String get profile_section_body_diet_title => 'Tělo & Strava';

  @override
  String get profile_section_body_diet_height_str_label => 'Výška';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'např. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Hmotnost';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'např. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menstruační cyklus';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'např. Pravidelný, Nepravidelný';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Stravovací omezení';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Vyberte prosím';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Dejte nám vědět, co jíte a jaká máte omezení';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Žádné';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetarián';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Veganská';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Bez lepku';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Index tělesné hmotnosti (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'např. 24,5';

  @override
  String get profile_section_health_profile_title => 'Zdravotní profil';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Chronická onemocnění';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'např. Diabetes typu 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Uveďte všechny chronické nemoci a zahrňte, kdy byly diagnostikovány a jakékoliv komplikace.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Dřívější onemocnění';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'např. Časté nachlazení';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Uveďte prosím závažné nemoci, které jste měli v minulosti, i když jste se uzdravili.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Chirurgická anamnéza';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'např. apendektomie';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Uveďte prosím všechny operace a zahrňte rok a zda došlo k nějakým komplikacím.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Příležitostně užívané léky';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'např. Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Uveďte prosím léky, které užíváte občas (například: léky proti bolesti, léky na alergie), včetně dávkování a důvodu užívání.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Pravidelné léky';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'např. Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Uveďte prosím všechny léky, které pravidelně užíváte, včetně názvu, dávky, kolikrát denně je užíváte a na jaký stav jsou určeny.';

  @override
  String get profile_section_health_profile_allergies_label => 'Alergie';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'např. Penicilin – způsobuje vyrážku';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Uveďte prosím všechny alergie (léky, potraviny, prostředí) a popište, jakou reakci máte (například: vyrážka, otok, problémy s dýcháním).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Speciální stavy';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'např. těhotenství, postižení';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Pokud máte nějaké důležité zdravotní stavy, které by lékaři měli vždy znát (například: těhotenství, implantované zařízení, postižení, antikoagulační terapie), prosím, popište je. Pokud žádné nemáte, můžete to nechat prázdné.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Rodinná anamnéza';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'např. srdeční onemocnění, rakovina';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Prosím, popište důležité nemoci ve vaší rodině (například: cukrovka, vysoký krevní tlak, srdeční choroby, rakovina, genetické choroby) a uveďte, který člen rodiny měl tuto nemoc.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Sociální a životní faktory';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'např. kouření, konzumace alkoholu';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Prosím, popište faktory životního stylu, které mohou ovlivnit vaše zdraví, jako je kouření, alkohol, fyzická aktivita, strava, spánek a povolání.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Zdravotnické prostředky';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'např. kardiostimulátor, sluchadlo, inzulínová pumpa';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Uveďte prosím jakákoliv lékařská zařízení, která používáte nebo máte implantována, jako jsou kardiostimulátory, inzulinové pumpy, sluchadla, protézy nebo jiná asistenční či monitorovací zařízení. Zahrňte relevantní detaily, pokud je to možné.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Všežravý';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Rychlé občerstvení';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetarián';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Bez laktózy';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Dieta s nízkým obsahem sodíku';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Dieta s nízkým obsahem cukru';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Srdeční dieta';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Ledvinná dieta';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Jiné';
}
