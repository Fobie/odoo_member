import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback press;
  const CategoryCard({
    Key? key,
    required this.category,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                NetworkImage(category.imageUrl, headers: category.imgCookie),
          ),
          // customBackground(),
          Text(
            category.catName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
