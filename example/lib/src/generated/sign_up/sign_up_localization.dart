// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'sign_up_localization_af.dart';
import 'sign_up_localization_am.dart';
import 'sign_up_localization_ar.dart';
import 'sign_up_localization_az.dart';
import 'sign_up_localization_be.dart';
import 'sign_up_localization_bg.dart';
import 'sign_up_localization_bn.dart';
import 'sign_up_localization_ca.dart';
import 'sign_up_localization_cs.dart';
import 'sign_up_localization_da.dart';
import 'sign_up_localization_de.dart';
import 'sign_up_localization_el.dart';
import 'sign_up_localization_en.dart';
import 'sign_up_localization_es.dart';
import 'sign_up_localization_fa.dart';
import 'sign_up_localization_fr.dart';
import 'sign_up_localization_gu.dart';
import 'sign_up_localization_he.dart';
import 'sign_up_localization_hi.dart';
import 'sign_up_localization_hu.dart';
import 'sign_up_localization_id.dart';
import 'sign_up_localization_it.dart';
import 'sign_up_localization_ja.dart';
import 'sign_up_localization_kk.dart';
import 'sign_up_localization_km.dart';
import 'sign_up_localization_kn.dart';
import 'sign_up_localization_ko.dart';
import 'sign_up_localization_lo.dart';
import 'sign_up_localization_ml.dart';
import 'sign_up_localization_mr.dart';
import 'sign_up_localization_ms.dart';
import 'sign_up_localization_my.dart';
import 'sign_up_localization_ne.dart';
import 'sign_up_localization_nl.dart';
import 'sign_up_localization_pa.dart';
import 'sign_up_localization_pl.dart';
import 'sign_up_localization_ps.dart';
import 'sign_up_localization_pt.dart';
import 'sign_up_localization_ro.dart';
import 'sign_up_localization_ru.dart';
import 'sign_up_localization_si.dart';
import 'sign_up_localization_sk.dart';
import 'sign_up_localization_sw.dart';
import 'sign_up_localization_ta.dart';
import 'sign_up_localization_te.dart';
import 'sign_up_localization_th.dart';
import 'sign_up_localization_tl.dart';
import 'sign_up_localization_tr.dart';
import 'sign_up_localization_uk.dart';
import 'sign_up_localization_ur.dart';
import 'sign_up_localization_uz.dart';
import 'sign_up_localization_vi.dart';
import 'sign_up_localization_zh.dart';
import 'sign_up_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of SignUpLocalization
/// returned by `SignUpLocalization.of(context)`.
///
/// Applications need to include `SignUpLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'sign_up/sign_up_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: SignUpLocalization.localizationsDelegates,
///   supportedLocales: SignUpLocalization.supportedLocales,
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
/// be consistent with the languages listed in the SignUpLocalization.supportedLocales
/// property.
abstract class SignUpLocalization {
  SignUpLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static SignUpLocalization of(BuildContext context) {
    return Localizations.of<SignUpLocalization>(context, SignUpLocalization)!;
  }

  static const LocalizationsDelegate<SignUpLocalization> delegate =
      _SignUpLocalizationDelegate();

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

  /// Надпись "логин"
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// Надпись "пароль"
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordEnterYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address, and we’ll send you a link to reset your password.'**
  String get forgotPasswordEnterYourEmailAddress;

  /// No description provided for @rememberYourPasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'Remember your password?'**
  String get rememberYourPasswordQuestion;

  /// No description provided for @backToLoginButton.
  ///
  /// In en, this message translates to:
  /// **'I have a password'**
  String get backToLoginButton;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @passwordResetEmailSentSnackBar.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent'**
  String get passwordResetEmailSentSnackBar;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordButton;

  /// No description provided for @confirmCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm code'**
  String get confirmCodeButton;

  /// No description provided for @startUsingDoctorinaTodaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start using Doctorina today'**
  String get startUsingDoctorinaTodaySubtitle;

