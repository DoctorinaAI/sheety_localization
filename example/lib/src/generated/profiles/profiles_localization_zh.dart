// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class ProfilesLocalizationZh extends ProfilesLocalization {
  ProfilesLocalizationZh([String locale = 'zh']) : super(locale);

  @override
  String get chatDrawerTitle => '健康记录';

  @override
  String get chatDrawerBadgeNew => '新';

  @override
  String get bannerTitle => '创建您的健康记录';

  @override
  String get bannerSubtitle => '在咨询结束时，添加您的个人资料。';

  @override
  String get bannerMoreProfilesTitle => '添加更多个人资料';

  @override
  String get bannerMoreProfilesSubtitle => '为其他人开始咨询以创建他们的个人资料。';

  @override
  String get bannerSignUp => '注册以创建您的健康记录';

  @override
  String get errorRetryButton => '重试';

  @override
  String get dashboardDeleteError => '删除个人资料失败';

  @override
  String get dashboardSummaryLoadError => '加载个人资料摘要失败';

  @override
  String get dashboardMenuViewFullRecord => '查看完整记录';

  @override
  String get dashboardMenuShare => '分享';

  @override
  String get dashboardMenuDelete => '删除';

  @override
  String get dashboardMetricAgeLabel => '年龄';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value岁',
      one: '$value岁',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => '体重';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => '身高';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => '过敏';

  @override
  String get dashboardInfoChronicTitle => '慢性';

  @override
  String get dashboardInfoMedicationTitle => '药物';

  @override
  String get dashboardInfoDevicesTitle => '设备';

  @override
  String get dashboardNavigationConsultations => '咨询';

  @override
  String get dashboardNavigationDocuments => '文件';

  @override
  String get dashboardDeleteRecordTitle => '删除健康记录吗？';

  @override
  String get dashboardDeleteRecordSubtitle =>
      '这将永久删除您的健康数据，无法恢复。您将失去我们用来指导您的上下文。';

  @override
  String get dashboardDeleteRecordCancel => '取消';

  @override
  String get dashboardDeleteRecordConfirm => '删除';

  @override
  String get dashboardDeleteRecordLoading => '正在删除您的健康记录...';

  @override
  String get dashboardDeleteRecordError => '删除个人资料失败';

  @override
  String get dashboardDeleteRecordSuccessTitle => '健康记录已删除';

  @override
  String get dashboardDeleteRecordSuccessSubtitle => '您可以随时通过与助手聊天创建一个新的.';

  @override
  String get dashboardDeleteRecordSuccessButton => '返回聊天';

  @override
  String get dataEditingScreenTitle => '编辑';

  @override
  String get dataFailedToLoadError => '无法加载个人资料数据';

  @override
  String get dataRecordSavedTitle => '更改已保存';

  @override
  String get dataRecordSavedSubtitle => '您的信息已成功更新。';

  @override
  String get dataRecordSavedButton => '返回个人资料';

  @override
  String get dataRecordUpdateError => '更新个人资料数据失败';

  @override
  String get dataRecordDiscardTitle => '放弃更改吗？';

  @override
  String get dataRecordDiscardSubtitle => '您对个人资料进行了更改。在离开之前保存更改，或放弃它们。';

  @override
  String get dataRecordDiscardCancel => '继续编辑';

  @override
  String get dataRecordDiscardConfirm => '丢弃';

  @override
  String get dataRecordEditTooltip => '编辑';

  @override
  String get dataRecordAddTag => '添加记录';

  @override
  String get consultationsSearch => '搜索';

  @override
  String get consultationsSearchEmpty => '未找到结果';

  @override
  String get documentsMenuDownload => '下载';

  @override
  String get documentsMenuShare => '分享';

  @override
  String get documentsMenuDelete => '删除';

  @override
  String get documentsEmptyList => '未找到文档';

  @override
  String get documentsDeleteTitle => '删除此文档吗？';

  @override
  String get documentsDeleteSubtitle => '此文件将被永久删除';

  @override
  String get documentsDeleteCancel => '取消';

  @override
  String get documentsDeleteButton => '删除';

  @override
  String get documentsMoreActionsTooltip => '更多操作';

  @override
  String get profilesSearch => '搜索';

  @override
  String get profilesEmptyList => '未找到个人资料';

  @override
  String get profilesViewMore => '查看更多';

  @override
  String get profilesMore => '更多';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina 现在记住了您的健康';

  @override
  String get profilesAnnouncementSubtitle1 => '您的咨询现在会自动构建和更新您的健康记录。';

  @override
  String get profilesAnnouncementTitle2 => '您的健康记录，您的规则';

  @override
  String get profilesAnnouncementSubtitle2 => '随时查看、编辑或添加症状、药物、历史或文件。';

  @override
  String get profilesAnnouncementTitle3 => '照顾好您的整个家庭';

  @override
  String get profilesAnnouncementSubtitle3 => '为您的亲人、孩子、父母或伴侣创建健康记录。';

  @override
  String get profilesAnnouncementTitle4 => '准备好保存您的健康记录吗？';

  @override
  String get profilesAnnouncementSubtitle4 => '咨询后，点击“添加个人资料”以保存它。';

  @override
  String get profilesNextButton => '下一步';

  @override
  String get profilesStartButton => '开始咨询';

  @override
  String get profilesLaterButton => '也许稍后';

  @override
  String get profileSuccessCloseButton => '关闭';

  @override
  String get pdfHeaderTitle => '健康记录';

  @override
  String pdfHeaderTitleWithName(String name) {
    return '健康记录 — $name';
  }

  @override
  String get expandableFieldMore => '...更多';

  @override
  String get expandableFieldLess => '...更少';

  @override
  String get profiles_button_addnew => '添加新档案';

  @override
  String get profiles_label_addnew => '创建一个档案以保存此次咨询的详细信息';

  @override
  String get profiles_label_health_records_hint => '您可以随时在您的健康记录中评估它';

  @override
  String get profiles_label_keep_talking_hint =>
      '如果您对此或相关任何问题还有更多疑问，欢迎继续与我交谈。我在这里为您提供帮助';

  @override
  String get profile_section_basic_title => '基本信息';

  @override
  String get profile_section_basic_name_label => '姓名';

  @override
  String get profile_section_basic_name_placeholder => '张三';

  @override
  String get profile_section_basic_first_name_label => '名字';

  @override
  String get profile_section_basic_first_name_placeholder => '约翰';

  @override
  String get profile_section_basic_last_name_label => '姓';

  @override
  String get profile_section_basic_last_name_placeholder => '张';

  @override
  String get profile_section_basic_sex_label => '性别';

  @override
  String get profile_section_basic_sex_placeholder => '请选择';

  @override
  String get profile_section_basic_sex_options_male => '男性';

  @override
  String get profile_section_basic_sex_options_female => '女性';

  @override
  String get profile_section_basic_sex_options_other => '其他';

  @override
  String get profile_section_basic_date_of_birth_label => '出生日期';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => '年龄';

  @override
  String get profile_section_basic_age_str_placeholder => '例如 30';

  @override
  String get profile_section_basic_phonenumber_label => '电话号码';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => '电子邮箱';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => '位置';

  @override
  String get profile_section_basic_location_placeholder => '例如：城市，国家';

  @override
  String get profile_section_body_diet_title => '身体与饮食';

  @override
  String get profile_section_body_diet_height_str_label => '身高';

  @override
  String get profile_section_body_diet_height_str_placeholder => '例如 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => '体重';

  @override
  String get profile_section_body_diet_weight_str_placeholder => '例如 75 公斤';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => '月经周期';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      '例如：规律、不规律';

  @override
  String get profile_section_body_diet_dietary_restrictions_label => '饮食限制';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      '请选择';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      '告诉我们您吃什么以及您有哪些限制';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      '无饮食限制';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          '素食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      '纯素';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          '无麸质';

  @override
  String get profile_section_body_diet_bmi_label => '身体质量指数 (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => '例如 24.5';

  @override
  String get profile_section_health_profile_title => '健康档案';

  @override
  String get profile_section_health_profile_chronic_illnesses_label => '慢性疾病';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      '例如：2型糖尿病';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      '请列出所有慢性疾病，并包括诊断时间和任何并发症。';

  @override
  String get profile_section_health_profile_past_illnesses_label => '既往病史';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      '例如：频繁感冒';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      '请列出您过去患过的严重疾病，即使您已经康复。';

  @override
  String get profile_section_health_profile_surgical_history_label => '手术史';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      '例如：阑尾切除术';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      '请列出所有手术，并包括年份以及是否有任何并发症。';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      '偶尔使用的药物';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          '例如，布洛芬';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      '请列出您偶尔服用的药物（例如：止痛药、过敏药物），包括剂量和使用原因。';

  @override
  String get profile_section_health_profile_regular_medications_label => '常规用药';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      '例如，二甲双胍';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      '请列出您定期服用的所有药物，包括名称、剂量、每天服用的次数以及用于治疗的疾病。';

  @override
  String get profile_section_health_profile_allergies_label => '过敏';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      '例如：青霉素 – 引起皮疹';

  @override
  String get profile_section_health_profile_allergies_hint =>
      '请列出所有过敏源（药物、食物、环境），并描述您有什么反应（例如：皮疹、肿胀、呼吸问题）。';

  @override
  String get profile_section_health_profile_special_conditions_label => '特殊情况';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      '例如：怀孕、残疾';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      '如果您有任何重要的医疗状况，医生应该始终知道（例如：怀孕、植入设备、残疾、抗凝治疗），请描述它们。如果没有，您可以留空。';

  @override
  String get profile_section_health_profile_family_history_label => '家族史';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      '例如：心脏病、癌症';

  @override
  String get profile_section_health_profile_family_history_hint =>
      '请描述您家族中重要的疾病（例如：糖尿病、高血压、心脏病、癌症、遗传疾病），并说明哪个家庭成员患有该疾病。';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      '社会与生活方式因素';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          '例如吸烟、饮酒';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      '请描述可能影响您健康的生活方式因素，例如吸烟、饮酒、身体活动、饮食、睡眠和职业。';

  @override
  String get profile_section_health_profile_devices_label => '医疗设备';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      '例如：起搏器、助听器、胰岛素泵';

  @override
  String get profile_section_health_profile_devices_hint =>
      '请列出您使用或植入的任何医疗设备，例如心脏起搏器、胰岛素泵、助听器、假肢或其他辅助或监测设备。如适用，请包括相关细节。';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          '杂食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      '快餐';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          '海鲜素食者';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          '无乳糖';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          '低钠饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      '低糖饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      '心脏病饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      '肾脏饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      '其他';
}

