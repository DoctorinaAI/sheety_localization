// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class ProfilesLocalizationDe extends ProfilesLocalization {
  ProfilesLocalizationDe([String locale = 'de']) : super(locale);

  @override
  String get chatDrawerTitle => 'Gesundheitsakten';

  @override
  String get chatDrawerBadgeNew => 'NEU';

  @override
  String get bannerTitle => 'Erstellen Sie Ihre Gesundheitsakte';

  @override
  String get bannerSubtitle =>
      'Fügen Sie am Ende Ihrer Beratung Ihr Profil hinzu.';

  @override
  String get bannerMoreProfilesTitle => 'Weitere Profile hinzufügen';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Starten Sie eine Beratung für jemand anderen, um dessen Profil zu erstellen.';

  @override
  String get bannerSignUp =>
      'Melden Sie sich an, um Ihre Gesundheitsakte zu erstellen';

  @override
  String get errorRetryButton => 'Erneut versuchen';

  @override
  String get dashboardDeleteError => 'Profil konnte nicht gelöscht werden';

  @override
  String get dashboardSummaryLoadError =>
      'Fehler beim Laden der Profilübersicht';

  @override
  String get dashboardMenuViewFullRecord => 'Vollständigen Datensatz anzeigen';

  @override
  String get dashboardMenuShare => 'Teilen';

  @override
  String get dashboardMenuDelete => 'Löschen';

  @override
  String get dashboardMetricAgeLabel => 'Alter';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value Jahre',
      one: '$value Jahr',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Gewicht';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Höhe';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Allergien';

  @override
  String get dashboardInfoChronicTitle => 'Chronisch';

  @override
  String get dashboardInfoMedicationTitle => 'Medikament';

  @override
  String get dashboardInfoDevicesTitle => 'Geräte';

  @override
  String get dashboardNavigationConsultations => 'Konsultationen';

  @override
  String get dashboardNavigationDocuments => 'Dokumente';

  @override
  String get dashboardDeleteRecordTitle => 'Gesundheitsakte löschen?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Dies wird Ihre Gesundheitsdaten dauerhaft entfernen und kann nicht rückgängig gemacht werden. Sie verlieren den Kontext, den wir verwenden, um Sie zu leiten.';

  @override
  String get dashboardDeleteRecordCancel => 'Abbrechen';

  @override
  String get dashboardDeleteRecordConfirm => 'Löschen';

  @override
  String get dashboardDeleteRecordLoading =>
      'Löschen Ihres Gesundheitsdatensatzes...';

  @override
  String get dashboardDeleteRecordError =>
      'Profil konnte nicht gelöscht werden';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Gesundheitsakte gelöscht';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Sie können jederzeit einen neuen erstellen, indem Sie mit dem Assistenten chatten.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Zurück zum Chat';

  @override
  String get dataEditingScreenTitle => 'Bearbeiten';

  @override
  String get dataFailedToLoadError =>
      'Profildaten konnten nicht geladen werden';

  @override
  String get dataRecordSavedTitle => 'Änderungen gespeichert';

  @override
  String get dataRecordSavedSubtitle =>
      'Ihre Informationen wurden erfolgreich aktualisiert.';

  @override
  String get dataRecordSavedButton => 'Zurück zum Profil';

  @override
  String get dataRecordUpdateError =>
      'Fehler beim Aktualisieren der Profildaten';

  @override
  String get dataRecordDiscardTitle => 'Änderungen verwerfen?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Sie haben einige Änderungen an Ihrem Profil vorgenommen. Speichern Sie sie, bevor Sie gehen, oder verwerfen Sie sie.';

  @override
  String get dataRecordDiscardCancel => 'Weiter bearbeiten';

  @override
  String get dataRecordDiscardConfirm => 'Verwerfen';

  @override
  String get dataRecordEditTooltip => 'Bearbeiten';

  @override
  String get dataRecordAddTag => 'Aufzeichnung hinzufügen';

  @override
  String get consultationsSearch => 'Suche';

  @override
  String get consultationsSearchEmpty => 'Keine Ergebnisse gefunden';

  @override
  String get documentsMenuDownload => 'Herunterladen';

  @override
  String get documentsMenuShare => 'Teilen';

  @override
  String get documentsMenuDelete => 'Löschen';

  @override
  String get documentsEmptyList => 'Keine Dokumente gefunden';

  @override
  String get documentsDeleteTitle => 'Dieses Dokument löschen?';

  @override
  String get documentsDeleteSubtitle => 'Diese Datei wird dauerhaft entfernt';

  @override
  String get documentsDeleteCancel => 'Abbrechen';

  @override
  String get documentsDeleteButton => 'Löschen';

  @override
  String get documentsMoreActionsTooltip => 'Weitere Aktionen';

  @override
  String get profilesSearch => 'Suche';

  @override
  String get profilesEmptyList => 'Keine Profile gefunden';

  @override
  String get profilesViewMore => 'Mehr anzeigen';

  @override
  String get profilesMore => 'Mehr';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina erinnert sich jetzt an Ihre Gesundheit';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Ihre Konsultationen erstellen und aktualisieren jetzt automatisch Ihre Gesundheitsakte.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Ihr Gesundheitsbericht, Ihre Regeln';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Symptome, Medikamente, Vorgeschichte oder Dokumente jederzeit anzeigen, bearbeiten oder hinzufügen.';

  @override
  String get profilesAnnouncementTitle3 =>
      'Kümmern Sie sich um Ihre ganze Familie';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Erstellen Sie eine Gesundheitsakte für Ihre Angehörigen, Ihre Kinder, Eltern oder Partner.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Bereit, Ihre Gesundheitsakte zu speichern?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Tippen Sie nach Ihrer Beratung auf „Profil hinzufügen“, um es zu speichern.';

  @override
  String get profilesNextButton => 'Weiter';

  @override
  String get profilesStartButton => 'Eine Beratung starten';

  @override
  String get profilesLaterButton => 'Vielleicht später';

  @override
  String get profileSuccessCloseButton => 'Schließen';

  @override
  String get pdfHeaderTitle => 'Gesundheitsakte';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Gesundheitsakte — $name';
  }

  @override
  String get expandableFieldMore => '...mehr';

  @override
  String get expandableFieldLess => '...weniger';

  @override
  String get profiles_button_addnew => 'Neues Profil hinzufügen';

  @override
  String get profiles_label_addnew =>
      'Erstellen Sie ein Profil, um die Details dieser Konsultation zu speichern.';

  @override
  String get profiles_label_health_records_hint =>
      'Sie können es jederzeit in Ihren Gesundheitsakten einsehen';

  @override
  String get profiles_label_keep_talking_hint =>
      'Wenn Sie weitere Fragen dazu oder zu etwas anderem haben, können Sie gerne weiter mit mir sprechen. Ich bin hier, um zu helfen';

  @override
  String get profile_section_basic_title => 'Allgemeine Informationen';

  @override
  String get profile_section_basic_name_label => 'Name';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'Vorname';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => 'Nachname';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Geschlecht';

  @override
  String get profile_section_basic_sex_placeholder => 'Bitte auswählen';

  @override
  String get profile_section_basic_sex_options_male => 'Männlich';

  @override
  String get profile_section_basic_sex_options_female => 'Weiblich';

  @override
  String get profile_section_basic_sex_options_other => 'Andere';

  @override
  String get profile_section_basic_date_of_birth_label => 'Geburtsdatum';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'JJJJ-MM-TT';

  @override
  String get profile_section_basic_age_str_label => 'Alter';

  @override
  String get profile_section_basic_age_str_placeholder => 'z.B. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Telefonnummer';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-Mail';

  @override
  String get profile_section_basic_email_placeholder => 'beispiel@example.com';

  @override
  String get profile_section_basic_location_label => 'Standort';

  @override
  String get profile_section_basic_location_placeholder => 'z.B. Stadt, Land';

  @override
  String get profile_section_body_diet_title => 'Körper & Ernährung';

  @override
  String get profile_section_body_diet_height_str_label => 'Höhe';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'z.B. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Gewicht';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'z.B. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menstruationszyklus';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'z.B. Regelmäßig, Unregelmäßig';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Diätetische Einschränkungen';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Bitte auswählen';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Lassen Sie uns wissen, was Sie essen und welche Einschränkungen Sie haben';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Keine';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetarisch';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegan';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Glutenfrei';

  @override
  String get profile_section_body_diet_bmi_label => 'Body-Mass-Index (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'z.B. 24,5';

  @override
  String get profile_section_health_profile_title => 'Gesundheitsprofil';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Chronische Krankheiten';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'z.B. Diabetes Typ 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Bitte listen Sie alle chronischen Krankheiten auf und geben Sie an, wann sie diagnostiziert wurden und ob es Komplikationen gab.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Frühere Erkrankungen';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'z.B. Häufige Erkältungen';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Bitte listen Sie ernsthafte Krankheiten auf, die Sie in der Vergangenheit hatten, auch wenn Sie sich erholt haben.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Chirurgische Vorgeschichte';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'z.B. Appendektomie';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Bitte listen Sie alle Operationen auf und geben Sie das Jahr sowie eventuelle Komplikationen an.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Gelegentlich verwendete Medikamente';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'z.B. Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Bitte listen Sie Medikamente auf, die Sie von Zeit zu Zeit einnehmen (zum Beispiel: Schmerzmittel, Allergiemedikamente), einschließlich der Dosis und des Verwendungszwecks.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Regelmäßige Medikamente';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'z.B. Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Bitte listen Sie alle Medikamente auf, die Sie regelmäßig einnehmen, einschließlich des Namens, der Dosis, wie oft Sie es täglich einnehmen und wofür es bestimmt ist.';

  @override
  String get profile_section_health_profile_allergies_label => 'Allergien';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'z.B. Penicillin – verursacht Ausschlag';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Bitte listen Sie alle Allergien (Medikamente, Lebensmittel, Umwelt) auf und beschreiben Sie, welche Reaktion Sie haben (zum Beispiel: Ausschlag, Schwellung, Atemprobleme).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Besondere Bedingungen';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'z.B. Schwangerschaft, Behinderung';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Wenn Sie wichtige medizinische Bedingungen haben, die Ärzte immer wissen sollten (zum Beispiel: Schwangerschaft, implantierte Geräte, Behinderungen, Antikoagulationstherapie), beschreiben Sie diese bitte. Wenn keine vorhanden sind, können Sie dies leer lassen.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Familiengeschichte';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'z.B. Herzkrankheit, Krebs';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Bitte beschreiben Sie wichtige Krankheiten in Ihrer Familie (zum Beispiel: Diabetes, Bluthochdruck, Herzkrankheiten, Krebs, genetische Erkrankungen) und geben Sie an, welches Familienmitglied die Erkrankung hatte.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Soziale und Lebensstilfaktoren';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'z. B. Rauchen, Alkoholkonsum';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Bitte beschreiben Sie Lebensstilfaktoren, die Ihre Gesundheit beeinflussen können, wie Rauchen, Alkohol, körperliche Aktivität, Ernährung, Schlaf und Beruf.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Medizinische Geräte';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'z.B. Herzschrittmacher, Hörgerät, Insulinpumpe';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Bitte listen Sie alle medizinischen Geräte auf, die Sie verwenden oder implantiert haben, wie z.B. Herzschrittmacher, Insulinpumpen, Hörgeräte, Prothesen oder andere Hilfs- oder Überwachungsgeräte. Fügen Sie relevante Details hinzu, falls zutreffend.';

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
          'Pescetarier';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Laktosefrei';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Natriumarme Ernährung';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Zuckerarme Ernährung';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Kardiale Diät';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Nierendiät';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Andere';
}