  /// Разделитель ---ИЛИ--- между кнопками
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get orDivider;

  /// No description provided for @enterPasswordForEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPasswordForEmailHint;

  /// No description provided for @showPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPasswordHint;

  /// No description provided for @obscurePasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Obscure password'**
  String get obscurePasswordHint;

  /// No description provided for @clearLoginTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear login'**
  String get clearLoginTooltip;

  /// No description provided for @emailOrPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or phone'**
  String get emailOrPhoneLabel;

  /// No description provided for @emailOrPhoneLabelExample.
  ///
  /// In en, this message translates to:
  /// **'name@gmail.com or +1234567890'**
  String get emailOrPhoneLabelExample;

  /// No description provided for @emailOrPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email or phone number'**
  String get emailOrPhoneHint;

  /// No description provided for @pleaseAcceptTheAgreementsToContinueSnackBar.
  ///
  /// In en, this message translates to:
  /// **'Please accept the agreements to continue.'**
  String get pleaseAcceptTheAgreementsToContinueSnackBar;

  /// На конце запятая
  ///
  /// In en, this message translates to:
  /// **'I consent to the processing of personal data,'**
  String get consentToTheProcessingOfPersonalData;

  /// No description provided for @consentTheUseOf.
  ///
  /// In en, this message translates to:
  /// **'the use of'**
  String get consentTheUseOf;

  /// No description provided for @consentCookies.
  ///
  /// In en, this message translates to:
  /// **'cookies'**
  String get consentCookies;

  /// В начале запятая
  ///
  /// In en, this message translates to:
  /// **', agree to the'**
  String get consentAgreeToThe;

  /// No description provided for @consentTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'terms and conditions'**
  String get consentTermsAndConditions;

  /// В начале запятая
  ///
  /// In en, this message translates to:
  /// **', and acknowledge the '**
  String get consentAndAcknowledgeThe;

  /// No description provided for @consentPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get consentPrivacyPolicy;

  /// Точка на конце соглашения
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get consentDot;

  /// No description provided for @acknowledgeMyConsultation.
  ///
  /// In en, this message translates to:
  /// **'I acknowledge that my consultation is with an AI and not a licensed medical professional.'**
  String get acknowledgeMyConsultation;

  /// Диалог выхода, заголовок
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOutDialogTitle;

  /// Диалог выхода, текст
  ///
  /// In en, this message translates to:
  /// **'Are you sure to log out?'**
  String get logOutDialogContent;

  /// Диалог выхода, кнопка отмены
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get logOutDialogCancelButton;

  /// Диалог выхода, кнопка выйти
  ///
  /// In en, this message translates to:
  /// **'Yes, log out'**
  String get logOutDialogLogOutButton;

  /// Кнопка отправить код заного
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCodeButton;

  /// Таймер для повторной отправки кода
  ///
  /// In en, this message translates to:
  /// **'Resend code ({timer})'**
  String resendCodeTimer(String timer);

  /// Соглашение на обработку персональных данных.
  /// В тэгах <c> <t> <p> указаны кликабельные спаны, они должны присутсвовать во всех языках.
  ///
  /// In en, this message translates to:
  /// **'I consent to the processing of personal data, the use of <c>cookies</c>, agree to the <t>terms and conditions</t>, and acknowledge the <p>privacy policy</p>.'**
  String get consentFull;

  /// Email input field label.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailLabel;

  /// AppBar title for email signup overlay
  ///
  /// In en, this message translates to:
  /// **'Sign up with Email'**
  String get signUpWithEmailTitle;

  /// AppBar title for email login overlay
  ///
  /// In en, this message translates to:
  /// **'Log in with Email'**
  String get logInWithEmailTitle;

  /// Phone input field label
  ///
  /// In en, this message translates to:
  /// **'Enter your phone'**
  String get phoneLabel;

  /// AppBar title for phone confirmation screen
  ///
  /// In en, this message translates to:
  /// **'Confirm your phone'**
  String get confirmPhoneTitle;

