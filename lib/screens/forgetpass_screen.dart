import 'package:flutter/material.dart';

import '../constants.dart';

import '../common/custom_helper.dart';
import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../custom_decoratoin.dart';
import '../screens/otp_screen.dart';
import '../screens/password_reset.dart';
import '../generated/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = "/forgetpass";
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  String phone = "";

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizeText = AppLocalizations.of(context)!;
    return Scaffold(
      // appBar: AppBar(
      //   leading: Icon(Icons.arrow_back_ios),
      //   backgroundColor: Colors.white,
      // ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(100),
                    ),
                    Image.asset(
                      AssetImagePath.forgetPassword,
                      height: getProportionateScreenHeight(300),
                    ),
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: Text(
                        localizeText.forgetPwParagraph,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (value) => phone = value!,
                        validator: (value) =>
                            CustomHelper.validateMobile(value),
                        decoration: getInputDecoration(
                            hint: "Your login phone number",
                            prefixWidget: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: const Text(
                                      '+959',
                                    ),
                                  )
                                ]),
                            label: "Phone",
                            showSurfixIco: false),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    ElevatedButton(
                        onPressed: () => {
                              _formKey.currentState!.validate(),
                              if (_formKey.currentState!.validate())
                                {
                                  _formKey.currentState!.save(),
                                  Navigator.push(
                                    context,
                                    createRoute(
                                      OtpScreen(
                                        isSgnup: false,
                                        phoneNumber: '+959$phone',
                                        data: const {},
                                        forgetPassword: () =>
                                            Navigator.pushReplacement(
                                          context,
                                          createRoute(
                                            PasswordReset(
                                                loginId: '+959$phone'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                }
                            },
                        style: getNewElevatedButtonStyle(context),
                        child: Text(
                            localizeText.nextLabel,
                          style: TextStyle(
                            color: kPrimaryWhite
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            backArrowWithLabel(context, localizeText.forgetPasswordLabel)
          ],
        ),
      ),
    );
  }
}