/// The translations for Chinese, as used in China (`zh_CN`).
class ProfilesLocalizationZhCn extends ProfilesLocalizationZh {
  ProfilesLocalizationZhCn() : super('zh_CN');

  @override
  String get chatDrawerTitle => '健康记录';

  @override
  String get chatDrawerBadgeNew => '新';

  @override
  String get bannerTitle => '创建您的健康记录';

  @override
  String get bannerSubtitle => '在咨询结束时，添加您的个人资料。';

  @override
  String get bannerMoreProfilesTitle => '添加更多个人资料';

  @override
  String get bannerMoreProfilesSubtitle => '为其他人开始咨询以创建他们的个人资料。';

  @override
  String get bannerSignUp => '注册以创建您的健康记录';

  @override
  String get errorRetryButton => '重试';

  @override
  String get dashboardDeleteError => '删除个人资料失败';

  @override
  String get dashboardSummaryLoadError => '加载个人资料摘要失败';

  @override
  String get dashboardMenuViewFullRecord => '查看完整记录';

  @override
  String get dashboardMenuShare => '分享';

  @override
  String get dashboardMenuDelete => '删除';

  @override
  String get dashboardMetricAgeLabel => '年龄';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value岁',
      one: '$value岁',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => '体重';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => '身高';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => '过敏';

