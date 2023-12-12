import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_widget.dart';
import '../../common/custom_helper.dart';
import '../../common/size_config.dart';
import '../../constants.dart';
import '../../custom_decoratoin.dart';
import '../../flavor_config.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import '../../screens/app_settings_screen.dart';
import '../../screens/forgetpass_screen.dart';
import '../../screens/member_signup_screen.dart';
import '../../screens/signup_screen.dart';
import '../../view_models/user_vm.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _userPhone = '';

  String? _userPassword = '';

  void _sumitAuthForm(
    String phone,
    String password,
    BuildContext ctx,
  ) async {
    overLayLoadingSpinner(ctx);
    await Provider.of<UserVM>(ctx, listen: false)
        .login(
          '+959$phone',
          password,
        )
        .then((result) => {
              Navigator.of(ctx).pop(),
              if (!result.status)
                {
                  showMessage(ctx, result.message, result.status),
                }
            });
  }

  void _trySubmit(BuildContext ctx) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(ctx).unfocus(); //to close the keyboard
    if (isValid) {
      _formKey.currentState!.save();
      _sumitAuthForm(_userPhone!, _userPassword!, ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizeText = AppLocalizations.of(context)!;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        "Welcome Back !",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey('phoneNb'),
                      autocorrect: false,
                      // textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      keyboardType: TextInputType.number,
                      validator: (value) => CustomHelper.validateMobile(value),
                      decoration: getInputDecoration(
                          hint: phNoHint,
                          prefixWidget: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: const Text(
                                    '+959',
                                  ),
                                )
                              ]),
                          label: "Phone Number",
                          showSurfixIco: false),
                      onSaved: (value) {
                        _userPhone = value;
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    TextFormField(
                      // initialValue: mainuser_password,
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password can\'t be blank.';
                        }
                        return null;
                      },
                      decoration: getInputDecoration(
                          hint: pwHint,
                          label: "Password",
                          showSurfixIco: false),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => {
                              Navigator.of(context)
                                  .pushNamed(ForgetPasswordScreen.routeName)
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20),
                                ),
                                child: Text(
                                  "${localizeText.forgetPasswordLabel}?",
                                  style: formTextStyle(context),
                                )),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: getNewElevatedButtonStyle(context),
                      onPressed: () => _trySubmit(context),
                      child: Text(
                          localizeText.loginLabel,
                        style: TextStyle(
                          color: kPrimaryWhite
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                InkWell(
                  child: Text(
                    localizeText.signUpLabel,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(SignUpScreen.routeName),
                )
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Column(
              children: [
                const Text("Do you have member card?"),
                InkWell(
                  child: Text(
                    localizeText.existingMemberSignUpLabel,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed(MemberSignUpScreen.routeName),
                )
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 40),
            //   child: Text(
            //     'v ${FlavorConfig.appInfo!.version.toString()} ${FlavorConfig.mAppMode}',
            //     style: optionTextStyle(),
            //   ),
            // ),
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppSettingsScreen.routeName),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
