import 'package:c4e_rewards/constants.dart';
import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import 'app_settings_screen.dart';
import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../flavor_config.dart';
import '../view_models/user_vm.dart';
import '../widgets/profile/user_image_container.dart';
import '../widgets/list_tile_option.dart';
import '../screens/user_security_screen.dart';
import '../custom_decoratoin.dart';
import '../screens/user_profile_detail_screen.dart';
import '../screens/user_shipping_address_screen.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/user-profile';
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          title: AppLocalizations.of(context)!.profileAppBarTitle
      ),
        body: SingleChildScrollView(
      child: Consumer<UserVM>(
          builder:(context, userdata, child){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryWhite,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 2.0,
                              color: kGreyShade1
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const UserImageContainer(),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130,
                                    child: Text(
                                        userdata.user.name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            overflow: TextOverflow.visible
                                        )
                                    ),
                                  ),
                                  Text(
                                    userdata.user.barcode.toString(),
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          OutlinedButton(
                              onPressed: (){
                                Navigator.pushNamed(
                                    context, UserProfileDetailScreen.routeName);
                              },
                              child: Text(
                                'Edit'
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryWhite,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 2.0,
                              color: kGreyShade1
                          )
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              Text(
                                userdata.user.email.toString(),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              Text(
                                '+959${userdata.user.phone.toString()}'
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_city),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              Text(
                                userdata.user.city.isEmpty ? '- - -' : userdata.user.city.toString()
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryWhite,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3.0, 3.0),
                              blurRadius: 2.0,
                              color: kGreyShade1
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.language),
                          title: Text(
                            AppLocalizations.of(context)!.languageProfileList
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          onTap: (){
                            Navigator.of(context)
                                .pushNamed(AppSettingsScreen.routeName);
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(5),
                        ),
                        ListTile(
                          leading: Icon(Icons.lock),
                          title: Text(
                              AppLocalizations.of(context)!.changePasswordProfileList
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 15,),
                          onTap: (){
                            Navigator.pushNamed(context, UserSecurity.routeName);
                          },
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                GestureDetector(
                  onTap: () {
                    showAlertMessageDialog(
                        isDissmissable: true,
                        ctx: context,
                        elevatedcallback: () => {
                          Provider.of<UserVM>(context, listen: false)
                              .logout(),
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName("/")),
                        },
                        title:
                        AppLocalizations.of(context)!.confirmationLabel,
                        content:
                        AppLocalizations.of(context)!.surelogoutLabel,
                        elevatedbuttonTxt:
                        AppLocalizations.of(context)!.confirmLabel,
                        showOutlineButton: true,
                        outlinebuttonTxt:
                        AppLocalizations.of(context)!.cancelLabel,
                        outlinecallback: () => Navigator.pop(context));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: getProportionateScreenHeight(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryColor,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.logOutLabel,
                          style: TextStyle(
                            color: kPrimaryWhite
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'v ${FlavorConfig.appInfo!.version.toString()} ${FlavorConfig.mAppMode}',
                          style: optionTextStyle(),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(2),
                        ),
                        Text(
                          "\u00a9 C4E Computer & Mobile",
                          style: optionTextStyle(),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(2),
                        ),
                        Text(
                          "Powered By ApexIntegra Co., Ltd.",
                          style: optionTextStyle(),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(2),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            );
          }
      ),
    ));
  }
}
