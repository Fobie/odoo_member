import 'package:flutter/material.dart';

import '../common/common_widget.dart';
import '../common/size_config.dart';
import '../generated/gen_l10n/app_localizations.dart';
import '../widgets/profile/shipping_address_form.dart';

class UserShippingAddress extends StatelessWidget {
  static String routeName = "/shipping-address";
  const UserShippingAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar(
        //     title: "Shipping Address",
        //     showSearch: false,
        //     showCart: false,
        //     isDetail: false),
        body: SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(16.0),
              ),
              child: const ShippingAdderssForm(),
            ),
          ),
          backArrowWithLabel(
              context, AppLocalizations.of(context)!.shippingAddressLabel)
        ],
      ),
    ));
  }
}
