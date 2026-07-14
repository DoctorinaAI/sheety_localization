// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'pay_localization.dart';

// ignore_for_file: type=lint

/// The translations for Bulgarian (`bg`).
class PayLocalizationBg extends PayLocalization {
  PayLocalizationBg([String locale = 'bg']) : super(locale);

  @override
  String get exampleButton => 'Пример на бутон';

  @override
  String get donationYesItsAllGoodButton => 'Да, всичко е наред!';

  @override
  String get everyContributionHealsTitle => 'Всяко дарение лекува!';

  @override
  String get ifThisHelpedYouConsiderSupportingSubtitle =>
      'Вашето дарение помага за финансиране на безплатни съвети за други в нужда.';

  @override
  String get payWhatFeelsRightLabel => 'Платете, както ви се струва правилно,';

  @override
  String get orKeepUsingDoctorinaForFreeLabel =>
      'или продължете да използвате Doctorina безплатно, благодарение на другите, които избраха да дарят.';

  @override
  String get oneTimeLabel => 'Еднократно';

  @override
  String get monthlyLabel => 'Месечно';

  @override
  String get chooseMonthlyDonationAmountLabel =>
      'Изберете месечна сума за дарение';

  @override
  String get subscriptionNoAmount => 'Вие ще се абонирате за месечен план.';

  @override
  String subscriptionAmount(String amount) {
    return 'Вие се абонирате за месечен план за $amount/месец.';
  }

  @override
  String subscriptionInfo(String termsOfService, String privacyPolicy) {
    return 'Плащането ще бъде начислено на вашата сметка при потвърждение на покупката. Абонаментът се подновява автоматично всеки месец, освен ако автоматичното подновяване не бъде изключено поне 24 часа преди края на текущия период. Можете да управлявате или отменяте абонамента си по всяко време в настройките на вашия акаунт. Като продължавате, вие се съгласявате с нашите $termsOfService и $privacyPolicy.';
  }

  @override
  String get chooseOneTimeDonationAmountLabel =>
      'Изберете еднократна сума за дарение';

  @override
  String get mostPeopleGiveHint => 'Повечето хора дават \$7–\$15';

  @override
  String get selectCurrencyTooltip => 'Изберете валута';

  @override
  String get processingPaymentSemantics => 'Обработка на плащането';

  @override
  String processingOneTimePaymentSemantics(String currency, String amount) {
    return 'Обработка на еднократно плащане от $currency $amount';
  }

  @override
  String processingMonthlyPaymentSemantics(String amount) {
    return 'Обработка на месечно плащане от $amount';
  }

  @override
  String get thankYouTitle => 'Благодаря!';

  @override
  String get thankYouSubtitle =>
      'Сега още повече хора ще получат безплатни съвети — вашата подкрепа е наистина безценна.';

  @override
  String get youContributedLabel => 'Вие допринесохте:';

  @override
  String get perMonth => '/ месец';

  @override
  String get returnToTheMainScreenButton => 'Върнете се на главния екран';

  @override
  String get termsOfServiceLabel => 'Условия за ползване';

  @override
  String get privacyPolicyLabel => 'Политика за поверителност';

  @override
  String get donateButton => 'Дарете';

  @override
  String get subscriptionStatusActiveLabel => 'Активен';

  @override
  String get subscriptionStatusCanceledLabel => 'Отменен';

  @override
  String get subscriptionStatusPausedLabel => 'Пауза';

  @override
  String get subscriptionStatusPendingLabel => 'В очакване';

  @override
  String get subscriptionStatusCreatedLabel => 'Създадено';

  @override
  String get subscriptionStatusTimeoutLabel => 'Времето изтече';

  @override
  String get subscriptionStatusUnknownLabel => 'Неизвестно';

  @override
  String get subscriptionDoctorinaContributor => 'Doctorina сътрудник';

  @override
  String get subscriptionRenews => 'Подновява';

  @override
  String get subscriptionCancelButton => 'Отмяна на абонамента';

  @override
  String get subscriptionAreYouSureDialogTitle => 'Сигурни ли сте?';

  @override
  String get subscriptionAreYouSureDialogText =>
      'Вашата месечна подкрепа поддържа Doctorina безплатно за хора, които разчитат на него, но не могат да си позволят да платят. \n\nВашата абонаментна такса финансира поне 10 безплатни консултации всеки месец. \n\nАко напуснете, по-малко пациенти ще получат помощта, от която се нуждаят.';

  @override
  String get subscriptionAreYouSureDialogKeepButton => 'Запази абонамента';

  @override
  String get subscriptionAreYouSureDialogCancelButton => 'Отмени все пак';

  @override
  String get subscriptionYourMonthlySupportCanceledNotification =>
      'Вашата месечна поддръжка е успешно отменена';

  @override
  String get subscriptionMalformed => 'Неправилни данни за абонамент';

  @override
  String get subscriptionSignUpForMonthlySupportButton =>
      'Запишете се за месечна поддръжка, за да се появи тук.';

  @override
  String get subscriptionNoSubscriptionsYet => 'Няма абонаменти все още';

  @override
  String get subscriptionCreatedAtDateLabel => 'Дата на абонамента';

  @override
  String get subscriptionExpiresAtDateLabel => 'Изтича';

  @override
  String get subscriptionSubscriptionIdLabel => 'ID на абонамента';

  @override
  String get subscriptionProductIdLabel => 'Идентификатор на продукта';

  @override
  String get subscriptionDialogOkButton => 'ОК';

  @override
  String get errorProcessDonationTitle =>
      'Не можахме да обработим плащането ви';

  @override
  String get errorProcessDonationSubtitle => 'Нещо се обърка с плащането.';

  @override
  String get errorProcessDonationRetryButton => 'Опитай отново';

  @override
  String get processingDonationTitle => 'Обработка на плащането';

  @override
  String get processingDonationStripeSubtitle =>
      'Ще завършите покупката си на защитената страница за плащане на Stripe.';

  @override
  String get perWeek => '/ седмица';

  @override
  String get perYear => '/ година';

  @override
  String get premiumMostPopularRibbon => 'Най-популярен';

  @override
  String get premiumCloseTooltip => 'Затвори';

  @override
  String get premiumTitle => 'Doctorina Premium';

  @override
  String get premiumWhatYouGetHeader => 'Какво получавате с Премиум:';

  @override
  String get premiumFeatureAdFree => 'Консултации без реклами';

  @override
  String get premiumFeatureFasterReplies => 'По-бързи отговори';

  @override
  String get premiumFeatureEarlyAccess => 'Ранен достъп до нови функции';

  @override
  String get premiumPricePerWeek => '/седмица';

  @override
  String get premiumCancelAnytime => 'Отменете по всяко време. Без ангажимент.';

  @override
  String get premiumLimitedTimeBadge => 'ОГРАНИЧЕНО ВРЕМЕ';

  @override
  String get premiumAutoRenewsConsent =>
      'Автоматично се подновява седмично. Можете да отмените по всяко време в настройките. Като продължавате, вие се съгласявате с нашите <t>Условия</t> и <p>Политика за поверителност</p>.';

  @override
  String get premiumContinueButton => '🎁 Продължи с Премиум';

  @override
  String get premiumSupportMessage =>
      '💚 Вашата подкрепа помага да се запази достъпността на грижите';

  @override
  String get subscriptionLoginRequiredError =>
      'Моля, регистрирайте се или влезте, за да завършите покупката.';
}
