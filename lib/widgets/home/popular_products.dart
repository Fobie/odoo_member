import 'package:flutter/material.dart';

import '../../models/product_by_cat.dart';
import '../../screens/product_detail_screen.dart';
import '../../common/size_config.dart';
import '../../widgets/home/popular_product_card.dart';

class PopularProducts extends StatefulWidget {
  final List<ProductByCat> productList;
  const PopularProducts({
    Key? key,
    required this.productList,
  }) : super(key: key);
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Popular Products',
                  style: TextStyle(fontSize: getProportionateScreenWidth(20)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                      arguments: widget.productList);
                },
                child: const Text(
                  'See All',
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  widget.productList.length,
                  (index) {
                    return PopularProductCard(
                      product: widget.productList[index],
                    );
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
