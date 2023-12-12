import 'package:c4e_rewards/widgets/auth/member_search_form.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MemberSignUpScreen extends StatefulWidget {
  static String routeName = '/search-member';
  const MemberSignUpScreen({Key? key}) : super(key: key);

  @override
  State<MemberSignUpScreen> createState() => _MemberSignUpScreenState();
}

class _MemberSignUpScreenState extends State<MemberSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.3,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff0292e0), Color(0xff144591)],
                    stops: [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Image.asset(
                  AssetImagePath.c4eHorizontalIco,
                  height: 350,
                ),
              ),
            ),
            FractionallySizedBox(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.75,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                ),
                child: const MemberSearchForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
