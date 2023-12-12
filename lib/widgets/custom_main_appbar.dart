import 'package:c4e_rewards/constants.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MainAppBar({
    super.key,
    required this.title,
    this.leadingWidget,
    this.isCenterTitle = true
  });

  final String title;
  final Widget? leadingWidget;
  final bool? isCenterTitle;

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingWidget,
      elevation: 0,
      title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: kTextColorForth
          ),
      ),
      centerTitle: isCenterTitle,
      flexibleSpace: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)
            )
        ),
      ),
    );
  }
}
