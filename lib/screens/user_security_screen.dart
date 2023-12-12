import 'dart:async';
import 'dart:io';

import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../common/custom_helper.dart';
import '../constants.dart';
import '../custom_decoratoin.dart';
import '../generated/gen_l10n/app_localizations.dart';
import '../common/common_widget.dart';
import '../models/result_status.dart';
import '../common/size_config.dart';
import '../view_models/user_vm.dart';

class UserSecurity extends StatefulWidget {
  static String routeName = "/security";
  const UserSecurity({Key? key}) : super(key: key);

  @override
  State<UserSecurity> createState() => _UserSecurityState();
}

class _UserSecurityState extends State<UserSecurity> {
  String? _oldPassword = "";
  String? _newPassword = "";
  String? _confirmPassword = "";
  final _formKey = GlobalKey<FormState>();

  void _submitChangepassword(
      BuildContext ctx, String oldpwd, String newpwd, String confirmpwd) async {
    try {
      overLayLoadingSpinner(ctx);
      ResultStatus result = await Provider.of<UserVM>(ctx, listen: false)
          .changePassword(oldpwd, newpwd);
      if (result.status) {
        // ignore: use_build_context_synchronously
        Navigator.of(ctx).pop();
        // ignore: use_build_context_synchronously
        showAlertMessageDialog(
            isDissmissable: false,
            ctx: ctx,
            elevatedcallback: () async => {
                  await Provider.of<UserVM>(ctx, listen: false).logout(),
                  Navigator.popUntil(context, ModalRoute.withName("/")),
                },
            title: "Updated Successfully",
            content: "This will automitically logout your account",
            elevatedbuttonTxt: "Ok",
            showOutlineButton: false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(ctx).pop();
        // ignore: use_build_context_synchronously
        showInfoSnackBar(context, result.message, false);
        // showInfoSnackBar(ctx, result.message);
      }
    } on PlatformException catch (err) {
      if (err.message != null) {}
    } on TimeoutException catch (err) {
      showInfoSnackBar(ctx, err.message.toString(), false);
    } on SocketException catch (err) {
      showInfoSnackBar(ctx, err.message.toString(), false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //     title: "Security",
      //     showSearch: false,
      //     showCart: false,
      //     isDetail: false),
      // appBar: AppBar(
      //   title: const Text("Security"),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      appBar: MainAppBar(
          title: AppLocalizations.of(context)!.changePasswordProfileList,
          leadingWidget: BackButton(
            color: kPrimaryWhite,
          ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(16.0),
                        ),
                        child: Consumer<UserVM>(
                          builder: (context, userData, child) => Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: TextFormField(
                                    textAlign: TextAlign.left,
                                    validator: (value) {
                                      {
                                        if (value == null || value.isEmpty) {
                                          return "Old password can't be blank!";
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    onSaved: (value) => _oldPassword = value!,
                                    obscureText: true,
                                    decoration: getInputDecoration(
                                        label: "Old Passwrod",
                                        hint: pwHint,
                                        showSurfixIco: false)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  validator: (value) =>
                                      CustomHelper.validatePassword(value),
                                  onChanged: (value) => _newPassword = value,
                                  //onSaved: (value) => _newPassword = value!,
                                  obscureText: true,
                                  decoration: getInputDecoration(
                                      label: "New Password",
                                      hint: pwHint,
                                      showSurfixIco: false),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: TextFormField(
                                  textAlign: TextAlign.left,
                                  validator: (value) =>
                                      CustomHelper.validateConfirmPassword(
                                          value, _newPassword),
                                  onSaved: (value) => _confirmPassword = value!,
                                  obscureText: true,
                                  decoration: getInputDecoration(
                                      label: "Confirm Password",
                                      hint: pwHint,
                                      showSurfixIco: false),
                                ),
                              ),
                              ElevatedButton(
                                style: getNewElevatedButtonStyle(context),
                                // style: ElevatedButton.styleFrom(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 40, vertical: 12),
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(25.0),
                                //   ),
                                //   // primary:
                                //   //     const Color.fromRGBO(103, 58, 183, 1),
                                // ),
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  _formKey.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  _submitChangepassword(context, _oldPassword!,
                                      _newPassword!, _confirmPassword!);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.saveLabel,
                                  style: TextStyle(
                                    color: kPrimaryWhite
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          // backArrowWithLabel(
          //     context, AppLocalizations.of(context)!.securityLabel)
        ],
      )),
    );
  }
}
