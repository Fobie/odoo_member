import 'app_localizations.dart';

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appName => 'C4E ဆုလာဘ်များ';

  @override
  String get loginLabel => 'အကောင့်ဝင်မည်';

  @override
  String get newMemberSignUpLabel => 'မန်ဘာအသစ် အကောင့်စာရင်းသွင်းမည်';

  @override
  String get signUpLabel => 'အကောင့်စာရင်းသွင်းမည်';

  @override
  String get searchLabel => 'ရှာမည်';

  @override
  String get searchAgainLabel => 'ထပ်ရှာမည်';

  @override
  String get existingMemberSignUpLabel => 'မန်ဘာဟောင်း အကောင့်စာရင်းသွင်းမည်';

  @override
  String get forgetPasswordLabel => 'စကားဝှက် မေ့သွားပြီ';

  @override
  String get nextLabel => 'ဆက်သွားမည်';

  @override
  String get forgetPwParagraph => 'OTP Code ပို့ရန်သင့်အကောင့်၏ဖုန်းနံပါတ်အားထည့်ပေးပါ';

  @override
  String get verificationLabel => 'မှန်ကန်ကြောင်းအတည်ပြုရန်';

  @override
  String verifySmsSentLabel(String phone) {
    return 'verify လုပ်ရန် code အား $phone သို့ပို့ထားပါပြီ';
  }

  @override
  String get otpExpireLabel => 'ထိုcodeသည် ';

  @override
  String get secondsLabel => ' စက္ကန့်အတွင်းသက်တမ်းကုန်ဆုံးမည်ဖြစ်သည်။';

  @override
  String get otpTimeoutLabel => 'OTP သက်တမ်းကုန်ဆုံးသွားပါပြီ';

  @override
  String get orLabel => 'သို့မဟုတ်';

  @override
  String get resetPasswordsLabel => 'စကားဝှက်အသစ်ပြန်လုပ်မည်';

  @override
  String get somethinWrongLabel => 'တစ်ခုခုမှားယွင်းသွားပါပြီ';

  @override
  String get retryLabel => 'ပြန်လုပ်ကြည့်မည်';

  @override
  String get openBarcodeScanner => 'Scanner ဖွင့်မည်';

  @override
  String get closeBarcodeScannerLabel => 'အောက်သို့ဆွဲ၍ပိတ်ပါ';

  @override
  String get barcodeIntroLabel => 'ပစ္စည်းရှိbarcodeအားဖတ်၍\nအသေးစိတ်အချက်အလက်အားကြည့်ပါ';

  @override
  String get collectRewardsLabel => 'ပွိုင့်သိမ်းဆည်းမည်';

  @override
  String qrToExpireLabel(String time) {
    return 'ဤ QR code သည် $time မိနစ်အတွင်း သက်တမ်းကုန်ဆုံးမည်';
  }

  @override
  String get qrExpireLabel => 'Qr code သက်တမ်းကုန်ဆုံးသွားပါပြီ';

  @override
  String get profileDetailLabel => 'ကိုယ်ရေးအချက်အလက်';

  @override
  String get securityLabel => 'လုံခြုံရေး';

  @override
  String get shippingAddressLabel => 'နေရပ်လိပ်စာ';

  @override
  String get termsAndConditionsLabel => 'မူဝါဒဆိုင်ရာ သတ်မှတ်ချက်များ';

  @override
  String get aboutUsLabel => 'ကျွန်ုပ်တို့အကြောင်း';

  @override
  String get logOutLabel => 'အကောင့်မှထွက်မည်';

  @override
  String get settingsLabel => 'ပြင်ဆင်မှုများ';

  @override
  String get confirmationLabel => 'အတည်ပြုခြင်း';

  @override
  String get surelogoutLabel => 'အကောင့်မှထွက်ရန်သေချာပါသလား';

  @override
  String get confirmLabel => 'သေချာသည်';

  @override
  String get cancelLabel => 'မလုပ်တော့ပါ';

  @override
  String get promoExpireLabel => 'ဤ promotion သက်တမ်းကုန်ဆုံးမည့်ချိန်';

  @override
  String get fromCameraLabel => 'ဓါတ်ပုံရိုက်ယူမည်';

  @override
  String get fromFileLabel => 'ဓါတ်ပုံများမှရွေးယူမည်';

  @override
  String get saveLabel => 'သိမ်းဆည်းမည်';

  @override
  String get pointsLabel => 'ပွိုင့်စုစုပေါင်း';

  @override
  String get rewardsAppBarTitle => 'ဆုလက်ဆောင်များ';

  @override
  String get historyAppBarTitle => 'မှတ်တမ်းများ';

  @override
  String get profileAppBarTitle => 'ပရိုဖိုင်';

  @override
  String get languageProfileList => 'ဘာသာစကား';

  @override
  String get changePasswordProfileList => 'စကားဝှက်ပြောင်းလဲရန်';

  @override
  String get campaignTitle => 'ကမ်ပိန်းများ';

  @override
  String get successAlertBox => 'အောင်မြင်ပါသည်';

  @override
  String get somethingWentWrongAlertBox => 'တခုခုမှားယွင်းနေပါသည်';

  @override
  String get noHistoryLabel => 'မှတ်တမ်းမရှိသေးပါ';
}
