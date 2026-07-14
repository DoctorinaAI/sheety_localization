// This file is generated, do not edit it manually!
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'onboarding_localization_af.dart';
import 'onboarding_localization_am.dart';
import 'onboarding_localization_ar.dart';
import 'onboarding_localization_az.dart';
import 'onboarding_localization_be.dart';
import 'onboarding_localization_bg.dart';
import 'onboarding_localization_bn.dart';
import 'onboarding_localization_ca.dart';
import 'onboarding_localization_cs.dart';
import 'onboarding_localization_da.dart';
import 'onboarding_localization_de.dart';
import 'onboarding_localization_el.dart';
import 'onboarding_localization_en.dart';
import 'onboarding_localization_es.dart';
import 'onboarding_localization_fa.dart';
import 'onboarding_localization_fr.dart';
import 'onboarding_localization_gu.dart';
import 'onboarding_localization_he.dart';
import 'onboarding_localization_hi.dart';
import 'onboarding_localization_hu.dart';
import 'onboarding_localization_id.dart';
import 'onboarding_localization_it.dart';
import 'onboarding_localization_ja.dart';
import 'onboarding_localization_kk.dart';
import 'onboarding_localization_km.dart';
import 'onboarding_localization_kn.dart';
import 'onboarding_localization_ko.dart';
import 'onboarding_localization_lo.dart';
import 'onboarding_localization_ml.dart';
import 'onboarding_localization_mr.dart';
import 'onboarding_localization_ms.dart';
import 'onboarding_localization_my.dart';
import 'onboarding_localization_ne.dart';
import 'onboarding_localization_nl.dart';
import 'onboarding_localization_pa.dart';
import 'onboarding_localization_pl.dart';
import 'onboarding_localization_ps.dart';
import 'onboarding_localization_pt.dart';
import 'onboarding_localization_ro.dart';
import 'onboarding_localization_ru.dart';
import 'onboarding_localization_si.dart';
import 'onboarding_localization_sk.dart';
import 'onboarding_localization_sw.dart';
import 'onboarding_localization_ta.dart';
import 'onboarding_localization_te.dart';
import 'onboarding_localization_th.dart';
import 'onboarding_localization_tl.dart';
import 'onboarding_localization_tr.dart';
import 'onboarding_localization_uk.dart';
import 'onboarding_localization_ur.dart';
import 'onboarding_localization_uz.dart';
import 'onboarding_localization_vi.dart';
import 'onboarding_localization_zh.dart';
import 'onboarding_localization_zu.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of OnboardingLocalization
/// returned by `OnboardingLocalization.of(context)`.
///
/// Applications need to include `OnboardingLocalization.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'onboarding/onboarding_localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: OnboardingLocalization.localizationsDelegates,
///   supportedLocales: OnboardingLocalization.supportedLocales,
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
/// be consistent with the languages listed in the OnboardingLocalization.supportedLocales
/// property.
abstract class OnboardingLocalization {
  OnboardingLocalization(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static OnboardingLocalization of(BuildContext context) {
    return Localizations.of<OnboardingLocalization>(
        context, OnboardingLocalization)!;
  }

  static const LocalizationsDelegate<OnboardingLocalization> delegate =
      _OnboardingLocalizationDelegate();

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

  /// Brand name displayed under the logo on the welcome screen
  ///
  /// In en, this message translates to:
  /// **'doctorina'**
  String get appNameLogo;

  /// Short tagline describing the product category
  ///
  /// In en, this message translates to:
  /// **'ADVANCED AI HEALTH ASSISTANT'**
  String get welcomeTagline;

  /// Main headline welcoming the user
  ///
  /// In en, this message translates to:
  /// **'Welcome\nto Doctorina!'**
  String get welcomeScreenTitle;

  /// Social proof header with highlighted user count
  /// New line should be preserved. 48K+
  ///
  /// In en, this message translates to:
  /// **'Trusted by\n<green>48K+ Users</green>'**
  String get socialProofTrustedBy;

  /// Short paragraph explaining the value proposition of the app
  ///
  /// In en, this message translates to:
  /// **'Designed to analyze symptoms the way experienced clinicians do —  by understanding patterns, timing, and context.'**
  String get welcomeDescription;

  /// Primary call-to-action button to begin onboarding
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStartedBtn;

  /// Secondary text prompting existing users to sign in with tappable login action
  ///
  /// In en, this message translates to:
  /// **'Already have an account? <link>Log In</link>'**
  String get alreadyHaveAccount;

  /// Legal consent text with tappable Terms of Service and Privacy Policy
  /// New line should be preserved
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our\n<termsOfService>Terms of Service</termsOfService> | <privacyPolicy>Privacy Policy</privacyPolicy>'**
  String get termsConsent;

  /// Headline prompting the user to start personalization with highlighted brand name
  ///
  /// In en, this message translates to:
  /// **'Let\'s personalize\n<brand>Doctorina</brand> for you'**
  String get personalizationInterruptionTitle;

  /// Small section label indicating personalization flow
  ///
  /// In en, this message translates to:
  /// **'PERSONALIZATION'**
  String get personalizationSectionLabel;

  /// Question asking why the user opened the app
  ///
  /// In en, this message translates to:
  /// **'What brings you here today?'**
  String get personalizationReasonTitle;

  /// Option indicating the user currently has symptoms
  ///
  /// In en, this message translates to:
  /// **'I\'m experiencing symptoms now'**
  String get personalizationReasonSymptomsNow;

  /// Option indicating the user wants to understand a health change
  ///
  /// In en, this message translates to:
  /// **'I want to understand a health change'**
  String get personalizationReasonUnderstandChange;

  /// Option indicating the user wants to rule out serious issues
  ///
  /// In en, this message translates to:
  /// **'I want to rule out something serious'**
  String get personalizationReasonRuleOutSerious;

  /// Option indicating proactive health monitoring
  ///
  /// In en, this message translates to:
  /// **'I\'m monitoring my health proactively'**
  String get personalizationReasonMonitoring;

  /// Primary button to proceed to next step
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// Introductory empathy statement about health uncertainty
  ///
  /// In en, this message translates to:
  /// **'When something changes in your health, knowing what matters is hardest.'**
  String get captionEmpathyText;

  /// Statement explaining Doctorina's analytical approach with emphasized phrase
  ///
  /// In en, this message translates to:
  /// **'<em>Doctorina focuses on symptom patterns and timing</em> — the same signals clinicians look for early on.'**
  String get captionDifferentiatorText;

  /// Question asking the user to select gender
  ///
  /// In en, this message translates to:
  /// **'Select your gender'**
  String get genderTitle;

  /// Supporting text explaining why gender data is used
  ///
  /// In en, this message translates to:
  /// **'This helps us interpret symptoms and give recommendations more accurately.'**
  String get genderSubtitle;

  /// Gender selection option male
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// Gender selection option female
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// Gender selection option prefer not to disclose
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get genderPreferNotSay;

  /// Question asking the user's age
  ///
  /// In en, this message translates to:
  /// **'What is your age?'**
  String get ageTitle;

  /// Supporting explanation for age usage
  ///
  /// In en, this message translates to:
  /// **'Age helps us evaluate health patterns more accurately.'**
  String get ageSubtitle;

  /// Social proof headline with emphasized number
  /// New line should be preserved
  ///
  /// In en, this message translates to:
  /// **'<green>Over 48k+ people</green>\nhave chosen Doctorina'**
  String get socialProofLargeTitle;

  /// Small note describing data source
  ///
  /// In en, this message translates to:
  /// **'*Based on Doctorina user base statistics'**
  String get socialProofDisclaimer;

  /// Badge text indicating medical expertise
  /// New line should be preserved
  ///
  /// In en, this message translates to:
  /// **'Developed by\n<b>Doctors</b>'**
  String get developedByDoctors;

  /// Progress indicator showing current quiz step
  ///
  /// In en, this message translates to:
  /// **'STEP 1/6'**
  String get quizStepLabel1;

  /// Question about overall health situation
  ///
  /// In en, this message translates to:
  /// **'How would you describe your current health situation?'**
  String get quizHealthSituationTitle;

  /// Option indicating no major health concerns
  ///
  /// In en, this message translates to:
  /// **'I generally feel healthy'**
  String get quizHealthHealthy;

  /// Option indicating minor ongoing issues
  ///
  /// In en, this message translates to:
  /// **'I have ongoing minor concerns'**
  String get quizHealthMinorConcerns;

  /// Option indicating an existing diagnosed condition
  ///
  /// In en, this message translates to:
  /// **'I\'m managing a known condition'**
  String get quizHealthKnownCondition;

  /// Option indicating unresolved issue
  ///
  /// In en, this message translates to:
  /// **'I\'m dealing with something unresolved'**
  String get quizHealthUnresolved;

  /// Progress indicator showing second quiz step
  ///
  /// In en, this message translates to:
  /// **'STEP 2/6'**
  String get quizStepLabel2;

  /// Question about frequency of doctor visits
  ///
  /// In en, this message translates to:
  /// **'How often do you usually see a doctor?'**
  String get quizDoctorVisitFrequencyTitle;

  /// Option indicating regular checkups
  ///
  /// In en, this message translates to:
  /// **'Regularly (checkups / follow-ups)'**
  String get quizDoctorVisitRegular;

  /// Option indicating occasional visits
  ///
  /// In en, this message translates to:
  /// **'Occasionally, when something wrong'**
  String get quizDoctorVisitOccasional;

  /// Option indicating rare visits
  ///
  /// In en, this message translates to:
  /// **'Rarely, only if necessary'**
  String get quizDoctorVisitRare;

  /// Пользователь говорит, что не любит ходить к врачам и старается
  ///  лишний раз не обращаться к доктору. Итоговая фраза должна быть
  ///  понятной и отражать это поведение, например:
  /// «Вы не любите обращаться к врачам»
  ///
  /// In en, this message translates to:
  /// **'Avoid visiting doctors'**
  String get quizDoctorVisitAvoid;

  /// Option indicating never visited
  ///
  /// In en, this message translates to:
  /// **'I\'ve never visited a doctor'**
  String get quizDoctorVisitNever;

  /// Progress indicator showing third quiz step
  ///
  /// In en, this message translates to:
  /// **'STEP 3/6'**
  String get quizStepLabel3;

  /// Question about healthcare challenges
  ///
  /// In en, this message translates to:
  /// **'What\'s been your biggest challenge with healthcare so far?'**
  String get quizBiggestChallengeTitle;

  /// Helper text indicating multiple selection allowed
  ///
  /// In en, this message translates to:
  /// **'Choose as many as you like'**
  String get quizMultiSelectHint;

  /// Option indicating long appointment wait times
  ///
  /// In en, this message translates to:
  /// **'Long wait times for appointments'**
  String get quizChallengeLongWait;

  /// Option indicating short or rushed visits
  ///
  /// In en, this message translates to:
  /// **'Visits feel rushed'**
  String get quizChallengeRushedVisits;

  /// Option indicating cost or pricing clarity issues
  ///
  /// In en, this message translates to:
  /// **'High cost or unclear pricing'**
  String get quizChallengeCost;

  /// Option indicating difficulty explaining symptoms
  ///
  /// In en, this message translates to:
  /// **'Hard to explain everything clearly'**
  String get quizChallengeHardExplain;

  /// Option indicating conflicting medical opinions
  ///
  /// In en, this message translates to:
  /// **'Conflicting opinions or advice'**
  String get quizChallengeConflictingAdvice;

  /// Option indicating no major issues
  ///
  /// In en, this message translates to:
  /// **'No major issues'**
  String get quizChallengeNone;

  /// Progress indicator showing fourth quiz step
  ///
  /// In en, this message translates to:
  /// **'STEP 4/6'**
  String get quizStepLabel4;

  /// Question about clarity after doctor appointments
  ///
  /// In en, this message translates to:
  /// **'After appointments, how confident do you feel about what you were told?'**
  String get quizConfidenceAfterAppointmentTitle;

  /// Helper note clarifying subjective nature
  ///
  /// In en, this message translates to:
  /// **'There\'s no right or wrong answer.'**
  String get quizConfidenceNoRightAnswer;

  /// Option indicating full understanding
  ///
  /// In en, this message translates to:
  /// **'Very clear about what\'s going on'**
  String get quizConfidenceVeryClear;

  /// Option indicating partial clarity
  ///
  /// In en, this message translates to:
  /// **'Somewhat clear'**
  String get quizConfidenceSomewhatClear;

  /// Option indicating ongoing uncertainty
  ///
  /// In en, this message translates to:
  /// **'Still uncertain'**
  String get quizConfidenceStillUncertain;

  /// Option indicating increased confusion
  ///
  /// In en, this message translates to:
  /// **'More confused than before'**
  String get quizConfidenceMoreConfused;

  /// Образовательная подпись, подчеркивающая развитие симптомов.
  ///  Подпись должна объяснять, что многие люди сталкиваются с трудностями
  ///  не сразу после постановки диагноза, а когда симптомы меняются со временем.
  ///
  /// In en, this message translates to:
  /// **'Many <green>people struggle not after diagnosis</green> but when symptoms change over time.'**
  String get captionDiagnosisVsChange;

  /// Progress indicator showing fifth quiz step
  ///
  /// In en, this message translates to:
  /// **'STEP 5/6'**
  String get quizStepLabel5;

  /// Question about how well concerns are addressed
  ///
  /// In en, this message translates to:
  /// **'How well do you feel your concerns are usually addressed?'**
  String get quizConcernsAddressedTitle;

  /// Clarifies answers are subjective
  ///
  /// In en, this message translates to:
  /// **'Based on your subjective feelings'**
  String get quizConcernsAddressedSubtitle;

  /// Option indicating strong satisfaction
  ///
  /// In en, this message translates to:
  /// **'Very well'**
  String get quizConcernsVeryWell;

  /// Option indicating moderate satisfaction
  ///
  /// In en, this message translates to:
  /// **'Fairly well'**
  String get quizConcernsFairlyWell;

  /// Option indicating low satisfaction
  ///
  /// In en, this message translates to:
  /// **'Not very well'**
  String get quizConcernsNotVeryWell;

  /// Option indicating inconsistent experience
  ///
  /// In en, this message translates to:
  /// **'It varies a lot'**
  String get quizConcernsVaries;

  /// Progress indicator showing sixth quiz step
  ///
  /// In en, this message translates to:
  /// **'STEP 6/6'**
  String get quizStepLabel6;

  /// Question about pre-visit self-research behavior
  ///
  /// In en, this message translates to:
  /// **'Before seeing a doctor, do you usually try to make sense of symptoms yourself?'**
  String get quizSelfResearchTitle;

  /// Option indicating proactive research
  ///
  /// In en, this message translates to:
  /// **'Yes, I research and track things'**
  String get quizSelfResearchYes;

  /// Option indicating occasional research
  ///
  /// In en, this message translates to:
  /// **'Sometimes'**
  String get quizSelfResearchSometimes;

  /// Option indicating rare research
  ///
  /// In en, this message translates to:
  /// **'Rarely'**
  String get quizSelfResearchRarely;

  /// Option indicating full reliance on professionals
  ///
  /// In en, this message translates to:
  /// **'No, I rely entirely on professionals'**
  String get quizSelfResearchNo;

  /// Statement about healthcare accessibility with highlighted phrase
  ///
  /// In en, this message translates to:
  /// **'Health questions <green>don\'t follow</green> office hours.'**
  String get captionAvailabilityTitle;

  /// Statement about continuous availability
  ///
  /// In en, this message translates to:
  /// **'Doctorina is <green>available 24/7.</green>'**
  String get captionAvailabilitySupport;

  /// Supporting line reinforcing immediate clarity
  ///
  /// In en, this message translates to:
  /// **'Clarity shouldn\'t have to wait for the next appointment.'**
  String get captionAvailabilityDescription;

  /// Question asking about permission for notifications
  ///
  /// In en, this message translates to:
  /// **'Do you want us to check in on your health symptoms?'**
  String get notificationTitle;

  /// Explanation about why better to enable notification
  ///
  /// In en, this message translates to:
  /// **'AI can monitor your symptoms and alert you if something may need attention'**
  String get notificationDescription;

  /// Option indicating yes to all notifications
  ///
  /// In en, this message translates to:
  /// **'Yes — keep an eye on my health'**
  String get notificationYes;

  /// Option indicating yes only for important notification
  ///
  /// In en, this message translates to:
  /// **'Yes — only if something important changes'**
  String get notificationOnlyImportant;

  /// Option indicating user don't want to enable notification now
  ///
  /// In en, this message translates to:
  /// **'Not sure yet'**
  String get notificationNo;

  /// Question asking whether a doctor recommended Doctorina
  ///
  /// In en, this message translates to:
  /// **'Did you hear about Doctorina from a doctor?'**
  String get referralSourceTitle;

  /// Yes option
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get referralSourceYes;

  /// No option
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get referralSourceNo;

  /// Small label indicating analysis phase
  ///
  /// In en, this message translates to:
  /// **'ANALYZING YOUR RESULTS'**
  String get processingSectionLabel;

  /// Title on the results processing screen
  ///
  /// In en, this message translates to:
  /// **'Personalizing your experience'**
  String get processingTitle;

  /// Progress percentage value during processing
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String processingPercentValue(int percent);

  /// Main paywall headline with highlighted product tier
  ///
  /// In en, this message translates to:
  /// **'Unlimited experience with <brand>Doctorina Pro</brand>'**
  String get paywallHeadline;

  /// Supporting tagline under logo
  ///
  /// In en, this message translates to:
  /// **'YOUR ASSISTANT WHO IS ALWAYS NEARBY'**
  String get paywallAssistantTagline;

  /// Toggle label offering free trial
  ///
  /// In en, this message translates to:
  /// **'Not sure yet? Enable free trial.'**
  String get paywallEnableTrialToggle;

  /// Yearly subscription plan title
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get paywallPlanYear;

  /// Monthly subscription plan title
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get paywallPlanMonthly;

  /// Weekly subscription plan title
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get paywallPlanWeek;

  /// Daily subscription plan title
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get paywallPlanDaily;

  /// Yearly subscription price with weekly equivalent
  ///
  /// In en, this message translates to:
  /// **'\$39.99 (only \$3.34/week)'**
  String get paywallPlanYearPrice;

  /// Weekly subscription price
  ///
  /// In en, this message translates to:
  /// **'\$3.99'**
  String get paywallPlanWeekPrice;

  /// Discount badge label
  ///
  /// In en, this message translates to:
  /// **'SAVE 58%'**
  String get paywallSaveBadge;

  /// Continue purchase without trial
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get paywallContinueBtn;

  /// Start free trial CTA
  ///
  /// In en, this message translates to:
  /// **'Start Free-trial'**
  String get paywallStartTrialBtn;

  /// Legal renewal disclaimer
  ///
  /// In en, this message translates to:
  /// **'Subscription is auto-renewable. Cancel anytime'**
  String get paywallSubscriptionDisclaimer;

  /// Links to legal documents
  ///
  /// In en, this message translates to:
  /// **'<termsOfService>Terms of Service</termsOfService> | <privacyPolicy>Privacy Policy</privacyPolicy>'**
  String get paywallTermsPrivacy;

  /// Week, in context per week, e.g. "$3,99/week"
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get paywallPerWeek;

  /// Section label on the results processing screen
  ///
  /// In en, this message translates to:
  /// **'Analyzing your results'**
  String get processingLabel;

  /// Tooltip for the paywall close button
  ///
  /// In en, this message translates to:
  /// **'Close onboarding'**
  String get paywallCloseTooltip;

  /// Tooltip for the restore purchases button
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get paywallRestoreTooltip;

  /// Restore purchases button text
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get paywallRestoreBtn;

  /// Message when no active subscription found to restore
  ///
  /// In en, this message translates to:
  /// **'No active subscription found to restore.'**
  String get paywallRestoreNoneFound;

  /// Error message when restore purchases fails
  ///
  /// In en, this message translates to:
  /// **'Failed to restore purchases. Please try again later.'**
  String get paywallRestoreError;

  /// Error message when subscription purchase fails
  ///
  /// In en, this message translates to:
  /// **'Failed to complete the purchase. Please try again later.'**
  String get paywallPurchaseError;

  /// Заголовок 1-го шага в таймлайне триала на пейволле v2 (доступ открывается сегодня)
  ///
  /// In en, this message translates to:
  /// **'Today: Get instant access'**
  String get paywallTrialStep1Title;

  /// Описание 1-го шага таймлайна триала на пейволле v2
  ///
  /// In en, this message translates to:
  /// **'Unlock full access, get AI health answers, anytime.'**
  String get paywallTrialStep1Description;

  /// Заголовок 2-го шага таймлайна триала (напоминание о завершении триала)
  ///
  /// In en, this message translates to:
  /// **'Day 2: Trial reminder'**
  String get paywallTrialStep2Title;

  /// Описание 2-го шага таймлайна триала на пейволле v2
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a reminder that your trial is about to end'**
  String get paywallTrialStep2Description;

  /// Заголовок 3-го шага таймлайна триала (списание после окончания триала)
  ///
  /// In en, this message translates to:
  /// **'Day 3: Renewal'**
  String get paywallTrialStep3Title;

  /// Описание 3-го шага таймлайна с датой ближайшего списания
  ///
  /// In en, this message translates to:
  /// **'You\'ll be charged on {date}, cancel anytime before.'**
  String paywallTrialStep3Description(String date);

  /// Заголовок таблицы с фичами Free/Pro на пейволле v2
  ///
  /// In en, this message translates to:
  /// **'WHAT\'S INCLUDED'**
  String get paywallBenefitsHeader;

  /// Бейдж колонки "Free" в таблице фич на пейволле v2
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get paywallBenefitsBadgeFree;

  /// Бейдж колонки "Pro" в таблице фич на пейволле v2
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get paywallBenefitsBadgePro;

  /// Пункт списка фич на пейволле v2 — приватность и безопасность
  ///
  /// In en, this message translates to:
  /// **'Private and secure'**
  String get paywallBenefitPrivateSecure;

  /// Пункт списка фич на пейволле v2 — AI-ассистент 24/7
  ///
  /// In en, this message translates to:
  /// **'AI assistant, 24/7'**
  String get paywallBenefitAiAssistant;

  /// Пункт списка фич на пейволле v2 — мгновенные ответы
  ///
  /// In en, this message translates to:
  /// **'Instant health answers'**
  String get paywallBenefitInstantAnswers;

  /// Пункт списка фич на пейволле v2 — научно обоснованные инсайты
  ///
  /// In en, this message translates to:
  /// **'Clear, science-based insights'**
  String get paywallBenefitScienceInsights;

  /// Пункт списка фич на пейволле v2 — автоматические резюме консультаций
  ///
  /// In en, this message translates to:
  /// **'Auto conversation summaries'**
  String get paywallBenefitAutoSummaries;

  /// Пункт списка фич на пейволле v2 — поддержка любого языка
  ///
  /// In en, this message translates to:
  /// **'Any language, anytime'**
  String get paywallBenefitAnyLanguage;

  /// Подпись "per week" под ценой подписки в плитке выбора плана на пейволле v2
  ///
  /// In en, this message translates to:
  /// **'per week'**
  String get paywallPriceUnitPerWeek;

  /// Заголовок шита одноразового оффера после онбординга. Для языков русского, белорусского, украинского - слово "одноразовый" применимо к поссуде, а не к предложению. One time offer лучше перевести как "Разовое предложение"
  ///
  /// In en, this message translates to:
  /// **'One time offer'**
  String get paywallOfferTitle;

  /// Процент скидки на белой карточке шита одноразового оффера
  ///
  /// In en, this message translates to:
  /// **'{percent}% OFF'**
  String paywallOfferDiscountPercent(int percent);

  /// Подпись "FOREVER" под процентом скидки.  Для языков русского, белорусского, украинского - слово FOREVER лучше перевести  как "НАВСЕГДА" (не так пафосно , как "навечно")
  ///
  /// In en, this message translates to:
  /// **'FOREVER'**
  String get paywallOfferForeverBadge;

  /// Дисклеймер о том, что предложение исчезнет после закрытия шита. лучше на русский/белорусский и украинский переводить по смыслу так: "У вас только один шанс воспользоваться этим предложением"
  ///
  /// In en, this message translates to:
  /// **'Once you close your one-time offer, it\'s gone!'**
  String get paywallOfferDisclaimer;

  /// Цена за месяц для годовой подписки на карточке одноразового оффера
  ///
  /// In en, this message translates to:
  /// **'{price}/mo'**
  String paywallOfferPricePerMonth(String price);

  /// Бейдж "LOWEST PRICE EVER" над карточкой годовой подписки. лучше на русский/белорусский и украинский переводить по смыслу так: "САМАЯ НИЗКАЯ ЦЕНА"
  ///
  /// In en, this message translates to:
  /// **'LOWEST PRICE EVER'**
  String get paywallOfferLowestPriceBadge;

  /// Подпись "Cancel anytime" между карточкой подписки и CTA. "Отмена в любой момент" - хороший ориентир для перевода на русский, украинский и белорусский
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime'**
  String get paywallOfferCancelAnytime;

  /// CTA-кнопка для активации одноразового оффера. "Получить предложение" -  хороший ориентир для перевода на русский, украинский и белорусский
  ///
  /// In en, this message translates to:
  /// **'Claim your offer'**
  String get paywallOfferClaimButton;

  /// Футер шита одноразового оффера — текст про автопродление подписки
  ///
  /// In en, this message translates to:
  /// **'Auto-renewable subscription'**
  String get paywallOfferAutoRenewable;

  /// Заголовок шита подарка перед одноразовым оффером
  ///
  /// In en, this message translates to:
  /// **'Special gift inside'**
  String get paywallGiftBoxTitle;

  /// Подзаголовок шита подарка с приглашением открыть оффер. "Нажмите, чтобы открыть специальное предложение" -  хороший ориентир для перевода на русский, украинский и белорусский
  ///
  /// In en, this message translates to:
  /// **'One tap to reveal your special offer'**
  String get paywallGiftBoxSubtitle;

  /// CTA-кнопка для открытия шита подарка. "Открыть" -  хороший ориентир для перевода на русский, украинский и белорусский
  ///
  /// In en, this message translates to:
  /// **'Open now'**
  String get paywallGiftBoxOpenButton;

  /// Тост-ошибка при неудачной повторной загрузке цен подписок на пейволле
  ///
  /// In en, this message translates to:
  /// **'Failed to load subscription options. Please try again later.'**
  String get paywallRetryLoadPricesError;

  /// Заголовок фолбэка на пейволле, когда RevenueCat не отдал цены подписок
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load subscription prices'**
  String get paywallPricesUnavailableTitle;

  /// Подзаголовок фолбэка на пейволле с просьбой проверить соединение и повторить
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get paywallPricesUnavailableMessage;

  /// Текст кнопки повторной загрузки цен в фолбэке пейволла
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get paywallPricesUnavailableRetryButton;

  /// Кнопка для пропуска онбординга, должна быть записана емко и кратко. Например: "Пр-ть"
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipOnboardingButton;
}

class _OnboardingLocalizationDelegate
    extends LocalizationsDelegate<OnboardingLocalization> {
  const _OnboardingLocalizationDelegate();

  @override
  Future<OnboardingLocalization> load(Locale locale) {
    return SynchronousFuture<OnboardingLocalization>(
        lookupOnboardingLocalization(locale));
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
  bool shouldReload(_OnboardingLocalizationDelegate old) => false;
}

OnboardingLocalization lookupOnboardingLocalization(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'ar':
      {
        switch (locale.countryCode) {
          case 'EG':
            return OnboardingLocalizationArEg();
        }
        break;
      }
    case 'pa':
      {
        switch (locale.countryCode) {
          case 'PK':
            return OnboardingLocalizationPaPk();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return OnboardingLocalizationPtBr();
        }
        break;
      }
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return OnboardingLocalizationZhCn();
          case 'HK':
            return OnboardingLocalizationZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return OnboardingLocalizationAf();
    case 'am':
      return OnboardingLocalizationAm();
    case 'ar':
      return OnboardingLocalizationAr();
    case 'az':
      return OnboardingLocalizationAz();
    case 'be':
      return OnboardingLocalizationBe();
    case 'bg':
      return OnboardingLocalizationBg();
    case 'bn':
      return OnboardingLocalizationBn();
    case 'ca':
      return OnboardingLocalizationCa();
    case 'cs':
      return OnboardingLocalizationCs();
    case 'da':
      return OnboardingLocalizationDa();
    case 'de':
      return OnboardingLocalizationDe();
    case 'el':
      return OnboardingLocalizationEl();
    case 'en':
      return OnboardingLocalizationEn();
    case 'es':
      return OnboardingLocalizationEs();
    case 'fa':
      return OnboardingLocalizationFa();
    case 'fr':
      return OnboardingLocalizationFr();
    case 'gu':
      return OnboardingLocalizationGu();
    case 'he':
      return OnboardingLocalizationHe();
    case 'hi':
      return OnboardingLocalizationHi();
    case 'hu':
      return OnboardingLocalizationHu();
    case 'id':
      return OnboardingLocalizationId();
    case 'it':
      return OnboardingLocalizationIt();
    case 'ja':
      return OnboardingLocalizationJa();
    case 'kk':
      return OnboardingLocalizationKk();
    case 'km':
      return OnboardingLocalizationKm();
    case 'kn':
      return OnboardingLocalizationKn();
    case 'ko':
      return OnboardingLocalizationKo();
    case 'lo':
      return OnboardingLocalizationLo();
    case 'ml':
      return OnboardingLocalizationMl();
    case 'mr':
      return OnboardingLocalizationMr();
    case 'ms':
      return OnboardingLocalizationMs();
    case 'my':
      return OnboardingLocalizationMy();
    case 'ne':
      return OnboardingLocalizationNe();
    case 'nl':
      return OnboardingLocalizationNl();
    case 'pa':
      return OnboardingLocalizationPa();
    case 'pl':
      return OnboardingLocalizationPl();
    case 'ps':
      return OnboardingLocalizationPs();
    case 'pt':
      return OnboardingLocalizationPt();
    case 'ro':
      return OnboardingLocalizationRo();
    case 'ru':
      return OnboardingLocalizationRu();
    case 'si':
      return OnboardingLocalizationSi();
    case 'sk':
      return OnboardingLocalizationSk();
    case 'sw':
      return OnboardingLocalizationSw();
    case 'ta':
      return OnboardingLocalizationTa();
    case 'te':
      return OnboardingLocalizationTe();
    case 'th':
      return OnboardingLocalizationTh();
    case 'tl':
      return OnboardingLocalizationTl();
    case 'tr':
      return OnboardingLocalizationTr();
    case 'uk':
      return OnboardingLocalizationUk();
    case 'ur':
      return OnboardingLocalizationUr();
    case 'uz':
      return OnboardingLocalizationUz();
    case 'vi':
      return OnboardingLocalizationVi();
    case 'zh':
      return OnboardingLocalizationZh();
    case 'zu':
      return OnboardingLocalizationZu();
  }

  throw FlutterError(
      'OnboardingLocalization.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
