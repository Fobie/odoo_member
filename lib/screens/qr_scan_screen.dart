import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constants.dart';
import '../generated/gen_l10n/app_localizations.dart';
import '../common/common_widget.dart';
import '../custom_decoratoin.dart';
import '../screens/product_detail_screen.dart';
import '../common/size_config.dart';

class QRScanScreen extends StatefulWidget {
  static const routeName = '/qr-scan';

  const QRScanScreen({Key? key}) : super(key: key);

  @override
  State<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  final qrKey = GlobalKey(debugLabel: "qr");
  QRViewController? controller;
  bool showQRView = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<dynamic> getCameraPermission() async {
    await Permission.camera.status.then((status) => {
          if (!status.isGranted)
            {
              Permission.camera.request().then((result) => {
                    if (result.isGranted)
                      showQRView = true
                    else
                      showQRView = false,
                    reusableQrCodeScanner(
                        context, _onQRViewCreated, showQRView, qrKey),
                  })
            }
          else
            {
              showQRView = true,
              reusableQrCodeScanner(
                  context, _onQRViewCreated, showQRView, qrKey),
            }
        });
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      // if (int.parse(scanData.code as String) % 1 == 0) {
      // controller.pauseCamera();
      // print(scanData.format);
      if (scanData.format != BarcodeFormat.unknown) {
        controller.pauseCamera();
        await Navigator.of(context).pushReplacementNamed(
          ProductDetailScreen.routeName,
          arguments: scanData.code,
        );
      } else {
        controller.pauseCamera();
        showAlertMessageDialog(
            isDissmissable: false,
            ctx: context,
            elevatedcallback: () {
              controller.resumeCamera();
              Navigator.pop(context);
            },
            title: "Invalid Barcode",
            content:
                "This scanner can't hadle ${scanData.format.toString().substring(14)} : ${scanData.code}",
            elevatedbuttonTxt: "OK",
            showOutlineButton: false);
      }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'QR Scan'),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.barcodeIntroLabel,
                //"Scan product's barcode \n and view product's detail.",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Image.asset(
              AssetImagePath.barCodeScanIllu,
              height: getProportionateScreenHeight(300),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: getNewElevatedButtonStyle(context),
                onPressed: () => getCameraPermission(),
                child: Text(
                    AppLocalizations.of(context)!.openBarcodeScanner,
                  style: TextStyle(
                    color: kPrimaryWhite
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
