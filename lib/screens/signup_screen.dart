import 'package:c4e_rewards/screens/member_signup_screen.dart';
import 'package:c4e_rewards/widgets/auth/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../generated/gen_l10n/app_localizations.dart';
import '../models/common.dart';
import '../common/custom_helper.dart';
import '../constants.dart';
import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../models/app_user.dart';
import '../screens/otp_screen.dart';
import '../custom_decoratoin.dart';
import '../view_models/user_vm.dart';
import '../widgets/pickers/user_image_picker.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/new-member-singnup";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> signData = {};
  String? _userPhoneNumber = '';
  String? _userName = '';
  String? _userPassword = '';
  XFile? _userImageFile;

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
    AppUser? existingMember =
        ModalRoute.of(context)?.settings.arguments as AppUser?;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: 0.3,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0292e0), Color(0xff144591)],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.asset(
                AssetImagePath.c4eHorizontalIco,
                height: 350,
              ),
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.75,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
              ),
              child: SignupForm(existingMember: existingMember),
            ),
          ),
        ],
      ),
    );
  }
}
