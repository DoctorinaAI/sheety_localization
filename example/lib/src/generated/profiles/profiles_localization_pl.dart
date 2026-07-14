// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class ProfilesLocalizationPl extends ProfilesLocalization {
  ProfilesLocalizationPl([String locale = 'pl']) : super(locale);

  @override
  String get chatDrawerTitle => 'Rekordy zdrowia';

  @override
  String get chatDrawerBadgeNew => 'NOWY';

  @override
  String get bannerTitle => 'Utwórz swój rekord zdrowia';

  @override
  String get bannerSubtitle => 'Na końcu konsultacji dodaj swój profil.';

  @override
  String get bannerMoreProfilesTitle => 'Dodaj więcej profili';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Rozpocznij konsultację dla kogoś innego, aby stworzył swój profil.';

  @override
  String get bannerSignUp =>
      'Zarejestruj się, aby stworzyć swoją Kartę Zdrowia';

  @override
  String get errorRetryButton => 'Spróbuj ponownie';

  @override
  String get dashboardDeleteError => 'Nie udało się usunąć profilu';

  @override
  String get dashboardSummaryLoadError =>
      'Nie udało się załadować podsumowania profilu';

  @override
  String get dashboardMenuViewFullRecord => 'Zobacz pełny rekord';

  @override
  String get dashboardMenuShare => 'Udostępnij';

  @override
  String get dashboardMenuDelete => 'Usuń';

  @override
  String get dashboardMetricAgeLabel => 'Wiek';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value lata',
      one: '$value rok',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Waga';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Wzrost';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Alergie';

  @override
  String get dashboardInfoChronicTitle => 'Przewlekłe';

  @override
  String get dashboardInfoMedicationTitle => 'Leki';

  @override
  String get dashboardInfoDevicesTitle => 'Urządzenia';

  @override
  String get dashboardNavigationConsultations => 'Konsultacje';

  @override
  String get dashboardNavigationDocuments => 'Dokumenty';

  @override
  String get dashboardDeleteRecordTitle => 'Usunąć rekord zdrowia?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'To trwale usunie twoje dane zdrowotne i nie można tego cofnąć. Stracisz kontekst, który wykorzystujemy do udzielania ci wskazówek.';

  @override
  String get dashboardDeleteRecordCancel => 'Anuluj';

  @override
  String get dashboardDeleteRecordConfirm => 'Usuń';

  @override
  String get dashboardDeleteRecordLoading => 'Usuwam twój rekord zdrowia...';

  @override
  String get dashboardDeleteRecordError => 'Nie udało się usunąć profilu';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Rekord zdrowia usunięty';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Możesz stworzyć nowy w każdej chwili, rozmawiając z asystentem.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Powrót do czatu';

  @override
  String get dataEditingScreenTitle => 'Edycja';

  @override
  String get dataFailedToLoadError => 'Nie udało się załadować danych profilu';

  @override
  String get dataRecordSavedTitle => 'Zmiany zapisane';

  @override
  String get dataRecordSavedSubtitle =>
      'Twoje informacje zostały pomyślnie zaktualizowane.';

  @override
  String get dataRecordSavedButton => 'Powrót do profilu';

  @override
  String get dataRecordUpdateError =>
      'Nie udało się zaktualizować danych profilu';

  @override
  String get dataRecordDiscardTitle => 'Anulować zmiany?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Dokonałeś pewnych zmian w swoim profilu. Zapisz je przed wyjściem lub je odrzuć.';

  @override
  String get dataRecordDiscardCancel => 'Kontynuuj edytowanie';

  @override
  String get dataRecordDiscardConfirm => 'Odrzuć';

  @override
  String get dataRecordEditTooltip => 'Edytuj';

  @override
  String get dataRecordAddTag => 'Dodaj rekord';

  @override
  String get consultationsSearch => 'Szukaj';

  @override
  String get consultationsSearchEmpty => 'Nie znaleziono wyników';

  @override
  String get documentsMenuDownload => 'Pobierz';

  @override
  String get documentsMenuShare => 'Udostępnij';

  @override
  String get documentsMenuDelete => 'Usuń';

  @override
  String get documentsEmptyList => 'Nie znaleziono dokumentów';

  @override
  String get documentsDeleteTitle => 'Usunąć ten dokument?';

  @override
  String get documentsDeleteSubtitle => 'Ten plik zostanie trwale usunięty';

  @override
  String get documentsDeleteCancel => 'Anuluj';

  @override
  String get documentsDeleteButton => 'Usuń';

  @override
  String get documentsMoreActionsTooltip => 'Więcej działań';

  @override
  String get profilesSearch => 'Szukaj';

  @override
  String get profilesEmptyList => 'Nie znaleziono profili';

  @override
  String get profilesViewMore => 'Zobacz więcej';

  @override
  String get profilesMore => 'Więcej';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina teraz pamięta o twoim zdrowiu';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Twoje konsultacje teraz automatycznie budują i aktualizują Twoją Kartę Zdrowia.';

  @override
  String get profilesAnnouncementTitle2 => 'Twoja karta zdrowia, twoje zasady';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Wyświetlaj, edytuj lub dodawaj objawy, leki, historię lub dokumenty w dowolnym momencie.';

  @override
  String get profilesAnnouncementTitle3 => 'Opieka nad całą rodziną';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Utwórz kartę zdrowia dla swoich bliskich, dzieci, rodziców lub partnera.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Gotowy, aby zapisać swoją Kartę Zdrowia?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Po konsultacji dotknij „Dodaj profil”, aby go zapisać';

  @override
  String get profilesNextButton => 'Dalej';

  @override
  String get profilesStartButton => 'Rozpocznij konsultację';

  @override
  String get profilesLaterButton => 'Może później';

  @override
  String get profileSuccessCloseButton => 'Zamknij';

  @override
  String get pdfHeaderTitle => 'Dokumentacja zdrowotna';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Rekord zdrowia — $name';
  }

  @override
  String get expandableFieldMore => '...więcej';

  @override
  String get expandableFieldLess => '...mniej';

  @override
  String get profiles_button_addnew => 'Dodaj nowy profil';

  @override
  String get profiles_label_addnew =>
      'Utwórz profil, aby zapisać szczegóły tej konsultacji';

  @override
  String get profiles_label_health_records_hint =>
      'Możesz to sprawdzić w swojej dokumentacji medycznej w dowolnym momencie';

  @override
  String get profiles_label_keep_talking_hint =>
      'Jeśli masz więcej pytań dotyczących tego lub czegokolwiek z tym związanego, śmiało kontynuuj rozmowę ze mną. Jestem tu, aby pomóc';

  @override
  String get profile_section_basic_title => 'Informacje ogólne';

  @override
  String get profile_section_basic_name_label => 'Imię';

  @override
  String get profile_section_basic_name_placeholder => 'Jan Kowalski';

  @override
  String get profile_section_basic_first_name_label => 'Imię';

  @override
  String get profile_section_basic_first_name_placeholder => 'Jan';

  @override
  String get profile_section_basic_last_name_label => 'Nazwisko';

  @override
  String get profile_section_basic_last_name_placeholder => 'Kowalski';

  @override
  String get profile_section_basic_sex_label => 'Płeć';

  @override
  String get profile_section_basic_sex_placeholder => 'Wybierz';

  @override
  String get profile_section_basic_sex_options_male => 'Mężczyzna';

  @override
  String get profile_section_basic_sex_options_female => 'Kobieta';

  @override
  String get profile_section_basic_sex_options_other => 'Inna';

  @override
  String get profile_section_basic_date_of_birth_label => 'Data urodzenia';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Wiek';

  @override
  String get profile_section_basic_age_str_placeholder => 'np. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Numer telefonu';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Lokalizacja';

  @override
  String get profile_section_basic_location_placeholder => 'np. Miasto, Kraj';

  @override
  String get profile_section_body_diet_title => 'Ciało & Dieta';

  @override
  String get profile_section_body_diet_height_str_label => 'Wzrost';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'np. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Waga';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'np. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Cykl menstruacyjny';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'np. Regularny, Nieregularny';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Ograniczenia Dietetyczne';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Wybierz';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Daj nam znać, co jesz i jakie masz ograniczenia';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Brak';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Wegetariańska';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Wegański';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Bezglutenowy';

  @override
  String get profile_section_body_diet_bmi_label => 'Wskaźnik masy ciała (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'np. 24,5';

  @override
  String get profile_section_health_profile_title => 'Profil zdrowia';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Choroby przewlekłe';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'np. Cukrzyca typu 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Proszę wymienić wszystkie przewlekłe choroby oraz podać, kiedy zostały zdiagnozowane i wszelkie powikłania.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Przebyte choroby';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'np. Częste przeziębienia';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Proszę wymienić poważne choroby, które miałeś w przeszłości, nawet jeśli wyzdrowiałeś.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Historia operacji';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'np. Appendektomia';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Proszę wymienić wszystkie operacje, podając rok oraz informację, czy wystąpiły jakiekolwiek powikłania';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Leki stosowane okazjonalnie';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'np. Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Proszę wymienić leki, które przyjmujesz od czasu do czasu (na przykład: leki przeciwbólowe, leki na alergię), w tym dawkę i powód stosowania.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Stałe leki';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'np. Metformina';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Proszę wymienić wszystkie leki, które przyjmujesz regularnie, w tym nazwę, dawkę, ile razy dziennie je przyjmujesz oraz na jakie schorzenie są przeznaczone.';

  @override
  String get profile_section_health_profile_allergies_label => 'Alergie';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'np. Penicylina – powoduje wysypkę';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Proszę wymienić wszystkie alergie (leki, jedzenie, czynniki środowiskowe) i opisać, jakie reakcje występują (na przykład: wysypka, obrzęk, problemy z oddychaniem)';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Szczególne schorzenia';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'np. Ciąża, Niepełnosprawność';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Jeśli masz jakiekolwiek ważne schorzenia medyczne, o których lekarze powinni zawsze wiedzieć (na przykład: ciąża, wszczepione urządzenia, niepełnosprawności, terapia przeciwzakrzepowa), opisz je. Jeśli nie, możesz to pole pozostawić puste.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Historia rodzinna';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'np. choroba serca, rak';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Proszę opisać ważne choroby w swojej rodzinie (na przykład: cukrzyca, nadciśnienie, choroby serca, nowotwory, choroby genetyczne) i określić, który członek rodziny miał tę chorobę.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Czynniki społeczne i związane ze stylem życia';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'np. Palenie, Spożywanie alkoholu';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Proszę opisać czynniki stylu życia, które mogą wpływać na zdrowie, takie jak palenie, alkohol, aktywność fizyczna, dieta, sen i zawód';

  @override
  String get profile_section_health_profile_devices_label =>
      'Urządzenia Medyczne';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'np. Rozrusznik serca, Aparat słuchowy, Pompa insulinowa';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Proszę wymienić wszelkie urządzenia medyczne, które używasz lub masz wszczepione, takie jak rozruszniki serca, pompy insulinowe, aparaty słuchowe, protezy lub inne urządzenia wspomagające lub monitorujące. Dołącz odpowiednie szczegóły, jeśli to możliwe.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Wszystkożerny';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Fast Food';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetarianin';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Bez laktozy';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Dieta niskosodowa';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Dieta niskocukrowa';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Dieta sercowa';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Dieta nerkowa';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Inne';
}
