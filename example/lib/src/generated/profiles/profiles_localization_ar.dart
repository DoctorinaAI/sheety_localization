// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class ProfilesLocalizationAr extends ProfilesLocalization {
  ProfilesLocalizationAr([String locale = 'ar']) : super(locale);

  @override
  String get chatDrawerTitle => 'سجلات الصحة';

  @override
  String get chatDrawerBadgeNew => 'جديد';

  @override
  String get bannerTitle => 'أنشئ سجل صحتك';

  @override
  String get bannerSubtitle => 'في نهاية استشارتك، أضف ملفك الشخصي';

  @override
  String get bannerMoreProfilesTitle => 'أضف المزيد من الملفات الشخصية';

  @override
  String get bannerMoreProfilesSubtitle =>
      'ابدأ استشارة لشخص آخر لإنشاء ملفه الشخصي';

  @override
  String get bannerSignUp => 'سجل لإنشاء سجل صحتك';

  @override
  String get errorRetryButton => 'إعادة المحاولة';

  @override
  String get dashboardDeleteError => 'فشل حذف الملف الشخصي';

  @override
  String get dashboardSummaryLoadError => 'فشل تحميل ملخص الملف الشخصي';

  @override
  String get dashboardMenuViewFullRecord => 'عرض السجل الكامل';

  @override
  String get dashboardMenuShare => 'شارك';

  @override
  String get dashboardMenuDelete => 'حذف';

  @override
  String get dashboardMetricAgeLabel => 'العمر';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value سنوات',
      one: '$value سنة',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'الوزن';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value كجم';
  }

  @override
  String get dashboardMetricHeightLabel => 'الطول';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value سم';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'الحساسية';

  @override
  String get dashboardInfoChronicTitle => 'مزمن';

  @override
  String get dashboardInfoMedicationTitle => 'الأدوية';

  @override
  String get dashboardInfoDevicesTitle => 'الأجهزة';

  @override
  String get dashboardNavigationConsultations => 'استشارات';

  @override
  String get dashboardNavigationDocuments => 'المستندات';

  @override
  String get dashboardDeleteRecordTitle => 'هل تريد حذف السجل الصحي؟';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'سيؤدي ذلك إلى إزالة بيانات صحتك بشكل دائم ولا يمكن التراجع عنه. ستفقد السياق الذي نستخدمه لإرشادك.';

  @override
  String get dashboardDeleteRecordCancel => 'إلغاء';

  @override
  String get dashboardDeleteRecordConfirm => 'حذف';

  @override
  String get dashboardDeleteRecordLoading => 'جارٍ حذف سجل صحتك...';

  @override
  String get dashboardDeleteRecordError => 'فشل في حذف الملف الشخصي';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'تم حذف السجل الصحي';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'يمكنك إنشاء واحدة جديدة في أي وقت من خلال الدردشة مع المساعد.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'العودة إلى الدردشة';

  @override
  String get dataEditingScreenTitle => 'تعديل';

  @override
  String get dataFailedToLoadError => 'فشل تحميل بيانات الملف الشخصي';

  @override
  String get dataRecordSavedTitle => 'تم حفظ التغييرات';

  @override
  String get dataRecordSavedSubtitle => 'تم تحديث معلوماتك بنجاح';

  @override
  String get dataRecordSavedButton => 'العودة إلى الملف الشخصي';

  @override
  String get dataRecordUpdateError => 'فشل في تحديث بيانات الملف الشخصي';

  @override
  String get dataRecordDiscardTitle => 'هل تريدDiscard التغييرات؟';

  @override
  String get dataRecordDiscardSubtitle =>
      'لقد قمت بإجراء بعض التغييرات على ملفك الشخصي. احفظها قبل أن تذهب، أو تخلص منها.';

  @override
  String get dataRecordDiscardCancel => 'استمر في التحرير';

  @override
  String get dataRecordDiscardConfirm => 'تجاهل';

  @override
  String get dataRecordEditTooltip => 'تعديل';

  @override
  String get dataRecordAddTag => 'أضف سجل';

  @override
  String get consultationsSearch => 'بحث';

  @override
  String get consultationsSearchEmpty => 'لم يتم العثور على نتائج';

  @override
  String get documentsMenuDownload => 'تحميل';

  @override
  String get documentsMenuShare => 'شارك';

  @override
  String get documentsMenuDelete => 'حذف';

  @override
  String get documentsEmptyList => 'لا توجد مستندات';

  @override
  String get documentsDeleteTitle => 'هل تريد حذف هذا المستند؟';

  @override
  String get documentsDeleteSubtitle => 'سيتم حذف هذا الملف بشكل دائم';

  @override
  String get documentsDeleteCancel => 'إلغاء';

  @override
  String get documentsDeleteButton => 'حذف';

  @override
  String get documentsMoreActionsTooltip => 'إجراءات إضافية';

  @override
  String get profilesSearch => 'بحث';

  @override
  String get profilesEmptyList => 'لم يتم العثور على ملفات شخصية';

  @override
  String get profilesViewMore => 'عرض المزيد';

  @override
  String get profilesMore => 'المزيد';

  @override
  String get profilesAnnouncementTitle1 => 'دوكتورينا الآن تتذكر صحتك';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'استشاراتك الآن تبني وتحدث سجل صحتك تلقائيًا.';

  @override
  String get profilesAnnouncementTitle2 => 'سجل صحتك، قواعدك';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'عرض أو تعديل أو إضافة الأعراض أو الأدوية أو التاريخ أو المستندات في أي وقت';

  @override
  String get profilesAnnouncementTitle3 => 'اعتنِ بكل عائلتك';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'أنشئ سجل صحي لأحبائك، أطفالك، والديك، أو شريكك.';

  @override
  String get profilesAnnouncementTitle4 => 'هل أنت مستعد لحفظ سجل صحتك؟';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'بعد الاستشارة، اضغط على \"إضافة ملف\" لحفظه.';

  @override
  String get profilesNextButton => 'التالي';

  @override
  String get profilesStartButton => 'ابدأ استشارة';

  @override
  String get profilesLaterButton => 'ربما لاحقًا';

  @override
  String get profileSuccessCloseButton => 'إغلاق';

  @override
  String get pdfHeaderTitle => 'سجل الصحة';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'سجل الصحة — $name';
  }

  @override
  String get expandableFieldMore => '...المزيد';

  @override
  String get expandableFieldLess => 'أقل';

  @override
  String get profiles_button_addnew => 'إضافة ملف جديد';

  @override
  String get profiles_label_addnew => 'أنشئ ملفًا لحفظ تفاصيل هذه الاستشارة';

  @override
  String get profiles_label_health_records_hint =>
      'يمكنك الاطلاع عليه في أي وقت في سجلاتك الصحية';

  @override
  String get profiles_label_keep_talking_hint =>
      'إذا كان لديك المزيد من الأسئلة حول هذا أو أي شيء ذي صلة، فلا تتردد في الاستمرار في الحديث معي. أنا هنا للمساعدة';

  @override
  String get profile_section_basic_title => 'معلومات عامة';

  @override
  String get profile_section_basic_name_label => 'الاسم';

  @override
  String get profile_section_basic_name_placeholder => 'جون دو';

  @override
  String get profile_section_basic_first_name_label => 'الاسم الأول';

  @override
  String get profile_section_basic_first_name_placeholder => 'جون';

  @override
  String get profile_section_basic_last_name_label => 'اسم العائلة';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'الجنس';

  @override
  String get profile_section_basic_sex_placeholder => 'يرجى الاختيار';

  @override
  String get profile_section_basic_sex_options_male => 'ذكر';

  @override
  String get profile_section_basic_sex_options_female => 'أنثى';

  @override
  String get profile_section_basic_sex_options_other => 'آخر';

  @override
  String get profile_section_basic_date_of_birth_label => 'تاريخ الميلاد';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'العمر';

  @override
  String get profile_section_basic_age_str_placeholder => 'مثلاً 30';

  @override
  String get profile_section_basic_phonenumber_label => 'رقم الهاتف';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'البريد الإلكتروني';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'الموقع';

  @override
  String get profile_section_basic_location_placeholder =>
      'مثال: المدينة، الدولة';

  @override
  String get profile_section_body_diet_title => 'الجسم والنظام الغذائي';

  @override
  String get profile_section_body_diet_height_str_label => 'الطول';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'مثال: 180 سم';

  @override
  String get profile_section_body_diet_weight_str_label => 'الوزن';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'مثلاً 75 كجم';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'الدورة الشهرية';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'مثلاً منتظمة، غير منتظمة';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'قيود غذائية';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'يرجى الاختيار';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'أخبرنا بما تأكله وأي قيود لديك';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'لا شيء';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'نباتي';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'نباتي صارم';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'خالٍ من الغلوتين';

  @override
  String get profile_section_body_diet_bmi_label => 'مؤشر كتلة الجسم (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'مثلاً 24.5';

  @override
  String get profile_section_health_profile_title => 'الملف الصحي';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'أمراض مزمنة';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'مثل السكري من النوع الثاني';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'يرجى سرد جميع الأمراض المزمنة وذكر متى تم تشخيصها وأي مضاعفات.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'الأمراض السابقة';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'مثل: نزلة برد شائعة متكررة';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'يرجى سرد الأمراض الخطيرة التي عانيت منها في الماضي، حتى لو كنت قد تعافيت.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'التاريخ الجراحي';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'مثال: استئصال الزائدة الدودية';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'يرجى سرد جميع العمليات الجراحية وذكر السنة وما إذا كانت هناك أي مضاعفات';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'الأدوية المستخدمة أحيانًا';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'مثل إيبوبروفين';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'يرجى إدراج الأدوية التي تتناولها من وقت لآخر (على سبيل المثال: مسكنات الألم، أدوية الحساسية)، بما في ذلك الجرعة وسبب الاستخدام.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'الأدوية المنتظمة';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'مثل ميتفورمين';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'يرجى سرد جميع الأدوية التي تتناولها بانتظام، بما في ذلك الاسم، الجرعة، عدد المرات التي تتناولها في اليوم، وما هي الحالة التي تستخدم من أجلها.';

  @override
  String get profile_section_health_profile_allergies_label => 'الحساسية';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'مثل: البنسلين - يسبب طفح جلدي';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'يرجى سرد جميع الحساسية (الأدوية، الطعام، البيئة)، ووصف رد الفعل الذي لديك (على سبيل المثال: طفح جلدي، تورم، مشاكل في التنفس).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'الحالات الخاصة';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'مثلاً الحمل، الإعاقة';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'إذا كان لديك أي حالات طبية مهمة يجب أن يعرفها الأطباء دائمًا (على سبيل المثال: الحمل، الأجهزة المزروعة، الإعاقات، العلاج بمضادات التخثر)، يرجى وصفها. إذا لم يكن هناك، يمكنك ترك هذا الحقل فارغًا.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'التاريخ العائلي';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'مثلاً: أمراض القلب، السرطان';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'يرجى وصف الأمراض المهمة في عائلتك (على سبيل المثال: السكري، ارتفاع ضغط الدم، أمراض القلب، السرطان، الأمراض الوراثية) وتحديد أي فرد من العائلة كان لديه الحالة.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'العوامل الاجتماعية ونمط الحياة';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'مثال: التدخين، تناول الكحول';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'يرجى وصف عوامل نمط الحياة التي يمكن أن تؤثر على صحتك، مثل التدخين، الكحول، النشاط البدني، النظام الغذائي، النوم، والمهنة.';

  @override
  String get profile_section_health_profile_devices_label => 'الأجهزة الطبية';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'مثلاً منظم ضربات القلب، جهاز مساعدة السمع، مضخة الإنسولين';

  @override
  String get profile_section_health_profile_devices_hint =>
      'يرجى إدراج أي أجهزة طبية تستخدمها أو تم زرعها، مثل أجهزة تنظيم ضربات القلب، مضخات الأنسولين، أجهزة السمع، الأطراف الصناعية، أو أي أجهزة مساعدة أو مراقبة أخرى. أدرج التفاصيل ذات الصلة إذا كانت متاحة.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'آكل اللحوم والنباتات';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'الوجبات السريعة';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'بيسكاتاريان';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'خالي من اللاكتوز';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'نظام غذائي منخفض الصوديوم';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'نظام غذائي منخفض السكر';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'حمية قلبية';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'حمية كلوية';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'أخرى';
}