  @override
  String get dashboardInfoChronicTitle => '慢性';

  @override
  String get dashboardInfoMedicationTitle => '药物';

  @override
  String get dashboardInfoDevicesTitle => '设备';

  @override
  String get dashboardNavigationConsultations => '咨询';

  @override
  String get dashboardNavigationDocuments => '文件';

  @override
  String get dashboardDeleteRecordTitle => '删除健康记录吗？';

  @override
  String get dashboardDeleteRecordSubtitle =>
      '这将永久删除您的健康数据，无法恢复。您将失去我们用来指导您的上下文。';

  @override
  String get dashboardDeleteRecordCancel => '取消';

  @override
  String get dashboardDeleteRecordConfirm => '删除';

  @override
  String get dashboardDeleteRecordLoading => '正在删除您的健康记录...';

  @override
  String get dashboardDeleteRecordError => '删除个人资料失败';

  @override
  String get dashboardDeleteRecordSuccessTitle => '健康记录已删除';

  @override
  String get dashboardDeleteRecordSuccessSubtitle => '您可以随时通过与助手聊天创建一个新的.';

  @override
  String get dashboardDeleteRecordSuccessButton => '返回聊天';

  @override
  String get dataEditingScreenTitle => '编辑';

  @override
  String get dataFailedToLoadError => '无法加载个人资料数据';

