// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class ProfilesLocalizationKo extends ProfilesLocalization {
  ProfilesLocalizationKo([String locale = 'ko']) : super(locale);

  @override
  String get chatDrawerTitle => '건강 기록';

  @override
  String get chatDrawerBadgeNew => '새로운';

  @override
  String get bannerTitle => '건강 기록 만들기';

  @override
  String get bannerSubtitle => '상담이 끝난 후 프로필을 추가하세요.';

  @override
  String get bannerMoreProfilesTitle => '프로필 추가';

  @override
  String get bannerMoreProfilesSubtitle => '다른 사람을 위해 상담을 시작하여 프로필을 생성하세요.';

  @override
  String get bannerSignUp => '건강 기록을 만들기 위해 가입하세요';

  @override
  String get errorRetryButton => '다시 시도';

  @override
  String get dashboardDeleteError => '프로필 삭제에 실패했습니다';

  @override
  String get dashboardSummaryLoadError => '프로필 요약을 불러오는 데 실패했습니다';

  @override
  String get dashboardMenuViewFullRecord => '전체 기록 보기';

  @override
  String get dashboardMenuShare => '공유';

  @override
  String get dashboardMenuDelete => '삭제';

  @override
  String get dashboardMetricAgeLabel => '나이';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value세',
      one: '$value세',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => '체중';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => '신장';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => '알레르기';

  @override
  String get dashboardInfoChronicTitle => '만성';

  @override
  String get dashboardInfoMedicationTitle => '약물';

  @override
  String get dashboardInfoDevicesTitle => '장치';

  @override
  String get dashboardNavigationConsultations => '상담';

  @override
  String get dashboardNavigationDocuments => '문서';

  @override
  String get dashboardDeleteRecordTitle => '건강 기록을 삭제하시겠습니까?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      '이 작업은 귀하의 건강 데이터를 영구적으로 삭제하며 되돌릴 수 없습니다. 귀하를 안내하는 데 사용하는 맥락을 잃게 됩니다.';

  @override
  String get dashboardDeleteRecordCancel => '취소';

  @override
  String get dashboardDeleteRecordConfirm => '삭제';

  @override
  String get dashboardDeleteRecordLoading => '건강 기록을 삭제하는 중...';

  @override
  String get dashboardDeleteRecordError => '프로필을 삭제하지 못했습니다';

  @override
  String get dashboardDeleteRecordSuccessTitle => '건강 기록이 삭제되었습니다';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      '언제든지 도우미와 채팅하여 새로 만들 수 있습니다.';

  @override
  String get dashboardDeleteRecordSuccessButton => '채팅으로 돌아가기';

  @override
  String get dataEditingScreenTitle => '편집 중';

  @override
  String get dataFailedToLoadError => '프로필 데이터를 불러오는 데 실패했습니다';

  @override
  String get dataRecordSavedTitle => '변경 사항이 저장되었습니다';

  @override
  String get dataRecordSavedSubtitle => '귀하의 정보가 성공적으로 업데이트되었습니다.';

  @override
  String get dataRecordSavedButton => '프로필로 돌아가기';

  @override
  String get dataRecordUpdateError => '프로필 데이터를 업데이트하지 못했습니다';

  @override
  String get dataRecordDiscardTitle => '변경 사항을 버리시겠습니까?';

  @override
  String get dataRecordDiscardSubtitle =>
      '프로필에 변경 사항을 적용했습니다. 가기 전에 저장하거나 폐기하세요.';

  @override
  String get dataRecordDiscardCancel => '편집 계속하기';

  @override
  String get dataRecordDiscardConfirm => '버리기';

  @override
  String get dataRecordEditTooltip => '편집';

  @override
  String get dataRecordAddTag => '기록 추가';

  @override
  String get consultationsSearch => '검색';

  @override
  String get consultationsSearchEmpty => '결과가 없습니다';

  @override
  String get documentsMenuDownload => '다운로드';

  @override
  String get documentsMenuShare => '공유';

  @override
  String get documentsMenuDelete => '삭제';

  @override
  String get documentsEmptyList => '문서가 없습니다';

  @override
  String get documentsDeleteTitle => '이 문서를 삭제하시겠습니까?';

  @override
  String get documentsDeleteSubtitle => '이 파일은 영구적으로 삭제됩니다';

  @override
  String get documentsDeleteCancel => '취소';

  @override
  String get documentsDeleteButton => '삭제';

  @override
  String get documentsMoreActionsTooltip => '추가 작업';

  @override
  String get profilesSearch => '검색';

  @override
  String get profilesEmptyList => '프로필을 찾을 수 없습니다';

  @override
  String get profilesViewMore => '더 보기';

  @override
  String get profilesMore => '더보기';

  @override
  String get profilesAnnouncementTitle1 => '닥터리나가 이제 당신의 건강을 기억합니다';

  @override
  String get profilesAnnouncementSubtitle1 =>
      '이제 귀하의 상담이 자동으로 건강 기록을 작성하고 업데이트합니다.';

  @override
  String get profilesAnnouncementTitle2 => '당신의 건강 기록, 당신의 규칙';

  @override
  String get profilesAnnouncementSubtitle2 =>
      '증상, 약물, 병력 또는 문서를 언제든지 보고, 수정하거나 추가하세요.';

  @override
  String get profilesAnnouncementTitle3 => '가족 전체를 위한 돌봄';

  @override
  String get profilesAnnouncementSubtitle3 =>
      '사랑하는 사람들, 자녀, 부모 또는 파트너를 위한 건강 기록을 만드세요.';

  @override
  String get profilesAnnouncementTitle4 => '건강 기록을 저장할 준비가 되셨나요?';

  @override
  String get profilesAnnouncementSubtitle4 => '상담 후 \'프로필 추가\'를 눌러 저장하세요.';

  @override
  String get profilesNextButton => '다음';

  @override
  String get profilesStartButton => '상담 시작';

  @override
  String get profilesLaterButton => '나중에 할게요';

  @override
  String get profileSuccessCloseButton => '닫기';

  @override
  String get pdfHeaderTitle => '건강 기록';

  @override
  String pdfHeaderTitleWithName(String name) {
    return '건강 기록 — $name';
  }

  @override
  String get expandableFieldMore => '...더 보기';

  @override
  String get expandableFieldLess => '...덜';

  @override
  String get profiles_button_addnew => '새 프로필 추가';

  @override
  String get profiles_label_addnew => '이 상담의 세부 정보를 저장할 프로필을 만드세요';

  @override
  String get profiles_label_health_records_hint =>
      '언제든지 Health Records에서 확인할 수 있습니다';

  @override
  String get profiles_label_keep_talking_hint =>
      '이 문제나 관련된 다른 질문이 있으면 언제든 저와 계속 이야기해 주세요. 도와드리기 위해 여기 있어요';

  @override
  String get profile_section_basic_title => '일반 정보';

  @override
  String get profile_section_basic_name_label => '이름';

  @override
  String get profile_section_basic_name_placeholder => '홍길동';

  @override
  String get profile_section_basic_first_name_label => '이름';

  @override
  String get profile_section_basic_first_name_placeholder => '철수';

  @override
  String get profile_section_basic_last_name_label => '성';

  @override
  String get profile_section_basic_last_name_placeholder => '김';

  @override
  String get profile_section_basic_sex_label => '성별';

  @override
  String get profile_section_basic_sex_placeholder => '선택하세요';

  @override
  String get profile_section_basic_sex_options_male => '남성';

  @override
  String get profile_section_basic_sex_options_female => '여성';

  @override
  String get profile_section_basic_sex_options_other => '기타';

  @override
  String get profile_section_basic_date_of_birth_label => '생년월일';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => '나이';

  @override
  String get profile_section_basic_age_str_placeholder => '예: 30';

  @override
  String get profile_section_basic_phonenumber_label => '전화번호';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => '이메일';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => '위치';

  @override
  String get profile_section_basic_location_placeholder => '예: 도시, 국가';

  @override
  String get profile_section_body_diet_title => '신체 및 식단';

  @override
  String get profile_section_body_diet_height_str_label => '키';

  @override
  String get profile_section_body_diet_height_str_placeholder => '예: 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => '체중';

  @override
  String get profile_section_body_diet_weight_str_placeholder => '예: 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => '월경 주기';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      '예: 규칙적, 불규칙적';

  @override
  String get profile_section_body_diet_dietary_restrictions_label => '식이 제한';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      '선택하세요';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      '당신이 먹는 것과 어떤 제한이 있는지 알려주세요';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      '없음';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          '채식주의자';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      '비건';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          '글루텐 프리';

  @override
  String get profile_section_body_diet_bmi_label => '체질량지수(BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => '예: 24.5';

  @override
  String get profile_section_health_profile_title => '건강 프로필';

  @override
  String get profile_section_health_profile_chronic_illnesses_label => '만성 질환';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      '예: 제2형 당뇨병';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      '모든 만성 질환을 나열하고 진단된 시기와 합병증을 포함해 주세요.';

  @override
  String get profile_section_health_profile_past_illnesses_label => '과거 병력';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      '예: 잦은 감기';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      '과거에 앓았던 심각한 질병을 나열해 주세요, 회복했더라도.';

  @override
  String get profile_section_health_profile_surgical_history_label => '수술력';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      '예: 충수절제술';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      '모든 수술을 나열하고 연도와 합병증 여부를 포함해 주세요.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      '가끔 복용하는 약';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          '예: 이부프로펜';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      '가끔 복용하는 약물(예: 진통제, 알레르기 약물)을 복용량과 사용 이유와 함께 기재해 주세요';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      '정기 복용 약물';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      '예: 메트포르민';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      '정기적으로 복용하는 모든 약물의 이름, 용량, 하루 몇 번 복용하는지, 어떤 질환을 위한 것인지 기재해 주세요';

  @override
  String get profile_section_health_profile_allergies_label => '알레르기';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      '예: 페니실린 – 발진 유발';

  @override
  String get profile_section_health_profile_allergies_hint =>
      '모든 알레르기(약물, 음식, 환경)를 나열하고 어떤 반응이 있었는지 설명해 주세요(예: 발진, 부기, 호흡 문제).';

  @override
  String get profile_section_health_profile_special_conditions_label => '특이사항';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      '예: 임신, 장애';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      '의사가 항상 알아야 할 중요한 의학적 상태가 있다면(예: 임신, 이식된 장치, 장애, 항응고 요법) 설명해 주십시오. 없다면 비워 두셔도 됩니다.';

  @override
  String get profile_section_health_profile_family_history_label => '가족력';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      '예: 심장 질환, 암';

  @override
  String get profile_section_health_profile_family_history_hint =>
      '가족의 중요한 질병을 설명해 주세요 (예: 당뇨병, 고혈압, 심장병, 암, 유전병) 그리고 어떤 가족 구성원이 그 질병을 앓았는지 명시해 주세요.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      '사회 및 생활습관 요인';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          '예: 흡연, 음주';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      '흡연, 음주, 신체 활동, 식단, 수면 및 직업과 같이 건강에 영향을 줄 수 있는 생활 습관 요소를 설명해 주세요.';

  @override
  String get profile_section_health_profile_devices_label => '의료기기';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      '예: 심박동조율기, 보청기, 인슐린 펌프';

  @override
  String get profile_section_health_profile_devices_hint =>
      '사용 중이거나 이식된 의료 기기를 나열해 주세요. 예: 심박조율기, 인슐린 펌프, 보청기, 의수족 또는 기타 보조 기기나 모니터링 기기. 관련 세부정보가 있으면 포함해 주세요.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          '잡식성';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      '패스트푸드';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          '페스카테리언';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          '무유당';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          '저나트륨 식단';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      '저당 식단';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      '심장 질환 식단';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      '신장 식단';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      '기타';
}