/// The translations for Arabic, as used in Egypt (`ar_EG`).
class ProfilesLocalizationArEg extends ProfilesLocalizationAr {
  ProfilesLocalizationArEg() : super('ar_EG');

  @override
  String get chatDrawerTitle => 'سجلات الصحة';

  @override
  String get chatDrawerBadgeNew => 'جديد';

  @override
  String get bannerTitle => 'أنشئ سجل صحتك';

  @override
  String get bannerSubtitle => 'في نهاية استشارتك، أضف ملفك الشخصي';

  @override
  String get bannerMoreProfilesTitle => 'أضف المزيد من الملفات الشخصية';

  @override
  String get bannerMoreProfilesSubtitle =>
      'ابدأ استشارة لشخص آخر لإنشاء ملفه الشخصي';

  @override
  String get bannerSignUp => 'سجل لإنشاء سجل صحتك';

  @override
  String get errorRetryButton => 'إعادة المحاولة';

  @override
  String get dashboardDeleteError => 'فشل حذف الملف الشخصي';

  @override
  String get dashboardSummaryLoadError => 'فشل تحميل ملخص الملف الشخصي';

  @override
  String get dashboardMenuViewFullRecord => 'عرض السجل الكامل';

  @override
  String get dashboardMenuShare => 'شارك';

