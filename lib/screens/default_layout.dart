import 'package:c4e_rewards/generated/gen_l10n/app_localizations.dart';
import 'package:c4e_rewards/screens/collect_reward_screen.dart';
import 'package:c4e_rewards/screens/history_screen.dart';
import 'package:c4e_rewards/screens/rewards_screen.dart';
import 'package:flutter/material.dart';

import './home_screen.dart';
import './qr_scan_screen.dart';
import './user_profile_screen.dart';

class DefaultLayout extends StatefulWidget {
  static String routeName = "/default";
  const DefaultLayout({Key? key}) : super(key: key);

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  bool get loading => _loading;
  bool _loading = false;
  int _navigatorValue = 0;
  get navigationValue => _navigatorValue;

  Widget currentScreen = const HomeScreen();
  void selectBottomNavigator(int selectedValue) {
    _loading = true;
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        setState(() {
          currentScreen = const HomeScreen();
        });
        break;
      case 1:
        setState(() {
          currentScreen = const RewardsScreen();
        });
        break;
      case 2:
        setState(() {
          currentScreen = const CollectRewardScreen();
        });
        break;
      case 3:
        setState(() {
          currentScreen = const HistoryScreen();
        });
        break;
      case 4:
        setState(() {
          currentScreen = const UserProfile();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: AppLocalizations.of(context)!.rewardsAppBarTitle),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: "Scanner"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      currentIndex: navigationValue,
      onTap: (index) => selectBottomNavigator(index),
      selectedItemColor:
      Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
      backgroundColor:
      Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
    );
  }
}
