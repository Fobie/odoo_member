import 'package:c4e_rewards/flavor_config.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: kSplashScreenGradient
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                AssetImagePath.c4eHero,
                width: 250
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'v ${FlavorConfig.appInfo?.version.toString()} ${FlavorConfig.mAppMode}',
                        style: TextStyle(
                          fontSize: 15,
                          color: kPrimaryWhite,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
