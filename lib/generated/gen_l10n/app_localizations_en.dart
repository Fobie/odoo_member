import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'C4E Rewards';

  @override
  String get loginLabel => 'Login';

  @override
  String get newMemberSignUpLabel => 'New member signup';

  @override
  String get signUpLabel => 'Signup';

  @override
  String get searchLabel => 'Search';

  @override
  String get searchAgainLabel => 'Search again';

  @override
  String get existingMemberSignUpLabel => 'Existing member signup';

  @override
  String get forgetPasswordLabel => 'Forget password';

  @override
  String get nextLabel => 'Next';

  @override
  String get forgetPwParagraph => 'Please enter your phone number and we will send otp to reset your password';

  @override
  String get verificationLabel => 'Verification';

  @override
  String verifySmsSentLabel(String phone) {
    return 'We sent verification code to $phone';
  }

  @override
  String get otpExpireLabel => 'This code will expiredd in ';

  @override
  String get secondsLabel => ' seconds';

  @override
  String get otpTimeoutLabel => 'OTP time out';

  @override
  String get orLabel => 'or';

  @override
  String get resetPasswordsLabel => 'Reset Password';

  @override
  String get somethinWrongLabel => 'Something went wrong';

  @override
  String get retryLabel => 'retry';

  @override
  String get openBarcodeScanner => 'Open Scanner';

  @override
  String get closeBarcodeScannerLabel => 'slide down to close';

  @override
  String get barcodeIntroLabel => 'Scan product\'s barcode \n and view product\'s detail.';

  @override
  String get collectRewardsLabel => 'Collects Rewards';

  @override
  String qrToExpireLabel(String time) {
    return 'This Qr will be expire in $time minutes';
  }

  @override
  String get qrExpireLabel => 'Qr code has been expire';

  @override
  String get profileDetailLabel => 'Profile Detail';

  @override
  String get securityLabel => 'Security';

  @override
  String get shippingAddressLabel => 'Shipping Address ';

  @override
  String get termsAndConditionsLabel => 'Terms And Conditions';

  @override
  String get aboutUsLabel => 'About Us';

  @override
  String get logOutLabel => 'Log Out';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get confirmationLabel => 'confirm';

  @override
  String get surelogoutLabel => 'Are you sure want to log out';

  @override
  String get confirmLabel => 'confirm';

  @override
  String get cancelLabel => 'cancel';

  @override
  String get promoExpireLabel => 'Promotion expire date ';

  @override
  String get fromCameraLabel => 'Take a picture';

  @override
  String get fromFileLabel => 'Select from pictures';

  @override
  String get saveLabel => 'Save';

  @override
  String get pointsLabel => 'Total Points';

  @override
  String get rewardsAppBarTitle => 'Rewards';

  @override
  String get historyAppBarTitle => 'History';

  @override
  String get profileAppBarTitle => 'Profile';

  @override
  String get languageProfileList => 'Language';

  @override
  String get changePasswordProfileList => 'Change Password';

  @override
  String get campaignTitle => 'Campaigns';

  @override
  String get successAlertBox => 'Success';

  @override
  String get somethingWentWrongAlertBox => 'Something Went Wrong';

  @override
  String get noHistoryLabel => 'No History';
}
