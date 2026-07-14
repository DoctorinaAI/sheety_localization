// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'pay_localization_af.dart';
import 'pay_localization_am.dart';
import 'pay_localization_ar.dart';
import 'pay_localization_az.dart';
import 'pay_localization_be.dart';
import 'pay_localization_bg.dart';
import 'pay_localization_bn.dart';
import 'pay_localization_ca.dart';
import 'pay_localization_cs.dart';
import 'pay_localization_da.dart';
import 'pay_localization_de.dart';
import 'pay_localization_el.dart';
import 'pay_localization_en.dart';
import 'pay_localization_es.dart';
import 'pay_localization_fa.dart';
import 'pay_localization_fr.dart';
import 'pay_localization_gu.dart';
import 'pay_localization_he.dart';
import 'pay_localization_hi.dart';
import 'pay_localization_hu.dart';
import 'pay_localization_id.dart';
import 'pay_localization_it.dart';
import 'pay_localization_ja.dart';
import 'pay_localization_kk.dart';
import 'pay_localization_km.dart';
import 'pay_localization_kn.dart';
import 'pay_localization_ko.dart';
import 'pay_localization_lo.dart';
import 'pay_localization_ml.dart';
import 'pay_localization_mr.dart';
import 'pay_localization_ms.dart';
import 'pay_localization_my.dart';
import 'pay_localization_ne.dart';
import 'pay_localization_nl.dart';
import 'pay_localization_pa.dart';
import 'pay_localization_pl.dart';
import 'pay_localization_ps.dart';
import 'pay_localization_pt.dart';
import 'pay_localization_ro.dart';
import 'pay_localization_ru.dart';
import 'pay_localization_si.dart';
import 'pay_localization_sk.dart';
import 'pay_localization_sw.dart';
import 'pay_localization_ta.dart';
import 'pay_localization_te.dart';
import 'pay_localization_th.dart';
import 'pay_localization_tl.dart';
import 'pay_localization_tr.dart';
import 'pay_localization_uk.dart';
import 'pay_localization_ur.dart';
import 'pay_localization_uz.dart';
import 'pay_localization_vi.dart';
import 'pay_localization_zh.dart';
import 'pay_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of PayLocalization
/// returned by `PayLocalization.of(context)`.
///
/// Applications need to include `PayLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'pay/pay_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PayLocalization.localizationsDelegates,
///   supportedLocales: PayLocalization.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the PayLocalization.supportedLocales
/// property.
abstract class PayLocalization {
  PayLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PayLocalization of(BuildContext context) {
    return Localizations.of<PayLocalization>(context, PayLocalization)!;
  }

