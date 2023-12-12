import 'package:flutter/material.dart';

import '../../models/product_by_cat.dart';
import '../../screens/product_detail_screen.dart';
import '../../common/size_config.dart';

// import '../../screens/product_details_screen.dart';
// import '../../provider/product.dart';

class PopularProductCard extends StatelessWidget {
  // final String catId;
  // final String prodId;
  // final String title;
  // final double price;
  // final String imageUrl;
  // //bool isFav;
  final ProductByCat product;

  const PopularProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 209,
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
        margin: const EdgeInsets.all(2),
        shadowColor: Colors.grey.shade500,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            width: 150,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.productTmplId);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Hero(
                          tag: "${product.productId}",
                          child: Image.network(
                            product.image1920Url,
                            headers: product.imgCookie,
                            height: getProportionateScreenHeight(80),
                          )),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.productName,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
