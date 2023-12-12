import 'dart:async';

import 'package:flutter/material.dart';
import '../generated/gen_l10n/app_localizations.dart';

class CustomCountDown extends StatefulWidget {
  const CustomCountDown({Key? key}) : super(key: key);
  @override
  State<CustomCountDown> createState() => _CustomCountDownState();
}

class _CustomCountDownState extends State<CustomCountDown> {
  static var countdownDuration1 = const Duration(minutes: 5);

  Duration duration1 = const Duration();
  Timer? timer1;
  bool countDown1 = true;
  void _invokeCountDown() {
    resetCountDown();
    int mints1;
    int secs1;
    mints1 = int.parse("05");
    secs1 = int.parse("00");
    countdownDuration1 = Duration(minutes: mints1, seconds: secs1);
    startCountDown();
  }

  void resetCountDown() {
    if (countDown1) {
      setState(() => duration1 = countdownDuration1);
    } else {
      setState(() => duration1 = const Duration());
    }
  }

  void startCountDown() {
    timer1 =
        Timer.periodic(const Duration(seconds: 1), (_) => reduceCountDown());
  }

  void reduceCountDown() {
    const int addSeconds = 1;
    setState(() {
      final seconds = duration1.inSeconds - addSeconds;
      if (seconds < 0) {
        timer1?.cancel();
      } else {
        duration1 = Duration(seconds: seconds);
      }
    });
  }

  Widget buildTime1(AppLocalizations text) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return minutes + seconds == "0000"
        ? Text(text.qrExpireLabel)
        : Text(" ${text.qrToExpireLabel('$minutes : $seconds')} ");
  }

  @override
  void initState() {
    _invokeCountDown();
    super.initState();
  }

  @override
  void dispose() {
    timer1?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations text = AppLocalizations.of(context)!;
    return buildTime1(text);
  }
}