  @override
  String get dataRecordSavedTitle => '更改已保存';

  @override
  String get dataRecordSavedSubtitle => '您的信息已成功更新。';

  @override
  String get dataRecordSavedButton => '返回个人资料';

  @override
  String get dataRecordUpdateError => '更新个人资料数据失败';

  @override
  String get dataRecordDiscardTitle => '放弃更改吗？';

  @override
  String get dataRecordDiscardSubtitle => '您对个人资料进行了更改。在离开之前保存更改，或放弃它们。';

  @override
  String get dataRecordDiscardCancel => '继续编辑';

  @override
  String get dataRecordDiscardConfirm => '丢弃';

  @override
  String get dataRecordEditTooltip => '编辑';

  @override
  String get dataRecordAddTag => '添加记录';

  @override
  String get consultationsSearch => '搜索';

  @override
  String get consultationsSearchEmpty => '未找到结果';

  @override
  String get documentsMenuDownload => '下载';

  @override
  String get documentsMenuShare => '分享';

  @override
  String get documentsMenuDelete => '删除';

  @override
  String get documentsEmptyList => '未找到文档';

  @override
  String get documentsDeleteTitle => '删除此文档吗？';

  @override
  String get documentsDeleteSubtitle => '此文件将被永久删除';

  @override
  String get documentsDeleteCancel => '取消';

  @override
  String get documentsDeleteButton => '删除';

  @override
  String get documentsMoreActionsTooltip => '更多操作';

  @override
  String get profilesSearch => '搜索';

  @override
  String get profilesEmptyList => '未找到个人资料';

  @override
  String get profilesViewMore => '查看更多';

  @override
  String get profilesMore => '更多';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina 现在记住了您的健康';

  @override
  String get profilesAnnouncementSubtitle1 => '您的咨询现在会自动构建和更新您的健康记录。';

  @override
  String get profilesAnnouncementTitle2 => '您的健康记录，您的规则';

  @override
  String get profilesAnnouncementSubtitle2 => '随时查看、编辑或添加症状、药物、历史或文件。';

  @override
  String get profilesAnnouncementTitle3 => '照顾好您的整个家庭';

  @override
  String get profilesAnnouncementSubtitle3 => '为您的亲人、孩子、父母或伴侣创建健康记录。';

  @override
  String get profilesAnnouncementTitle4 => '准备好保存您的健康记录吗？';

  @override
  String get profilesAnnouncementSubtitle4 => '咨询后，点击“添加个人资料”以保存它。';

  @override
  String get profilesNextButton => '下一步';

  @override
  String get profilesStartButton => '开始咨询';

  @override
  String get profilesLaterButton => '也许稍后';

