// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Slovak (`sk`).
class ProfilesLocalizationSk extends ProfilesLocalization {
  ProfilesLocalizationSk([String locale = 'sk']) : super(locale);

  @override
  String get chatDrawerTitle => 'Zdravotné záznamy';

  @override
  String get chatDrawerBadgeNew => 'NOVÉ';

  @override
  String get bannerTitle => 'Vytvorte si zdravotný záznam';

  @override
  String get bannerSubtitle => 'Na konci konzultácie pridajte svoj profil.';

  @override
  String get bannerMoreProfilesTitle => 'Pridať viac profilov';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Začnite konzultáciu pre niekoho iného, aby si vytvoril svoj profil.';

  @override
  String get bannerSignUp =>
      'Zaregistrujte sa a vytvorte si svoj Zdravotný záznam';

  @override
  String get errorRetryButton => 'Skúsiť znova';

  @override
  String get dashboardDeleteError => 'Nepodarilo sa zmazať profil';

  @override
  String get dashboardSummaryLoadError => 'Nepodarilo sa načítať súhrn profilu';

  @override
  String get dashboardMenuViewFullRecord => 'Zobraziť celý záznam';

  @override
  String get dashboardMenuShare => 'Zdieľať';

  @override
  String get dashboardMenuDelete => 'Zmazať';

  @override
  String get dashboardMetricAgeLabel => 'Vek';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value rokov',
      one: '$value rok',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Hmotnosť';

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
  String get dashboardInfoMedicationTitle => 'Lieky';

  @override
  String get dashboardInfoDevicesTitle => 'Zariadenia';

  @override
  String get dashboardNavigationConsultations => 'Konzultácie';

  @override
  String get dashboardNavigationDocuments => 'Dokumenty';

  @override
  String get dashboardDeleteRecordTitle => 'Zmazať zdravotný záznam?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Toto trvalo odstráni vaše zdravotné údaje a nemožno to vrátiť späť. Stratíte kontext, ktorý používame na to, aby sme vás usmerňovali.';

  @override
  String get dashboardDeleteRecordCancel => 'Zrušiť';

  @override
  String get dashboardDeleteRecordConfirm => 'Zmazať';

  @override
  String get dashboardDeleteRecordLoading =>
      'Odstraňujem váš zdravotný záznam...';

  @override
  String get dashboardDeleteRecordError => 'Nepodarilo sa odstrániť profil';

  @override
  String get dashboardDeleteRecordSuccessTitle =>
      'Zdravotný záznam bol odstránený';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Nový môžete vytvoriť kedykoľvek tak, že sa porozprávate s asistentom.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Návrat do chatu';

  @override
  String get dataEditingScreenTitle => 'Úprava';

  @override
  String get dataFailedToLoadError => 'Nepodarilo sa načítať profilové údaje';

  @override
  String get dataRecordSavedTitle => 'Zmeny uložené';

  @override
  String get dataRecordSavedSubtitle =>
      'Vaše informácie boli úspešne aktualizované.';

  @override
  String get dataRecordSavedButton => 'Návrat na profil';

  @override
  String get dataRecordUpdateError =>
      'Nepodarilo sa aktualizovať údaje profilu';

  @override
  String get dataRecordDiscardTitle => 'Zahodiť zmeny?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Urobili ste niektoré zmeny vo svojom profile. Uložte ich pred odchodom alebo ich zahoďte.';

  @override
  String get dataRecordDiscardCancel => 'Pokračovať v úprave';

  @override
  String get dataRecordDiscardConfirm => 'Zahodiť';

  @override
  String get dataRecordEditTooltip => 'Upraviť';

  @override
  String get dataRecordAddTag => 'Pridať záznam';

  @override
  String get consultationsSearch => 'Hľadať';

  @override
  String get consultationsSearchEmpty => 'Nenašli sa žiadne výsledky';

  @override
  String get documentsMenuDownload => 'Stiahnuť';

  @override
  String get documentsMenuShare => 'Zdieľať';

  @override
  String get documentsMenuDelete => 'Zmazať';

  @override
  String get documentsEmptyList => 'Nenašli sa žiadne dokumenty';

  @override
  String get documentsDeleteTitle => 'Zmazať tento dokument?';

  @override
  String get documentsDeleteSubtitle => 'Tento súbor bude trvalo odstránený';

  @override
  String get documentsDeleteCancel => 'Zrušiť';

  @override
  String get documentsDeleteButton => 'Zmazať';

  @override
  String get documentsMoreActionsTooltip => 'Ďalšie akcie';

  @override
  String get profilesSearch => 'Hľadať';

  @override
  String get profilesEmptyList => 'Nenašli sa žiadne profily';

  @override
  String get profilesViewMore => 'Zobraziť viac';

  @override
  String get profilesMore => 'Viac';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina si teraz pamätá vaše zdravie';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Vaše konzultácie teraz automaticky vytvárajú a aktualizujú váš Zdravotný záznam.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Vaša zdravotná dokumentácia, vaše pravidlá';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Zobrazte, upravte alebo pridajte symptómy, lieky, históriu alebo dokumenty kedykoľvek.';

  @override
  String get profilesAnnouncementTitle3 => 'Starostlivosť o celú rodinu';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Vytvorte zdravotný záznam pre svojich blízkych, deti, rodičov alebo partnera.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Pripravení uložiť svoj zdravotný záznam?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Po vašej konzultácii ťuknite na „Pridať profil“, aby ste ho uložili.';

  @override
  String get profilesNextButton => 'Ďalší';

  @override
  String get profilesStartButton => 'Začať konzultáciu';

  @override
  String get profilesLaterButton => 'Možno neskôr';

