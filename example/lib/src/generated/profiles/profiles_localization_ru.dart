// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class ProfilesLocalizationRu extends ProfilesLocalization {
  ProfilesLocalizationRu([String locale = 'ru']) : super(locale);

  @override
  String get chatDrawerTitle => 'Медицинские записи';

  @override
  String get chatDrawerBadgeNew => 'НОВЫЙ';

  @override
  String get bannerTitle => 'Создайте свою медицинскую карту';

  @override
  String get bannerSubtitle =>
      'В конце вашей консультации добавьте свой профиль';

  @override
  String get bannerMoreProfilesTitle => 'Добавить больше профилей';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Начните консультацию для кого-то другого, чтобы создать их профиль';

  @override
  String get bannerSignUp =>
      'Зарегистрируйтесь, чтобы создать свою медицинскую карту';

  @override
  String get errorRetryButton => 'Повторить';

  @override
  String get dashboardDeleteError => 'Не удалось удалить профиль';

  @override
  String get dashboardSummaryLoadError => 'Не удалось загрузить сводку профиля';

  @override
  String get dashboardMenuViewFullRecord => 'Просмотреть полную запись';

  @override
  String get dashboardMenuShare => 'Поделиться';

  @override
  String get dashboardMenuDelete => 'Удалить';

  @override
  String get dashboardMetricAgeLabel => 'Возраст';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value года',
      one: '$value год',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Вес';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value кг';
  }

  @override
  String get dashboardMetricHeightLabel => 'Рост';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value см';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'Аллергии';

  @override
  String get dashboardInfoChronicTitle => 'Хронический';

  @override
  String get dashboardInfoMedicationTitle => 'Медикаменты';

  @override
  String get dashboardInfoDevicesTitle => 'Устройства';

  @override
  String get dashboardNavigationConsultations => 'Консультации';

  @override
  String get dashboardNavigationDocuments => 'Документы';

  @override
  String get dashboardDeleteRecordTitle => 'Удалить медицинскую запись?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Это навсегда удалит ваши данные о здоровье и не может быть отменено. Вы потеряете контекст, который мы используем для вашего руководства.';

  @override
  String get dashboardDeleteRecordCancel => 'Отмена';

  @override
  String get dashboardDeleteRecordConfirm => 'Удалить';

  @override
  String get dashboardDeleteRecordLoading =>
      'Удаление вашей медицинской записи...';

  @override
  String get dashboardDeleteRecordError => 'Не удалось удалить профиль';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Запись о здоровье удалена';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Вы можете создать новый в любое время, общаясь с помощником.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Вернуться в чат';

  @override
  String get dataEditingScreenTitle => 'Редактирование';

  @override
  String get dataFailedToLoadError => 'Не удалось загрузить данные профиля';

  @override
  String get dataRecordSavedTitle => 'Изменения сохранены';

  @override
  String get dataRecordSavedSubtitle =>
      'Ваша информация была успешно обновлена.';

  @override
  String get dataRecordSavedButton => 'Вернуться к профилю';

  @override
  String get dataRecordUpdateError => 'Не удалось обновить данные профиля';

  @override
  String get dataRecordDiscardTitle => 'Отменить изменения?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Вы внесли изменения в свой профиль. Сохраните их перед тем, как уйти, или отмените.';

  @override
  String get dataRecordDiscardCancel => 'Продолжить редактирование';

  @override
  String get dataRecordDiscardConfirm => 'Отменить';

  @override
  String get dataRecordEditTooltip => 'Редактировать';

  @override
  String get dataRecordAddTag => 'Добавить запись';

  @override
  String get consultationsSearch => 'Поиск';

  @override
  String get consultationsSearchEmpty => 'Результатов не найдено';

  @override
  String get documentsMenuDownload => 'Скачать';

  @override
  String get documentsMenuShare => 'Поделиться';

  @override
  String get documentsMenuDelete => 'Удалить';

  @override
  String get documentsEmptyList => 'Документы не найдены';

  @override
  String get documentsDeleteTitle => 'Удалить этот документ?';

  @override
  String get documentsDeleteSubtitle => 'Этот файл будет удален навсегда';

  @override
  String get documentsDeleteCancel => 'Отмена';

  @override
  String get documentsDeleteButton => 'Удалить';

  @override
  String get documentsMoreActionsTooltip => 'Другие действия';

  @override
  String get profilesSearch => 'Поиск';

  @override
  String get profilesEmptyList => 'Профили не найдены';

  @override
  String get profilesViewMore => 'Показать ещё';

  @override
  String get profilesMore => ' Ещё';

  @override
  String get profilesAnnouncementTitle1 =>
      'Докторина теперь помнит о вашем здоровье';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Ваши консультации теперь автоматически формируют и обновляют вашу медицинскую карту.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Ваша медицинская карта, ваши правила';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Просматривайте, редактируйте или добавляйте симптомы, лекарства, историю или документы в любое время';

  @override
  String get profilesAnnouncementTitle3 => 'Заботьтесь о всей вашей семье';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Создайте медицинскую карту для своих близких, детей, родителей или партнера.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Готовы сохранить вашу медицинскую карту?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'После консультации нажмите «Добавить профиль», чтобы сохранить его.';

  @override
  String get profilesNextButton => 'Далее';

  @override
  String get profilesStartButton => 'Начать консультацию';

  @override
  String get profilesLaterButton => 'Может быть позже';

  @override
  String get profileSuccessCloseButton => 'Закрыть';

  @override
  String get pdfHeaderTitle => 'Медицинская карта';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Медицинская карта — $name';
  }

  @override
  String get expandableFieldMore => '...больше';

  @override
  String get expandableFieldLess => '...меньше';

  @override
  String get profiles_button_addnew => 'Добавить профиль';

  @override
  String get profiles_label_addnew =>
      'Создайте профиль, чтобы сохранить данные этой консультации.';

  @override
  String get profiles_label_health_records_hint =>
      'Вы можете в любое время оценить это в своих медицинских записях';

  @override
  String get profiles_label_keep_talking_hint =>
      'Если у вас есть ещё вопросы по этому или по смежным темам, не стесняйтесь продолжать общение со мной. Я здесь, чтобы помочь';

  @override
  String get profile_section_basic_title => 'Общая информация';

  @override
  String get profile_section_basic_name_label => 'Имя';

  @override
  String get profile_section_basic_name_placeholder => 'Иван Иванов';

  @override
  String get profile_section_basic_first_name_label => 'Имя';

  @override
  String get profile_section_basic_first_name_placeholder => 'Иван';

  @override
  String get profile_section_basic_last_name_label => 'Фамилия';

  @override
  String get profile_section_basic_last_name_placeholder => 'Иванов';

  @override
  String get profile_section_basic_sex_label => 'Пол';

  @override
  String get profile_section_basic_sex_placeholder => 'Выберите';

  @override
  String get profile_section_basic_sex_options_male => 'Мужской';

  @override
  String get profile_section_basic_sex_options_female => 'Женский';

  @override
  String get profile_section_basic_sex_options_other => 'Другое';

  @override
  String get profile_section_basic_date_of_birth_label => 'Дата рождения';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'ГГГГ-ММ-ДД';

  @override
  String get profile_section_basic_age_str_label => 'Возраст';

  @override
  String get profile_section_basic_age_str_placeholder => 'например, 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Номер телефона';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'Электронная почта';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Местоположение';

  @override
  String get profile_section_basic_location_placeholder =>
      'напр. Город, Страна';

  @override
  String get profile_section_body_diet_title => 'Тело и питание';

  @override
  String get profile_section_body_diet_height_str_label => 'Рост';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'например, 180 см';

  @override
  String get profile_section_body_diet_weight_str_label => 'Вес';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'напр. 75 кг';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Менструальный цикл';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'например регулярный';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Ограничения в питании';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Пожалуйста, выберите';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Сообщите нам, что вы едите и какие у вас есть ограничения';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Нет';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Вегетарианец';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Веган';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Без глютена';

  @override
  String get profile_section_body_diet_bmi_label => 'Индекс массы тела (ИМТ)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'напр. 24,5';

  @override
  String get profile_section_health_profile_title => 'Профиль здоровья';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Хронические заболевания';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'например диабет 2 типа';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Пожалуйста, укажите все хронические заболевания, а также дату их диагностики и любые осложнения';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Перенесённые заболевания';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'например частые простуды';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Пожалуйста, укажите серьезные заболевания, которые у вас были в прошлом, даже если вы выздоровели';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Хирургический анамнез';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'например аппендэктомия';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Пожалуйста, перечислите все операции и укажите год, а также были ли какие-либо осложнения';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Редко используемые лекарства';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'например Ибупрофен';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Пожалуйста, укажите лекарства, которые вы принимаете время от времени (например: обезболивающие, аллергические препараты), включая дозу и причину использования';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Регулярные препараты';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'например Метформин';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Пожалуйста, укажите все лекарства, которые вы принимаете регулярно, включая название, дозу, сколько раз в день вы их принимаете и для какого состояния они предназначены.';

  @override
  String get profile_section_health_profile_allergies_label => 'Аллергии';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'например Пенициллин';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Пожалуйста, укажите все аллергии (лекарства, продукты, окружающая среда) и опишите, какая реакция у вас возникает (например: сыпь, отек, проблемы с дыханием).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Особые состояния здоровья';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'например беременность';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Если у вас есть какие-либо важные медицинские состояния, о которых врачи всегда должны знать (например: беременность, имплантированные устройства, инвалидность, терапия антикоагулянтами), пожалуйста, опишите их. Если нет, вы можете оставить это поле пустым.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Семейный анамнез';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'например болезнь сердца';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Пожалуйста, опишите важные заболевания в вашей семье (например: диабет, гипертония, сердечно-сосудистые заболевания, рак, генетические заболевания) и укажите, у какого члена семьи была эта болезнь.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Социальные и связанные с образом жизни факторы';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'например курение';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Пожалуйста, опишите факторы образа жизни, которые могут повлиять на ваше здоровье, такие как курение, алкоголь, физическая активность, диета, сон и профессия.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Медицинские устройства';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'например кардиостимулятор';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Пожалуйста, укажите любые медицинские устройства, которые вы используете или которые у вас имплантированы, такие как кардиостимуляторы, инсулиновые помпы, слуховые аппараты, протезы или другие вспомогательные или мониторинговые устройства. Укажите соответствующие детали, если это применимо.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Всеядный';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Фастфуд';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Пескетарианец';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Без лактозы';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Низкосолевая диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Низкосахарная диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Кардиологическая диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Почечная диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Другое';
}
