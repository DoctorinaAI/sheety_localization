// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class ProfilesLocalizationCa extends ProfilesLocalization {
  ProfilesLocalizationCa([String locale = 'ca']) : super(locale);

  @override
  String get chatDrawerTitle => 'Registres de salut';

  @override
  String get chatDrawerBadgeNew => 'NOU';

  @override
  String get bannerTitle => 'Crea el teu Registre de Salut';

  @override
  String get bannerSubtitle =>
      'Al final de la teva consulta, afegeix el teu perfil.';

  @override
  String get bannerMoreProfilesTitle => 'Afegir més perfils';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Inicia una consulta per a algú altre per crear el seu perfil';

  @override
  String get bannerSignUp => 'Inscriu-te per crear el teu Registre de Salut';

  @override
  String get errorRetryButton => 'Torna a provar';

  @override
  String get dashboardDeleteError => 'No s\'ha pogut eliminar el perfil';

  @override
  String get dashboardSummaryLoadError =>
      'No s\'ha pogut carregar el resum del perfil';

  @override
  String get dashboardMenuViewFullRecord => 'Veure registre complet';

  @override
  String get dashboardMenuShare => 'Compartir';

  @override
  String get dashboardMenuDelete => 'Esborrar';

  @override
  String get dashboardMetricAgeLabel => 'Edat';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value anys',
      one: '$value any',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Pes';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Alçada';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Al·lèrgies';

  @override
  String get dashboardInfoChronicTitle => 'Crònic';

  @override
  String get dashboardInfoMedicationTitle => 'Medicament';

  @override
  String get dashboardInfoDevicesTitle => 'Dispositius';

  @override
  String get dashboardNavigationConsultations => 'Consultes';

  @override
  String get dashboardNavigationDocuments => 'Documents';

  @override
  String get dashboardDeleteRecordTitle => 'Esborrar registre de salut?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Això eliminarà permanentment les teves dades de salut i no es podrà desfer. Perdràs el context que fem servir per guiar-te.';

  @override
  String get dashboardDeleteRecordCancel => 'Cancel·la';

  @override
  String get dashboardDeleteRecordConfirm => 'Esborrar';

  @override
  String get dashboardDeleteRecordLoading =>
      'Eliminant el teu registre de salut...';

  @override
  String get dashboardDeleteRecordError => 'No s\'ha pogut eliminar el perfil';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Registre de salut eliminat';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Pots crear-ne un de nou en qualsevol moment xerrant amb l\'assistent.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Torna al xat';

  @override
  String get dataEditingScreenTitle => 'Editant';

  @override
  String get dataFailedToLoadError =>
      'No s\'ha pogut carregar les dades del perfil';

  @override
  String get dataRecordSavedTitle => 'Canvis desats';

  @override
  String get dataRecordSavedSubtitle =>
      'La teva informació s\'ha actualitzat correctament.';

  @override
  String get dataRecordSavedButton => 'Torna al perfil';

  @override
  String get dataRecordUpdateError =>
      'No s\'ha pogut actualitzar les dades del perfil';

  @override
  String get dataRecordDiscardTitle => 'Descartar canvis?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Heu fet alguns canvis al vostre perfil. Deseu-los abans de marxar, o deseu-los.';

  @override
  String get dataRecordDiscardCancel => 'Segueix editant';

  @override
  String get dataRecordDiscardConfirm => 'Descartar';

  @override
  String get dataRecordEditTooltip => 'Editar';

  @override
  String get dataRecordAddTag => 'Afegir registre';

  @override
  String get consultationsSearch => 'Cerca';

  @override
  String get consultationsSearchEmpty => 'No s\'han trobat resultats';

  @override
  String get documentsMenuDownload => 'Descarregar';

  @override
  String get documentsMenuShare => 'Compartir';

  @override
  String get documentsMenuDelete => 'Esborrar';

  @override
  String get documentsEmptyList => 'No s\'han trobat documents';

  @override
  String get documentsDeleteTitle => 'Esborrar aquest document?';

  @override
  String get documentsDeleteSubtitle =>
      'Aquest fitxer serà eliminat de manera permanent';

  @override
  String get documentsDeleteCancel => 'Cancel·la';

  @override
  String get documentsDeleteButton => 'Esborrar';

  @override
  String get documentsMoreActionsTooltip => 'Més accions';

  @override
  String get profilesSearch => 'Cerca';

  @override
  String get profilesEmptyList => 'No s\'han trobat perfils';

  @override
  String get profilesViewMore => 'Veure\'n més';

  @override
  String get profilesMore => 'Més';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina ara recorda la teva salut';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Les teves consultes ara construeixen i actualitzen automàticament el teu Registre de Salut.';

  @override
  String get profilesAnnouncementTitle2 =>
      'El teu registre de salut, les teves regles';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Veure, editar o afegir símptomes, medicaments, historial o documents en qualsevol moment.';

  @override
  String get profilesAnnouncementTitle3 => 'Cura per a tota la teva família';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Crea un registre de salut per als teus éssers estimats, els teus fills, pares o parella.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Preparat per desar el teu historial mèdic?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Després de la teva consulta, toca \"Afegir perfil\" per desar-ho.';

  @override
  String get profilesNextButton => 'Següent';

  @override
  String get profilesStartButton => 'Iniciar una consulta';

  @override
  String get profilesLaterButton => 'Potser més tard';

  @override
  String get profileSuccessCloseButton => 'Tanca';

  @override
  String get pdfHeaderTitle => 'Fitxa de salut';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Registre de salut — $name';
  }

  @override
  String get expandableFieldMore => '...més';

  @override
  String get expandableFieldLess => '...menys';

  @override
  String get profiles_button_addnew => 'Afegir nou perfil';

  @override
  String get profiles_label_addnew =>
      'Crea un perfil per desar els detalls d\'aquesta consulta';

  @override
  String get profiles_label_health_records_hint =>
      'Pots consultar-ho en qualsevol moment als teus registres de salut';

  @override
  String get profiles_label_keep_talking_hint =>
      'Si tens més preguntes sobre això o qualsevol cosa relacionada, no dubtis a seguir parlant amb mi. Estic aquí per ajudar-te';

  @override
  String get profile_section_basic_title => 'Informació general';

  @override
  String get profile_section_basic_name_label => 'Nom';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'Nom';

  @override
  String get profile_section_basic_first_name_placeholder => 'Joan';

  @override
  String get profile_section_basic_last_name_label => 'Cognom';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Sexe';

  @override
  String get profile_section_basic_sex_placeholder => 'Seleccioneu';

  @override
  String get profile_section_basic_sex_options_male => 'Home';

  @override
  String get profile_section_basic_sex_options_female => 'Dona';

  @override
  String get profile_section_basic_sex_options_other => 'Altre';

  @override
  String get profile_section_basic_date_of_birth_label => 'Data de naixement';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Edat';

  @override
  String get profile_section_basic_age_str_placeholder => 'p. ex. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Número de telèfon';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'Correu electrònic';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Ubicació';

  @override
  String get profile_section_basic_location_placeholder =>
      'p. ex. Ciutat, País';

  @override
  String get profile_section_body_diet_title => 'Cos & Dieta';

  @override
  String get profile_section_body_diet_height_str_label => 'Alçada';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'p. ex. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Pes';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'p. ex. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Cicle Menstrual';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'p. ex. Regular, Irregular';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Restriccions Alimentàries';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Si us plau seleccioneu';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Feu-nos saber què mengeu i quines restriccions teniu';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Cap';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetarià';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegà';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Sense gluten';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Índex de massa corporal (IMC)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'p. ex. 24.5';

  @override
  String get profile_section_health_profile_title => 'Perfil de salut';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Malalties cròniques';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'p. ex. Diabetis Tipus 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Si us plau, enumereu totes les malalties cròniques i incloeu quan van ser diagnosticades i qualsevol complicació.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Malalties anteriors';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'per exemple, refredats comuns freqüents';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Si us plau, enumera les malalties greus que has tingut en el passat, fins i tot si t\'has recuperat';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Historial Quirúrgic';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'p. ex. apendicectomia';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Si us plau, enumera totes les cirurgies i inclou l\'any i si hi va haver complicacions.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Medicaments d\'ús ocasional';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'per exemple, Ibuprofè';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Si us plau, enumereu els medicaments que preneu de tant en tant (per exemple: analgèsics, medicaments per a al·lèrgies), incloent la dosi i el motiu d\'ús.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Medicació habitual';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'per exemple, Metformina';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Si us plau, enumera tots els medicaments que prens regularment, incloent el nom, la dosi, quantes vegades al dia ho prens i per a quina condició és.';

  @override
  String get profile_section_health_profile_allergies_label => 'Al·lèrgies';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'per exemple, penicil·la – causa erupció';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Si us plau, enumera totes les al·lèrgies (medicaments, aliments, ambientals) i descriu quina reacció tens (per exemple: erupció, inflor, problemes respiratoris).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Condicions especials';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'p. ex. Embaràs, Discapacitat';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Si teniu alguna condició mèdica important que els metges haurien de conèixer sempre (per exemple: embaràs, dispositius implantats, discapacitats, teràpia anticoagulant), si us plau, descriviu-les. Si no en teniu, podeu deixar-ho en blanc.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Antecedents Familiars';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'p. ex. Malaltia Cardíaca, Càncer';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Si us plau, descriviu les malalties importants de la vostra família (per exemple: diabetis, hipertensió, malaltia cardíaca, càncer, malalties genètiques) i especifiqueu quin membre de la família tenia la condició.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Factors socials & d\'estil de vida';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'p. ex. Fumar, Consum d\'alcohol';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Si us plau, descriviu els factors de l\'estil de vida que poden afectar la vostra salut, com ara el tabaquisme, l\'alcohol, l\'activitat física, la dieta, el son i la professió.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Dispositius mèdics';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'p. ex. marcapassos, audiòfon, bomba d\'insulina';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Si us plau, enumera qualsevol dispositiu mèdic que utilitzis o que tinguis implantat, com ara marcapassos, bombes d\'insulina, audiòfons, pròtesis o altres dispositius d\'assistència o de monitoratge. Inclou detalls rellevants si escau.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Omnívor';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Menjar ràpid';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetarià';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Sense lactosa';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Dieta baixa en sodi';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Dieta baixa en sucre';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Dieta cardíaca';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Dieta renal';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Altres';
}
