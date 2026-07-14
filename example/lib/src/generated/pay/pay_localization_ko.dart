// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'pay_localization.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class PayLocalizationKo extends PayLocalization {
  PayLocalizationKo([String locale = 'ko']) : super(locale);

  @override
  String get exampleButton => '버튼 예시';

  @override
  String get donationYesItsAllGoodButton => '네, 다 괜찮아요!';

  @override
  String get everyContributionHealsTitle => '모든 기여가 치유됩니다!';

  @override
  String get ifThisHelpedYouConsiderSupportingSubtitle =>
      '여러분의 기여는 도움이 필요한 사람들에게 무료 상담을 제공하는 데 도움을 줍니다.';

  @override
  String get payWhatFeelsRightLabel => '적당하다고 느끼는 만큼 지불하세요,';

  @override
  String get orKeepUsingDoctorinaForFreeLabel =>
      '또는 기부를 선택한 다른 사람들 덕분에 Doctorina를 무료로 계속 사용하세요';

  @override
  String get oneTimeLabel => '일회성';

  @override
  String get monthlyLabel => '매월';

  @override
  String get chooseMonthlyDonationAmountLabel => '매월 기부 금액 선택';

  @override
  String get subscriptionNoAmount => '귀하는 월간 플랜을 구독하려고 합니다.';

  @override
  String subscriptionAmount(String amount) {
    return '당신은 $amount/월의 월간 플랜을 구독하고 있습니다';
  }

  @override
  String subscriptionInfo(String termsOfService, String privacyPolicy) {
    return '구매 확인 시 결제가 계정에서 이루어집니다. 구독은 현재 기간 종료 최소 24시간 전까지 자동 갱신이 꺼지지 않으면 매월 자동으로 갱신됩니다. 계정 설정에서 언제든지 구독을 관리하거나 취소할 수 있습니다. 진행함으로써 귀하는 당사의 $termsOfService 및 $privacyPolicy에 동의하게 됩니다.';
  }

  @override
  String get chooseOneTimeDonationAmountLabel => '일회성 기부 금액 선택';

  @override
  String get mostPeopleGiveHint => '대부분은 \$7–\$15 줍니다';

  @override
  String get selectCurrencyTooltip => '통화 선택';

  @override
  String get processingPaymentSemantics => '결제 처리 중';

  @override
  String processingOneTimePaymentSemantics(String currency, String amount) {
    return '일회성 결제 $currency $amount 처리 중';
  }

  @override
  String processingMonthlyPaymentSemantics(String amount) {
    return '월별 결제 $amount 처리 중';
  }

  @override
  String get thankYouTitle => '감사합니다!';

  @override
  String get thankYouSubtitle =>
      '이제 더 많은 사람들이 무료 상담을 받게 됩니다 — 당신의 지원은 정말 귀중합니다.';

  @override
  String get youContributedLabel => '기여하셨습니다:';

  @override
  String get perMonth => '/ 월';

  @override
  String get returnToTheMainScreenButton => '메인 화면으로 돌아가기';

  @override
  String get termsOfServiceLabel => '이용 약관';

  @override
  String get privacyPolicyLabel => '개인정보 보호정책';

  @override
  String get donateButton => '기부하기';

  @override
  String get subscriptionStatusActiveLabel => '활성';

  @override
  String get subscriptionStatusCanceledLabel => '취소됨';

  @override
  String get subscriptionStatusPausedLabel => '일시정지';

  @override
  String get subscriptionStatusPendingLabel => '보류중';

  @override
  String get subscriptionStatusCreatedLabel => '생성됨';

  @override
  String get subscriptionStatusTimeoutLabel => '시간 초과';

  @override
  String get subscriptionStatusUnknownLabel => '알 수 없음';

  @override
  String get subscriptionDoctorinaContributor => 'Doctorina 기여자';

  @override
  String get subscriptionRenews => '갱신';

  @override
  String get subscriptionCancelButton => '구독 취소';

  @override
  String get subscriptionAreYouSureDialogTitle => '정말 확실합니까?';

  @override
  String get subscriptionAreYouSureDialogText =>
      '매달의 지원 덕분에 Doctorina는 비용을 감당할 수 없는 이용자들에게 무료로 제공됩니다.\n\n구독을 통해 매달 최소 10회의 무료 상담이 지원됩니다.\n구독을 취소하면, 필요한 도움을 받는 환자가 줄어듭니다';

  @override
  String get subscriptionAreYouSureDialogKeepButton => '구독 유지';

  @override
  String get subscriptionAreYouSureDialogCancelButton => '그래도 취소';

  @override
  String get subscriptionYourMonthlySupportCanceledNotification =>
      '월간 지원이 성공적으로 취소되었습니다.';

  @override
  String get subscriptionMalformed => '잘못된 구독 데이터';

  @override
  String get subscriptionSignUpForMonthlySupportButton =>
      '월간 지원에 가입하여 여기에 표시되도록 하세요';

  @override
  String get subscriptionNoSubscriptionsYet => '아직 구독이 없습니다';

  @override
  String get subscriptionCreatedAtDateLabel => '구독 날짜';

  @override
  String get subscriptionExpiresAtDateLabel => '만료';

  @override
  String get subscriptionSubscriptionIdLabel => '구독 ID';

  @override
  String get subscriptionProductIdLabel => '제품 ID';

  @override
  String get subscriptionDialogOkButton => '확인';

  @override
  String get errorProcessDonationTitle => '결제를 처리하지 못했습니다';

  @override
  String get errorProcessDonationSubtitle => '결제 과정에서 문제가 발생했습니다.\n다시 시도해 주세요.';

  @override
  String get errorProcessDonationRetryButton => '다시 시도';

  @override
  String get processingDonationTitle => '결제 처리 중';

  @override
  String get processingDonationStripeSubtitle =>
      'Stripe의 안전한 결제 페이지에서 구매를 완료합니다.';

  @override
  String get perWeek => '/ 주';

  @override
  String get perYear => '/ 년';

  @override
  String get premiumMostPopularRibbon => '가장 인기 있는';

  @override
  String get premiumCloseTooltip => '닫기';

  @override
  String get premiumTitle => '닥터리나 프리미엄';

  @override
  String get premiumWhatYouGetHeader => '프리미엄으로 얻는 것:';

  @override
  String get premiumFeatureAdFree => '광고 없는 상담';

  @override
  String get premiumFeatureFasterReplies => '더 빠른 응답';

  @override
  String get premiumFeatureEarlyAccess => '새로운 기능에 대한 조기 액세스';

  @override
  String get premiumPricePerWeek => '/주';

  @override
  String get premiumCancelAnytime => '언제든지 취소할 수 있습니다. 약정이 없습니다.';

  @override
  String get premiumLimitedTimeBadge => '한정 시간';

  @override
  String get premiumAutoRenewsConsent =>
      '매주 자동 갱신됩니다. 설정에서 언제든지 취소할 수 있습니다. 계속 진행하면 <t>약관</t> 및 <p>개인정보 처리방침</p>에 동의하는 것입니다.';

  @override
  String get premiumContinueButton => '🎁 프리미엄으로 계속하기';

  @override
  String get premiumSupportMessage => '💚 당신의 지원은 치료를 접근 가능하게 유지하는 데 도움이 됩니다';

  @override
  String get subscriptionLoginRequiredError => '구매를 완료하려면 가입하거나 로그인하세요.';
}
