import 'dart:io';

import 'package:c4e_rewards/view_models/point_vm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../flavor_config.dart';
import '../common/size_config.dart';
import '../screens/app_settings_screen.dart';
import '../screens/collect_reward_screen.dart';
import '../screens/color_palettes_screen.dart';
import '../screens/forgetpass_screen.dart';
import '../screens/member_signup_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/login_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/qr_scan_screen.dart';
import '../screens/user_security_screen.dart';
import '../screens/user_shipping_address_screen.dart';
import '../screens/default_layout.dart';
import '../screens/user_profile_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/user_profile_detail_screen.dart';
import '../view_models/user_vm.dart';
import '../view_models/product_list_vm.dart';
import '../view_models/detail_product_vm.dart';
import '../generated/gen_l10n/app_localizations.dart';
import '../common/custom_helper.dart';
import '../constants.dart';

void preLoadingBeforeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig.appInfo = await PackageInfo.fromPlatform();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<bool> _initAppLocale() async {
    return await LocalStorageManager.readData(CachedKey.locale) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: kDebugMode ? null : _initAppLocale(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => UserVM()),
              ChangeNotifierProvider(
                  create: (context) => ProductListVM(initLocale: true)),
              ChangeNotifierProvider(
                create: (context) => DetailProductVM(),
              ),
              ChangeNotifierProvider(
                create: (context) => PointVM(),
              ),
            ],
            child: Selector<ProductListVM, String>(
              selector: (_, provider) => provider.localeName,
              shouldRebuild: (previous, next) => previous != next,
              builder: (context, locale, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: Locale(locale),
                localizationsDelegates: const [
                  AppLocalizations.delegate, // Add this line
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                title: FlavorConfig.mAppAName,
                theme: ThemeData(
                  fontFamily: "Padauk",
                  primaryColor: const Color.fromRGBO(2, 146, 224, 1),
                  colorScheme: const ColorScheme.light(
                    secondary: Color.fromRGBO(236, 83, 20, 1),
                    primary: Color.fromRGBO(8, 121, 198, 1),
                  ),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    unselectedItemColor: Colors.black,
                    backgroundColor: Color.fromRGBO(244, 249, 251, 1),
                    selectedItemColor: Color.fromRGBO(0, 204, 146, 1),
                  ),
                ),
                home: Selector<UserVM, bool>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (_, provider) => provider.isAuth,
                    builder: (context, isAuth, _) {
                      SizeConfig().init(context);
                      return isAuth
                          ? const DefaultLayout()
                          : FutureBuilder(
                              future:
                                  Provider.of<UserVM>(context, listen: false)
                                      .tryAutoLogin(),
                              builder: (ctx, authResultSnapshot) =>
                                  authResultSnapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? const SplashScreen()
                                      : const LoginScreen(),
                            );
                    }),
                routes: {
                  AuthScreen.routeName: (context) => const AuthScreen(),
                  ProductDetailScreen.routeName: (context) =>
                      const ProductDetailScreen(),
                  QRScanScreen.routeName: (context) => const QRScanScreen(),
                  // CategoryScreen.routeName: (context) => const CategoryScreen(),
                  UserProfile.routeName: (context) => const UserProfile(),
                  UserProfileDetailScreen.routeName: (context) =>
                      const UserProfileDetailScreen(),
                  UserSecurity.routeName: (context) => const UserSecurity(),
                  UserShippingAddress.routeName: (context) =>
                      const UserShippingAddress(),
                  CollectRewardScreen.routeName: (context) =>
                      const CollectRewardScreen(),
                  DefaultLayout.routeName: (context) => const DefaultLayout(),
                  SignUpScreen.routeName: (context) => const SignUpScreen(),
                  MemberSignUpScreen.routeName: (context) =>
                      const MemberSignUpScreen(),
                  ForgetPasswordScreen.routeName: (context) =>
                      const ForgetPasswordScreen(),
                  AppSettingsScreen.routeName: (context) =>
                      const AppSettingsScreen(),
                  ColorPalettesScreen.routeName: (context) =>
                      const ColorPalettesScreen()
                },
              ),
            ),
          );
        });
  }
}