  @override
  String get dashboardMenuDelete => 'حذف';

  @override
  String get dashboardMetricAgeLabel => 'العمر';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value سنوات',
      one: '$value سنة',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'الوزن';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value كجم';
  }

  @override
  String get dashboardMetricHeightLabel => 'الطول';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value سم';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'الحساسية';

  @override
  String get dashboardInfoChronicTitle => 'مزمن';

  @override
  String get dashboardInfoMedicationTitle => 'الأدوية';

  @override
  String get dashboardInfoDevicesTitle => 'الأجهزة';

  @override
  String get dashboardNavigationConsultations => 'استشارات';

  @override
  String get dashboardNavigationDocuments => 'المستندات';

  @override
  String get dashboardDeleteRecordTitle => 'هل تريد حذف السجل الصحي؟';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'سيؤدي ذلك إلى إزالة بيانات صحتك بشكل دائم ولا يمكن التراجع عنه. ستفقد السياق الذي نستخدمه لإرشادك.';

  @override
  String get dashboardDeleteRecordCancel => 'إلغاء';

  @override
  String get dashboardDeleteRecordConfirm => 'حذف';

  @override
  String get dashboardDeleteRecordLoading => 'جارٍ حذف سجل صحتك...';

  @override
  String get dashboardDeleteRecordError => 'فشل في حذف الملف الشخصي';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'تم حذف السجل الصحي';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'يمكنك إنشاء واحدة جديدة في أي وقت من خلال الدردشة مع المساعد.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'العودة إلى الدردشة';

  @override
  String get dataEditingScreenTitle => 'تعديل';

  @override
  String get dataFailedToLoadError => 'فشل تحميل بيانات الملف الشخصي';

  @override
  String get dataRecordSavedTitle => 'تم حفظ التغييرات';

  @override
  String get dataRecordSavedSubtitle => 'تم تحديث معلوماتك بنجاح';

  @override
  String get dataRecordSavedButton => 'العودة إلى الملف الشخصي';

  @override
  String get dataRecordUpdateError => 'فشل في تحديث بيانات الملف الشخصي';

  @override
  String get dataRecordDiscardTitle => 'هل تريدDiscard التغييرات؟';

  @override
  String get dataRecordDiscardSubtitle =>
      'لقد قمت بإجراء بعض التغييرات على ملفك الشخصي. احفظها قبل أن تذهب، أو تخلص منها.';

  @override
  String get dataRecordDiscardCancel => 'استمر في التحرير';

  @override
  String get dataRecordDiscardConfirm => 'تجاهل';

  @override
  String get dataRecordEditTooltip => 'تعديل';

  @override
  String get dataRecordAddTag => 'أضف سجل';

  @override
  String get consultationsSearch => 'بحث';

  @override
  String get consultationsSearchEmpty => 'لم يتم العثور على نتائج';

  @override
  String get documentsMenuDownload => 'تحميل';

  @override
  String get documentsMenuShare => 'شارك';

  @override
  String get documentsMenuDelete => 'حذف';

  @override
  String get documentsEmptyList => 'لا توجد مستندات';

  @override
  String get documentsDeleteTitle => 'هل تريد حذف هذا المستند؟';

  @override
  String get documentsDeleteSubtitle => 'سيتم حذف هذا الملف بشكل دائم';

  @override
  String get documentsDeleteCancel => 'إلغاء';

  @override
  String get documentsDeleteButton => 'حذف';

  @override
  String get documentsMoreActionsTooltip => 'إجراءات إضافية';

  @override
  String get profilesSearch => 'بحث';

  @override
  String get profilesEmptyList => 'لم يتم العثور على ملفات شخصية';

  @override
  String get profilesViewMore => 'عرض المزيد';

  @override
  String get profilesMore => 'المزيد';

  @override
  String get profilesAnnouncementTitle1 => 'دوكتورينا الآن تتذكر صحتك';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'استشاراتك الآن تبني وتحدث سجل صحتك تلقائيًا.';

  @override
  String get profilesAnnouncementTitle2 => 'سجل صحتك، قواعدك';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'عرض أو تعديل أو إضافة الأعراض أو الأدوية أو التاريخ أو المستندات في أي وقت';

  @override
  String get profilesAnnouncementTitle3 => 'اعتنِ بكل عائلتك';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'أنشئ سجل صحي لأحبائك، أطفالك، والديك، أو شريكك.';

  @override
  String get profilesAnnouncementTitle4 => 'هل أنت مستعد لحفظ سجل صحتك؟';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'بعد الاستشارة، اضغط على \"إضافة ملف\" لحفظه.';

  @override
  String get profilesNextButton => 'التالي';

  @override
  String get profilesStartButton => 'ابدأ استشارة';

  @override
  String get profilesLaterButton => 'ربما لاحقًا';

  @override
  String get profileSuccessCloseButton => 'إغلاق';

  @override
  String get pdfHeaderTitle => 'سجل الصحة';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'سجل الصحة — $name';
  }

  @override
  String get expandableFieldMore => '...المزيد';

  @override
  String get expandableFieldLess => 'أقل';

  @override
  String get profiles_button_addnew => 'إضافة ملف جديد';

  @override
  String get profiles_label_addnew => 'أنشئ ملفًا لحفظ تفاصيل هذه الاستشارة';

  @override
  String get profiles_label_health_records_hint =>
      'يمكنك الاطلاع عليه في أي وقت في سجلاتك الصحية';

  @override
  String get profiles_label_keep_talking_hint =>
      'إذا كان لديك المزيد من الأسئلة حول هذا أو أي شيء ذي صلة، فلا تتردد في الاستمرار في الحديث معي. أنا هنا للمساعدة';

  @override
  String get profile_section_basic_title => 'معلومات عامة';

  @override
  String get profile_section_basic_name_label => 'الاسم';

  @override
  String get profile_section_basic_name_placeholder => 'جون دو';

  @override
  String get profile_section_basic_first_name_label => 'الاسم الأول';

  @override
  String get profile_section_basic_first_name_placeholder => 'جون';

  @override
  String get profile_section_basic_last_name_label => 'اسم العائلة';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'الجنس';

  @override
  String get profile_section_basic_sex_placeholder => 'يرجى الاختيار';

  @override
  String get profile_section_basic_sex_options_male => 'ذكر';

  @override
  String get profile_section_basic_sex_options_female => 'أنثى';

  @override
  String get profile_section_basic_sex_options_other => 'آخر';

  @override
  String get profile_section_basic_date_of_birth_label => 'تاريخ الميلاد';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'العمر';

  @override
  String get profile_section_basic_age_str_placeholder => 'مثلاً 30';

  @override
  String get profile_section_basic_phonenumber_label => 'رقم الهاتف';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'البريد الإلكتروني';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'الموقع';

  @override
  String get profile_section_basic_location_placeholder =>
      'مثال: المدينة، الدولة';

  @override
  String get profile_section_body_diet_title => 'الجسم والنظام الغذائي';

  @override
  String get profile_section_body_diet_height_str_label => 'الطول';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'مثال: 180 سم';

  @override
  String get profile_section_body_diet_weight_str_label => 'الوزن';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'مثلاً 75 كجم';

  @override
  String get profile_section_body_diet_menstrual_cycle_label =>
      'الدورة الشهرية';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'مثلاً منتظمة، غير منتظمة';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'قيود غذائية';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'يرجى الاختيار';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'أخبرنا بما تأكله وأي قيود لديك';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'لا شيء';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'نباتي';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'نباتي صارم';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'خالٍ من الغلوتين';

  @override
  String get profile_section_body_diet_bmi_label => 'مؤشر كتلة الجسم (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'مثلاً 24.5';

  @override
  String get profile_section_health_profile_title => 'الملف الصحي';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'أمراض مزمنة';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'مثل السكري من النوع الثاني';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'يرجى سرد جميع الأمراض المزمنة وذكر متى تم تشخيصها وأي مضاعفات.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'الأمراض السابقة';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'مثل: نزلة برد شائعة متكررة';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'يرجى سرد الأمراض الخطيرة التي عانيت منها في الماضي، حتى لو كنت قد تعافيت.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'التاريخ الجراحي';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'مثال: استئصال الزائدة الدودية';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'يرجى سرد جميع العمليات الجراحية وذكر السنة وما إذا كانت هناك أي مضاعفات';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'الأدوية المستخدمة أحيانًا';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'مثل إيبوبروفين';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'يرجى إدراج الأدوية التي تتناولها من وقت لآخر (على سبيل المثال: مسكنات الألم، أدوية الحساسية)، بما في ذلك الجرعة وسبب الاستخدام.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'الأدوية المنتظمة';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'مثل ميتفورمين';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'يرجى سرد جميع الأدوية التي تتناولها بانتظام، بما في ذلك الاسم، الجرعة، عدد المرات التي تتناولها في اليوم، وما هي الحالة التي تستخدم من أجلها.';

  @override
  String get profile_section_health_profile_allergies_label => 'الحساسية';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'مثل: البنسلين - يسبب طفح جلدي';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'يرجى سرد جميع الحساسية (الأدوية، الطعام، البيئة)، ووصف رد الفعل الذي لديك (على سبيل المثال: طفح جلدي، تورم، مشاكل في التنفس).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'الحالات الخاصة';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'مثلاً الحمل، الإعاقة';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'إذا كان لديك أي حالات طبية مهمة يجب أن يعرفها الأطباء دائمًا (على سبيل المثال: الحمل، الأجهزة المزروعة، الإعاقات، العلاج بمضادات التخثر)، يرجى وصفها. إذا لم يكن هناك، يمكنك ترك هذا الحقل فارغًا.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'التاريخ العائلي';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'مثلاً: أمراض القلب، السرطان';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'يرجى وصف الأمراض المهمة في عائلتك (على سبيل المثال: السكري، ارتفاع ضغط الدم، أمراض القلب، السرطان، الأمراض الوراثية) وتحديد أي فرد من العائلة كان لديه الحالة.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'العوامل الاجتماعية ونمط الحياة';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'مثال: التدخين، تناول الكحول';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'يرجى وصف عوامل نمط الحياة التي يمكن أن تؤثر على صحتك، مثل التدخين، الكحول، النشاط البدني، النظام الغذائي، النوم، والمهنة.';

  @override
  String get profile_section_health_profile_devices_label => 'الأجهزة الطبية';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'مثلاً منظم ضربات القلب، جهاز مساعدة السمع، مضخة الإنسولين';

  @override
  String get profile_section_health_profile_devices_hint =>
      'يرجى إدراج أي أجهزة طبية تستخدمها أو تم زرعها، مثل أجهزة تنظيم ضربات القلب، مضخات الأنسولين، أجهزة السمع، الأطراف الصناعية، أو أي أجهزة مساعدة أو مراقبة أخرى. أدرج التفاصيل ذات الصلة إذا كانت متاحة.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'آكل اللحوم والنباتات';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'الوجبات السريعة';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'بيسكاتاريان';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'خالي من اللاكتوز';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'نظام غذائي منخفض الصوديوم';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'نظام غذائي منخفض السكر';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'حمية قلبية';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'حمية كلوية';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'أخرى';
}
