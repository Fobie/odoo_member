// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/common.dart';
import '../pickers/user_image_picker.dart';
import '/custom_decoratoin.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String username,
    String password,
    XFile? userImage,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  const AuthForm(this.submitFn, this.isLoading, {super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String? _userEmail = '';
  String? _userName = '';
  String? _userPassword = '';
  XFile? _userImageFile;

  void _pickedImage(XFile? image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //to close the keyboard
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please pick an image.'),
      ));
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail!.trim(),
        _userName!.trim(),
        _userPassword!.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    UserImagePicker(_pickedImage, ImageType.signup),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: "ai@apexintegra.com",
                      key: const ValueKey('phoneNb'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        // if (value!.isEmpty || !value.startsWith('09')) {
                        //   return 'Please enter a valid phone number.';
                        // }
                        return null;
                      },
                      // keyboardType: TextInputType.number,
                      decoration: getInputDecoration(
                          hint: "Your Phone Number",
                          label: "Loign ID",
                          showSurfixIco: false),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                  ),
                  if (!_isLogin)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        key: const ValueKey('username'),
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
                            hint: "Eg. Mg Mg",
                            label: "User Name",
                            showSurfixIco: false),
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      initialValue: "123456",
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      decoration: getInputDecoration(
                          hint: "Eg. XXXXXXX",
                          label: "Password",
                          showSurfixIco: false),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      style: getNewElevatedButtonStyle(context),
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Singup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'new member and don\'t have an account?'
                          : 'already a member?'),
                      // textColor: Theme.of(context).primaryColor,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
