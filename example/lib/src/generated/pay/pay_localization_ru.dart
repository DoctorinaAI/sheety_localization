// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'pay_localization.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class PayLocalizationRu extends PayLocalization {
  PayLocalizationRu([String locale = 'ru']) : super(locale);

  @override
  String get exampleButton => 'Пример кнопки';

  @override
  String get donationYesItsAllGoodButton => 'Да, всё в порядке!';

  @override
  String get everyContributionHealsTitle => 'Каждый вклад лечит!';

  @override
  String get ifThisHelpedYouConsiderSupportingSubtitle =>
      'Ваш вклад помогает финансировать бесплатные консультации для тех, кто в них нуждается.';

  @override
  String get payWhatFeelsRightLabel => 'Платите, сколько считаете правильным,';

  @override
  String get orKeepUsingDoctorinaForFreeLabel =>
      'или продолжайте пользоваться Doctorina бесплатно, благодаря тем, кто решил пожертвовать';

  @override
  String get oneTimeLabel => 'Одноразовый';

  @override
  String get monthlyLabel => 'Ежемесячно';

  @override
  String get chooseMonthlyDonationAmountLabel =>
      'Выберите сумму ежемесячного пожертвования';

  @override
  String get subscriptionNoAmount =>
      'Вы собираетесь подписаться на месячный план.';

  @override
  String subscriptionAmount(String amount) {
    return 'Вы подписываетесь на ежемесячный план за $amount/месяц.';
  }

  @override
  String subscriptionInfo(String termsOfService, String privacyPolicy) {
    return 'С вашего счета будет списана оплата после подтверждения покупки. Подписка автоматически продлевается каждый месяц, если функция автопродления не отключена как минимум за 24 часа до окончания текущего периода. Вы можете управлять подпиской или отменить её в любое время в настройках аккаунта. Продолжая, вы соглашаетесь с нашими $termsOfService и $privacyPolicy.';
  }

  @override
  String get chooseOneTimeDonationAmountLabel =>
      'Выберите сумму разового пожертвования';

  @override
  String get mostPeopleGiveHint => 'Большинство людей дают \$7–\$15';

  @override
  String get selectCurrencyTooltip => 'Выберите валюту';

  @override
  String get processingPaymentSemantics => 'Обработка оплаты';

  @override
  String processingOneTimePaymentSemantics(String currency, String amount) {
    return 'Обработка единовременного платежа $currency $amount';
  }

  @override
  String processingMonthlyPaymentSemantics(String amount) {
    return 'Обрабатывается ежемесячный платеж на сумму $amount';
  }

  @override
  String get thankYouTitle => 'Спасибо!';

  @override
  String get thankYouSubtitle =>
      'Теперь еще больше людей получат бесплатные советы — ваша поддержка действительно неоценима';

  @override
  String get youContributedLabel => 'Ваш вклад:';

  @override
  String get perMonth => '/ месяц';

  @override
  String get returnToTheMainScreenButton => 'Вернуться на главный экран';

  @override
  String get termsOfServiceLabel => 'Пользовательское соглашение';

  @override
  String get privacyPolicyLabel => 'Политика конфиденциальности';

  @override
  String get donateButton => 'Пожертвовать';

  @override
  String get subscriptionStatusActiveLabel => 'Активный';

  @override
  String get subscriptionStatusCanceledLabel => 'Отменено';

  @override
  String get subscriptionStatusPausedLabel => 'Приостановлено';

  @override
  String get subscriptionStatusPendingLabel => 'В ожидании';

  @override
  String get subscriptionStatusCreatedLabel => 'Создано';

  @override
  String get subscriptionStatusTimeoutLabel => 'Тайм-аут';

  @override
  String get subscriptionStatusUnknownLabel => 'Неизвестно';

  @override
  String get subscriptionDoctorinaContributor => 'Doctorina вкладчик';

  @override
  String get subscriptionRenews => 'Продлевается';

  @override
  String get subscriptionCancelButton => 'Отменить подписку';

  @override
  String get subscriptionAreYouSureDialogTitle => 'Вы уверены?';

  @override
  String get subscriptionAreYouSureDialogText =>
      'Ваша ежемесячная поддержка позволяет Докторине оставаться бесплатной для людей, которые на неё рассчитывают, но не могут позволить себе платить. Ваша подписка финансирует не менее 10 бесплатных консультаций каждый месяц. Если вы уйдёте, меньше пациентов получат необходимую помощь.';

  @override
  String get subscriptionAreYouSureDialogKeepButton => 'Оставить подписку';

  @override
  String get subscriptionAreYouSureDialogCancelButton => 'Все равно отменить';

  @override
  String get subscriptionYourMonthlySupportCanceledNotification =>
      'Ваша ежемесячная поддержка\nбыла успешно отменена.';

  @override
  String get subscriptionMalformed => 'Неверные данные подписки';

  @override
  String get subscriptionSignUpForMonthlySupportButton =>
      'Подпишитесь на ежемесячную поддержку, чтобы она отображалась здесь';

  @override
  String get subscriptionNoSubscriptionsYet => 'Подписок пока нет';

  @override
  String get subscriptionCreatedAtDateLabel => 'Дата подписки';

  @override
  String get subscriptionExpiresAtDateLabel => 'Истекает';

  @override
  String get subscriptionSubscriptionIdLabel => 'Идентификатор подписки';

  @override
  String get subscriptionProductIdLabel => 'Идентификатор продукта';

  @override
  String get subscriptionDialogOkButton => 'ОК';

  @override
  String get errorProcessDonationTitle => 'Мы не смогли обработать ваш платеж';

  @override
  String get errorProcessDonationSubtitle =>
      'Что-то пошло не так с оплатой. Пожалуйста, попробуйте снова.';

  @override
  String get errorProcessDonationRetryButton => 'Повторить';

  @override
  String get processingDonationTitle => 'Обработка платежа';

  @override
  String get processingDonationStripeSubtitle =>
      'Вы завершите покупку на защищённой странице оформления заказа Stripe.';

  @override
  String get perWeek => '/ неделя';

  @override
  String get perYear => '/ год';

  @override
  String get premiumMostPopularRibbon => 'Самый популярный';

  @override
  String get premiumCloseTooltip => 'Закрыть';

  @override
  String get premiumTitle => 'Doctorina Премиум';

  @override
  String get premiumWhatYouGetHeader => 'Что вы получаете с Премиум:';

  @override
  String get premiumFeatureAdFree => 'Консультации без рекламы';

  @override
  String get premiumFeatureFasterReplies => 'Быстрые ответы';

  @override
  String get premiumFeatureEarlyAccess => 'Ранний доступ к новым функциям';

  @override
  String get premiumPricePerWeek => '/неделя';

  @override
  String get premiumCancelAnytime =>
      'Отмените в любое время. Без обязательств.';

  @override
  String get premiumLimitedTimeBadge => 'ОГРАНИЧЕННОЕ ВРЕМЯ';

  @override
  String get premiumAutoRenewsConsent =>
      'Автообновление каждую неделю. Отменить в любое время в настройках. Продолжая, вы соглашаетесь с нашими <t>Условиями</t> и <p>Политикой конфиденциальности</p>.';

  @override
  String get premiumContinueButton => '🎁 Продолжить с Премиум';

  @override
  String get premiumSupportMessage =>
      '💚 Ваша поддержка помогает сделать медицинскую помощь доступной';

  @override
  String get subscriptionLoginRequiredError =>
      'Пожалуйста, зарегистрируйтесь или войдите, чтобы завершить покупку';
}
