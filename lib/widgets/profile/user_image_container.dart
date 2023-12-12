import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../common/size_config.dart';
import '../../view_models/user_vm.dart';

class UserImageContainer extends StatelessWidget {
  const UserImageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserVM>(
      builder: (context, userData, child) => SizedBox(
        height: getProportionateScreenWidth(90),
        width: getProportionateScreenWidth(90),
        child: Stack(
          children: [
            SizedBox(
              // decoration: ShapeDecoration(
              //   shape: const CircleBorder(
              //       // side:
              //       //     BorderSide(color: Theme.of(context).colorScheme.primary),
              //       ),
              //   image: DecorationImage(
              //     image: MemoryImage(
              //       base64Decode(userData.user.base64_profile),
              //     ),
              //   ),
              // ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: userData.user.base64Profile != ""
                      ? Image.memory(
                          base64Decode(userData.user.base64Profile),
                        )
                      : Image.asset(AssetImagePath.noProfilePicColor01),
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Container(
            //     padding: EdgeInsets.all(
            //       getProportionateScreenWidth(8),
            //     ),
            //     decoration: ShapeDecoration(
            //         shape: const CircleBorder(side: BorderSide.none),
            //         color: Theme.of(context).colorScheme.primary),
            //     child: const Icon(
            //       Icons.camera_alt,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
