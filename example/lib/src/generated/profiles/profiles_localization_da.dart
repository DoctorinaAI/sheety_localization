// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class ProfilesLocalizationDa extends ProfilesLocalization {
  ProfilesLocalizationDa([String locale = 'da']) : super(locale);

  @override
  String get chatDrawerTitle => 'Sundhedsoptegnelser';

  @override
  String get chatDrawerBadgeNew => 'NY';

  @override
  String get bannerTitle => 'Opret din Sundhedsoptegnelse';

  @override
  String get bannerSubtitle =>
      'Tilføj din profil ved slutningen af din konsultation.';

  @override
  String get bannerMoreProfilesTitle => 'Tilføj flere profiler';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Start en konsultation for en anden for at oprette deres profil';

  @override
  String get bannerSignUp =>
      'Tilmeld dig for at oprette din Sundhedsoptegnelse';

  @override
  String get errorRetryButton => 'Prøv igen';

  @override
  String get dashboardDeleteError => 'Kunne ikke slette profil';

  @override
  String get dashboardSummaryLoadError => 'Kunne ikke indlæse profiloversigt';

  @override
  String get dashboardMenuViewFullRecord => 'Se fuld optegnelse';

  @override
  String get dashboardMenuShare => 'Del';

  @override
  String get dashboardMenuDelete => 'Slet';

  @override
  String get dashboardMetricAgeLabel => 'Alder';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value år',
      one: '$value år',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Vægt';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Højde';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Allergier';

  @override
  String get dashboardInfoChronicTitle => 'Kronisk';

  @override
  String get dashboardInfoMedicationTitle => 'Medicin';

  @override
  String get dashboardInfoDevicesTitle => 'Enheder';

  @override
  String get dashboardNavigationConsultations => 'Konsultationer';

  @override
  String get dashboardNavigationDocuments => 'Dokumenter';

  @override
  String get dashboardDeleteRecordTitle => 'Slet sundhedsoptegnelse?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Dette vil permanent fjerne dine sundhedsdata og kan ikke fortrydes. Du vil miste den kontekst, vi bruger til at vejlede dig.';

  @override
  String get dashboardDeleteRecordCancel => 'Annuller';

  @override
  String get dashboardDeleteRecordConfirm => 'Slet';

  @override
  String get dashboardDeleteRecordLoading =>
      'Sletter din sundhedsoptegnelse...';

  @override
  String get dashboardDeleteRecordError => 'Kunne ikke slette profil';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Sundhedsoptegnelse slettet';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Du kan oprette en ny når som helst ved at chatte med assistenten.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Returner til chat';

  @override
  String get dataEditingScreenTitle => 'Redigering';

  @override
  String get dataFailedToLoadError => 'Kunne ikke indlæse profildata';

  @override
  String get dataRecordSavedTitle => 'Ændringer gemt';

  @override
  String get dataRecordSavedSubtitle =>
      'Dine oplysninger er blevet opdateret med succes.';

  @override
  String get dataRecordSavedButton => 'Returner til profil';

  @override
  String get dataRecordUpdateError => 'Kunne ikke opdatere profildata';

  @override
  String get dataRecordDiscardTitle => 'Forkaste ændringer?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Du har foretaget nogle ændringer i din profil. Gem dem, før du går, eller kassér dem.';

  @override
  String get dataRecordDiscardCancel => 'Fortsæt med at redigere';

  @override
  String get dataRecordDiscardConfirm => 'Forkast';

  @override
  String get dataRecordEditTooltip => 'Rediger';

  @override
  String get dataRecordAddTag => 'Tilføj post';

  @override
  String get consultationsSearch => 'Søg';

  @override
  String get consultationsSearchEmpty => 'Ingen resultater fundet';

  @override
  String get documentsMenuDownload => 'Download';

  @override
  String get documentsMenuShare => 'Del';

  @override
  String get documentsMenuDelete => 'Slet';

  @override
  String get documentsEmptyList => 'Ingen dokumenter fundet';

  @override
  String get documentsDeleteTitle => 'Slette dette dokument?';

  @override
  String get documentsDeleteSubtitle => 'Denne fil vil blive permanent fjernet';

  @override
  String get documentsDeleteCancel => 'Annuller';

  @override
  String get documentsDeleteButton => 'Slet';

  @override
  String get documentsMoreActionsTooltip => 'Flere handlinger';

  @override
  String get profilesSearch => 'Søg';

  @override
  String get profilesEmptyList => 'Ingen profiler fundet';

  @override
  String get profilesViewMore => 'Se mere';

  @override
  String get profilesMore => 'Mere';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina husker nu dit helbred';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Dine konsultationer opbygger og opdaterer nu automatisk din Sundhedsoptegnelse.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Din sundhedsoptegnelse, dine regler';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Se, rediger eller tilføj symptomer, medicin, historie eller dokumenter når som helst.';

  @override
  String get profilesAnnouncementTitle3 => 'Pas på hele din familie';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Opret en sundhedsoptegnelse for dine kære, dine børn, forældre eller partner.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Klar til at gemme din sundhedsjournal?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Efter din konsultation, tryk på \"Tilføj profil\" for at gemme det.';

  @override
  String get profilesNextButton => 'Næste';

  @override
  String get profilesStartButton => 'Start en konsultation';

  @override
  String get profilesLaterButton => 'Måske senere';

  @override
  String get profileSuccessCloseButton => 'Luk';

  @override
  String get pdfHeaderTitle => 'Sundhedsoptegnelse';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Sundhedsoptegnelse — $name';
  }

  @override
  String get expandableFieldMore => '...mere';

  @override
  String get expandableFieldLess => '...mindre';

  @override
  String get profiles_button_addnew => 'Tilføj ny profil';

  @override
  String get profiles_label_addnew =>
      'Opret en profil for at gemme detaljerne om denne konsultation';

  @override
  String get profiles_label_health_records_hint =>
      'Du kan vurdere det når som helst i dine sundhedsoplysninger';

  @override
  String get profiles_label_keep_talking_hint =>
      'Hvis du har flere spørgsmål om dette eller noget relateret, er du velkommen til at blive ved med at tale med mig. Jeg er her for at hjælpe';

  @override
  String get profile_section_basic_title => 'Generelle Oplysninger';

  @override
  String get profile_section_basic_name_label => 'Navn';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'Fornavn';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => 'Efternavn';

  @override
  String get profile_section_basic_last_name_placeholder => 'Jensen';

  @override
  String get profile_section_basic_sex_label => 'Køn';

  @override
  String get profile_section_basic_sex_placeholder => 'Vælg venligst';

  @override
  String get profile_section_basic_sex_options_male => 'Mand';

  @override
  String get profile_section_basic_sex_options_female => 'Kvinde';

  @override
  String get profile_section_basic_sex_options_other => 'Andet';

  @override
  String get profile_section_basic_date_of_birth_label => 'Fødselsdato';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Alder';

  @override
  String get profile_section_basic_age_str_placeholder => 'f.eks. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Telefonnummer';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Placering';

  @override
  String get profile_section_basic_location_placeholder => 'f.eks. By, Land';

  @override
  String get profile_section_body_diet_title => 'Krop & Kost';

  @override
  String get profile_section_body_diet_height_str_label => 'Højde';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'f.eks. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Vægt';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'f.eks. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menstruationscyklus';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'f.eks. Regelmæssig, Uregelmæssig';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Kostbegrænsninger';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Vælg';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Lad os vide, hvad du spiser, og hvilke begrænsninger du har';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Ingen';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetar';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Veganer';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Glutenfri';

  @override
  String get profile_section_body_diet_bmi_label => 'Kropsmasseindeks (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'f.eks. 24,5';

  @override
  String get profile_section_health_profile_title => 'Sundhedsprofil';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Kroniske sygdomme';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'f.eks. Type 2 Diabetes';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Angiv venligst alle kroniske sygdomme og inkluder, hvornår de blev diagnosticeret, og eventuelle komplikationer.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Tidligere sygdomme';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'f.eks. hyppig forkølelse';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Angiv venligst alvorlige sygdomme, du har haft tidligere, selvom du er blevet rask';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Tidligere operationer';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'f.eks. Appendektomi';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Angiv venligst alle operationer og inkluder året samt om der var nogen komplikationer.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Lejlighedsvis brugt medicin';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'f.eks. Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Angiv venligst de medicin, du tager fra tid til anden (for eksempel: smertestillende, allergimedicin), inklusive dosis og årsag til brug.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Regelmæssige Lægemidler';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'f.eks. Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Angiv venligst alle de medicin, du tager regelmæssigt, herunder navn, dosis, hvor mange gange om dagen du tager det, og hvilken tilstand det er til.';

  @override
  String get profile_section_health_profile_allergies_label => 'Allergier';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'f.eks. penicillin – forårsager udslæt';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Angiv venligst alle allergier (medicin, mad, miljø) og beskriv, hvilken reaktion du har (for eksempel: udslæt, hævelse, vejrtrækningsproblemer).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Særlige Tilstande';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'f.eks. Graviditet, Handicap';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Hvis du har nogen vigtige medicinske tilstande, som læger altid bør vide om (for eksempel: graviditet, implanterede enheder, handicap, antikoagulationsbehandling), bedes du beskrive dem. Hvis ikke, kan du lade dette stå tomt.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Familiehistorie';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'f.eks. hjertesygdom, kræft';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Beskriv venligst vigtige sygdomme i din familie (for eksempel: diabetes, hypertension, hjertesygdom, kræft, genetiske sygdomme) og angiv, hvilket familiemedlem der havde tilstanden.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Sociale & Livsstilsfaktorer';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'f.eks. rygning, alkoholforbrug';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Beskriv venligst livsstilsfaktorer, der kan påvirke dit helbred, såsom rygning, alkohol, fysisk aktivitet, kost, søvn og beskæftigelse.';

  @override
  String get profile_section_health_profile_devices_label => 'Medicinsk udstyr';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'f.eks. Pacemaker, Høreapparat, Insulinpumpe';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Angiv venligst eventuelle medicinske enheder, du bruger eller har implanteret, såsom pacemakere, insulinpumper, høreapparater, proteser eller andre hjælpemidler eller overvågningsenheder. Inkluder relevante detaljer, hvis det er relevant.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Altædende';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Fastfood';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetar';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Laktosefri';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Saltfattig kost';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Sukkerfattig diæt';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Hjertevenlig kost';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Nyrediæt';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Andet';
}
