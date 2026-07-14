// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class ProfilesLocalizationEs extends ProfilesLocalization {
  ProfilesLocalizationEs([String locale = 'es']) : super(locale);

  @override
  String get chatDrawerTitle => 'Registros de salud';

  @override
  String get chatDrawerBadgeNew => 'NUEVO';

  @override
  String get bannerTitle => 'Crea tu Registro de Salud';

  @override
  String get bannerSubtitle => 'Al final de su consulta, agregue su perfil';

  @override
  String get bannerMoreProfilesTitle => 'Agregar más perfiles';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Inicia una consulta para que otra persona cree su perfil';

  @override
  String get bannerSignUp => 'Regístrate para crear tu Historial Médico';

  @override
  String get errorRetryButton => 'Reintentar';

  @override
  String get dashboardDeleteError => 'No se pudo eliminar el perfil';

  @override
  String get dashboardSummaryLoadError =>
      'Error al cargar el resumen del perfil';

  @override
  String get dashboardMenuViewFullRecord => 'Ver registro completo';

  @override
  String get dashboardMenuShare => 'Compartir';

  @override
  String get dashboardMenuDelete => 'Eliminar';

  @override
  String get dashboardMetricAgeLabel => 'Edad';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value años',
      one: '$value año',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Peso';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Altura';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'Alergias';

  @override
  String get dashboardInfoChronicTitle => 'Crónico';

  @override
  String get dashboardInfoMedicationTitle => 'Medicamentos';

  @override
  String get dashboardInfoDevicesTitle => 'Dispositivos';

  @override
  String get dashboardNavigationConsultations => 'Consultas';

  @override
  String get dashboardNavigationDocuments => 'Documentos';

  @override
  String get dashboardDeleteRecordTitle => '¿Eliminar el registro de salud?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Esto eliminará permanentemente tus datos de salud y no se puede deshacer. Perderás el contexto que usamos para guiarte.';

  @override
  String get dashboardDeleteRecordCancel => 'Cancelar';

  @override
  String get dashboardDeleteRecordConfirm => 'Eliminar';

  @override
  String get dashboardDeleteRecordLoading =>
      'Eliminando su registro de salud...';

  @override
  String get dashboardDeleteRecordError => 'No se pudo eliminar el perfil';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Registro de salud eliminado';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Puedes crear uno nuevo en cualquier momento chateando con el asistente.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Volver al chat';

  @override
  String get dataEditingScreenTitle => 'Editando';

  @override
  String get dataFailedToLoadError => 'No se pudo cargar los datos del perfil';

  @override
  String get dataRecordSavedTitle => 'Cambios guardados';

  @override
  String get dataRecordSavedSubtitle =>
      'Su información ha sido actualizada con éxito.';

  @override
  String get dataRecordSavedButton => 'Volver al perfil';

  @override
  String get dataRecordUpdateError =>
      'Error al actualizar los datos del perfil';

  @override
  String get dataRecordDiscardTitle => '¿Descartar cambios?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Hiciste algunos cambios en tu perfil. Guárdalos antes de irte o descártalos.';

  @override
  String get dataRecordDiscardCancel => 'Seguir editando';

  @override
  String get dataRecordDiscardConfirm => 'Descartar';

  @override
  String get dataRecordEditTooltip => 'Editar';

  @override
  String get dataRecordAddTag => 'Agregar registro';

  @override
  String get consultationsSearch => 'Buscar';

  @override
  String get consultationsSearchEmpty => 'No se encontraron resultados';

  @override
  String get documentsMenuDownload => 'Descargar';

  @override
  String get documentsMenuShare => 'Compartir';

  @override
  String get documentsMenuDelete => 'Eliminar';

  @override
  String get documentsEmptyList => 'No se encontraron documentos';

  @override
  String get documentsDeleteTitle => '¿Eliminar este documento?';

  @override
  String get documentsDeleteSubtitle =>
      'Este archivo será eliminado permanentemente';

  @override
  String get documentsDeleteCancel => 'Cancelar';

  @override
  String get documentsDeleteButton => 'Eliminar';

  @override
  String get documentsMoreActionsTooltip => 'Más acciones';

  @override
  String get profilesSearch => 'Buscar';

  @override
  String get profilesEmptyList => 'No se encontraron perfiles';

  @override
  String get profilesViewMore => 'Ver más';

  @override
  String get profilesMore => 'Más';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina ahora recuerda tu salud';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Tus consultas ahora construyen y actualizan tu Historial Médico automáticamente.';

  @override
  String get profilesAnnouncementTitle2 => 'Tu historial médico, tus reglas';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Ve, edita o añade síntomas, medicamentos, historial o documentos en cualquier momento';

  @override
  String get profilesAnnouncementTitle3 => 'Cuida de toda tu familia';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Crea un registro de salud para tus seres queridos, tus hijos, padres o pareja.';

  @override
  String get profilesAnnouncementTitle4 =>
      '¿Listo para guardar tu historial médico?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Después de su consulta, toque “Agregar perfil” para guardarlo.';

  @override
  String get profilesNextButton => 'Siguiente';

  @override
  String get profilesStartButton => 'Iniciar una consulta';

  @override
  String get profilesLaterButton => 'Quizás más tarde';

  @override
  String get profileSuccessCloseButton => 'Cerrar';

  @override
  String get pdfHeaderTitle => 'Historial médico';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Historial médico — $name';
  }

  @override
  String get expandableFieldMore => '...más';

  @override
  String get expandableFieldLess => '...menos';

  @override
  String get profiles_button_addnew => 'Agregar nuevo perfil';

  @override
  String get profiles_label_addnew =>
      'Crear un perfil para guardar los detalles de esta consulta.';

  @override
  String get profiles_label_health_records_hint =>
      'Puede consultarlo en cualquier momento en Health Records';

  @override
  String get profiles_label_keep_talking_hint =>
      'Si tienes más preguntas sobre esto o cualquier cosa relacionada, no dudes en seguir hablando conmigo. Estoy aquí para ayudarte';

  @override
  String get profile_section_basic_title => 'Información General';

  @override
  String get profile_section_basic_name_label => 'Nombre';

  @override
  String get profile_section_basic_name_placeholder => 'Juan Pérez';

  @override
  String get profile_section_basic_first_name_label => 'Nombre';

  @override
  String get profile_section_basic_first_name_placeholder => 'Juan';

  @override
  String get profile_section_basic_last_name_label => 'Apellido';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Sexo';

  @override
  String get profile_section_basic_sex_placeholder => 'Por favor, seleccione';

  @override
  String get profile_section_basic_sex_options_male => 'Masculino';

  @override
  String get profile_section_basic_sex_options_female => 'Femenino';

  @override
  String get profile_section_basic_sex_options_other => 'Otro';

  @override
  String get profile_section_basic_date_of_birth_label => 'Fecha de nacimiento';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'AAAA-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Edad';

  @override
  String get profile_section_basic_age_str_placeholder => 'p. ej. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Número de teléfono';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'Correo electrónico';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Ubicación';

  @override
  String get profile_section_basic_location_placeholder =>
      'p. ej. Ciudad, País';

  @override
  String get profile_section_body_diet_title => 'Cuerpo & Dieta';

  @override
  String get profile_section_body_diet_height_str_label => 'Altura';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'p. ej. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Peso';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'p. ej. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Ciclo menstrual';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'p. ej. Regular, Irregular';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Restricciones alimentarias';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Seleccione';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Háganos saber qué come y cualquier restricción que tenga';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Ninguna';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vegetariano';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegano';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Sin gluten';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Índice de masa corporal (IMC)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'p. ej. 24.5';

  @override
  String get profile_section_health_profile_title => 'Perfil de salud';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Enfermedades crónicas';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'por ejemplo, diabetes tipo 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Por favor, enumere todas las enfermedades crónicas e incluya cuándo fueron diagnosticadas y cualquier complicación.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Enfermedades previas';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'por ejemplo, resfriados frecuentes';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Por favor, enumere las enfermedades graves que tuvo en el pasado, incluso si se recuperó';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Antecedentes quirúrgicos';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'p. ej. Apendicectomía';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Por favor, enumere todas las cirugías e incluya el año y si hubo alguna complicación';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Medicamentos de Uso Ocasional';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'por ejemplo, Ibuprofeno';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Por favor, enumere los medicamentos que toma de vez en cuando (por ejemplo: analgésicos, medicamentos para alergias), incluyendo la dosis y la razón de uso';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Medicamentos habituales';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'p. ej., Metformina';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Por favor, enumere todos los medicamentos que toma regularmente, incluyendo el nombre, la dosis, cuántas veces al día los toma y para qué condición son.';

  @override
  String get profile_section_health_profile_allergies_label => 'Alergias';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'por ejemplo, penicilina – causa erupción';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Por favor, enumere todas las alergias (medicamentos, alimentos, ambientales) y describa qué reacción tiene (por ejemplo: erupción, hinchazón, problemas para respirar).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Condiciones Especiales';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'p. ej. Embarazo, discapacidad';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Si tiene alguna condición médica importante que los médicos siempre deben conocer (por ejemplo: embarazo, dispositivos implantados, discapacidades, terapia anticoagulante), por favor descríbala. Si no, puede dejar esto en blanco.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Antecedentes familiares';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'p. ej. enfermedad cardíaca, cáncer';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Por favor, describa las enfermedades importantes en su familia (por ejemplo: diabetes, hipertensión, enfermedades del corazón, cáncer, enfermedades genéticas) y especifique qué miembro de la familia tuvo la condición.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Factores Sociales y de Estilo de Vida';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'p. ej. Fumar, Consumo de alcohol';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Por favor, describa los factores de estilo de vida que pueden afectar su salud, como fumar, alcohol, actividad física, dieta, sueño y ocupación.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Dispositivos médicos';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'p. ej. marcapasos, audífono, bomba de insulina';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Por favor, enumere cualquier dispositivo médico que use o tenga implantado, como marcapasos, bombas de insulina, audífonos, prótesis u otros dispositivos de asistencia o monitoreo. Incluya detalles relevantes si corresponde.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Omnívoro';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Comida Rápida';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Pescetariano';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Sin lactosa';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Dieta baja en sodio';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Dieta baja en azúcar';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Dieta cardíaca';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Dieta renal';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Otro';
}
