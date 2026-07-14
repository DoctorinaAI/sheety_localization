// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Hungarian (`hu`).
class ProfilesLocalizationHu extends ProfilesLocalization {
  ProfilesLocalizationHu([String locale = 'hu']) : super(locale);

  @override
  String get chatDrawerTitle => 'Egészségügyi nyilvántartások';

  @override
  String get chatDrawerBadgeNew => 'ÚJ';

  @override
  String get bannerTitle => 'Hozza létre egészségügyi nyilvántartását';

  @override
  String get bannerSubtitle => 'A konzultáció végén adja hozzá a profilját.';

  @override
  String get bannerMoreProfilesTitle => 'További profilok hozzáadása';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Kezdj el egy konzultációt valaki más számára, hogy létrehozhassa a profilját.';

  @override
  String get bannerSignUp =>
      'Jelentkezzen be az egészségügyi nyilvántartás létrehozásához';

  @override
  String get errorRetryButton => 'Újrapróbálkozás';

  @override
  String get dashboardDeleteError => 'A profil törlése nem sikerült';

  @override
  String get dashboardSummaryLoadError =>
      'A profil összefoglalójának betöltése nem sikerült';

  @override
  String get dashboardMenuViewFullRecord => 'Teljes rekord megtekintése';

  @override
  String get dashboardMenuShare => 'Megosztás';

  @override
  String get dashboardMenuDelete => 'Törlés';

  @override
  String get dashboardMetricAgeLabel => 'Kor';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value év',
      one: '$value év',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Súly';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Magasság';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Allergiák';

  @override
  String get dashboardInfoChronicTitle => 'Krónikus';

  @override
  String get dashboardInfoMedicationTitle => 'Gyógyszer';

  @override
  String get dashboardInfoDevicesTitle => 'Eszközök';

  @override
  String get dashboardNavigationConsultations => 'Konzultációk';

  @override
  String get dashboardNavigationDocuments => 'Dokumentumok';

  @override
  String get dashboardDeleteRecordTitle =>
      'Egészségügyi nyilvántartás törlése?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Ez véglegesen eltávolítja az egészségügyi adatait, és nem vonható vissza. El fogja veszíteni a kontextust, amelyet a vezetéshez használunk.';

  @override
  String get dashboardDeleteRecordCancel => 'Mégse';

  @override
  String get dashboardDeleteRecordConfirm => 'Törlés';

  @override
  String get dashboardDeleteRecordLoading =>
      'Az egészségügyi nyilvántartás törlése...';

  @override
  String get dashboardDeleteRecordError => 'A profil törlése nem sikerült';

  @override
  String get dashboardDeleteRecordSuccessTitle =>
      'Egészségügyi nyilvántartás törölve';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Bármikor létrehozhat egy újat, ha beszélget a segéddel.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Vissza a csevegéshez';

  @override
  String get dataEditingScreenTitle => 'Szerkesztés';

  @override
  String get dataFailedToLoadError => 'A profiladatok betöltése nem sikerült';

  @override
  String get dataRecordSavedTitle => 'Változások mentve';

  @override
  String get dataRecordSavedSubtitle =>
      'Az Ön adatai sikeresen frissítve lettek.';

  @override
  String get dataRecordSavedButton => 'Vissza a profilhoz';

  @override
  String get dataRecordUpdateError => 'A profiladatok frissítése nem sikerült';

  @override
  String get dataRecordDiscardTitle => 'Változások elvetése?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Változtatásokat hajtott végre a profilján. Mentse el őket, mielőtt elmegy, vagy dobja el őket.';

  @override
  String get dataRecordDiscardCancel => 'Szerkesztés folytatása';

  @override
  String get dataRecordDiscardConfirm => 'Elvetés';

  @override
  String get dataRecordEditTooltip => 'Szerkesztés';

  @override
  String get dataRecordAddTag => 'Felvétel hozzáadása';

  @override
  String get consultationsSearch => 'Keresés';