  @override
  String get profileSuccessCloseButton => '关闭';

  @override
  String get pdfHeaderTitle => '健康记录';

  @override
  String pdfHeaderTitleWithName(String name) {
    return '健康记录 — $name';
  }

  @override
  String get expandableFieldMore => '...更多';

  @override
  String get expandableFieldLess => '...更少';

  @override
  String get profiles_button_addnew => '添加新档案';

  @override
  String get profiles_label_addnew => '创建一个档案以保存此次咨询的详细信息';

  @override
  String get profiles_label_health_records_hint => '您可以随时在您的健康记录中评估它';

  @override
  String get profiles_label_keep_talking_hint =>
      '如果您对此或相关任何问题还有更多疑问，欢迎继续与我交谈。我在这里为您提供帮助';

  @override
  String get profile_section_basic_title => '基本信息';

  @override
  String get profile_section_basic_name_label => '姓名';

  @override
  String get profile_section_basic_name_placeholder => '张三';

  @override
  String get profile_section_basic_first_name_label => '名字';

  @override
  String get profile_section_basic_first_name_placeholder => '约翰';

  @override
  String get profile_section_basic_last_name_label => '姓';

  @override
  String get profile_section_basic_last_name_placeholder => '张';

  @override
  String get profile_section_basic_sex_label => '性别';

  @override
  String get profile_section_basic_sex_placeholder => '请选择';

  @override
  String get profile_section_basic_sex_options_male => '男性';

  @override
  String get profile_section_basic_sex_options_female => '女性';

  @override
  String get profile_section_basic_sex_options_other => '其他';

  @override
  String get profile_section_basic_date_of_birth_label => '出生日期';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => '年龄';

  @override
  String get profile_section_basic_age_str_placeholder => '例如 30';

  @override
  String get profile_section_basic_phonenumber_label => '电话号码';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => '电子邮箱';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => '位置';

  @override
  String get profile_section_basic_location_placeholder => '例如：城市，国家';

  @override
  String get profile_section_body_diet_title => '身体与饮食';

  @override
  String get profile_section_body_diet_height_str_label => '身高';

  @override
  String get profile_section_body_diet_height_str_placeholder => '例如 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => '体重';

  @override
  String get profile_section_body_diet_weight_str_placeholder => '例如 75 公斤';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => '月经周期';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      '例如：规律、不规律';

  @override
  String get profile_section_body_diet_dietary_restrictions_label => '饮食限制';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      '请选择';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      '告诉我们您吃什么以及您有哪些限制';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      '无饮食限制';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          '素食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      '纯素';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          '无麸质';

  @override
  String get profile_section_body_diet_bmi_label => '身体质量指数 (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => '例如 24.5';

  @override
  String get profile_section_health_profile_title => '健康档案';

  @override
  String get profile_section_health_profile_chronic_illnesses_label => '慢性疾病';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      '例如：2型糖尿病';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      '请列出所有慢性疾病，并包括诊断时间和任何并发症。';

  @override
  String get profile_section_health_profile_past_illnesses_label => '既往病史';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      '例如：频繁感冒';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      '请列出您过去患过的严重疾病，即使您已经康复。';

  @override
  String get profile_section_health_profile_surgical_history_label => '手术史';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      '例如：阑尾切除术';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      '请列出所有手术，并包括年份以及是否有任何并发症。';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      '偶尔使用的药物';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          '例如，布洛芬';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      '请列出您偶尔服用的药物（例如：止痛药、过敏药物），包括剂量和使用原因。';

  @override
  String get profile_section_health_profile_regular_medications_label => '常规用药';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      '例如，二甲双胍';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      '请列出您定期服用的所有药物，包括名称、剂量、每天服用的次数以及用于治疗的疾病。';

  @override
  String get profile_section_health_profile_allergies_label => '过敏';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      '例如：青霉素 – 引起皮疹';

  @override
  String get profile_section_health_profile_allergies_hint =>
      '请列出所有过敏源（药物、食物、环境），并描述您有什么反应（例如：皮疹、肿胀、呼吸问题）。';

