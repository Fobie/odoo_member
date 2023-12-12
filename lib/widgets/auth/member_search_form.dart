import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../common/common_widget.dart';
import '../../common/custom_helper.dart';
import '../../common/size_config.dart';
import '../../constants.dart';
import '../../custom_decoratoin.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import '../../models/app_user.dart';
import '../../models/common.dart';
import '../../screens/signup_screen.dart';
import '../../view_models/user_vm.dart';

class MemberSearchForm extends StatefulWidget {
  const MemberSearchForm({super.key});

  @override
  State<MemberSearchForm> createState() => _MemberSearchFormState();
}

class _MemberSearchFormState extends State<MemberSearchForm> {
  final _formKey = GlobalKey<FormState>();
  MemberSearchType _searchType = MemberSearchType.phone;
  final qrKey = GlobalKey(debugLabel: "qr");
  QRViewController? controller;
  bool showQRView = false;
  final txtcontroller = TextEditingController();
  bool _showMember = false;

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
      if (int.parse(scanData.code as String) % 1 == 0) {
        controller.pauseCamera();
        txtcontroller.text = scanData.code.toString();
        Navigator.pop(context);
      }
    });
  }

  Future<void> _searchButtonClick() async {
    const searchLimit = 5;
    const blockDuration = Duration(minutes: 15);
    FocusScope.of(context).unfocus(); //to close the keyboard
    var userProvider = Provider.of<UserVM>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      userProvider.changeSearchCount(searchLimit: searchLimit);
      overLayLoadingSpinner(context);

      await userProvider
          .isValidToSearch(duration: blockDuration)
          .then((isValid) {
        if (isValid) {
          userProvider
              .searchExitingMember(_searchType, txtcontroller.text)
              .then((result) {
            Navigator.of(context).pop();
            if (!result.status) {
              showMessage(context, result.message, false);
            } else {
              setState(() {
                _showMember = true;
              });
            }
          });
        } else {
          Navigator.of(context).pop();
          showMessage(
              context,
              "You can only search $searchLimit times per ${blockDuration.inMinutes} minutes",
              false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizeText = AppLocalizations.of(context)!;
    return Expanded(
        child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _showMember
                ? Selector<UserVM, AppUser>(
                    selector: (_, provider) => provider.existingUser,
                    shouldRebuild: (previous, next) => previous != next,
                    builder: (context, user, child) => Column(
                      children: [
                        ListTile(
                          // children: [
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: user.base64Profile == ""
                                ? Image.asset(
                                        AssetImagePath.noProfilePicColor01)
                                    .image
                                : MemoryImage(
                                    base64Decode(user.base64Profile),
                                  ),
                          ),
                          title: Text(
                            user.name,
                          ),
                          subtitle: Text(
                            user.phone == "" ? "-" : '+959${user.phone}',
                          ),
                          trailing: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => Navigator.pushReplacementNamed(
                                context, SignUpScreen.routeName,
                                arguments: user),
                            icon: const Icon(Icons.check),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() {
                            _showMember = false;
                          }),
                          style: getNewElevatedButtonStyle(context),
                          child: Text(localizeText.searchAgainLabel),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Phone"),
                          Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: MemberSearchType.phone,
                            groupValue: _searchType,
                            onChanged: (value) {
                              setState(() {
                                _searchType = value as MemberSearchType;
                              });
                              txtcontroller.clear();
                            },
                          ),
                          const Text("Barcode"),
                          Radio(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: MemberSearchType.barcode,
                            groupValue: _searchType,
                            onChanged: (value) {
                              setState(() {
                                _searchType = value as MemberSearchType;
                              });
                              txtcontroller.clear();
                            },
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: txtcontroller,
                              keyboardType: TextInputType.number,
                              decoration: getInputDecoration(
                                hint: _searchType == MemberSearchType.phone
                                    ? phNoHint
                                    : "",
                                label: _searchType.toString().split('.')[1],
                                prefixWidget: _searchType ==
                                        MemberSearchType.phone
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: const Text(
                                                '+959',
                                              ),
                                            )
                                          ])
                                    : null,
                                showSurfixIco:
                                    _searchType == MemberSearchType.barcode
                                        ? true
                                        : false,
                                surfixButIcon: Icons.qr_code,
                                surfixButAction: () => getCameraPermission(),
                              ),
                              validator: _searchType == MemberSearchType.phone
                                  ? (val) => CustomHelper.validateMobile(val)
                                  : (val) => CustomHelper.validateBarcode(val),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: getNewElevatedButtonStyle(context),
                              onPressed: () => {
                                _searchButtonClick(),
                              },
                              child: Text(
                                  localizeText.searchLabel,
                                style: TextStyle(
                                  color: kPrimaryWhite
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    ));
  }
}