  @override
  String get profileSuccessCloseButton => 'Zavrieť';

  @override
  String get pdfHeaderTitle => 'Zdravotná dokumentácia';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Zdravotný záznam — $name';
  }

  @override
  String get expandableFieldMore => '...viac';

  @override
  String get expandableFieldLess => '...menej';

  @override
  String get profiles_button_addnew => 'Pridať nový profil';

  @override
  String get profiles_label_addnew =>
      'Vytvorte profil na uloženie podrobností o tejto konzultácii';

  @override
  String get profiles_label_health_records_hint =>
      'Môžete to kedykoľvek posúdiť vo vašich Health Records';

  @override
  String get profiles_label_keep_talking_hint =>
      'Ak máte ďalšie otázky o tomto alebo o čomkoľvek súvisiacom, kľudne sa so mnou ďalej porozprávajte. Som tu, aby som pomohol';

  @override
  String get profile_section_basic_title => 'Všeobecné Informácie';

  @override
  String get profile_section_basic_name_label => 'Meno';

  @override
  String get profile_section_basic_name_placeholder => 'Ján Novák';

  @override
  String get profile_section_basic_first_name_label => 'Krstné meno';

  @override
  String get profile_section_basic_first_name_placeholder => 'Ján';

  @override
  String get profile_section_basic_last_name_label => 'Priezvisko';

  @override
  String get profile_section_basic_last_name_placeholder => 'Novák';

  @override
  String get profile_section_basic_sex_label => 'Pohlavie';

  @override
  String get profile_section_basic_sex_placeholder => 'Vyberte';

  @override
  String get profile_section_basic_sex_options_male => 'Muž';

  @override
  String get profile_section_basic_sex_options_female => 'Žena';

  @override
  String get profile_section_basic_sex_options_other => 'Iné';

  @override
  String get profile_section_basic_date_of_birth_label => 'Dátum narodenia';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Vek';

  @override
  String get profile_section_basic_age_str_placeholder => 'napr. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Telefónne číslo';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Miesto';

  @override
  String get profile_section_basic_location_placeholder =>
      'napr. Mesto, Krajina';

  @override
  String get profile_section_body_diet_title => 'Telo & Strava';

  @override
  String get profile_section_body_diet_height_str_label => 'Výška';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'napr. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Hmotnosť';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'napr. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menštruačný cyklus';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'napr. Pravidelný, Nepravidelný';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Stravovacie obmedzenia';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Vyberte';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Dajte nám vedieť, čo jete a aké obmedzenia máte';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Žiadne';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetarián';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegán';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Bez lepku';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Index telesnej hmotnosti (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'napr. 24,5';

  @override
  String get profile_section_health_profile_title => 'Zdravotný profil';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Chronické ochorenia';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'napr. Diabetes typu 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Uveďte všetky chronické ochorenia a zahrňte, kedy boli diagnostikované a akékoľvek komplikácie.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Predchádzajúce ochorenia';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'napr. časté prechladnutie';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Prosím, uveďte vážne ochorenia, ktoré ste mali v minulosti, aj keď ste sa uzdravili';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Chirurgická anamnéza';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'napr. Apendektómia';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Prosím, uveďte všetky operácie a zahrňte rok a či došlo k nejakým komplikáciám.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Príležitostne užívané lieky';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'napr. Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Prosím, uveďte lieky, ktoré užívate občas (napríklad: lieky proti bolesti, alergické lieky), vrátane dávky a dôvodu použitia.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Pravidelné lieky';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'napr. Metformín';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Prosím, uveďte všetky lieky, ktoré pravidelne užívate, vrátane názvu, dávky, koľkokrát denne ich užívate a na akú chorobu sú.';

  @override
  String get profile_section_health_profile_allergies_label => 'Alergie';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'napr. penicilín – spôsobuje vyrážku';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Prosím, uveďte všetky alergie (lieky, jedlo, prostredie) a popíšte, akú reakciu máte (napríklad: vyrážka, opuch, problémy s dýchaním).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Špeciálne Zdravotné Stavy';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'napr. Tehotenstvo, Postihnutie';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Ak máte akékoľvek dôležité zdravotné ťažkosti, o ktorých by mali lekári vždy vedieť (napríklad: tehotenstvo, implantované zariadenia, postihnutia, antikoagulačná terapia), prosím, popíšte ich. Ak nemáte žiadne, môžete to nechať prázdne.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Rodinná anamnéza';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'napr. srdcové choroby, rakovina';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Prosím, popíšte dôležité choroby vo vašej rodine (napríklad: cukrovka, hypertenzia, srdcové choroby, rakovina, genetické choroby) a uveďte, ktorý rodinný príslušník mal daný stav.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Sociálne & Faktory Životného Štýlu';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'napr. fajčenie, konzumácia alkoholu';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Prosím, popíšte faktory životného štýlu, ktoré môžu ovplyvniť vaše zdravie, ako sú fajčenie, alkohol, fyzická aktivita, strava, spánok a zamestnanie.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Zdravotnícke pomôcky';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'napr. kardiostimulátor, sluchadlo, inzulínová pumpa';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Prosím, uveďte akékoľvek lekárske zariadenia, ktoré používate alebo máte implantované, ako sú kardiostimulátory, inzulínové pumpy, sluchadlá, protézy alebo iné asistenčné alebo monitorovacie zariadenia. Zahrňte relevantné podrobnosti, ak je to možné.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Všežravý';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Rýchle občerstvenie';

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
          'Nízkosodíková diéta';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Diéta s nízkym obsahom cukru';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Diéta pri srdcovom ochorení';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Renálna diéta';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Iné';
}
