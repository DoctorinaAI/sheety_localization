// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class ProfilesLocalizationFr extends ProfilesLocalization {
  ProfilesLocalizationFr([String locale = 'fr']) : super(locale);

  @override
  String get chatDrawerTitle => 'Dossiers de santé';

  @override
  String get chatDrawerBadgeNew => 'NOUVEAU';

  @override
  String get bannerTitle => 'Créez votre dossier de santé';

  @override
  String get bannerSubtitle =>
      'À la fin de votre consultation, ajoutez votre profil.';

  @override
  String get bannerMoreProfilesTitle => 'Ajouter plus de profils';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Commencez une consultation pour quelqu\'un d\'autre afin de créer son profil.';

  @override
  String get bannerSignUp => 'Inscrivez-vous pour créer votre dossier de santé';

  @override
  String get errorRetryButton => 'Réessayer';

  @override
  String get dashboardDeleteError => 'Échec de la suppression du profil';

  @override
  String get dashboardSummaryLoadError =>
      'Échec du chargement du résumé du profil';

  @override
  String get dashboardMenuViewFullRecord => 'Voir le dossier complet';

  @override
  String get dashboardMenuShare => 'Partager';

  @override
  String get dashboardMenuDelete => 'Supprimer';

  @override
  String get dashboardMetricAgeLabel => 'Âge';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ans',
      one: '$value an',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Poids';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Taille';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Allergies';

  @override
  String get dashboardInfoChronicTitle => 'Chronique';

  @override
  String get dashboardInfoMedicationTitle => 'Médicament';

  @override
  String get dashboardInfoDevicesTitle => 'Appareils';

  @override
  String get dashboardNavigationConsultations => 'Consultations';

  @override
  String get dashboardNavigationDocuments => 'Documents';

  @override
  String get dashboardDeleteRecordTitle => 'Supprimer le dossier de santé ?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Cela supprimera définitivement vos données de santé et ne peut pas être annulé. Vous perdrez le contexte que nous utilisons pour vous guider.';

  @override
  String get dashboardDeleteRecordCancel => 'Annuler';

  @override
  String get dashboardDeleteRecordConfirm => 'Supprimer';

  @override
  String get dashboardDeleteRecordLoading =>
      'Suppression de votre dossier de santé...';

  @override
  String get dashboardDeleteRecordError => 'Échec de la suppression du profil';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Dossier de santé supprimé';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Vous pouvez en créer un nouveau à tout moment en discutant avec l\'assistant.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Retour au chat';

  @override
  String get dataEditingScreenTitle => 'Édition';

  @override
  String get dataFailedToLoadError =>
      'Échec du chargement des données du profil';

  @override
  String get dataRecordSavedTitle => 'Modifications enregistrées';

  @override
  String get dataRecordSavedSubtitle =>
      'Vos informations ont été mises à jour avec succès.';

  @override
  String get dataRecordSavedButton => 'Retour au profil';

  @override
  String get dataRecordUpdateError =>
      'Échec de la mise à jour des données du profil';

  @override
  String get dataRecordDiscardTitle =>
      'Voulez-vous annuler les modifications ?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Vous avez apporté des modifications à votre profil. Enregistrez-les avant de partir ou abandonnez-les.';

  @override
  String get dataRecordDiscardCancel => 'Continuer à éditer';

  @override
  String get dataRecordDiscardConfirm => 'Jeter';

  @override
  String get dataRecordEditTooltip => 'Modifier';

  @override
  String get dataRecordAddTag => 'Ajouter un enregistrement';

  @override
  String get consultationsSearch => 'Rechercher';

  @override
  String get consultationsSearchEmpty => 'Aucun résultat trouvé';

  @override
  String get documentsMenuDownload => 'Télécharger';

  @override
  String get documentsMenuShare => 'Partager';

  @override
  String get documentsMenuDelete => 'Supprimer';

  @override
  String get documentsEmptyList => 'Aucun document trouvé';

  @override
  String get documentsDeleteTitle => 'Supprimer ce document ?';

  @override
  String get documentsDeleteSubtitle =>
      'Ce fichier sera définitivement supprimé';

  @override
  String get documentsDeleteCancel => 'Annuler';

  @override
  String get documentsDeleteButton => 'Supprimer';

  @override
  String get documentsMoreActionsTooltip => 'Autres actions';

  @override
  String get profilesSearch => 'Rechercher';

  @override
  String get profilesEmptyList => 'Aucun profil trouvé';

  @override
  String get profilesViewMore => 'Voir plus';

  @override
  String get profilesMore => 'Plus';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina se souvient maintenant de votre santé';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Vos consultations construisent et mettent à jour automatiquement votre Dossier de Santé.';

  @override
  String get profilesAnnouncementTitle2 => 'Votre dossier de santé, vos règles';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Consultez, modifiez ou ajoutez des symptômes, des médicaments, des antécédents ou des documents à tout moment.';

  @override
  String get profilesAnnouncementTitle3 => 'Prenez soin de toute votre famille';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Créez un dossier de santé pour vos proches, vos enfants, vos parents ou votre partenaire.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Prêt à enregistrer votre dossier de santé ?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Après votre consultation, appuyez sur « Ajouter un profil » pour l\'enregistrer.';

  @override
  String get profilesNextButton => 'Suivant';

  @override
  String get profilesStartButton => 'Commencer une consultation';

  @override
  String get profilesLaterButton => 'Peut-être plus tard';

  @override
  String get profileSuccessCloseButton => 'Fermer';

  @override
  String get pdfHeaderTitle => 'Dossier de santé';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Dossier de santé — $name';
  }

  @override
  String get expandableFieldMore => '...plus';

  @override
  String get expandableFieldLess => '...moins';

  @override
  String get profiles_button_addnew => 'Ajouter un nouveau profil';

  @override
  String get profiles_label_addnew =>
      'Créez un profil pour enregistrer les détails de cette consultation.';

  @override
  String get profiles_label_health_records_hint =>
      'Vous pouvez l\'évaluer à tout moment dans vos dossiers de santé';

  @override
  String get profiles_label_keep_talking_hint =>
      'Si vous avez d\'autres questions à ce sujet ou sur des sujets connexes, n\'hésitez pas à continuer à me parler. Je suis là pour vous aider';

  @override
  String get profile_section_basic_title => 'Informations générales';

  @override
  String get profile_section_basic_name_label => 'Nom';

  @override
  String get profile_section_basic_name_placeholder => 'Jean Dupont';

  @override
  String get profile_section_basic_first_name_label => 'Prénom';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => 'Nom de famille';

  @override
  String get profile_section_basic_last_name_placeholder => 'Dupont';

  @override
  String get profile_section_basic_sex_label => 'Sexe';

  @override
  String get profile_section_basic_sex_placeholder => 'Sélectionnez';

  @override
  String get profile_section_basic_sex_options_male => 'Homme';

  @override
  String get profile_section_basic_sex_options_female => 'Femme';

  @override
  String get profile_section_basic_sex_options_other => 'Autre';

  @override
  String get profile_section_basic_date_of_birth_label => 'Date de naissance';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'AAAA-MM-JJ';

  @override
  String get profile_section_basic_age_str_label => 'Âge';

  @override
  String get profile_section_basic_age_str_placeholder => 'p. ex. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Numéro de téléphone';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-mail';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Localisation';

  @override
  String get profile_section_basic_location_placeholder => 'ex. Ville, Pays';

  @override
  String get profile_section_body_diet_title => 'Corps et alimentation';

  @override
  String get profile_section_body_diet_height_str_label => 'Taille';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'p. ex. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Poids';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'p. ex. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Cycle menstruel';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'p. ex. Régulier, Irrégulier';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Restrictions alimentaires';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Veuillez sélectionner';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Faites-nous savoir ce que vous mangez et les restrictions que vous avez';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Aucune';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Végétarien';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Végétalien';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Sans gluten';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Indice de masse corporelle (IMC)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'p. ex. 24,5';

  @override
  String get profile_section_health_profile_title => 'Profil de santé';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Maladies chroniques';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'ex. Diabète de type 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Veuillez lister toutes les maladies chroniques et inclure la date de leur diagnostic ainsi que les complications éventuelles.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Antécédents médicaux';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'ex. Rhume fréquent';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Veuillez indiquer les maladies graves que vous avez eues dans le passé, même si vous vous êtes rétabli.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Antécédents chirurgicaux';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'e.g. Appendectomy';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Veuillez lister toutes les interventions chirurgicales et inclure l\'année ainsi que s\'il y a eu des complications.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Médicaments utilisés occasionnellement';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'par exemple, Ibuprofène';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Veuillez indiquer les médicaments que vous prenez de temps en temps (par exemple : analgésiques, médicaments contre les allergies), y compris la dose et la raison de leur utilisation.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Médicaments réguliers';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'par exemple, Metformine';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Veuillez indiquer tous les médicaments que vous prenez régulièrement, y compris le nom, la dose, combien de fois par jour vous le prenez et pour quelle condition.';

  @override
  String get profile_section_health_profile_allergies_label => 'Allergies';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'ex. Pénicilline – provoque une éruption';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Veuillez lister toutes les allergies (médicaments, aliments, environnement) et décrire quelle réaction vous avez (par exemple : éruption cutanée, gonflement, problèmes respiratoires).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Conditions particulières';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'p. ex. Grossesse, Handicap';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Si vous avez des conditions médicales importantes que les médecins doivent toujours connaître (par exemple : grossesse, dispositifs implantés, handicaps, thérapie anticoagulante), veuillez les décrire. Si aucune, vous pouvez laisser ce champ vide.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Antécédents familiaux';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'p. ex. maladie cardiaque, cancer';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Veuillez décrire les maladies importantes dans votre famille (par exemple : diabète, hypertension, maladies cardiaques, cancer, maladies génétiques) et spécifiez quel membre de la famille avait la condition.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Facteurs sociaux et liés au mode de vie';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'p. ex. tabagisme, consommation d\'alcool';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Veuillez décrire les facteurs de mode de vie qui peuvent affecter votre santé, tels que le tabagisme, l\'alcool, l\'activité physique, l\'alimentation, le sommeil et la profession.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Dispositifs médicaux';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'p. ex. stimulateur cardiaque, appareil auditif, pompe à insuline';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Veuillez lister tout dispositif médical que vous utilisez ou avez implanté, tel que des stimulateurs cardiaques, des pompes à insuline, des appareils auditifs, des prothèses ou d\'autres dispositifs d\'assistance ou de surveillance. Incluez les détails pertinents si applicable.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Omnivore';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Restauration Rapide';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescétarien';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Sans lactose';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Régime pauvre en sodium';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Régime pauvre en sucre';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Régime cardiaque';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Régime rénal';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Autre';
}