  @override
  String get consultationsSearchEmpty => 'Nincsenek találatok';

  @override
  String get documentsMenuDownload => 'Letöltés';

  @override
  String get documentsMenuShare => 'Megosztás';

  @override
  String get documentsMenuDelete => 'Törlés';

  @override
  String get documentsEmptyList => 'Nincsenek dokumentumok';

  @override
  String get documentsDeleteTitle => 'Törölni szeretné ezt a dokumentumot?';

  @override
  String get documentsDeleteSubtitle =>
      'Ez a fájl véglegesen eltávolításra kerül';

  @override
  String get documentsDeleteCancel => 'Mégse';

  @override
  String get documentsDeleteButton => 'Törlés';

  @override
  String get documentsMoreActionsTooltip => 'További műveletek';

  @override
  String get profilesSearch => 'Keresés';

  @override
  String get profilesEmptyList => 'Nem találhatók profilok';

  @override
  String get profilesViewMore => 'Továbbiak megtekintése';

  @override
  String get profilesMore => 'Több';

  @override
  String get profilesAnnouncementTitle1 =>
      'A Doctorina most már emlékszik az egészségére';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'A konzultációi most automatikusan építik és frissítik az Egészségügyi Nyilvántartását.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Az Ön egészségügyi nyilvántartása, az Ön szabályai';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Bármikor megtekintheti, szerkesztheti vagy hozzáadhatja a tüneteket, gyógyszereket, a kórtörténetet vagy a dokumentumokat.';

  @override
  String get profilesAnnouncementTitle3 => 'Gondoskodjon az egész családjáról';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Hozzon létre egészségügyi nyilvántartást szerettei, gyerekei, szülei vagy partnere számára.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Készen áll a Health Record mentésére?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'A konzultáció után érintse meg az „Profil hozzáadása” gombot a mentéshez.';

  @override
  String get profilesNextButton => 'Következő';

  @override
  String get profilesStartButton => 'Konzultáció indítása';

  @override
  String get profilesLaterButton => 'Később';

  @override
  String get profileSuccessCloseButton => 'Bezárás';

