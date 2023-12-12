import 'package:c4e_rewards/constants.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../generated/gen_l10n/app_localizations.dart';
import '../../custom_decoratoin.dart';
import '../common/size_config.dart';

Widget backArrowWithLabel(BuildContext ctx, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      InkWell(
        onTap: () => Navigator.of(ctx).pop(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Theme.of(ctx).colorScheme.primary,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(ctx).colorScheme.primary,
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(30),
      )
    ],
  );
}

Widget appBarReplacementWidget(BuildContext ctx, String label) {
  final localizeText = AppLocalizations.of(ctx)!;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(ctx).colorScheme.primary),
          child: InkWell(
            onTap: () => Navigator.of(ctx).pop(),
            child: Row(children: [
              const Icon(Icons.arrow_back_ios),
              Text(
                localizeText.cancelLabel,
              )
            ]),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(ctx).colorScheme.primary,
          ),
        )
      ],
    ),
  );
}

void overLayLoadingSpinner(BuildContext ctx, {String? loadingText}) {
  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (context) => Center(
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    if (loadingText != null) Text(loadingText)
                  ],
                ),
              ),
            ),
          ));
}

void showAlertMessageDialog({
  required isDissmissable,
  required BuildContext ctx,
  required VoidCallback elevatedcallback,
  required String title,
  required String content,
  required String elevatedbuttonTxt,
  required bool showOutlineButton,
  String? outlinebuttonTxt,
  VoidCallback? outlinecallback,
}) {
  showDialog(
    barrierDismissible: isDissmissable,
    context: ctx,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(title),
      content: Text(content),
      actions: [
        if (showOutlineButton)
          OutlinedButton(
            onPressed: outlinecallback,
            style: getDialogOutLineStyle(context),
            child: Text(outlinebuttonTxt!),
          ),
        ElevatedButton(
          onPressed: elevatedcallback,
          style: getDialogElevatedStyle(context),
          child: Text(elevatedbuttonTxt, style: TextStyle(color: kPrimaryWhite),),
        ),
      ],
    ),
  );
}

void showInfoSnackBar(BuildContext context, String message, bool status) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: !status ? Colors.red : Colors.green,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(15.0),
    // ),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    content: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.w600),
      textAlign: TextAlign.start,
    ),
  ));
}

void showMessage(BuildContext context, String message, bool status,
    {String? popUntilRouteName}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: status
                ? const Color.fromARGB(255, 160, 244, 160)
                : const Color.fromARGB(255, 244, 167, 161),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Text(
              textAlign: TextAlign.center,
              message,
            ),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                status ? Icon(Icons.info, color: Colors.white,) : Icon(Icons.error_outline),
                status ? Text(
                  AppLocalizations.of(context)!.successAlertBox,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold
                  ),
                ) : Text(
                  AppLocalizations.of(context)!.successAlertBox,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () => popUntilRouteName != null
                    ? Navigator.of(context)
                        .popUntil(ModalRoute.withName(popUntilRouteName))
                    : Navigator.of(context).pop(),
                style: getDialogElevatedStyle(context),
                child: const Text(
                    "Ok",
                  style: TextStyle(
                    color: kPrimaryWhite
                  ),
                ),
              ),
            ],
          ),
      barrierDismissible: false,
      useSafeArea: true);
}

void reusableQrCodeScanner(BuildContext ctx,
    void Function(QRViewController) qrCtrlMethod, bool permit, GlobalKey key) {
  showModalBottomSheet(
    enableDrag: true,
    context: ctx,
    isScrollControlled: true,
    builder: (ctx) => FractionallySizedBox(
      alignment: Alignment.center,
      heightFactor: 0.961, //getProportionateScreenHeight(1.22),
      child: SizedBox(
        child: permit
            ? SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.keyboard_arrow_down_rounded),
                            Text(AppLocalizations.of(ctx)!
                                .closeBarcodeScannerLabel),
                          ]),
                    ),
                    Expanded(
                      flex: 5,
                      child: QRView(
                        key: key,
                        onQRViewCreated: (ctrl) => qrCtrlMethod(ctrl),
                        overlay: QrScannerOverlayShape(
                            // borderRadius: 10,
                            // borderWidth: 15,
                            borderColor: Theme.of(ctx).primaryColor),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: Text("Permisssion denined."),
              ),
      ),
    ),
  );
}
