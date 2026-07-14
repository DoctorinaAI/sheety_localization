// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class ProfilesLocalizationRo extends ProfilesLocalization {
  ProfilesLocalizationRo([String locale = 'ro']) : super(locale);

  @override
  String get chatDrawerTitle => 'Dosare medicale';

  @override
  String get chatDrawerBadgeNew => 'NOU';

  @override
  String get bannerTitle => 'Creează-ți Dosarul Medical';

  @override
  String get bannerSubtitle =>
      'La sfârșitul consultației, adăugați profilul dvs.';

  @override
  String get bannerMoreProfilesTitle => 'Adaugă mai multe profile';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Începe o consultație pentru altcineva pentru a crea profilul lor.';

  @override
  String get bannerSignUp => 'Înscrie-te pentru a-ți crea Dosarul Medical';

  @override
  String get errorRetryButton => 'Reîncercați';

  @override
  String get dashboardDeleteError => 'Ștergerea profilului a eșuat';

  @override
  String get dashboardSummaryLoadError =>
      'Eșec la încărcarea rezumatului profilului';

  @override
  String get dashboardMenuViewFullRecord => 'Vezi înregistrarea completă';

  @override
  String get dashboardMenuShare => 'Împărtășește';

  @override
  String get dashboardMenuDelete => 'Șterge';

  @override
  String get dashboardMetricAgeLabel => 'Vârstă';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ani',
      one: '$value an',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Greutate';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Înălțime';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Alergii';

  @override
  String get dashboardInfoChronicTitle => 'Cronice';

  @override
  String get dashboardInfoMedicationTitle => 'Medicamente';

  @override
  String get dashboardInfoDevicesTitle => 'Dispozitive';

  @override
  String get dashboardNavigationConsultations => 'Consultări';

  @override
  String get dashboardNavigationDocuments => 'Documente';

  @override
  String get dashboardDeleteRecordTitle => 'Ștergeți dosarul medical?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Aceasta va elimina permanent datele dumneavoastră de sănătate și nu poate fi anulată. Veți pierde contextul pe care îl folosim pentru a vă ghida.';

  @override
  String get dashboardDeleteRecordCancel => 'Anulează';

  @override
  String get dashboardDeleteRecordConfirm => 'Șterge';

  @override
  String get dashboardDeleteRecordLoading =>
      'Ștergerea dosarului tău medical...';

  @override
  String get dashboardDeleteRecordError => 'Nu s-a putut șterge profilul';

  @override
  String get dashboardDeleteRecordSuccessTitle =>
      'Fișa medicală a fost ștearsă';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Puteți crea unul nou oricând discutând cu asistentul.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Întoarce-te la chat';

  @override
  String get dataEditingScreenTitle => 'Editare';

  @override
  String get dataFailedToLoadError => 'Nu s-a putut încărca datele profilului';

  @override
  String get dataRecordSavedTitle => 'Modificările au fost salvate';

  @override
  String get dataRecordSavedSubtitle =>
      'Informațiile dumneavoastră au fost actualizate cu succes.';

  @override
  String get dataRecordSavedButton => 'Întoarceți-vă la profil';

  @override
  String get dataRecordUpdateError => 'Actualizarea datelor profilului a eșuat';

  @override
  String get dataRecordDiscardTitle => 'Renunțați la modificări?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Ați făcut câteva modificări la profilul dumneavoastră. Salvați-le înainte de a pleca sau renunțați la ele.';

  @override
  String get dataRecordDiscardCancel => 'Continuă editarea';

  @override
  String get dataRecordDiscardConfirm => 'Aruncă';

  @override
  String get dataRecordEditTooltip => 'Editează';

  @override
  String get dataRecordAddTag => 'Adaugă înregistrare';

  @override
  String get consultationsSearch => 'Caută';

  @override
  String get consultationsSearchEmpty => 'Nu s-au găsit rezultate';

  @override
  String get documentsMenuDownload => 'Descarcă';

  @override
  String get documentsMenuShare => 'Împărtășește';

  @override
  String get documentsMenuDelete => 'Șterge';

  @override
  String get documentsEmptyList => 'Nu au fost găsite documente';

  @override
  String get documentsDeleteTitle => 'Șterge acest document?';

  @override
  String get documentsDeleteSubtitle => 'Acest fișier va fi eliminat permanent';

  @override
  String get documentsDeleteCancel => 'Anulează';

  @override
  String get documentsDeleteButton => 'Șterge';

  @override
  String get documentsMoreActionsTooltip => 'Mai multe acțiuni';

  @override
  String get profilesSearch => 'Caută';

  @override
  String get profilesEmptyList => 'Nu au fost găsite profiluri';

  @override
  String get profilesViewMore => 'Vezi mai mult';

  @override
  String get profilesMore => 'Mai multe';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina îți amintește acum de sănătatea ta';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Consultațiile dumneavoastră acum construiesc și actualizează automat Dosarul de Sănătate.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Dosarul tău de sănătate, regulile tale';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Vizualizați, editați sau adăugați simptome, medicamente, istoric sau documente oricând.';

  @override
  String get profilesAnnouncementTitle3 => 'Îngrijire pentru întreaga familie';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Creează un Dosar Medical pentru cei dragi, copiii tăi, părinți sau partener.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Ești gata să îți salvezi Dosarul Medical?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'După consultație, apasă „Adaugă profil” pentru a-l salva.';

  @override
  String get profilesNextButton => 'Următorul';

  @override
  String get profilesStartButton => 'Începe o consultație';

  @override
  String get profilesLaterButton => 'Poate mai târziu';

  @override
  String get profileSuccessCloseButton => 'Închide';

  @override
  String get pdfHeaderTitle => 'Fișa medicală';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Fișa medicală — $name';
  }

  @override
  String get expandableFieldMore => '...mai mult';

  @override
  String get expandableFieldLess => '...mai puțin';

  @override
  String get profiles_button_addnew => 'Adaugă profil nou';

  @override
  String get profiles_label_addnew =>
      'Creează un profil pentru a salva detaliile acestei consultații.';

  @override
  String get profiles_label_health_records_hint =>
      'Îl puteți evalua oricând în Health Records';

  @override
  String get profiles_label_keep_talking_hint =>
      'Dacă ai mai multe întrebări despre asta sau despre orice legat de acest subiect, simte-te liber să continui să vorbești cu mine. Sunt aici să te ajut';

  @override
  String get profile_section_basic_title => 'Informații generale';

  @override
  String get profile_section_basic_name_label => 'Nume';

  @override
  String get profile_section_basic_name_placeholder => 'Ion Popescu';

  @override
  String get profile_section_basic_first_name_label => 'Prenume';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => 'Nume de familie';

  @override
  String get profile_section_basic_last_name_placeholder => 'Popescu';

  @override
  String get profile_section_basic_sex_label => 'Sex';

  @override
  String get profile_section_basic_sex_placeholder => 'Vă rugăm să selectați';

  @override
  String get profile_section_basic_sex_options_male => 'Masculin';

  @override
  String get profile_section_basic_sex_options_female => 'Femeie';

  @override
  String get profile_section_basic_sex_options_other => 'Altul';

  @override
  String get profile_section_basic_date_of_birth_label => 'Data nașterii';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Vârstă';

  @override
  String get profile_section_basic_age_str_placeholder => 'ex. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Număr de telefon';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Locație';

  @override
  String get profile_section_basic_location_placeholder => 'ex. Oraș, Țară';

  @override
  String get profile_section_body_diet_title => 'Corp & Dietă';

  @override
  String get profile_section_body_diet_height_str_label => 'Înălțime';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'ex. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Greutate';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'ex. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Ciclu Menstrual';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'de ex. Regulat, Neregulat';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Restricții alimentare';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Vă rugăm să selectați';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Spune-ne ce mănânci și orice restricții ai';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Niciuna';

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
          'Fără gluten';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Indicele de masă corporală (IMC)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'de ex. 24.5';

  @override
  String get profile_section_health_profile_title => 'Profil de sănătate';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Afecțiuni cronice';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'de exemplu, diabet zaharat de tip 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Vă rugăm să listați toate bolile cronice și să includeți când au fost diagnosticate și orice complicații.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Afecțiuni anterioare';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'de exemplu, Răceală comună frecventă';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Vă rugăm să listați bolile grave pe care le-ați avut în trecut, chiar dacă v-ați recuperat.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Antecedente chirurgicale';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'ex. Apendicectomie';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Vă rugăm să listați toate intervențiile chirurgicale și să includeți anul și dacă au existat complicații.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Medicamente Utilizate Ocazional';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'de exemplu: Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Vă rugăm să listați medicamentele pe care le luați din când în când (de exemplu: analgezice, medicamente pentru alergii), inclusiv doza și motivul utilizării.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Medicație regulată';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'de exemplu: Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Vă rugăm să listați toate medicamentele pe care le luați regulat, inclusiv numele, doza, de câte ori pe zi le luați și pentru ce afecțiune sunt.';

  @override
  String get profile_section_health_profile_allergies_label => 'Alergii';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'de exemplu: Penicilină – cauzează erupție';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Vă rugăm să listați toate alergiile (medicamente, alimente, mediu) și să descrieți ce reacție aveți (de exemplu: erupție cutanată, umflare, probleme respiratorii).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Condiții Speciale';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'de ex. Sarcină, Dizabilitate';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Dacă aveți condiții medicale importante de care medicii ar trebui să știe întotdeauna (de exemplu: sarcină, dispozitive implantate, dizabilități, terapie anticoagulantă), vă rugăm să le descrieți. Dacă nu, puteți lăsa acest câmp gol.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Antecedente familiale';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'ex. boli cardiace, cancer';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Vă rugăm să descrieți bolile importante din familia dumneavoastră (de exemplu: diabet, hipertensiune, boli de inimă, cancer, boli genetice) și să specificați ce membru al familiei a avut această afecțiune.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Factori sociali și de stil de viață';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'de ex. Fumat, Consum de alcool';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Vă rugăm să descrieți factorii de stil de viață care pot afecta sănătatea dumneavoastră, cum ar fi fumatul, alcoolul, activitatea fizică, dieta, somnul și ocupația.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Dispozitive medicale';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'de ex. pacemaker, aparat auditiv, pompă de insulină';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Vă rugăm să listați orice dispozitive medicale pe care le utilizați sau le aveți implantate, cum ar fi stimulatoare cardiace, pompe de insulină, aparate auditive, proteze sau alte dispozitive de asistență sau monitorizare. Includeți detalii relevante, dacă este cazul.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Omnivor';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Fast Food';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetar';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Fără lactoză';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Dietă cu conținut scăzut de sodiu';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Dietă săracă în zahăr';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Dietă cardiacă';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Dietă renală';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Altul';
}
