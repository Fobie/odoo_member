import 'package:c4e_rewards/constants.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AssetImagePath.c4eHeroHorizontal
              ),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.circle_notifications_outlined,size: 40,color: Colors.white,)
              )
            ],
          ),
        ),
      ),
    );
  }
}
