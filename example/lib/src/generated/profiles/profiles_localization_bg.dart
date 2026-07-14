// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class ProfilesLocalizationBg extends ProfilesLocalization {
  ProfilesLocalizationBg([String locale = 'bg']) : super(locale);

  @override
  String get chatDrawerTitle => 'Медицински записи';

  @override
  String get chatDrawerBadgeNew => 'НОВ';

  @override
  String get bannerTitle => 'Създайте своя здравен запис';

  @override
  String get bannerSubtitle => 'В края на консултацията добавете профила си.';

  @override
  String get bannerMoreProfilesTitle => 'Добави още профили';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Започнете консултация за някой друг, за да създадете профила му.';

  @override
  String get bannerSignUp =>
      'Регистрирайте се, за да създадете здравния си запис';

  @override
  String get errorRetryButton => 'Опитай отново';

  @override
  String get dashboardDeleteError => 'Неуспешно изтриване на профила';

  @override
  String get dashboardSummaryLoadError =>
      'Неуспешно зареждане на резюме на профила';

  @override
  String get dashboardMenuViewFullRecord => 'Преглед на пълния запис';

  @override
  String get dashboardMenuShare => 'Сподели';

  @override
  String get dashboardMenuDelete => 'Изтрий';

  @override
  String get dashboardMetricAgeLabel => 'Възраст';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value години',
      one: '$value година',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Тегло';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Височина';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'Алергии';

  @override
  String get dashboardInfoChronicTitle => 'Хроничен';

  @override
  String get dashboardInfoMedicationTitle => 'Лекарства';

  @override
  String get dashboardInfoDevicesTitle => 'Устройства';

  @override
  String get dashboardNavigationConsultations => 'Консултации';

  @override
  String get dashboardNavigationDocuments => 'Документи';

  @override
  String get dashboardDeleteRecordTitle => 'Изтриване на здравен запис?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Това ще премахне трайно вашите здравни данни и не може да бъде отменено. Ще загубите контекста, който използваме, за да ви водим.';

  @override
  String get dashboardDeleteRecordCancel => 'Отмяна';

  @override
  String get dashboardDeleteRecordConfirm => 'Изтрий';

  @override
  String get dashboardDeleteRecordLoading => 'Изтривам вашия здравен запис...';

  @override
  String get dashboardDeleteRecordError => 'Неуспешно изтриване на профил';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Здравният запис е изтрит';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Можете да създадете нов по всяко време, като разговаряте с асистента.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Върнете се в чата';

  @override
  String get dataEditingScreenTitle => 'Редактиране';

  @override
  String get dataFailedToLoadError => 'Неуспешно зареждане на данни за профила';

  @override
  String get dataRecordSavedTitle => 'Промените са запазени';

  @override
  String get dataRecordSavedSubtitle =>
      'Вашата информация беше успешно актуализирана.';

  @override
  String get dataRecordSavedButton => 'Върнете се в профила';

  @override
  String get dataRecordUpdateError =>
      'Неуспешно обновяване на данните за профила';

  @override
  String get dataRecordDiscardTitle => 'Отказване на промените?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Направихте някои промени в профила си. Запазете ги, преди да си тръгнете, или ги отхвърлете.';

  @override
  String get dataRecordDiscardCancel => 'Продължете да редактирате';

  @override
  String get dataRecordDiscardConfirm => 'Изтрий';

  @override
  String get dataRecordEditTooltip => 'Редактиране';

  @override
  String get dataRecordAddTag => 'Добави запис';

  @override
  String get consultationsSearch => 'Търсене';

  @override
  String get consultationsSearchEmpty => 'Не са намерени резултати';

  @override
  String get documentsMenuDownload => 'Изтегли';

  @override
  String get documentsMenuShare => 'Сподели';

  @override
  String get documentsMenuDelete => 'Изтрий';

  @override
  String get documentsEmptyList => 'Не са намерени документи';

  @override
  String get documentsDeleteTitle => 'Да изтрием ли този документ?';

  @override
  String get documentsDeleteSubtitle => 'Този файл ще бъде трайно премахнат';

  @override
  String get documentsDeleteCancel => 'Отмяна';

  @override
  String get documentsDeleteButton => 'Изтрий';

  @override
  String get documentsMoreActionsTooltip => 'Още действия';

  @override
  String get profilesSearch => 'Търсене';

  @override
  String get profilesEmptyList => 'Не са намерени профили';

  @override
  String get profilesViewMore => 'Виж още';

  @override
  String get profilesMore => 'Още';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina вече помни вашето здраве';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Вашите консултации сега автоматично изграждат и актуализират вашата Здравна карта.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Вашата здравна карта, вашите правила';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Прегледайте, редактирайте или добавяйте симптоми, лекарства, история или документи по всяко време.';

  @override
  String get profilesAnnouncementTitle3 => 'Грижа за цялото семейство';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Създайте здравен запис за вашите близки, деца, родители или партньор.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Готови ли сте да запазите здравния си запис?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'След консултацията натиснете „Добави профил“, за да го запазите.';

  @override
  String get profilesNextButton => 'Напред';

  @override
  String get profilesStartButton => 'Започнете консултация';

  @override
  String get profilesLaterButton => 'Може би по-късно';

  @override
  String get profileSuccessCloseButton => 'Затвори';

  @override
  String get pdfHeaderTitle => 'Медицинска карта';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Медицинска карта — $name';
  }

  @override
  String get expandableFieldMore => '...повече';

  @override
  String get expandableFieldLess => '...по-малко';

  @override
  String get profiles_button_addnew => 'Добави нов профил';

  @override
  String get profiles_label_addnew =>
      'Създайте профил, за да запазите детайлите на тази консултация';

  @override
  String get profiles_label_health_records_hint =>
      'Можете да го прегледате по всяко време в здравните си записи';

  @override
  String get profiles_label_keep_talking_hint =>
      'Ако имате още въпроси за това или за нещо свързано, не се колебайте да продължите да говорите с мен. Аз съм тук, за да помогна';

  @override
  String get profile_section_basic_title => 'Обща информация';

  @override
  String get profile_section_basic_name_label => 'Име';

  @override
  String get profile_section_basic_name_placeholder => 'Иван Иванов';

  @override
  String get profile_section_basic_first_name_label => 'Име';

  @override
  String get profile_section_basic_first_name_placeholder => 'Иван';

  @override
  String get profile_section_basic_last_name_label => 'Фамилия';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Пол';

  @override
  String get profile_section_basic_sex_placeholder => 'Моля, изберете';

  @override
  String get profile_section_basic_sex_options_male => 'Мъж';

  @override
  String get profile_section_basic_sex_options_female => 'Жена';

  @override
  String get profile_section_basic_sex_options_other => 'Друго';

  @override
  String get profile_section_basic_date_of_birth_label => 'Дата на раждане';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'ГГГГ-ММ-ДД';

  @override
  String get profile_section_basic_age_str_label => 'Възраст';

  @override
  String get profile_section_basic_age_str_placeholder => 'напр. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Телефонен номер';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'Имейл';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'Местоположение';

  @override
  String get profile_section_basic_location_placeholder =>
      'напр. Град, Държава';

  @override
  String get profile_section_body_diet_title => 'Тяло & Хранене';

  @override
  String get profile_section_body_diet_height_str_label => 'Височина';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'напр. 180 см';

  @override
  String get profile_section_body_diet_weight_str_label => 'Тегло';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'напр. 75 кг';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'Менструален цикъл';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'напр. Редовен, Нередовен';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Диетични ограничения';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Моля, изберете';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Кажете ни какво ядете и какви ограничения имате';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Няма ограничения';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Вегетарианска диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Веган';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Без глутен';

  @override
  String get profile_section_body_diet_bmi_label =>
      'Индекс на телесна маса (ИТМ)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'напр. 24.5';

  @override
  String get profile_section_health_profile_title => 'Здравен профил';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Хронични заболявания';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'напр. Диабет тип 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Моля, посочете всички хронични заболявания и включете кога са били диагностицирани и всякакви усложнения.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Предишни заболявания';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'напр. Чести настинки';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Моля, посочете сериозни заболявания, които сте имали в миналото, дори и да сте се възстановили.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Хирургична анамнеза';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'напр. апендектомия';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Моля, изброите всички операции и включете годината и дали е имало усложнения.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Понякога използвани лекарства';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'напр. Ибупрофен';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Моля, посочете медикаменти, които приемате от време на време (например: болкоуспокояващи, медикаменти за алергия), включително дозата и причината за употреба.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Редовни лекарства';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'напр. Метформин';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Моля, посочете всички лекарства, които приемате редовно, включително името, дозата, колко пъти на ден ги приемате и за какво състояние са.';

  @override
  String get profile_section_health_profile_allergies_label => 'Алергии';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'напр. Пеницилин – причинява обрив';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Моля, посочете всички алергии (медикаменти, храни, околна среда) и опишете каква реакция имате (например: обрив, подуване, проблеми с дишането).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Специални състояния';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'напр. Бременност, Инвалидност';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Ако имате важни медицински състояния, за които лекарите винаги трябва да знаят (например: бременност, имплантирани устройства, увреждания, антикоагулантна терапия), моля, опишете ги. Ако нямате, можете да оставите това поле празно.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Семейна анамнеза';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'напр. сърдечни заболявания, рак';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Моля, опишете важни заболявания в семейството си (например: диабет, хипертония, сърдечни заболявания, рак, генетични заболявания) и посочете кой член на семейството е имал състоянието.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Социални и фактори, свързани с начина на живот';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'напр. Пушене, Консумация на алкохол';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Моля, опишете факторите на начина на живот, които могат да повлияят на вашето здраве, като пушене, алкохол, физическа активност, диета, сън и професия.';

  @override
  String get profile_section_health_profile_devices_label =>
      'Медицински устройства';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'напр. Пейсмейкър, Слухов апарат, Инсулинова помпа';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Моля, посочете всички медицински устройства, които използвате или имате имплантирани, като пейсмейкъри, инсулинови помпи, слухови апарати, протези или други помощни или мониторингови устройства. Включете съответните детайли, ако е приложимо.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Всеяден';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Бърза храна';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Пескатарианец';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Без лактоза';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Диета с ниско съдържание на сол';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Диета с ниско съдържание на захар';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Сърдечна диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Бъбречна диета';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Друго';
}
