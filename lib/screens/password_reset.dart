import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/common_widget.dart';
import '../custom_decoratoin.dart';
import '../common/size_config.dart';
import '../view_models/user_vm.dart';
import '../constants.dart';
import '../generated/gen_l10n/app_localizations.dart';

class PasswordReset extends StatefulWidget {
  static String routeName = "/resetpass";
  const PasswordReset({Key? key, required this.loginId}) : super(key: key);

  final String loginId;

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formKey = GlobalKey<FormState>();

  String _password = "";

  // String _confirmPassword = "";
  void submitReset(BuildContext ctx) async {
    FocusScope.of(ctx).unfocus(); //to close the keyboard
    overLayLoadingSpinner(ctx);
    Provider.of<UserVM>(ctx, listen: false)
        .resetForgetPassword(widget.loginId, _password)
        .then((result) {
      if (result.status) {
        Navigator.of(ctx).pop();
        showMessage(ctx, "Success", true, popUntilRouteName: '/');
      } else {
        Navigator.of(ctx).pop();
        showMessage(ctx, result.message, false, popUntilRouteName: '/');
      }
    });
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(20)),
                        child: Image.asset(
                          AssetImagePath.resetPass,
                          height: getProportionateScreenHeight(200),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        onChanged: (value) => _password = value,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters long.';
                          }
                          return null;
                        },
                        decoration: getInputDecoration(
                            hint: "New Password",
                            label: "Password",
                            showSurfixIco: false),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      TextFormField(
                        obscureText: true,
                        validator: ((value) {
                          if (value != _password) {
                            return 'Password and confirm password do not match.';
                          }
                          return null;
                        }),
                        decoration: getInputDecoration(
                            hint: "Confirm Password",
                            label: "Confirm Password",
                            showSurfixIco: false),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    submitReset(context),
                                  }
                              },
                          style: getNewElevatedButtonStyle(context),
                          child: Text(
                              localizeText.resetPasswordsLabel,
                            style: TextStyle(
                              color: kPrimaryWhite
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            backArrowWithLabel(context, localizeText.resetPasswordsLabel)
          ],
        ),
      ),
    );
  }
}
