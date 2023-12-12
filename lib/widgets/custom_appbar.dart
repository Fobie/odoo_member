import 'package:flutter/material.dart';

import '../screens/default_layout.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.showSearch,
    required this.showCart,
    required this.isDetail,
    this.catId,
    this.catName,
  }) : super(key: key);
  final int? catId;
  final String? catName;
  final String title;
  final bool isDetail;
  final bool showSearch;
  final bool showCart;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      leading: isDetail
          ? IconButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, DefaultLayout.routeName),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actionsIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
    );
  }
}
