import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'C4E Rewards'**
  String get appName;

  /// No description provided for @loginLabel.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLabel;

  /// No description provided for @newMemberSignUpLabel.
  ///
  /// In en, this message translates to:
  /// **'New member signup'**
  String get newMemberSignUpLabel;

  /// No description provided for @signUpLabel.
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signUpLabel;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLabel;

  /// No description provided for @searchAgainLabel.
  ///
  /// In en, this message translates to:
  /// **'Search again'**
  String get searchAgainLabel;

  /// No description provided for @existingMemberSignUpLabel.
  ///
  /// In en, this message translates to:
  /// **'Existing member signup'**
  String get existingMemberSignUpLabel;

  /// No description provided for @forgetPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Forget password'**
  String get forgetPasswordLabel;

  /// No description provided for @nextLabel.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextLabel;

  /// No description provided for @forgetPwParagraph.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number and we will send otp to reset your password'**
  String get forgetPwParagraph;

  /// No description provided for @verificationLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationLabel;

  /// No description provided for @verifySmsSentLabel.
  ///
  /// In en, this message translates to:
  /// **'We sent verification code to {phone}'**
  String verifySmsSentLabel(String phone);

  /// No description provided for @otpExpireLabel.
  ///
  /// In en, this message translates to:
  /// **'This code will expiredd in '**
  String get otpExpireLabel;

  /// No description provided for @secondsLabel.
  ///
  /// In en, this message translates to:
  /// **' seconds'**
  String get secondsLabel;

  /// No description provided for @otpTimeoutLabel.
  ///
  /// In en, this message translates to:
  /// **'OTP time out'**
  String get otpTimeoutLabel;

  /// No description provided for @orLabel.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orLabel;

  /// No description provided for @resetPasswordsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordsLabel;

  /// No description provided for @somethinWrongLabel.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethinWrongLabel;

  /// No description provided for @retryLabel.
  ///
  /// In en, this message translates to:
  /// **'retry'**
  String get retryLabel;

  /// No description provided for @openBarcodeScanner.
  ///
  /// In en, this message translates to:
  /// **'Open Scanner'**
  String get openBarcodeScanner;

  /// No description provided for @closeBarcodeScannerLabel.
  ///
  /// In en, this message translates to:
  /// **'slide down to close'**
  String get closeBarcodeScannerLabel;

  /// No description provided for @barcodeIntroLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan product\'s barcode \n and view product\'s detail.'**
  String get barcodeIntroLabel;

  /// No description provided for @collectRewardsLabel.
  ///
  /// In en, this message translates to:
  /// **'Collects Rewards'**
  String get collectRewardsLabel;

  /// No description provided for @qrToExpireLabel.
  ///
  /// In en, this message translates to:
  /// **'This Qr will be expire in {time} minutes'**
  String qrToExpireLabel(String time);

  /// No description provided for @qrExpireLabel.
  ///
  /// In en, this message translates to:
  /// **'Qr code has been expire'**
  String get qrExpireLabel;

  /// No description provided for @profileDetailLabel.
  ///
  /// In en, this message translates to:
  /// **'Profile Detail'**
  String get profileDetailLabel;

  /// No description provided for @securityLabel.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securityLabel;

  /// No description provided for @shippingAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address '**
  String get shippingAddressLabel;

  /// No description provided for @termsAndConditionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms And Conditions'**
  String get termsAndConditionsLabel;

  /// No description provided for @aboutUsLabel.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUsLabel;

  /// No description provided for @logOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOutLabel;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// No description provided for @confirmationLabel.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirmationLabel;

  /// No description provided for @surelogoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Are you sure want to log out'**
  String get surelogoutLabel;

  /// No description provided for @confirmLabel.
  ///
  /// In en, this message translates to:
  /// **'confirm'**
  String get confirmLabel;

  /// No description provided for @cancelLabel.
  ///
  /// In en, this message translates to:
  /// **'cancel'**
  String get cancelLabel;

  /// No description provided for @promoExpireLabel.
  ///
  /// In en, this message translates to:
  /// **'Promotion expire date '**
  String get promoExpireLabel;

  /// No description provided for @fromCameraLabel.
  ///
  /// In en, this message translates to:
  /// **'Take a picture'**
  String get fromCameraLabel;

  /// No description provided for @fromFileLabel.
  ///
  /// In en, this message translates to:
  /// **'Select from pictures'**
  String get fromFileLabel;

  /// No description provided for @saveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get pointsLabel;

  /// No description provided for @rewardsAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsAppBarTitle;

  /// No description provided for @historyAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyAppBarTitle;

  /// No description provided for @profileAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileAppBarTitle;

  /// No description provided for @languageProfileList.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageProfileList;

  /// No description provided for @changePasswordProfileList.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordProfileList;

  /// No description provided for @campaignTitle.
  ///
  /// In en, this message translates to:
  /// **'Campaigns'**
  String get campaignTitle;

  /// No description provided for @successAlertBox.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successAlertBox;

  /// No description provided for @somethingWentWrongAlertBox.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get somethingWentWrongAlertBox;

  /// No description provided for @noHistoryLabel.
  ///
  /// In en, this message translates to:
  /// **'No History'**
  String get noHistoryLabel;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'my': return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