  @override
  String get profile_section_health_profile_special_conditions_label => '特殊情况';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      '例如：怀孕、残疾';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      '如果您有任何重要的医疗状况，医生应该始终知道（例如：怀孕、植入设备、残疾、抗凝治疗），请描述它们。如果没有，您可以留空。';

  @override
  String get profile_section_health_profile_family_history_label => '家族史';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      '例如：心脏病、癌症';

  @override
  String get profile_section_health_profile_family_history_hint =>
      '请描述您家族中重要的疾病（例如：糖尿病、高血压、心脏病、癌症、遗传疾病），并说明哪个家庭成员患有该疾病。';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      '社会与生活方式因素';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          '例如吸烟、饮酒';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      '请描述可能影响您健康的生活方式因素，例如吸烟、饮酒、身体活动、饮食、睡眠和职业。';

  @override
  String get profile_section_health_profile_devices_label => '医疗设备';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      '例如：起搏器、助听器、胰岛素泵';

  @override
  String get profile_section_health_profile_devices_hint =>
      '请列出您使用或植入的任何医疗设备，例如心脏起搏器、胰岛素泵、助听器、假肢或其他辅助或监测设备。如适用，请包括相关细节。';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          '杂食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      '快餐';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          '海鲜素食者';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          '无乳糖';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          '低钠饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      '低糖饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      '心脏病饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      '肾脏饮食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      '其他';
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class ProfilesLocalizationZhHk extends ProfilesLocalizationZh {
  ProfilesLocalizationZhHk() : super('zh_HK');

  @override
  String get chatDrawerTitle => '健康記錄';

  @override
  String get chatDrawerBadgeNew => '新';

  @override
  String get bannerTitle => '建立您的健康記錄';

  @override
  String get bannerSubtitle => '在諮詢結束時，添加您的個人資料。';

  @override
  String get bannerMoreProfilesTitle => '添加更多個人資料';

  @override
  String get bannerMoreProfilesSubtitle => '為其他人開始諮詢以創建他們的個人資料。';

  @override
  String get bannerSignUp => '註冊以創建您的健康記錄';

  @override
  String get errorRetryButton => '重試';

  @override
  String get dashboardDeleteError => '刪除個人資料失敗';

  @override
  String get dashboardSummaryLoadError => '無法加載個人資料摘要';

  @override
  String get dashboardMenuViewFullRecord => '查看完整記錄';

  @override
  String get dashboardMenuShare => '分享';

  @override
  String get dashboardMenuDelete => '刪除';

  @override
  String get dashboardMetricAgeLabel => '年齡';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value 年',
      one: '$value 年',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => '體重';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => '高度';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value 厘米';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => '過敏';

  @override
  String get dashboardInfoChronicTitle => '慢性';

  @override
  String get dashboardInfoMedicationTitle => '藥物';

  @override
  String get dashboardInfoDevicesTitle => '設備';

  @override
  String get dashboardNavigationConsultations => '諮詢';

  @override
  String get dashboardNavigationDocuments => '文件';

  @override
  String get dashboardDeleteRecordTitle => '刪除健康記錄？';

  @override
  String get dashboardDeleteRecordSubtitle =>
      '這將永久刪除您的健康數據，無法恢復。您將失去我們用來指導您的背景。';

  @override
  String get dashboardDeleteRecordCancel => '取消';

  @override
  String get dashboardDeleteRecordConfirm => '刪除';

  @override
  String get dashboardDeleteRecordLoading => '正在刪除您的健康記錄...';

  @override
  String get dashboardDeleteRecordError => '刪除個人資料失敗';

  @override
  String get dashboardDeleteRecordSuccessTitle => '健康記錄已刪除';

  @override
  String get dashboardDeleteRecordSuccessSubtitle => '您可以隨時通過與助手聊天來創建新的。';

  @override
  String get dashboardDeleteRecordSuccessButton => '返回聊天';

  @override
  String get dataEditingScreenTitle => '編輯';

  @override
  String get dataFailedToLoadError => '無法加載個人資料數據';

  @override
  String get dataRecordSavedTitle => '變更已儲存';

  @override
  String get dataRecordSavedSubtitle => '您的信息已成功更新。';

  @override
  String get dataRecordSavedButton => '返回個人資料';

  @override
  String get dataRecordUpdateError => '無法更新個人資料';

  @override
  String get dataRecordDiscardTitle => '放棄更改嗎？';

  @override
  String get dataRecordDiscardSubtitle => '您對您的個人資料做了一些更改。在離開之前請保存它們，或放棄它們。';

  @override
  String get dataRecordDiscardCancel => '繼續編輯';

  @override
  String get dataRecordDiscardConfirm => '捨棄';

  @override
  String get dataRecordEditTooltip => '編輯';

  @override
  String get dataRecordAddTag => '添加記錄';

  @override
  String get consultationsSearch => '搜尋';

  @override
  String get consultationsSearchEmpty => '未找到結果';

  @override
  String get documentsMenuDownload => '下載';

  @override
  String get documentsMenuShare => '分享';

  @override
  String get documentsMenuDelete => '刪除';

  @override
  String get documentsEmptyList => '未找到文件';

  @override
  String get documentsDeleteTitle => '要刪除這份文件嗎？';

  @override
  String get documentsDeleteSubtitle => '此文件將被永久刪除';

  @override
  String get documentsDeleteCancel => '取消';

  @override
  String get documentsDeleteButton => '刪除';

  @override
  String get documentsMoreActionsTooltip => '更多操作';

  @override
  String get profilesSearch => '搜尋';

  @override
  String get profilesEmptyList => '找不到個人檔案';

  @override
  String get profilesViewMore => '查看更多';

  @override
  String get profilesMore => '更多';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina 現在記得你的健康';

  @override
  String get profilesAnnouncementSubtitle1 => '您的諮詢現在會自動建立和更新您的健康紀錄。';

  @override
  String get profilesAnnouncementTitle2 => '你的健康紀錄，你的規則';

  @override
  String get profilesAnnouncementSubtitle2 => '隨時查看、編輯或添加症狀、藥物、病史或文件。';

  @override
  String get profilesAnnouncementTitle3 => '照顧您全家';

  @override
  String get profilesAnnouncementSubtitle3 => '為您的摯愛、孩子、父母或伴侶創建健康記錄。';

  @override
  String get profilesAnnouncementTitle4 => '準備好保存您的健康記錄了嗎？';

  @override
  String get profilesAnnouncementSubtitle4 => '在諮詢後，點擊「新增檔案」以保存。';

  @override
  String get profilesNextButton => '下一步';

  @override
  String get profilesStartButton => '開始諮詢';

  @override
  String get profilesLaterButton => '稍後再說';

  @override
  String get profileSuccessCloseButton => '關閉';

  @override
  String get pdfHeaderTitle => '健康記錄';

  @override
  String pdfHeaderTitleWithName(String name) {
    return '健康記錄 — $name';
  }

  @override
  String get expandableFieldMore => '...更多';

  @override
  String get expandableFieldLess => '...少';

  @override
  String get profiles_button_addnew => '新增個人檔案';

  @override
  String get profiles_label_addnew => '創建一個檔案以保存此諮詢的詳細信息。';

  @override
  String get profiles_label_health_records_hint => '您可隨時在健康記錄中查看';

  @override
  String get profiles_label_keep_talking_hint =>
      '如果你對這件事或任何相關問題有更多疑問，歡迎隨時繼續與我對話。我在這裡幫助你';

  @override
  String get profile_section_basic_title => '一般資料';

  @override
  String get profile_section_basic_name_label => '姓名';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => '名字';

  @override
  String get profile_section_basic_first_name_placeholder => '約翰';

  @override
  String get profile_section_basic_last_name_label => '姓氏';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => '性別';

  @override
  String get profile_section_basic_sex_placeholder => '請選擇';

  @override
  String get profile_section_basic_sex_options_male => '男';

  @override
  String get profile_section_basic_sex_options_female => '女性';

  @override
  String get profile_section_basic_sex_options_other => '其他';

  @override
  String get profile_section_basic_date_of_birth_label => '出生日期';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => '年齡';

  @override
  String get profile_section_basic_age_str_placeholder => '例如 30';

  @override
  String get profile_section_basic_phonenumber_label => '電話號碼';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => '電郵';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => '地點';

  @override
  String get profile_section_basic_location_placeholder => '例如 城市，國家';

  @override
  String get profile_section_body_diet_title => '身體與飲食';

  @override
  String get profile_section_body_diet_height_str_label => '身高';

  @override
  String get profile_section_body_diet_height_str_placeholder => '例如 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => '體重';

  @override
  String get profile_section_body_diet_weight_str_placeholder => '例如 75 公斤';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => '月經週期';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      '例如 規律、不規律';

  @override
  String get profile_section_body_diet_dietary_restrictions_label => '飲食限制';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      '請選擇';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      '告訴我們您吃什麼以及您有任何限制';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none => '無';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          '素食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      '純素';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          '無麩質';

  @override
  String get profile_section_body_diet_bmi_label => '身體質量指數 (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => '例如 24.5';

  @override
  String get profile_section_health_profile_title => '健康檔案';

  @override
  String get profile_section_health_profile_chronic_illnesses_label => '慢性疾病';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      '例如. 二型糖尿病';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      '請列出所有慢性疾病，並包括診斷時間及任何併發症。';

  @override
  String get profile_section_health_profile_past_illnesses_label => '既往疾病';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      '例如：經常感冒';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      '請列出您過去曾經患過的重大疾病，即使您已經康復。';

  @override
  String get profile_section_health_profile_surgical_history_label => '手術史';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      '例如 闌尾切除術';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      '請列出所有手術，並包括年份及是否有任何併發症。';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      '偶爾使用的藥物';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          '例如：布洛芬';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      '請列出您偶爾服用的藥物（例如：止痛藥、過敏藥物），包括劑量和使用原因。';

  @override
  String get profile_section_health_profile_regular_medications_label => '常用藥物';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      '例如：二甲雙胍';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      '請列出您定期服用的所有藥物，包括名稱、劑量、每天服用的次數以及用於什麼病症。';

  @override
  String get profile_section_health_profile_allergies_label => '過敏';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      '例如：青黴素 – 會引起皮疹';

  @override
  String get profile_section_health_profile_allergies_hint =>
      '請列出所有過敏源（藥物、食物、環境），並描述您有什麼反應（例如：皮疹、腫脹、呼吸問題）。';

  @override
  String get profile_section_health_profile_special_conditions_label => '特殊情況';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      '例如：懷孕、殘疾';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      '如果您有任何重要的醫療狀況，醫生應該始終知道（例如：懷孕、植入裝置、殘疾、抗凝治療），請描述它們。如果沒有，您可以留空。';

  @override
  String get profile_section_health_profile_family_history_label => '家族病史';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      '例如心臟病、癌症';

  @override
  String get profile_section_health_profile_family_history_hint =>
      '請描述您家族中的重要疾病（例如：糖尿病、高血壓、心臟病、癌症、遺傳疾病），並指明哪位家庭成員曾患有該病。';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      '社交及生活方式因素';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          '例如：吸煙、飲酒';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      '請描述可能影響您健康的生活方式因素，例如吸煙、飲酒、身體活動、飲食、睡眠和職業。';

  @override
  String get profile_section_health_profile_devices_label => '醫療器材';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      '例如：心臟起搏器、助聽器、胰島素泵';

  @override
  String get profile_section_health_profile_devices_hint =>
      '請列出您使用或植入的任何醫療設備，例如心臟起搏器、胰島素泵、助聽器、義肢或其他輔助或監測設備。如適用，請包括相關細節。';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          '雜食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      '快餐';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          '魚素食者';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          '無乳糖';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          '低鈉飲食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      '低糖飲食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      '心臟病飲食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      '腎臟飲食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      '其他';
}
