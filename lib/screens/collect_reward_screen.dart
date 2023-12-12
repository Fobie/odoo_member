import 'package:c4e_rewards/constants.dart';
import 'package:c4e_rewards/models/app_user.dart';
import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../view_models/user_vm.dart';
import '../widgets/custom_countdown.dart';
import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../generated/gen_l10n/app_localizations.dart';

class CollectRewardScreen extends StatefulWidget {
  static String routeName = '/collect-point';
  const CollectRewardScreen({Key? key}) : super(key: key);

  @override
  State<CollectRewardScreen> createState() => _CollectRewardScreenState();
}

class _CollectRewardScreenState extends State<CollectRewardScreen> {
  //fetch user data
  Future<void> _fetchMemberPoint(BuildContext context) async {
    await Provider.of<UserVM>(context, listen: false)
        .fetchMemberPoint()
        .then((result) {
      if (!result.status && mounted) {
        showInfoSnackBar(context, result.message, result.status);
      }
    });
  }
  //fetch QR data
  Future<void> _fetchQrData(BuildContext context) async {
    await Provider.of<UserVM>(context, listen: false).userQrGenerate();
  }

  Widget _loadQrCode(BuildContext context, user) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(),
          borderRadius: BorderRadius.circular(15)
        ),
        child: FutureBuilder(
          future: _fetchMemberPoint(context),
          builder: (context,snapshot) {
            return Consumer<UserVM>(
                builder: (context, user, child){
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          // margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            // border: Border.all(color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadiusDirectional.circular(20),
                          ),
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: const Icon(Icons.refresh),
                            focusColor: Theme.of(context).shadowColor,
                            onPressed: () => {
                              setState(() {
                                _fetchQrData(context);
                              })
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: QrImageView(
                          data: user.qrData,
                          version: QrVersions.auto,
                          size: 220,
                          gapless: true,
                        ),
                      ),
                      const CustomCountDown(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: kPrimaryWhite,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Member Points'),
                              Text(user.user.loyaltyPoints.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kPrimaryWhite,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Member ID'),
                              Text(user.user.barcode.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      )
                    ],
                  );
                }
            );
          },
        ),
      ),
      //   ),
      // ),
    );
  }

  @override
  void deactivate() {
    _fetchMemberPoint(context);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return
        // WillPopScope(
        //   onWillPop: () {
        //     _fetchMemberPoint(context);
        //     return Future.value(true);
        //   },
        //   child:
        Scaffold(
          appBar: MainAppBar(
            title: 'QR',
          ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _fetchQrData(context);
                });
              },
              child: ListView(
                children: [
                  FutureBuilder(
                    future: _fetchQrData(context),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: getProportionateScreenHeight(300),
                                  ),
                                  const CircularProgressIndicator(),
                                ],
                              )
                            : Consumer<UserVM>(builder: (ctx, user, _) {
                                return _loadQrCode(context, user);
                              }),
                  ),
                ],
              ),
            ),
            // backArrowWithLabel(
            //     context, AppLocalizations.of(context)!.collectRewardsLabel),
          ],
        ),
      ),
      // ),
    );
  }
}
