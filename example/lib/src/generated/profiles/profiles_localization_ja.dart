// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class ProfilesLocalizationJa extends ProfilesLocalization {
  ProfilesLocalizationJa([String locale = 'ja']) : super(locale);

  @override
  String get chatDrawerTitle => '健康記録';

  @override
  String get chatDrawerBadgeNew => '新しい';

  @override
  String get bannerTitle => '健康記録を作成する';

  @override
  String get bannerSubtitle => '相談の最後に、プロフィールを追加してください。';

  @override
  String get bannerMoreProfilesTitle => 'プロフィールを追加';

  @override
  String get bannerMoreProfilesSubtitle => '他の人のために相談を始めて、彼らのプロフィールを作成します。';

  @override
  String get bannerSignUp => '健康記録を作成するためにサインアップしてください';

  @override
  String get errorRetryButton => '再試行';

  @override
  String get dashboardDeleteError => 'プロフィールの削除に失敗しました';

  @override
  String get dashboardSummaryLoadError => 'プロフィールの概要の読み込みに失敗しました';

  @override
  String get dashboardMenuViewFullRecord => 'フルレコードを見る';

  @override
  String get dashboardMenuShare => '共有する';

  @override
  String get dashboardMenuDelete => '削除';

  @override
  String get dashboardMetricAgeLabel => '年齢';

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
  String get dashboardMetricWeightLabel => '体重';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => '身長';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'アレルギー';

  @override
  String get dashboardInfoChronicTitle => '慢性';

  @override
  String get dashboardInfoMedicationTitle => '薬';

  @override
  String get dashboardInfoDevicesTitle => 'デバイス';

  @override
  String get dashboardNavigationConsultations => '相談';

  @override
  String get dashboardNavigationDocuments => 'ドキュメント';

  @override
  String get dashboardDeleteRecordTitle => '健康記録を削除しますか？';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'これにより、あなたの健康データが永久に削除され、元に戻すことはできません。あなたが私たちのガイドに使用するコンテキストを失います。';

  @override
  String get dashboardDeleteRecordCancel => 'キャンセル';

  @override
  String get dashboardDeleteRecordConfirm => '削除';

  @override
  String get dashboardDeleteRecordLoading => '健康記録を削除しています...';

  @override
  String get dashboardDeleteRecordError => 'プロフィールの削除に失敗しました';

  @override
  String get dashboardDeleteRecordSuccessTitle => '健康記録が削除されました';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'アシスタントとチャットすることで、いつでも新しいものを作成できます。';

  @override
  String get dashboardDeleteRecordSuccessButton => 'チャットに戻る';

  @override
  String get dataEditingScreenTitle => '編集中';

  @override
  String get dataFailedToLoadError => 'プロフィールデータの読み込みに失敗しました';

  @override
  String get dataRecordSavedTitle => '変更が保存されました';

  @override
  String get dataRecordSavedSubtitle => 'あなたの情報は正常に更新されました。';

  @override
  String get dataRecordSavedButton => 'プロフィールに戻る';

  @override
  String get dataRecordUpdateError => 'プロフィールデータの更新に失敗しました';

  @override
  String get dataRecordDiscardTitle => '変更を破棄しますか？';

  @override
  String get dataRecordDiscardSubtitle =>
      'プロフィールにいくつかの変更を加えました。行く前に保存するか、破棄してください。';

  @override
  String get dataRecordDiscardCancel => '編集を続ける';

  @override
  String get dataRecordDiscardConfirm => '破棄';

  @override
  String get dataRecordEditTooltip => '編集';

  @override
  String get dataRecordAddTag => 'レコードを追加';

  @override
  String get consultationsSearch => '検索';

  @override
  String get consultationsSearchEmpty => '結果が見つかりませんでした';

  @override
  String get documentsMenuDownload => 'ダウンロード';

  @override
  String get documentsMenuShare => '共有する';

  @override
  String get documentsMenuDelete => '削除';

  @override
  String get documentsEmptyList => 'ドキュメントが見つかりませんでした';

  @override
  String get documentsDeleteTitle => 'この文書を削除しますか？';

  @override
  String get documentsDeleteSubtitle => 'このファイルは永久に削除されます';

  @override
  String get documentsDeleteCancel => 'キャンセル';

  @override
  String get documentsDeleteButton => '削除';

  @override
  String get documentsMoreActionsTooltip => 'その他の操作';

  @override
  String get profilesSearch => '検索';

  @override
  String get profilesEmptyList => 'プロフィールが見つかりません';

  @override
  String get profilesViewMore => 'もっと見る';

  @override
  String get profilesMore => 'もっと';

  @override
  String get profilesAnnouncementTitle1 => 'ドクターリナはあなたの健康を覚えています';

  @override
  String get profilesAnnouncementSubtitle1 => 'あなたの相談は、健康記録を自動的に構築し更新します。';

  @override
  String get profilesAnnouncementTitle2 => 'あなたの健康記録、あなたのルール';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'いつでも症状、薬、履歴、または文書を表示、編集、または追加できます。';

  @override
  String get profilesAnnouncementTitle3 => '家族全体のケアをする';

  @override
  String get profilesAnnouncementSubtitle3 =>
      '愛する人、子供、親、またはパートナーのために健康記録を作成します。';

  @override
  String get profilesAnnouncementTitle4 => '健康記録を保存する準備はできていますか？';

  @override
  String get profilesAnnouncementSubtitle4 => '相談後、「プロフィールを追加」をタップして保存します。';

  @override
  String get profilesNextButton => '次へ';

  @override
  String get profilesStartButton => '相談を始める';

  @override
  String get profilesLaterButton => '後で';

  @override
  String get profileSuccessCloseButton => '閉じる';

  @override
  String get pdfHeaderTitle => '健康記録';

  @override
  String pdfHeaderTitleWithName(String name) {
    return '健康記録 — $name';
  }

  @override
  String get expandableFieldMore => '...もっと';

  @override
  String get expandableFieldLess => '...少';

  @override
  String get profiles_button_addnew => '新しいプロフィールを追加';

  @override
  String get profiles_label_addnew => 'この相談の詳細を保存するためにプロフィールを作成します';

  @override
  String get profiles_label_health_records_hint => '健康記録でいつでも確認できます';

  @override
  String get profiles_label_keep_talking_hint =>
      'この件や関連することでさらに質問があれば、遠慮なく引き続き話しかけてください。お手伝いします';

  @override
  String get profile_section_basic_title => '基本情報';

  @override
  String get profile_section_basic_name_label => '名前';

  @override
  String get profile_section_basic_name_placeholder => '山田 太郎';

  @override
  String get profile_section_basic_first_name_label => '名';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => '姓';

  @override
  String get profile_section_basic_last_name_placeholder => '山田';

  @override
  String get profile_section_basic_sex_label => '性別';

  @override
  String get profile_section_basic_sex_placeholder => '選択してください';

  @override
  String get profile_section_basic_sex_options_male => '男性';

  @override
  String get profile_section_basic_sex_options_female => '女性';

  @override
  String get profile_section_basic_sex_options_other => 'その他';

  @override
  String get profile_section_basic_date_of_birth_label => '生年月日';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => '年齢';

  @override
  String get profile_section_basic_age_str_placeholder => '例：30';

  @override
  String get profile_section_basic_phonenumber_label => '電話番号';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'メールアドレス';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => '居住地';

  @override
  String get profile_section_basic_location_placeholder => '例：市、国';

  @override
  String get profile_section_body_diet_title => '体と食事';

  @override
  String get profile_section_body_diet_height_str_label => '身長';

  @override
  String get profile_section_body_diet_height_str_placeholder => '例：180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => '体重';

  @override
  String get profile_section_body_diet_weight_str_placeholder => '例：75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => '月経周期';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      '例：規則的、不規則';

  @override
  String get profile_section_body_diet_dietary_restrictions_label => '食事制限';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      '選択してください';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'あなたが食べるものと、持っている制限について教えてください';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'なし';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'ベジタリアン';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'ビーガン';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'グルテンフリー';

  @override
  String get profile_section_body_diet_bmi_label => '体格指数（BMI）';

  @override
  String get profile_section_body_diet_bmi_placeholder => '例: 24.5';

  @override
  String get profile_section_health_profile_title => '健康プロフィール';

  @override
  String get profile_section_health_profile_chronic_illnesses_label => '慢性疾患';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      '例えば2型糖尿病';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'すべての慢性疾患をリストし、診断された時期と合併症を含めてください。';

  @override
  String get profile_section_health_profile_past_illnesses_label => '既往症';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      '例えば、頻繁な風邪';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      '過去にかかった重い病気をリストしてください、たとえ回復したとしても。';

  @override
  String get profile_section_health_profile_surgical_history_label => '手術歴';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      '例：虫垂切除術';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'すべての手術をリストし、年と合併症があったかどうかを含めてください。';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      '時々使用する薬';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          '例えば、イブプロフェン';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      '時々服用する薬（例：鎮痛剤、アレルギー薬）を、用量と使用理由を含めてリストしてください。';

  @override
  String get profile_section_health_profile_regular_medications_label => '常用薬';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      '例：メトホルミン';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      '定期的に服用しているすべての薬について、名前、用量、1日に何回服用するか、そしてその薬がどの病状のためであるかを記載してください。';

  @override
  String get profile_section_health_profile_allergies_label => 'アレルギー';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      '例：ペニシリン – 発疹を引き起こす';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'すべてのアレルギー（薬、食べ物、環境）をリストし、どのような反応があるかを説明してください（例：発疹、腫れ、呼吸の問題）。';

  @override
  String get profile_section_health_profile_special_conditions_label => '特記事項';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      '例：妊娠、障害';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      '医師が常に知っておくべき重要な医療条件がある場合（例：妊娠、埋め込みデバイス、障害、抗凝固療法）、それについて説明してください。ない場合は、空白のままにしておいても構いません。';

  @override
  String get profile_section_health_profile_family_history_label => '家族歴';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      '例：心臓病、がん';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'ご家族における重要な病気について説明してください（例：糖尿病、高血圧、心臓病、癌、遺伝性疾患）そして、どの家族のメンバーがその病気にかかったかを指定してください。';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      '社会的・生活習慣要因';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          '例：喫煙、飲酒';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      '喫煙、アルコール、身体活動、食事、睡眠、職業など、健康に影響を与えるライフスタイル要因について説明してください。';

  @override
  String get profile_section_health_profile_devices_label => '医療機器';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      '例：ペースメーカー、補聴器、インスリンポンプ';

  @override
  String get profile_section_health_profile_devices_hint =>
      'ペースメーカー、インスリンポンプ、補聴器、義肢、またはその他の支援または監視デバイスなど、使用しているまたは埋め込まれている医療機器をリストしてください。該当する場合は、関連する詳細を含めてください。';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          '雑食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'ファストフード';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'ペスカタリアン';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          '乳糖フリー';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          '減塩食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      '低糖質の食事';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      '心臓病食';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      '腎臓の食事';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'その他';
}
