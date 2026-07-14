// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class ProfilesLocalizationUk extends ProfilesLocalization {
  ProfilesLocalizationUk([String locale = 'uk']) : super(locale);

  @override
  String get chatDrawerTitle => 'Медичні записи';

  @override
  String get chatDrawerBadgeNew => 'НОВИЙ';

  @override
  String get bannerTitle => 'Створіть свою медичну картку';

  @override
  String get bannerSubtitle =>
      'В кінці вашої консультації додайте свій профіль.';

  @override
  String get bannerMoreProfilesTitle => 'Додати більше профілів';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Почніть консультацію для когось іншого, щоб створити їхній профіль.';

  @override
  String get bannerSignUp => 'Зареєструйтеся, щоб створити свою медичну картку';

  @override
  String get errorRetryButton => 'Спробувати знову';

  @override
  String get dashboardDeleteError => 'Не вдалося видалити профіль';

  @override
  String get dashboardSummaryLoadError =>
      'Не вдалося завантажити підсумок профілю';

  @override
  String get dashboardMenuViewFullRecord => 'Переглянути повний запис';

  @override
  String get dashboardMenuShare => 'Поділитися';

  @override
  String get dashboardMenuDelete => 'Видалити';

  @override
  String get dashboardMetricAgeLabel => 'Вік';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value років',
      one: '$value рік',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Вага';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value кг';
  }

  @override
  String get dashboardMetricHeightLabel => 'Висота';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value см';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Алергії';

  @override
  String get dashboardInfoChronicTitle => 'Хронічний';

  @override
  String get dashboardInfoMedicationTitle => 'Ліки';

  @override
  String get dashboardInfoDevicesTitle => 'Пристрої';

  @override
  String get dashboardNavigationConsultations => 'Консультації';

  @override
  String get dashboardNavigationDocuments => 'Документи';

  @override
  String get dashboardDeleteRecordTitle => 'Видалити медичну картку?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Це назавжди видалить ваші дані про здоров\'я і не може бути скасовано. Ви втратите контекст, який ми використовуємо для вашого керівництва.';

  @override
  String get dashboardDeleteRecordCancel => 'Скасувати';

  @override
  String get dashboardDeleteRecordConfirm => 'Видалити';

  @override
  String get dashboardDeleteRecordLoading =>
      'Видалення вашої медичної картки...';

  @override
  String get dashboardDeleteRecordError => 'Не вдалося видалити профіль';

  @override
  String get dashboardDeleteRecordSuccessTitle =>
      'Запис про здоров\'я видалено';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Ви можете створити новий у будь-який час, спілкуючись з асистентом.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Повернутися до чату';

  @override
  String get dataEditingScreenTitle => 'Редагування';

  @override
  String get dataFailedToLoadError => 'Не вдалося завантажити дані профілю';

  @override
  String get dataRecordSavedTitle => 'Зміни збережено';

  @override
  String get dataRecordSavedSubtitle =>
      'Ваша інформація була успішно оновлена.';

  @override
  String get dataRecordSavedButton => 'Повернутися до профілю';

  @override
  String get dataRecordUpdateError => 'Не вдалося оновити дані профілю';

  @override
  String get dataRecordDiscardTitle => 'Скасувати зміни?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Ви внесли деякі зміни до свого профілю. Збережіть їх перед виходом або скиньте.';

  @override
  String get dataRecordDiscardCancel => 'Продовжити редагування';

  @override
  String get dataRecordDiscardConfirm => 'Скасувати';

  @override
  String get dataRecordEditTooltip => 'Редагувати';

  @override
  String get dataRecordAddTag => 'Додати запис';

  @override
  String get consultationsSearch => 'Пошук';

  @override
  String get consultationsSearchEmpty => 'Результатів не знайдено';

  @override
  String get documentsMenuDownload => 'Завантажити';

  @override
  String get documentsMenuShare => 'Поділитися';

  @override
  String get documentsMenuDelete => 'Видалити';

  @override
  String get documentsEmptyList => 'Документи не знайдено';

  @override
  String get documentsDeleteTitle => 'Видалити цей документ?';

  @override
  String get documentsDeleteSubtitle => 'Цей файл буде видалено назавжди';

  @override
  String get documentsDeleteCancel => 'Скасувати';

  @override
  String get documentsDeleteButton => 'Видалити';

  @override
  String get documentsMoreActionsTooltip => 'Інші дії';

  @override
  String get profilesSearch => 'Пошук';

  @override
  String get profilesEmptyList => 'Профілів не знайдено';

  @override
  String get profilesViewMore => 'Показати більше';

  @override
  String get profilesMore => 'Більше';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina тепер пам\'ятає ваше здоров\'я';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Ваші консультації тепер автоматично формують і оновлюють вашу медичну картку.';

  @override
  String get profilesAnnouncementTitle2 => 'Ваш медичний запис, ваші правила';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Переглядайте, редагуйте або додавайте симптоми, ліки, історію чи документи в будь-який час.';

  @override
  String get profilesAnnouncementTitle3 => 'Доглядайте за всією родиною';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Створіть медичну картку для своїх близьких, дітей, батьків або партнера.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Готові зберегти вашу медичну картку?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Після консультації натисніть «Додати профіль», щоб зберегти його.';

  @override
  String get profilesNextButton => 'Далі';

  @override
  String get profilesStartButton => 'Почати консультацію';

  @override
  String get profilesLaterButton => 'Можливо, пізніше';

  @override
  String get profileSuccessCloseButton => 'Закрити';

  @override
  String get pdfHeaderTitle => 'Медична картка';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Медична картка — $name';
  }

  @override
  String get expandableFieldMore => '...більше';

  @override
  String get expandableFieldLess => 'менше';

  @override
  String get profiles_button_addnew => 'Додати новий профіль';

  @override
  String get profiles_label_addnew =>
      'Створіть профіль, щоб зберегти деталі цієї консультації.';

  @override
  String get profiles_label_health_records_hint =>
      'Ви можете переглянути це у своїх медичних записах будь-коли';

  @override
  String get profiles_label_keep_talking_hint =>
      'Якщо у вас є додаткові запитання щодо цього або будь-яких пов’язаних тем, не соромтеся продовжувати спілкуватися зі мною. Я тут, щоб допомогти';

  @override
  String get profile_section_basic_title => 'Загальна інформація';

  @override
  String get profile_section_basic_name_label => 'Ім\'я';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'Ім\'я';

  @override
  String get profile_section_basic_first_name_placeholder => 'Іван';

  @override
  String get profile_section_basic_last_name_label => 'Прізвище';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Стать';

  @override
  String get profile_section_basic_sex_placeholder => 'Оберіть';

  @override
  String get profile_section_basic_sex_options_male => 'Чоловік';

  @override
  String get profile_section_basic_sex_options_female => 'Жінка';

  @override
  String get profile_section_basic_sex_options_other => 'Інше';

  @override
  String get profile_section_basic_date_of_birth_label => 'Дата народження';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'РРРР-ММ-ДД';

  @override
  String get profile_section_basic_age_str_label => 'Вік';

  @override
  String get profile_section_basic_age_str_placeholder => 'наприклад 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Номер телефону';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'Електронна пошта';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Місцезнаходження';

  @override
  String get profile_section_basic_location_placeholder =>
      'напр. Місто, Країна';

  @override
  String get profile_section_body_diet_title => 'Тіло & Харчування';

  @override
  String get profile_section_body_diet_height_str_label => 'Зріст';

  @override
  String get profile_section_body_diet_height_str_placeholder =>
      'наприклад 180 см';

  @override
  String get profile_section_body_diet_weight_str_label => 'Вага';

  @override
  String get profile_section_body_diet_weight_str_placeholder =>
      'наприклад, 75 кг';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Менструальний цикл';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'e.g. Регулярний, Нерегулярний';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Дієтичні обмеження';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Будь ласка, виберіть';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Дайте нам знати, що ви їсте та які у вас є обмеження';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Немає';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Вегетаріанська';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Веган';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Без глютену';

  @override
  String get profile_section_body_diet_bmi_label => 'Індекс маси тіла (ІМТ)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'наприклад 24.5';

  @override
  String get profile_section_health_profile_title => 'Профіль здоров\'я';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Хронічні захворювання';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'Цукровий діабет 2 типу';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Будь ласка, перелікуйте всі хронічні захворювання та вкажіть, коли вони були діагностовані, а також будь-які ускладнення.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Попередні захворювання';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'наприклад, часті простудні захворювання';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Будь ласка, перераховуйте серйозні захворювання, які у вас були в минулому, навіть якщо ви одужали.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Хірургічний анамнез';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'наприклад апендектомія';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Будь ласка, перерахуйте всі операції та вкажіть рік і чи були ускладнення.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Зрідка вживані ліки';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'наприклад, Ібупрофен';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Будь ласка, вкажіть ліки, які ви приймаєте час від часу (наприклад: знеболювальні, ліки від алергії), включаючи дозу та причину використання.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Регулярні ліки';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'наприклад, Метформін';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Будь ласка, вкажіть усі ліки, які ви приймаєте регулярно, включаючи назву, дозу, скільки разів на день ви їх приймаєте та для якого стану вони призначені.';

  @override
  String get profile_section_health_profile_allergies_label => 'Алергії';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'наприклад, пеніцилін – викликає висип';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Будь ласка, перерахуйте всі алергії (ліки, їжа, навколишнє середовище) та опишіть, яку реакцію ви маєте (наприклад: висип, набряк, проблеми з диханням).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Особливі стани';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'наприклад: вагітність, інвалідність';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Якщо у вас є важливі медичні стани, про які лікарі завжди повинні знати (наприклад: вагітність, імплантовані пристрої, інвалідність, терапія антикоагулянтами), будь ласка, опишіть їх. Якщо немає, ви можете залишити це поле порожнім.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Сімейний анамнез';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'наприклад: серцеві захворювання, рак';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Будь ласка, опишіть важливі захворювання у вашій родині (наприклад: діабет, гіпертонія, серцеві захворювання, рак, генетичні захворювання) та вкажіть, який член родини мав це захворювання.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Соціальні та фактори способу життя';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'напр. Куріння, Вживання алкоголю';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Будь ласка, опишіть фактори способу життя, які можуть вплинути на ваше здоров\'я, такі як куріння, алкоголь, фізична активність, дієта, сон та професія.';

  @override
  String get profile_section_health_profile_devices_label => 'Медичні пристрої';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'Наприклад: кардіостимулятор, слуховий апарат, інсулінова помпа';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Будь ласка, вкажіть будь-які медичні пристрої, які ви використовуєте або які у вас імплантовані, такі як кардіостимулятори, інсулінові помпи, слухові апарати, протези або інші допоміжні чи моніторингові пристрої. Включіть відповідні деталі, якщо це можливо.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Всеїдний';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Фастфуд';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Пескатаріанець';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Без лактози';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Дієта з низьким вмістом солі';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Дієта з низьким вмістом цукру';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Серцева дієта';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Ниркова дієта';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Інше';
}
