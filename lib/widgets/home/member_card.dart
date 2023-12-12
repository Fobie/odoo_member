import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/collect_reward_screen.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import '../../constants.dart';
import '../../models/app_user.dart';
import '../../common/common_widget.dart';
import '../../common/size_config.dart';
import '../../view_models/user_vm.dart';

class NewMemberCard extends StatefulWidget {
  const NewMemberCard({super.key});

  @override
  State<NewMemberCard> createState() => _NewMemberCardState();
}

class _NewMemberCardState extends State<NewMemberCard> {
  Future<void> _fetchMemberPoint(BuildContext context) async {
    await Provider.of<UserVM>(context, listen: false)
        .fetchMemberPoint()
        .then((result) {
      if (!result.status) {
        showMessage(context, result.message, result.status);
      }
    });
  }

  void onAddIconClick() {
    Navigator.of(context).pushNamed(CollectRewardScreen.routeName);
  }

  // @override
  // Widget build(BuildContext context) {
  //   final colorSchemePrimary = Theme.of(context).colorScheme.primary;
  //   return Container(
  //     margin: EdgeInsets.all(getProportionateScreenWidth(10)),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         colors: [
  //           Color(0xffd1d1d1),
  //           Color(0xff747474),
  //         ],
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     height: getProportionateScreenHeight(300),
  //     child: FutureBuilder(
  //       builder: (context, snapshot) => Selector<UserVM, AppUser>(
  //         builder: (context, user, child) => Column(
  //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.all(
  //                 getProportionateScreenWidth(10),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Image.asset(
  //                     AssetImagePath.c4eTransLogo,
  //                     width: 230,
  //                   ),
  //                   ElevatedButton(
  //                     onPressed: () => onAddIconClick(),
  //                     style: ElevatedButton.styleFrom(
  //                         minimumSize: const Size(50, 50),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(15),
  //                         ),
  //                         backgroundColor: colorSchemePrimary),
  //                     child: const Icon(Icons.add),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             LayoutBuilder(
  //               builder: (context, boxConstrains) => Row(
  //                 children: [
  //                   const SizedBox(
  //                     width: 80,
  //                   ),
  //                   Container(
  //                     width: boxConstrains.maxWidth - 80,
  //                     decoration: const BoxDecoration(
  //                       color: Color.fromARGB(238, 238, 238, 238),
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(15),
  //                         bottomLeft: Radius.circular(15),
  //                       ),
  //                     ),
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             // const Icon(Icons.star),
  //                             Padding(
  //                               padding: EdgeInsets.all(
  //                                   getProportionateScreenWidth(10)),
  //                               child: Image.asset(
  //                                 "assets/images/illustration/star-circle.png",
  //                                 width: getProportionateScreenWidth(30),
  //                                 height: getProportionateScreenWidth(30),
  //                               ),
  //                             ),
  //                             Text(
  //                               AppLocalizations.of(context)!.pointsLabel,
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: getProportionateScreenHeight(20),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         const Divider(thickness: 1.5),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             snapshot.connectionState ==
  //                                     ConnectionState.waiting
  //                                 ? SkeletonLine(
  //                                     style: SkeletonLineStyle(
  //                                       borderRadius: const BorderRadius.only(
  //                                         bottomLeft: Radius.circular(15),
  //                                       ),
  //                                       height:
  //                                           getProportionateScreenHeight(50),
  //                                       width: boxConstrains.maxWidth - 80,
  //                                     ),
  //                                   )
  //                                 : Text(
  //                                     style: TextStyle(
  //                                       color: colorSchemePrimary,
  //                                       fontSize:
  //                                           getProportionateScreenHeight(30),
  //                                     ),
  //                                     user.loyaltyPoints.toString(),
  //                                   )
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(
  //                 left: getProportionateScreenWidth(30),
  //                 top: getProportionateScreenHeight(20),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     user.name,
  //                     style: const TextStyle(
  //                       fontFamily: 'OverpassMono',
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: getProportionateScreenWidth(30),
  //                 vertical: getProportionateScreenHeight(10),
  //               ),
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     user.barcode.toString(),
  //                     style: const TextStyle(
  //                       fontFamily: 'OverpassMono',
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         selector: (context, provider) => provider.user,
  //       ),
  //       future: _fetchMemberPoint(context),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final colorSchemePrimary = Theme.of(context).colorScheme.primary;

    // Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 55, vertical: 25),
    //   width: getProportionateScreenWidth(250),
    //   height: getProportionateScreenHeight(150),
    //   color: Colors.red,
    //   child: Text('Blh Blh'),
    // )
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30), vertical: getProportionateScreenHeight(20)),
      decoration: BoxDecoration(
      color: kPrimaryWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 2.0,
            color: kGreyShade1
          )
        ]
      ),
      height: getProportionateScreenHeight(170),
      child: FutureBuilder(
        builder: (context, snapshot) => Selector<UserVM, AppUser>(
          builder: (context, user, child) => Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(25),
                  vertical: getProportionateScreenHeight(20),
                ),
                child: Column(
                  children: [
                    Text(
                      "Member ID : ${user.barcode}",
                      style: const TextStyle(
                        fontFamily: 'OverpassMono',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    Text(
                      AppLocalizations.of(context)!.pointsLabel
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        snapshot.connectionState == ConnectionState.waiting ?
                            Text(
                              '- - -'
                            ) :
                        Text(
                          user.loyaltyPoints.toString(),
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(15),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: kGreyShade1
                          ),
                          child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _fetchMemberPoint(context);
                                });
                              },
                              child: Icon(Icons.refresh)
                          ),
                          // child: IconButton(
                          //   color: Theme.of(context).colorScheme.primary,
                          //   icon: const Icon(Icons.refresh),
                          //   focusColor: Theme.of(context).shadowColor,
                          //   onPressed: () => {
                          //     setState(() {
                          //       _fetchMemberPoint(context);
                          //     })
                          //   },
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          selector: (context, provider) => provider.user,
        ),
        future: _fetchMemberPoint(context),
      ),
    );
  }
}
