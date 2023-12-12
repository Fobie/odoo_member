import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../common/common_widget.dart';
import '../../common/custom_helper.dart';
import '../../constants.dart';
import '../../custom_decoratoin.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import '../../models/app_user.dart';
import '../../models/common.dart';
import '../../screens/otp_screen.dart';
import '../../screens/signup_screen.dart';
import '../../view_models/user_vm.dart';
import '../pickers/user_image_picker.dart';

class SignupForm extends StatefulWidget {
  final AppUser? existingMember;
  const SignupForm({
    super.key,
    this.existingMember,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

final _formKey = GlobalKey<FormState>();
Map<String, dynamic> signData = {};
String? _userPhoneNumber = '';
String? _userName = '';
String? _userPassword = '';
XFile? _userImageFile;

class _SignupFormState extends State<SignupForm> {
  void _pickedImage(XFile? image) {
    _userImageFile = image;
  }

  void _submitSignUp(String phone, String username, String password,
      XFile? userImage, BuildContext ctx, int? partnerId) async {
    FocusScope.of(context).unfocus(); //to close the keyboard
    overLayLoadingSpinner(context);
    await Provider.of<UserVM>(context, listen: false)
        .signup(phone, username, password, userImage, partnerId)
        .then(
      (result) {
        Navigator.of(context).pop();
        overLayLoadingSpinner(ctx, loadingText: "Please wait logging in...");
        if (result.status) {
          Provider.of<UserVM>(context, listen: false)
              .login(phone, password)
              .then((authRes) {
            Navigator.of(context).popUntil(ModalRoute.withName("/"));
            if (authRes.status) {
            } else {
              showMessage(context, authRes.message, authRes.status);
            }
          });
        } else {
          Navigator.popUntil(
            context,
            ModalRoute.withName(SignUpScreen.routeName),
          );
          showMessage(context, result.message, result.status);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizeText = AppLocalizations.of(context)!;
    return Expanded(
        child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Consumer<UserVM>(
            builder: (context, userData, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserImagePicker(
                      _pickedImage, ImageType.signup), // avator part
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      autofocus: true,
                      initialValue: widget.existingMember == null
                          ? _userPhoneNumber
                          : widget.existingMember?.phone,
                      readOnly: widget.existingMember != null ? true : false,
                      key: const ValueKey('phoneNb'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) => CustomHelper.validateMobile(value),
                      keyboardType: TextInputType.number,
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
                        label: "Phone / Login ID",
                        showSurfixIco: false,
                      ),
                      onSaved: (value) {
                        _userPhoneNumber = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      key: const ValueKey('username'),
                      initialValue: widget.existingMember == null
                          ? _userName
                          : widget.existingMember?.name,
                      readOnly: widget.existingMember != null ? true : false,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: ((value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters.';
                        }
                        return null;
                      }),
                      decoration: getInputDecoration(
                          hint: nameHint,
                          label: "User Name",
                          showSurfixIco: false),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      initialValue: _userPassword,
                      key: const ValueKey('password'),
                      validator: (value) =>
                          CustomHelper.validatePassword(value),
                      decoration: getInputDecoration(
                          hint: pwHint,
                          label: "Password",
                          showSurfixIco: false),
                      obscureText: true,
                      onChanged: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      initialValue: _userPassword,
                      key: const ValueKey('comfirmpassword'),
                      validator: (value) =>
                          CustomHelper.validateConfirmPassword(
                              value, _userPassword),
                      decoration: getInputDecoration(
                          hint: pwHint,
                          label: "Comfirm password",
                          showSurfixIco: false),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: getNewElevatedButtonStyle(context),
                      onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                _formKey.currentState!.save(),
                                signData["phone"] = _userPhoneNumber!,
                                signData["name"] = _userName!,
                                signData["password"] = _userPassword!,
                                signData["image"] = _userImageFile,
                                signData["parid"] =
                                    widget.existingMember?.partnerId,
                                Navigator.push(
                                  context,
                                  createRoute(
                                    OtpScreen(
                                      phoneNumber: '+959$_userPhoneNumber',
                                      completeFunction: _submitSignUp,
                                      isSgnup: true,
                                      data: signData,
                                    ),
                                  ),
                                )
                              }
                          },
                      child: Text(
                          localizeText.signUpLabel,
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
      ),
    ));
  }
}