  @override
  String get pdfHeaderTitle => 'Egészségügyi nyilvántartás';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Egészségügyi nyilvántartás — $name';
  }

  @override
  String get expandableFieldMore => '...több';

  @override
  String get expandableFieldLess => '...kevesebb';

  @override
  String get profiles_button_addnew => 'Új profil hozzáadása';

  @override
  String get profiles_label_addnew =>
      'Hozzon létre egy profilt a konzultáció részleteinek mentéséhez.';

  @override
  String get profiles_label_health_records_hint =>
      'Ezt bármikor értékelheti az Egészségügyi feljegyzéseiben';

  @override
  String get profiles_label_keep_talking_hint =>
      'Ha további kérdése van ezzel vagy bármivel kapcsolatban, nyugodtan folytassa a beszélgetést velem. Itt vagyok, hogy segítsek';

  @override
  String get profile_section_basic_title => 'Általános információk';

  @override
  String get profile_section_basic_name_label => 'Név';

  @override
  String get profile_section_basic_name_placeholder => 'János Kovács';

  @override
  String get profile_section_basic_first_name_label => 'Keresztnév';

  @override
  String get profile_section_basic_first_name_placeholder => 'János';

  @override
  String get profile_section_basic_last_name_label => 'Vezetéknév';

  @override
  String get profile_section_basic_last_name_placeholder => 'Kovács';

  @override
  String get profile_section_basic_sex_label => 'Nem';

  @override
  String get profile_section_basic_sex_placeholder => 'Válasszon';

  @override
  String get profile_section_basic_sex_options_male => 'Férfi';

  @override
  String get profile_section_basic_sex_options_female => 'Nő';

  @override
  String get profile_section_basic_sex_options_other => 'Egyéb';

  @override
  String get profile_section_basic_date_of_birth_label => 'Születési dátum';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Életkor';

  @override
  String get profile_section_basic_age_str_placeholder => 'pl. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Telefonszám';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'példa@példa.hu';

  @override
  String get profile_section_basic_location_label => 'Hely';

  @override
  String get profile_section_basic_location_placeholder => 'pl. Város, Ország';

  @override
  String get profile_section_body_diet_title => 'Test & Étrend';

  @override
  String get profile_section_body_diet_height_str_label => 'Magasság';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'pl. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Testsúly';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'pl. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Menstruációs ciklus';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'pl. Rendszeres, Rendszertelen';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Étrend-korlátozások';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Kérjük, válasszon';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Tudassa velünk, mit eszik, és van-e bármilyen korlátozása';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Nincs';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetáriánus';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegán';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Gluténmentes';

  @override
  String get profile_section_body_diet_bmi_label => 'Testtömegindex (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'pl. 24,5';

  @override
  String get profile_section_health_profile_title => 'Egészségprofil';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Krónikus betegségek';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'pl. 2-es típusú cukorbetegség';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Kérjük, sorolja fel az összes krónikus betegséget, és tüntesse fel, mikor diagnosztizálták őket, valamint bármilyen szövődményt.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Korábbi betegségek';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'pl. Gyakori megfázás';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Kérjük, sorolja fel a múltban előfordult súlyos betegségeket, még akkor is, ha felépült.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Műtéti előzmények';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'pl. vakbélműtét';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Kérjük, sorolja fel az összes műtétet, és adja meg az évet, valamint azt, hogy voltak-e szövődmények.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Időszakosan Használt Gyógyszerek';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'pl. Ibuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Kérjük, sorolja fel azokat a gyógyszereket, amelyeket időnként szed (például: fájdalomcsillapítók, allergiás gyógyszerek), beleértve az adagot és a használat okát.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Rendszeres gyógyszerek';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'pl. Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Kérjük, sorolja fel az összes gyógyszert, amelyet rendszeresen szed, beleértve a nevét, az adagot, hogy hányszor naponta szedi, és hogy milyen állapot kezelésére használja.';

  @override
  String get profile_section_health_profile_allergies_label => 'Allergiák';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'pl. Penicillin – kiütést okoz';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Kérjük, sorolja fel az összes allergiáját (gyógyszerek, ételek, környezeti), és írja le, milyen reakciót tapasztal (például: kiütés, duzzanat, légzési problémák).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Különleges állapotok';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'pl. terhesség, fogyatékosság';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Ha vannak fontos orvosi állapotai, amelyeket az orvosoknak mindig tudniuk kell (például: terhesség, beültetett eszközök, fogyatékosságok, antikoaguláns terápia), kérjük, írja le őket. Ha nincs, ezt üresen hagyhatja.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Családi anamnézis';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'pl. szívbetegség, rák';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Kérjük, írja le a családjában előforduló fontos betegségeket (például: cukorbetegség, magas vérnyomás, szívbetegség, rák, genetikai betegségek), és adja meg, hogy melyik családtag szenvedett az adott állapotban.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Szociális & Életmódbeli Tényezők';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'pl. dohányzás, alkoholfogyasztás';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Kérjük, írja le azokat az életmódbeli tényezőket, amelyek hatással lehetnek az egészségére, például a dohányzást, alkoholfogyasztást, fizikai aktivitást, étrendet, alvást és foglalkozást.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Orvostechnikai eszközök';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'pl. Pacemaker, Hallókészülék, Inzulinpumpa';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Kérjük, sorolja fel azokat az orvosi eszközöket, amelyeket használ vagy beültettek Önnek, például pacemakerek, inzulinpumpák, hallókészülékek, protézisek vagy egyéb segédeszközök vagy monitorozó eszközök. Ha releváns részletek vannak, kérjük, azokat is tüntesse fel.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Mindenevő';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Gyorséttermi ételek';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetáriánus';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Laktózmentes';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Alacsony nátriumtartalmú étrend';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Alacsony cukortartalmú étrend';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Szívbarát étrend';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Vese diéta';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Egyéb';
}