  /// Standalone "Sign up" text for buttons and tabs
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpText;

  /// Short email hint text in login dialog
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get emailHintShort;

  /// Button text for Google sign up
  ///
  /// In en, this message translates to:
  /// **'Sign up with Google'**
  String get buttonTextSignUpWithGoogle;

  /// Button text for Apple login sign up
  ///
  /// In en, this message translates to:
  /// **'Sign up with Apple'**
  String get buttonTextSignUpWithApple;

  /// Button text for phone login sign up
  ///
  /// In en, this message translates to:
  /// **'Sign up with Phone'**
  String get buttonTextSignUpWithPhone;

  /// Button text for Google sign up
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get buttonTextLoginWithGoogle;

  /// Button text for Apple login sign up
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get buttonTextLoginWithApple;

  /// Button text for phone login sign up
  ///
  /// In en, this message translates to:
  /// **'Login with Phone'**
  String get buttonTextLoginWithPhone;

  /// Message displayed on logout screen
  ///
  /// In en, this message translates to:
  /// **'You are logged out'**
  String get youAreLoggedOutMessage;

  /// Reload button text on logout screen
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reloadButtonText;

  /// Error message for invalid email address
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get emailErrorText;

  /// Error message for password validation (minimum length)
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordErrorText;

  /// Error message for invalid phone number format
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number: {phoneNumber}'**
  String invalidPhoneNumberError(Object phoneNumber);

  /// Error message when trying to resend code too soon
  ///
  /// In en, this message translates to:
  /// **'Please wait {seconds} seconds before requesting a new code.'**
  String resendCodeWaitError(Object seconds);

  /// Error message for invalid phone verification code
  ///
  /// In en, this message translates to:
  /// **'Invalid phone code: {phoneCode}'**
  String invalidPhoneCodeError(Object phoneCode);

  /// Terms and conditions link text in login dialog
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get termsAndConditionsText;

  /// Btn to continue as guest on sign up screen
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuestBtn;

  /// Login tab: single line with inline link. &lt;p&gt;…&lt;/p&gt; is the tappable “Sign up” link.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account yet? <p>Sign up</p>'**
  String get noAccountYetPromptText;

  /// Sign up tab: single line with inline link. &lt;p&gt;…&lt;/p&gt; is the tappable “Log in” link.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? <p>Log in</p>'**
  String get alreadyHaveAccountPromptText;

  /// Subtitle for login dialog
  ///
  /// In en, this message translates to:
  /// **'You need to sign up before you can continue with Premium'**
  String get beforeSubscribeYouNeedSignUpLoginDialogSubtitle;

  /// Подзаголовок на экране входа, мотивирующий пользователя авторизоваться
  ///
  /// In en, this message translates to:
  /// **'Get personalized content and keep in touch with your community!'**
  String get loginSubtitle;

  /// Метка поля ввода email в форме
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get emailFieldLabel;

  /// Пример email в поле ввода
  ///
  /// In en, this message translates to:
  /// **'username@gmail.com'**
  String get emailPlaceholder;

  /// Тултип кнопки восстановления пароля когда email валиден
  ///
  /// In en, this message translates to:
  /// **'Recover your password'**
  String get recoverPasswordTooltip;

  /// Заголовок экрана регистрации
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccountTitle;

  /// Подзаголовок экрана регистрации, объясняет зачем нужен аккаунт
  ///
  /// In en, this message translates to:
  /// **'We need an account to securely save your health data and continue your assessment.'**
  String get createAccountSubtitle;

  /// Метка поля повторного ввода пароля
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeatLabel;

  /// Подсказка в поле повторного ввода пароля
  ///
  /// In en, this message translates to:
  /// **'Repeat your password'**
  String get repeatPasswordHint;

  /// Кнопка подтверждения регистрации с паролем
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// Текст перед ссылкой на регистрацию на экране входа
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountPrompt;

