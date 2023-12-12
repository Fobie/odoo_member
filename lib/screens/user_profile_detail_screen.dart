import 'package:c4e_rewards/widgets/profile/shipping_address_form.dart';
import 'package:flutter/material.dart';

import '../custom_decoratoin.dart';
import '../common/size_config.dart';
import '../common/common_widget.dart';
import '../widgets/profile/profile_detail_form.dart';
import '../generated/gen_l10n/app_localizations.dart';

class UserProfileDetailScreen extends StatelessWidget {
  static const routeName = 'myProfile';
  const UserProfileDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          const SingleChildScrollView(
            child: Column(
              children: [
                ProfileDetailForm(),
              ],
            ),
          ),
          backArrowWithLabel(
              context, AppLocalizations.of(context)!.profileDetailLabel)
        ],
      ),
    ));
  }
}

class InputFormCard extends StatelessWidget {
  const InputFormCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextFormField(
              initialValue: value,
              textAlign: TextAlign.left,
              decoration: getInputDecoration(
                  hint: title, label: title, showSurfixIco: false),
            ),
          ),
        )
      ],
    );
  }
}
