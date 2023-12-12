import 'dart:math';
// import 'package:ai_ecommerce/size_config.dart';
import 'package:flutter/material.dart';

const kDefaultPaddin = 20.0;
const kPrimaryPupbleColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

///common color for placeholder
const kGreyShade1 = Color(0xFF8E8E93);
const kGreyShade2 = Color(0xFFAEAEB2);
const kGreyShade3 = Color(0xFFC7C7CC);
const kGreyShade4 = Color(0xFFD1D1D6);
const kGreyShade5 = Color(0xFFE5E5EA);
const kGreyShade6 = Color(0xFFF2F2F7);
const kShadowColor = Color(0x3322292E);
const kSeperatorColor = Color(0xFFC6C6C8);
const kGradientColor = Color(0xFF22292E);
const kFillColorPrimary = Color(0xFFE4E4E6);
const kFillColorAccent = Color(0xFFE9E9EB);
const kFillColorThird = Color(0xFFEFEFF0);
const kFillColorForth = Color(0xFFF4F4F5);
const kAlertColor = Color(0xFFFF3B30);
const kFailColor = Color(0xFFFF4343);
const kblueGrey = Colors.blueGrey;
const yellowAccent = Colors.yellowAccent;

///Text color
const kTextColor = Color(0xFF22292E);
const kTextColorAccent = Color(0xFF8A8A8E);
const kTextColorThird = Color(0xFFC5C5C7);
const kTextColorForth = Color(0xFFF8F8F8);

/// Main color pallete
const kPrimaryGreen = Color(0xFF54B175);
const kPrimaryRed = Color(0xFFFE6E4C);
const kPrimaryYellow = Color(0xFFFEBF43);
const kPrimaryPurple = Color(0xFF9B81E5);
const kPrimaryTosca = Color(0xFF03B0A9);
const kAccentGreen = Color(0xFFE4F3EA);
const kAccentRed = Color(0xFFFFECE8);
const kAccentYellow = Color(0xFFFFF6E4);
const kAccentPurple = Color(0xFFF1EDFC);
const kAccentTosca = Color(0xFFDDF5F4);
const kPrimaryWhite = Color(0xFFFFFFFF);
//const kPrimaryColor = Color(0xFFFF7643);
//const kPrimaryColor = Color.fromRGBO(188, 24, 82, 1);
const kPrimaryColor = Color(0xFF3D82AE);
const kSplashScreenGradient = LinearGradient(
    colors: [
      Colors.blue,
      Color(0xFF0D47A1)
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter
);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
//const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  // fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  // color: Colors.black,
  color: kPrimaryColor,
  height: 1.5,
);

const homeTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone";
const String kCityNullError = "Please Enter your city";
const String kAddressNullError = "Please Enter your address";
const String kStress1NullError = "Please Enter your address";
const String kCustomTextNullError = "Please Enter your custom text.";

final otpInputDecoration = InputDecoration(
  // contentPadding:
  //     EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return const OutlineInputBorder(
    // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

Color getColorRandomNumber() {
  List colors = [
    kPrimaryPupbleColor,
    kAlertColor,
    kPrimaryPurple,
    kPrimaryGreen,
    kPrimaryRed,
    kPrimaryYellow,
    kFailColor,
    kPrimaryTosca,
    kPrimaryColor,
    kblueGrey,
    yellowAccent
  ];
  Random random = Random();

  return colors[random.nextInt(11)];
}

const phNoHint = "454633745";
const pwHint = "*******";
const mailHint = "user@example.com";
const nameHint = "Mg Mg";
const addressHint = "Enter your address";
const townshipHint = "Dagon Township";
const cityHint = "Yangon";

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

class CachedKey {
  static const user = 'CACHED_USER_DATA';
  static const odooUser = 'CACHED_ODOO_USER_DATA';
  static const time = 'CACHED_TIME';
  static const count = 'CACHED_COUNT';
  static const locale = 'LOCALE';
}

class AssetImagePath {
  static const c4eHorizontalIco = 'assets/images/brand/c4e-horizontal.png';
  static const noProfilePicColor01 =
      'assets/images/no_profile_pic_color_01.png';
  static const c4eTransLogo = 'assets/images/brand/c4e_transparent.png';
  static const c4eSplashLogo = 'assets/images/brand/c4e_splash_tran.png';
  static const c4eLaunchIco = 'assets/images/brand/c4e_launch_ico.png';
  static const c4eCard = 'assets/images/brand/c4e_card.png';
  static const c4eSplash = 'assets/images/brand/c4e_splash.png';
  static const c4eSplashV3 = 'assets/images/brand/c4e_splash.v3.png';
  static const c4eFadeinImg = 'assets/images/brand/c4e_fadein.png';
  static const barCodeScanIllu = 'assets/images/illustration/barcode_scan.png';
  static const forgetPassword =
      'assets/images/illustration/forget_pass_girl.png';
  static const resetPass = 'assets/images/illustration/reset_pass.png';
  static const otpIco = 'assets/images/illustration/otp_ico.png';
  static const searchIco = 'assets/images/illustration/searching.png';
  static const rewardsIcon = 'assets/icons/rewards-ico.svg';
  static const purpleDotLoading = 'assets/animation/purple_dot_loading.json';
  static const svgStarCircle = 'assets/images/illustration/star-circle.svg';
  static const c4eHero = 'assets/images/brand/c4e-hero.png';
  static const c4eHeroHorizontal = 'assets/images/brand/c4e-horizontal.png';
}