  /// Текст перед ссылкой на вход на экране регистрации
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccountPrompt;

  /// Заголовок шага создания пароля в хедере диалога
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get createPasswordHeader;

  /// Заголовок шага ввода телефона в хедере диалога
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneHeader;

  /// Заголовок шага верификации телефона в хедере диалога
  ///
  /// In en, this message translates to:
  /// **'Verify Phone'**
  String get verifyPhoneHeader;

  /// Заголовок экрана ввода номера телефона
  ///
  /// In en, this message translates to:
  /// **'What\'s your number?'**
  String get phoneTitle;

  /// Подзаголовок экрана ввода телефона
  ///
  /// In en, this message translates to:
  /// **'We\'ll text a code to verify your phone'**
  String get phoneSubtitle;

  /// Метка поля ввода номера телефона
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get phoneNumberLabel;

  /// Подсказка в поле ввода телефона
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// Пример номера телефона в поле ввода
  ///
  /// In en, this message translates to:
  /// **'+1 (201) 555-01-23'**
  String get phonePlaceholder;

  /// Текст кнопки во время ожидания повторной отправки OTP
  ///
  /// In en, this message translates to:
  /// **'Wait {countdown} seconds'**
  String waitCountdownButton(int countdown);

  /// Заголовок экрана ввода OTP кода
  ///
  /// In en, this message translates to:
  /// **'Enter your code'**
  String get enterCodeTitle;

  /// Текст с информацией куда отправлен код
  ///
  /// In en, this message translates to:
  /// **'We sent a code to {phone}'**
  String codeSentToPhone(String phone);

  /// Текст перед ссылкой на повторную отправку кода
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// Текст ссылки повторной отправки кода
  ///
  /// In en, this message translates to:
  /// **'Click to resend'**
  String get clickToResend;

  /// Текст с обратным отсчётом до возможности повторной отправки кода
  ///
  /// In en, this message translates to:
  /// **'You can request a new code in {countdown} seconds'**
  String requestNewCodeCountdown(int countdown);

  /// Тултип кнопки закрытия диалога
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeTooltip;

  /// Тултип кнопки назад
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backTooltip;

  /// Текст ссылки на условия использования в футере
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfServiceLink;

  /// Текст ссылки на политику конфиденциальности в футере
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyLink;

  /// Заголовок экрана приветствия при возвращении пользователя
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBackTitle;

  /// Подзаголовок экрана приветствия, предлагающий войти или зарегистрироваться
  ///
  /// In en, this message translates to:
  /// **'Log in if you already have a Doctorina account, or sign up to get started.'**
  String get welcomeBackSubtitle;

  /// Правило валидации пароля: длина от 8 до 128 символов
  ///
  /// In en, this message translates to:
  /// **'From 8 to 128 characters'**
  String get passwordRuleLength;

  /// Правило валидации пароля: минимум 1 цифра
  ///
  /// In en, this message translates to:
  /// **'At least 1 number'**
  String get passwordRuleNumber;

  /// Правило валидации пароля: минимум 1 заглавная буква
  ///
  /// In en, this message translates to:
  /// **'At least 1 uppercase letter'**
  String get passwordRuleUppercase;

  /// Правило валидации пароля: пароли совпадают
  ///
  /// In en, this message translates to:
  /// **'Passwords match'**
  String get passwordRuleMatch;

  /// No description provided for @phoneOtpVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed. Please try again.'**
  String get phoneOtpVerificationFailed;

  /// Заголовок поля ввода реферального кода на экране регистрации
  ///
  /// In en, this message translates to:
  /// **'Referral code'**
  String get referralCodeLabel;

  /// Подсказка (labelText) в поле ввода реферального кода
  ///
  /// In en, this message translates to:
  /// **'Enter your referral code'**
  String get enterReferralCodeHint;

  /// Пример реферального кода в поле ввода (hintText)
  ///
  /// In en, this message translates to:
  /// **'E.G. CREATOR2026'**
  String get referralCodeExampleHint;

