import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../common/size_config.dart';
import '../view_models/user_vm.dart';
import '../widgets/auth/auth_form.dart';
import 'member_signup_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void showErrorMessage(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _sumitAuthForm(
    String email,
    String username,
    String password,
    XFile? userImage,
    bool isLogin,
    BuildContext ctx,
  ) async {
    String errMessage = 'An error occurred, please check your credentials!';
    try {
      // print('try auth');
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        try {
          await Provider.of<UserVM>(context, listen: false).login(
            email,
            password,
          );
        } on HttpException catch (error) {
          showErrorMessage(ctx, error.toString());

          setState(() {
            _isLoading = false;
          });
        }
      } else {
        try {
          // await Provider.of<UserVM>(context, listen: false)
          //     .signup(email, username, password, userImage);
        } on HttpException catch (error) {
          showErrorMessage(ctx, error.toString());

          setState(() {
            _isLoading = false;
          });
        }
        // create new user
        //authResult = await _auth.createUserWithEmailAndPassword(
        //   email: loginEmail,
        //   password: password,
        // );
        // print('signup result $authResult');

        // upload image ...
        /*
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${authResult.user!.uid}.jpg');

        await ref.putFile(File(userImage!.path));

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': loginEmail,
          'image_url': url,
        });
      */
      }
    } on PlatformException catch (err) {
      // print(err);

      if (err.message != null) {
        errMessage = err.message.toString();
      }
      showErrorMessage(ctx, errMessage);

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      showErrorMessage(ctx, errMessage);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthForm(
              _sumitAuthForm,
              _isLoading,
            ),
            OutlinedButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25), vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // primary: Colors.white,
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, MemberSignUpScreen.routeName),
              child: const Text("already member and don't have and account?"),
            )
            // Consumer<RoutesVM>(
            //   builder: (context, value, child) => Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         value.toggleState ? "DEV" : "UAT",
            //         style: TextStyle(
            //             fontSize: 15,
            //             color: Theme.of(context).colorScheme.primary),
            //       ),
            //       Switch(
            //           value: value.toggleState,
            //           onChanged: (val) => value.toggleSwitch(val))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
