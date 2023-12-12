import 'dart:async';
import 'package:c4e_rewards/constants.dart';
import 'package:c4e_rewards/custom_decoratoin.dart';
import 'package:c4e_rewards/generated/gen_l10n/app_localizations.dart';
import 'package:c4e_rewards/models/result_status.dart';
import 'package:c4e_rewards/view_models/product_list_vm.dart';
import 'package:c4e_rewards/widgets/home/banner_image.dart';
import 'package:c4e_rewards/widgets/home/clipPath.dart';
import 'package:c4e_rewards/widgets/home/promo_img_slider.dart';
import 'package:c4e_rewards/widgets/home/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../view_models/user_vm.dart';
import '../widgets/home/member_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  Future<void> _fetchMemberPoints(BuildContext context) async {
    //fetch member points
    await Provider.of<UserVM>(context, listen: false)
        .fetchMemberPoint()
        .then((result) {
      if (!result.status) {
        showInfoSnackBar(context, result.message, result.status);
      }
    });
  }

  Future<ResultStatus> _fetchProductAds(BuildContext context,
      {bool forceFetch = false}) async {
    return await Provider.of<ProductListVM>(context, listen: false)
        .getProductAds(forceFetch);
  }

  Future<void> _fetchHomeData(BuildContext context) async{
    await Future.wait([
      _fetchMemberPoints(context),
      _fetchProductAds(context),
    ]);
  }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return SafeArea(
//       child: Scaffold(
//         body: RefreshIndicator(
//           onRefresh: () => _fetchMemberPoint(context),
//           child: ListView(
//             children: [
//               const NewMemberCard(),
//               Divider(
//                 height: getProportionateScreenHeight(30),
//               ),
//               Column(
//                 children: const [
//                   PromoImgSlider(),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: HomeAppBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return _fetchHomeData(context);
        },
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: ClipPathClass(),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    color: Colors.blue,
                  ),
                ),
                NewMemberCard(),

              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  BannerImage(),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  homeTitleTextWidget(
                      text: AppLocalizations.of(context)!.campaignTitle
                  ),
                  PromoImgSlider(),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}

// FutureBuilder _showPoint(BuildContext context) {
//   return FutureBuilder(
//     future: _fetchMemberPoint(context),
//     builder: (context, snapshot) => SafeArea(
//       child: SizedBox(
//         child: Consumer<UserVM>(
//           builder: (context, value, child) => Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             elevation: 1,
//             shadowColor: Theme.of(context).primaryColor,
//             margin: const EdgeInsets.all(10),
//             child: MemberCard(
//               memberCode: value.user.userBarcode,
//               name: value.user.name,
//               point: value.memberPoint,
//               isLoading: snapshot.connectionState == ConnectionState.waiting
//                   ? true
//                   : false,
//               fetchPoint: (context) => _fetchMemberPoint(context),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