  static const LocalizationsDelegate<PayLocalization> delegate =
      _PayLocalizationDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('am'),
    Locale('ar'),
    Locale('ar', 'EG'),
    Locale('az'),
    Locale('be'),
    Locale('bg'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hu'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kk'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('lo'),
    Locale('ml'),
    Locale('mr'),
    Locale('ms'),
    Locale('my'),
    Locale('ne'),
    Locale('nl'),
    Locale('pa'),
    Locale('pa', 'PK'),
    Locale('pl'),
    Locale('ps'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ro'),
    Locale('ru'),
    Locale('si'),
    Locale('sk'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('uz'),
    Locale('vi'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zu')
  ];

  /// Пример кнопки
  ///
  /// In en, this message translates to:
  /// **'Button example'**
  String get exampleButton;

  /// Кнопка доната после рекомендаций
  ///
  /// In en, this message translates to:
  /// **'Yes, it\'s all good!'**
  String get donationYesItsAllGoodButton;

  /// No description provided for @everyContributionHealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Every contribution heals!'**
  String get everyContributionHealsTitle;

  /// No description provided for @ifThisHelpedYouConsiderSupportingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your contribution helps fund free advice for others in need.'**
  String get ifThisHelpedYouConsiderSupportingSubtitle;

  /// No description provided for @payWhatFeelsRightLabel.
  ///
  /// In en, this message translates to:
  /// **'Pay what feels right,'**
  String get payWhatFeelsRightLabel;

  /// No description provided for @orKeepUsingDoctorinaForFreeLabel.
  ///
  /// In en, this message translates to:
  /// **'or keep using Doctorina for free, thanks to others who chose to give.'**
  String get orKeepUsingDoctorinaForFreeLabel;

  /// No description provided for @oneTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'One-Time'**
  String get oneTimeLabel;

  /// No description provided for @monthlyLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyLabel;

  /// No description provided for @chooseMonthlyDonationAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose monthly donation amount'**
  String get chooseMonthlyDonationAmountLabel;

  /// Сумма подписки еще не выбрана
  ///
  /// In en, this message translates to:
  /// **'You are about to subscribe to a monthly plan.'**
  String get subscriptionNoAmount;

  /// Subscription info text with amount
  ///
  /// In en, this message translates to:
  /// **'You are subscribing to a monthly plan for {amount}/month.'**
  String subscriptionAmount(String amount);

  /// Subscription info text with amount, Terms of Service and Privacy Policy placeholders as tappable spans.
  ///
  /// In en, this message translates to:
  /// **'Payment will be charged to your account at confirmation of purchase. The subscription automatically renews every month unless auto-renew is turned off at least 24 hours before the end of the current period. You can manage or cancel your subscription anytime in your account settings. By proceeding, you agree to our {termsOfService} and {privacyPolicy}.'**
  String subscriptionInfo(String termsOfService, String privacyPolicy);

  /// No description provided for @chooseOneTimeDonationAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Choose one-time donation amount'**
  String get chooseOneTimeDonationAmountLabel;

  /// No description provided for @mostPeopleGiveHint.
  ///
  /// In en, this message translates to:
  /// **'Most people give \$7–\$15'**
  String get mostPeopleGiveHint;

  /// No description provided for @selectCurrencyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Select currency'**
  String get selectCurrencyTooltip;

  /// No description provided for @processingPaymentSemantics.
  ///
  /// In en, this message translates to:
  /// **'Processing payment'**
  String get processingPaymentSemantics;

  /// Shown when processing a one-time payment, with currency code and amount placeholders.
  ///
  /// In en, this message translates to:
  /// **'Processing one-time payment of {currency} {amount}'**
  String processingOneTimePaymentSemantics(String currency, String amount);

  /// Shown when processing a monthly payment with amount placeholder.
  ///
  /// In en, this message translates to:
  /// **'Processing monthly payment of {amount}'**
  String processingMonthlyPaymentSemantics(String amount);

  /// No description provided for @thankYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get thankYouTitle;

  /// No description provided for @thankYouSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Now even more people will receive free advice — your support is truly invaluable.'**
  String get thankYouSubtitle;

  /// No description provided for @youContributedLabel.
  ///
  /// In en, this message translates to:
  /// **'You contributed:'**
  String get youContributedLabel;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'/ month'**
  String get perMonth;

  /// No description provided for @returnToTheMainScreenButton.
  ///
  /// In en, this message translates to:
  /// **'Return to the main screen'**
  String get returnToTheMainScreenButton;

  /// No description provided for @termsOfServiceLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Service'**
  String get termsOfServiceLabel;

  /// No description provided for @privacyPolicyLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLabel;

  /// No description provided for @donateButton.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donateButton;

  /// No description provided for @subscriptionStatusActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get subscriptionStatusActiveLabel;

  /// No description provided for @subscriptionStatusCanceledLabel.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get subscriptionStatusCanceledLabel;

  /// No description provided for @subscriptionStatusPausedLabel.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get subscriptionStatusPausedLabel;

  /// No description provided for @subscriptionStatusPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get subscriptionStatusPendingLabel;

  /// No description provided for @subscriptionStatusCreatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get subscriptionStatusCreatedLabel;

  /// No description provided for @subscriptionStatusTimeoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get subscriptionStatusTimeoutLabel;

  /// No description provided for @subscriptionStatusUnknownLabel.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get subscriptionStatusUnknownLabel;

  /// No description provided for @subscriptionDoctorinaContributor.
  ///
  /// In en, this message translates to:
  /// **'Doctorina contributor'**
  String get subscriptionDoctorinaContributor;

  /// No description provided for @subscriptionRenews.
  ///
  /// In en, this message translates to:
  /// **'Renews'**
  String get subscriptionRenews;

  /// No description provided for @subscriptionCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription'**
  String get subscriptionCancelButton;

  /// No description provided for @subscriptionAreYouSureDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get subscriptionAreYouSureDialogTitle;

  /// No description provided for @subscriptionAreYouSureDialogText.
  ///
  /// In en, this message translates to:
  /// **'Your monthly support keeps Doctorina free for people who rely on it but can’t afford to pay. \n\nYour subscription funds at least  10 free consultations each month.\n If you leave, fewer patients will get  the help they need.'**
  String get subscriptionAreYouSureDialogText;

  /// No description provided for @subscriptionAreYouSureDialogKeepButton.
  ///
  /// In en, this message translates to:
  /// **'Keep subscription'**
  String get subscriptionAreYouSureDialogKeepButton;

  /// No description provided for @subscriptionAreYouSureDialogCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel anyway'**
  String get subscriptionAreYouSureDialogCancelButton;

  /// No description provided for @subscriptionYourMonthlySupportCanceledNotification.
  ///
  /// In en, this message translates to:
  /// **'Your Monthly support \nhas been successfully canceled.'**
  String get subscriptionYourMonthlySupportCanceledNotification;

  /// No description provided for @subscriptionMalformed.
  ///
  /// In en, this message translates to:
  /// **'Incorrect subscription data'**
  String get subscriptionMalformed;

  /// No description provided for @subscriptionSignUpForMonthlySupportButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up for monthly support to have it appear here.'**
  String get subscriptionSignUpForMonthlySupportButton;

  /// No description provided for @subscriptionNoSubscriptionsYet.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions yet'**
  String get subscriptionNoSubscriptionsYet;

  /// No description provided for @subscriptionCreatedAtDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Subscription date'**
  String get subscriptionCreatedAtDateLabel;

  /// No description provided for @subscriptionExpiresAtDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get subscriptionExpiresAtDateLabel;

  /// No description provided for @subscriptionSubscriptionIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Subscription ID'**
  String get subscriptionSubscriptionIdLabel;

  /// No description provided for @subscriptionProductIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get subscriptionProductIdLabel;

  /// No description provided for @subscriptionDialogOkButton.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get subscriptionDialogOkButton;

  /// No description provided for @errorProcessDonationTitle.
  ///
  /// In en, this message translates to:
  /// **'We couldn’t proceed your payment'**
  String get errorProcessDonationTitle;

  /// No description provided for @errorProcessDonationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with the payment.\nPlease try again.'**
  String get errorProcessDonationSubtitle;

  /// No description provided for @errorProcessDonationRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorProcessDonationRetryButton;

  /// No description provided for @processingDonationTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing payment'**
  String get processingDonationTitle;

  /// No description provided for @processingDonationStripeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You’ll complete your purchase on Stripe’s secure checkout page.'**
  String get processingDonationStripeSubtitle;

  /// Переодичность оплаты
  ///
  /// In en, this message translates to:
  /// **'/ week'**
  String get perWeek;

  /// Переодичность оплаты
  ///
  /// In en, this message translates to:
  /// **'/ year'**
  String get perYear;

  /// Label for the most popular subscription option ribbon
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get premiumMostPopularRibbon;

  /// Tooltip text for close button on premium screen
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get premiumCloseTooltip;

  /// Title of the premium subscription screen
  ///
  /// In en, this message translates to:
  /// **'Doctorina Premium'**
  String get premiumTitle;

  /// Section header describing premium features
  ///
  /// In en, this message translates to:
  /// **'What you get with Premium:'**
  String get premiumWhatYouGetHeader;

  /// Premium feature: ad-free consultations
  ///
  /// In en, this message translates to:
  /// **'Ad-free consultations'**
  String get premiumFeatureAdFree;

  /// Premium feature: faster response times
  ///
  /// In en, this message translates to:
  /// **'Faster replies'**
  String get premiumFeatureFasterReplies;

  /// Premium feature: early access to new features
  ///
  /// In en, this message translates to:
  /// **'Early access to new features'**
  String get premiumFeatureEarlyAccess;

  /// Time period suffix for weekly subscription price. Shortcat for "per week"
  ///
  /// In en, this message translates to:
  /// **'/week'**
  String get premiumPricePerWeek;

  /// Text explaining cancellation policy
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. No commitment.'**
  String get premiumCancelAnytime;

  /// Badge text for limited time offers
  ///
  /// In en, this message translates to:
  /// **'LIMITED TIME'**
  String get premiumLimitedTimeBadge;

  /// Auto-renewal consent text with tagged links for Terms and Privacy Policy
  ///
  /// In en, this message translates to:
  /// **'Auto-renews weekly. Cancel anytime in settings. By continuing, you agree to our <t>Terms</t> and <p>Privacy Policy</p>.'**
  String get premiumAutoRenewsConsent;

  /// Button text to continue with premium subscription
  ///
  /// In en, this message translates to:
  /// **'🎁 Continue with Premium'**
  String get premiumContinueButton;

  /// Message about supporting accessible healthcare
  ///
  /// In en, this message translates to:
  /// **'💚 Your support helps keep care accessible'**
  String get premiumSupportMessage;

  /// Сообщение об ошибке при попытке оформить подписку анонимным пользователем на вебе
  ///
  /// In en, this message translates to:
  /// **'Please sign up or log in to complete the purchase.'**
  String get subscriptionLoginRequiredError;
}

class _PayLocalizationDelegate extends LocalizationsDelegate<PayLocalization> {
  const _PayLocalizationDelegate();

  @override
  Future<PayLocalization> load(Locale locale) {
    return SynchronousFuture<PayLocalization>(lookupPayLocalization(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'am',
        'ar',
        'az',
        'be',
        'bg',
        'bn',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'fa',
        'fr',
        'gu',
        'he',
        'hi',
        'hu',
        'id',
        'it',
        'ja',
        'kk',
        'km',
        'kn',
        'ko',
        'lo',
        'ml',
        'mr',
        'ms',
        'my',
        'ne',
        'nl',
        'pa',
        'pl',
        'ps',
        'pt',
        'ro',
        'ru',
        'si',
        'sk',
        'sw',
        'ta',
        'te',
        'th',
        'tl',
        'tr',
        'uk',
        'ur',
        'uz',
        'vi',
        'zh',
        'zu'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_PayLocalizationDelegate old) => false;
}

PayLocalization lookupPayLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return PayLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return PayLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return PayLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return PayLocalizationZhCn();
          case 'HK':
            return PayLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return PayLocalizationAf();
    case 'am':
      return PayLocalizationAm();
    case 'ar':
      return PayLocalizationAr();
    case 'az':
      return PayLocalizationAz();
    case 'be':
      return PayLocalizationBe();
    case 'bg':
      return PayLocalizationBg();
    case 'bn':
      return PayLocalizationBn();
    case 'ca':
      return PayLocalizationCa();
    case 'cs':
      return PayLocalizationCs();
    case 'da':
      return PayLocalizationDa();
    case 'de':
      return PayLocalizationDe();
    case 'el':
      return PayLocalizationEl();
    case 'en':
      return PayLocalizationEn();
    case 'es':
      return PayLocalizationEs();
    case 'fa':
      return PayLocalizationFa();
    case 'fr':
      return PayLocalizationFr();
    case 'gu':
      return PayLocalizationGu();
    case 'he':
      return PayLocalizationHe();
    case 'hi':
      return PayLocalizationHi();
    case 'hu':
      return PayLocalizationHu();
    case 'id':
      return PayLocalizationId();
    case 'it':
      return PayLocalizationIt();
    case 'ja':
      return PayLocalizationJa();
    case 'kk':
      return PayLocalizationKk();
    case 'km':
      return PayLocalizationKm();
    case 'kn':
      return PayLocalizationKn();
    case 'ko':
      return PayLocalizationKo();
    case 'lo':
      return PayLocalizationLo();
    case 'ml':
      return PayLocalizationMl();
    case 'mr':
      return PayLocalizationMr();
    case 'ms':
      return PayLocalizationMs();
    case 'my':
      return PayLocalizationMy();
    case 'ne':
      return PayLocalizationNe();
    case 'nl':
      return PayLocalizationNl();
    case 'pa':
      return PayLocalizationPa();
    case 'pl':
      return PayLocalizationPl();
    case 'ps':
      return PayLocalizationPs();
    case 'pt':
      return PayLocalizationPt();
    case 'ro':
      return PayLocalizationRo();
    case 'ru':
      return PayLocalizationRu();
    case 'si':
      return PayLocalizationSi();
    case 'sk':
      return PayLocalizationSk();
    case 'sw':
      return PayLocalizationSw();
    case 'ta':
      return PayLocalizationTa();
    case 'te':
      return PayLocalizationTe();
    case 'th':
      return PayLocalizationTh();
    case 'tl':
      return PayLocalizationTl();
    case 'tr':
      return PayLocalizationTr();
    case 'uk':
      return PayLocalizationUk();
    case 'ur':
      return PayLocalizationUr();
    case 'uz':
      return PayLocalizationUz();
    case 'vi':
      return PayLocalizationVi();
    case 'zh':
      return PayLocalizationZh();
    case 'zu':
      return PayLocalizationZu();
  }

  throw FlutterError(
      'PayLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
