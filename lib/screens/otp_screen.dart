import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../flavor_config.dart';
import '../generated/gen_l10n/app_localizations.dart';

import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../custom_decoratoin.dart';
import '../view_models/user_vm.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp';
  const OtpScreen({
    Key? key,
    required this.isSgnup,
    required this.phoneNumber,
    required this.data,
    this.completeFunction,
    this.forgetPassword,
  }) : super(key: key);
  final String phoneNumber;
  final bool isSgnup;
  final Map<String, dynamic> data;
  final Function(String phone, String username, String password,
      XFile? userImage, BuildContext ctx, int? partnerId)? completeFunction;
  final Function? forgetPassword;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? verificationCode;
  final countryController = TextEditingController();

  Future<void> _requestOtpCode(BuildContext ctx) async {
    await Provider.of<UserVM>(ctx, listen: false)
        .requestOtp(widget.phoneNumber)
        .then((result) {
      if (result.status) {
        verificationCode = result.data;
      } else {
        showMessage(context, result.message, result.status);
      }
    });
  }

  Future<void> _requestOtpCodeSimulation(BuildContext ctx) async {
    verificationCode = "333333";
  }

  void onPinCompleted(String pin, BuildContext ctx) {
    if (pin == verificationCode) {
      if (widget.isSgnup) {
        widget.completeFunction!(
            widget.phoneNumber,
            widget.data["name"],
            widget.data["password"],
            widget.data["image"],
            ctx,
            widget.data["parid"]);
      }
      if (widget.forgetPassword != null) {
        widget.forgetPassword!();
      }
    } else {
      showMessage(ctx, "Invalid Code", false);
    }
  }

  Row buildTimer(BuildContext ctx, AppLocalizations localizeText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(localizeText.otpExpireLabel),
        TweenAnimationBuilder(
          tween: Tween(begin: 300.0, end: 0.0),
          duration: const Duration(seconds: 300),
          builder: (_, dynamic value, child) => Text(
            // "00:${value.toInt()}",
            "${value.toInt()}",
            style: const TextStyle(color: Colors.green),
          ),
          onEnd: () {
            int count = 0;
            showAlertMessageDialog(
              isDissmissable: false,
              ctx: ctx,
              elevatedcallback: () => {
                Navigator.pushReplacement(
                  ctx,
                  createRoute(
                    OtpScreen(
                      phoneNumber: widget.phoneNumber,
                      completeFunction: widget.completeFunction,
                      isSgnup: widget.isSgnup,
                      data: widget.data,
                      forgetPassword: widget.forgetPassword,
                    ),
                  ),
                ),
              },
              title: localizeText.somethinWrongLabel,
              content: localizeText.otpTimeoutLabel,
              elevatedbuttonTxt: localizeText.retryLabel,
              showOutlineButton: true,
              outlinebuttonTxt: localizeText.cancelLabel,
              outlinecallback: () => Navigator.of(ctx).popUntil((route) {
                return count++ == 2;
              }),
            );
          },
        ),
        Text(localizeText.secondsLabel)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizeText = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              child: FutureBuilder(
                future: FlavorConfig.appFlavor == Flavor.development
                    ? _requestOtpCodeSimulation(context)
                    : _requestOtpCode(
                        context), //use _requestOtpCode method for real otp
                builder: (context, snapshot) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(100),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getProportionateScreenHeight(50),
                      ),
                      child: Image.asset(
                        AssetImagePath.otpIco,
                        height: getProportionateScreenHeight(150),
                      ),
                    ),
                    Text(
                      localizeText.verificationLabel,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(localizeText.verifySmsSentLabel(widget.phoneNumber)),
                    if (snapshot.connectionState != ConnectionState.waiting)
                      buildTimer(context, localizeText),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            snapshot.connectionState == ConnectionState.waiting
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Pinput(
                                    androidSmsAutofillMethod:
                                        AndroidSmsAutofillMethod
                                            .smsUserConsentApi,
                                    autofocus: true,
                                    length: 6,
                                    showCursor: true,
                                    onCompleted: (pin) =>
                                        onPinCompleted(pin, context),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            backArrowWithLabel(context, localizeText.verificationLabel)
          ],
        ),
      ),
    );
  }
}
