import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../generated/gen_l10n/app_localizations.dart';
import '../../common/custom_helper.dart';
import '../../constants.dart';
import '../../common/common_widget.dart';
import '../../models/common.dart';
import '../../custom_decoratoin.dart';
import '../../common/size_config.dart';
import '../../view_models/user_vm.dart';
import '../pickers/user_image_picker.dart';

class ProfileDetailForm extends StatefulWidget {
  const ProfileDetailForm({Key? key}) : super(key: key);

  @override
  State<ProfileDetailForm> createState() => _ProfileDetailFormState();
}

class _ProfileDetailFormState extends State<ProfileDetailForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String? _userName = '';
  // String? _userGender = '';
  String? _userPhNO = '';
  // String? _userDOB = '';
  XFile? _userImageFile;
  String? _addressLine1 = "";
  String? _addressLine2 = "";
  String? _city = "";
  String? _zipCode = "";
  // String? _township = "";
  // bool _isLoading = false;
  void _pickedImage(XFile? image) {
    _userImageFile = image;
  }

  void _saveUpdate(
      BuildContext context, name, dob, mail, gender, phNo, img, address1, address2,
      state, city, zipcode) async {
    FocusScope.of(context).unfocus(); //to close the keyboard
    overLayLoadingSpinner(context);
    await Provider.of<UserVM>(context, listen: false)
        .updateDetailInfo(
        img: img,
        name: name,
        email: mail,
        phone: '+959$phNo',
        address1: address1,
        address2: address2,
        state: state,
        city: city,
        // township: township,
        zipcode: zipcode
    )
        .then((result) {
      Navigator.of(context).pop();
      showMessage(context, result.message, result.status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            UserImagePicker(_pickedImage, ImageType.profile),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16.0),
                ),
                child: Consumer<UserVM>(
                  builder: (context, userData, child) => Column(
                    children: [
                      Divider(
                        height: getProportionateScreenHeight(30),
                      ),
                      // Name Text Form Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          initialValue: userData.user.name,
                          textAlign: TextAlign.left,
                          onSaved: (value) => _userName = value!,
                          decoration: getInputDecoration(
                              hint: nameHint,
                              label: "User Name",
                              showSurfixIco: false),
                        ),
                      ),
                      // Email Text Form Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          initialValue: userData.user.email,
                          textAlign: TextAlign.left,
                          onSaved: (value) => _userEmail = value!,
                          validator: (value) =>
                              CustomHelper.validateEmail(value),
                          decoration: getInputDecoration(
                              hint: mailHint,
                              label: "Email",
                              showSurfixIco: false),
                        ),
                      ),
                      // Phone Number Text Form Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          validator: (value) =>
                              CustomHelper.validateMobile(value),
                          initialValue: userData.user.phone,
                          textAlign: TextAlign.left,
                          onSaved: (value) => _userPhNO = value!,
                          decoration: getInputDecoration(
                              hint: phNoHint,
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
                      // Address Line 1 Text Form Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          initialValue: userData.user.street,
                          textAlign: TextAlign.left,
                          onSaved: (value) => _addressLine1 = value!,
                          decoration: getInputDecoration(
                              hint: addressHint,
                              label: "Address Line 1",
                              showSurfixIco: false),
                        ),
                      ),
                      // Address Line 2 Text Form Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          initialValue: userData.user.street2,
                          textAlign: TextAlign.left,
                          onSaved: (value) => _addressLine2 = value!,
                          decoration: getInputDecoration(
                              hint: addressHint,
                              label: "Address Line 2",
                              showSurfixIco: false),
                        ),
                      ),
                      // Township Text Form Field
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 8),
                      //   child: TextFormField(
                      //     initialValue: userData.user.country,
                      //     textAlign: TextAlign.left,
                      //     onSaved: (value) => _township = value!,
                      //     decoration: getInputDecoration(
                      //         hint: townshipHint,
                      //         label: "Township",
                      //         showSurfixIco: false),
                      //   ),
                      // ),
                      // City Text Form Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          initialValue: userData.user.city,
                          textAlign: TextAlign.left,
                          onSaved: (value) => _city = value!,
                          decoration: getInputDecoration(
                              hint: cityHint,
                              label: "City",
                              showSurfixIco: false),
                        ),
                      ),
                      // ?Lottie.asset(
                      //     "assets/animation/purple_dot_loading.json",
                      //     width: 250,
                      //     height: 80)
                      ElevatedButton(
                        style: getNewElevatedButtonStyle(context),
                        // style: ElevatedButton.styleFrom(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 40, vertical: 12),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(25.0),
                        //   ),
                        //   // primary: const Color.fromRGBO(103, 58, 183, 1),
                        // ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          _formKey.currentState!.save();
                          _saveUpdate(context, _userName, null, _userEmail,
                              null, _userPhNO, _userImageFile,_addressLine1, _addressLine2, null, _city,
                              null);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.saveLabel,
                          style: TextStyle(
                            color: kPrimaryWhite
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // Widget buildTextBox({
  //   required String hint,
  //   required String fieldValue,
  //   required String initValue,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: TextFormField(
  //         initialValue: initValue,
  //         textAlign: TextAlign.left,
  //         onSaved: (value) => fieldValue = value!,
  //         style: TextStyle(
  //           fontWeight: FontWeight.w500,
  //           fontSize: getProportionateScreenWidth(14),
  //         ),
  //         decoration: getInputDecoration(hint: hint)),
  //   );
  // }
}