  /// Ссылка-вопрос, раскрывающая поле ввода реферального кода
  ///
  /// In en, this message translates to:
  /// **'Have a referral code?'**
  String get haveReferralCodeQuestion;
}

class _SignUpLocalizationDelegate
    extends LocalizationsDelegate<SignUpLocalization> {
  const _SignUpLocalizationDelegate();

  @override
  Future<SignUpLocalization> load(Locale locale) {
    return SynchronousFuture<SignUpLocalization>(
        lookupSignUpLocalization(locale));
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
  bool shouldReload(_SignUpLocalizationDelegate old) => false;
}

SignUpLocalization lookupSignUpLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return SignUpLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return SignUpLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return SignUpLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return SignUpLocalizationZhCn();
          case 'HK':
            return SignUpLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return SignUpLocalizationAf();
    case 'am':
      return SignUpLocalizationAm();
    case 'ar':
      return SignUpLocalizationAr();
    case 'az':
      return SignUpLocalizationAz();
    case 'be':
      return SignUpLocalizationBe();
    case 'bg':
      return SignUpLocalizationBg();
    case 'bn':
      return SignUpLocalizationBn();
    case 'ca':
      return SignUpLocalizationCa();
    case 'cs':
      return SignUpLocalizationCs();
    case 'da':
      return SignUpLocalizationDa();
    case 'de':
      return SignUpLocalizationDe();
    case 'el':
      return SignUpLocalizationEl();
    case 'en':
      return SignUpLocalizationEn();
    case 'es':
      return SignUpLocalizationEs();
    case 'fa':
      return SignUpLocalizationFa();
    case 'fr':
      return SignUpLocalizationFr();
    case 'gu':
      return SignUpLocalizationGu();
    case 'he':
      return SignUpLocalizationHe();
    case 'hi':
      return SignUpLocalizationHi();
    case 'hu':
      return SignUpLocalizationHu();
    case 'id':
      return SignUpLocalizationId();
    case 'it':
      return SignUpLocalizationIt();
    case 'ja':
      return SignUpLocalizationJa();
    case 'kk':
      return SignUpLocalizationKk();
    case 'km':
      return SignUpLocalizationKm();
    case 'kn':
      return SignUpLocalizationKn();
    case 'ko':
      return SignUpLocalizationKo();
    case 'lo':
      return SignUpLocalizationLo();
    case 'ml':
      return SignUpLocalizationMl();
    case 'mr':
      return SignUpLocalizationMr();
    case 'ms':
      return SignUpLocalizationMs();
    case 'my':
      return SignUpLocalizationMy();
    case 'ne':
      return SignUpLocalizationNe();
    case 'nl':
      return SignUpLocalizationNl();
    case 'pa':
      return SignUpLocalizationPa();
    case 'pl':
      return SignUpLocalizationPl();
    case 'ps':
      return SignUpLocalizationPs();
    case 'pt':
      return SignUpLocalizationPt();
    case 'ro':
      return SignUpLocalizationRo();
    case 'ru':
      return SignUpLocalizationRu();
    case 'si':
      return SignUpLocalizationSi();
    case 'sk':
      return SignUpLocalizationSk();
    case 'sw':
      return SignUpLocalizationSw();
    case 'ta':
      return SignUpLocalizationTa();
    case 'te':
      return SignUpLocalizationTe();
    case 'th':
      return SignUpLocalizationTh();
    case 'tl':
      return SignUpLocalizationTl();
    case 'tr':
      return SignUpLocalizationTr();
    case 'uk':
      return SignUpLocalizationUk();
    case 'ur':
      return SignUpLocalizationUr();
    case 'uz':
      return SignUpLocalizationUz();
    case 'vi':
      return SignUpLocalizationVi();
    case 'zh':
      return SignUpLocalizationZh();
    case 'zu':
      return SignUpLocalizationZu();
  }

  throw FlutterError(
      'SignUpLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
