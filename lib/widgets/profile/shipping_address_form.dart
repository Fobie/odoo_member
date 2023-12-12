import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_widget.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import '../../view_models/user_vm.dart';
import '../../custom_decoratoin.dart';
import '../../common/size_config.dart';

class ShippingAdderssForm extends StatefulWidget {
  const ShippingAdderssForm({Key? key}) : super(key: key);

  @override
  State<ShippingAdderssForm> createState() => _ShippingAdderssFormState();
}

class _ShippingAdderssFormState extends State<ShippingAdderssForm> {
  void _saveUpdate(BuildContext context, String address1, String address2,
      String? state, String city, String? township, String zipcode) async {
    FocusScope.of(context).unfocus(); //to close the keyboard
    overLayLoadingSpinner(context);
    await Provider.of<UserVM>(context, listen: false)
        .updateDetailInfo(
            address1: address1,
            address2: address2,
            state: state,
            city: city,
            township: township,
            zipcode: zipcode
    )
        .then((result) {
      Navigator.of(context).pop();
      showMessage(context, result.message, result.status);
    });
  }

  String _addressLine1 = "";
  String _addressLine2 = "";
  // String _state = "";
  String _city = "";
  String _zipCode = "";
  // String _township = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<UserVM>(
        builder: (context, userData, child) => Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: userData.user.street,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Address 1 cann't be blank!";
                  } else {
                    return null;
                  }
                },
                textAlign: TextAlign.left,
                onSaved: (value) => _addressLine1 = value!,
                decoration: getInputDecoration(
                    label: "Address Line 1",
                    hint: "Your Home Address",
                    showSurfixIco: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: userData.user.street2,
                textAlign: TextAlign.left,
                onSaved: (value) => _addressLine2 = value!,
                decoration: getInputDecoration(
                    label: "Address Line 2",
                    hint: "Optional Home Address",
                    showSurfixIco: false),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: TextFormField(
            //     initialValue: "",
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return "Country can't be blank!";
            //       } else {
            //         return null;
            //       }
            //     },
            //     textAlign: TextAlign.left,
            //     onSaved: (value) => _country = value!,
            //     style: TextStyle(
            //       fontWeight: FontWeight.w500,
            //       fontSize: getProportionateScreenWidth(14),
            //     ),
            //     decoration: getInputDecoration(hint: "Country"),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 4),
            //   child: FutureBuilder(
            //     future: _fetchCountryList(),
            //     builder: (ctx, snapshot) => snapshot.connectionState ==
            //             ConnectionState.waiting
            //         ? TextFormField(
            //             enabled: false,
            //           )
            //         : Center(
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(
            //                   horizontal: 12, vertical: 4),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(25.0),
            //                 border: Border.all(
            //                     color: Colors.grey.shade400, width: 1),
            //               ),
            //               child: DropdownButtonHideUnderline(
            //                 child: DropdownButton<String>(
            //                   value: userData.defaultCountry,
            //                   isExpanded: true,
            //                   items: userData.countryList.map((data) {
            //                     return DropdownMenuItem<String>(
            //                       value: data.name,
            //                       child: Text(data.name,
            //                           style: TextStyle(color: Colors.black)),
            //                     );
            //                   }).toList(),
            //                   onChanged: (value) {
            //                     setState(() {
            //                       userData.updateCountry(value!);
            //                     });
            //                   },
            //                 ),
            //               ),
            //             ),
            //           ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: TextFormField(
            //     initialValue: "",
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return "State can't be blank!";
            //       } else {
            //         return null;
            //       }
            //     },
            //     textAlign: TextAlign.left,
            //     onSaved: (value) => _state = value!,
            //     style: TextStyle(
            //       fontWeight: FontWeight.w500,
            //       fontSize: getProportionateScreenWidth(14),
            //     ),
            //     decoration: getInputDecoration(hint: "State"),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: userData.user.city,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "City can't be blank!";
                  } else {
                    return null;
                  }
                },
                textAlign: TextAlign.left,
                onSaved: (value) => _city = value!,
                decoration: getInputDecoration(
                    label: "City", hint: "Eg. Toranto", showSurfixIco: false),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8),
            //   child: TextFormField(
            //     initialValue: "",
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return "Township can't be blank!";
            //       } else {
            //         return null;
            //       }
            //     },
            //     textAlign: TextAlign.left,
            //     onSaved: (value) => _township = value!,
            //     style: TextStyle(
            //       fontWeight: FontWeight.w500,
            //       fontSize: getProportionateScreenWidth(14),
            //     ),
            //     decoration: getInputDecoration(hint: "Township"),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                initialValue: userData.user.zip,
                textAlign: TextAlign.left,
                onSaved: (value) => _zipCode = value!,
                decoration: getInputDecoration(
                    label: "zip code", hint: "000000", showSurfixIco: false),
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
              //   // primary: const Color.fromRGBO(103, 58, 183, 1),
              // ),
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                _formKey.currentState!.save();
                _saveUpdate(context, _addressLine1, _addressLine2, null, _city,
                    null, _zipCode);
              },
              child: Text(
                AppLocalizations.of(context)!.saveLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
