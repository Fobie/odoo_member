class ProductByCat {
  final int productTmplId;
  final int productId;
  final String productName;
  final bool hasDisPrice;
  final double listPrice;
  final double price;
  final String currency;
  final String description;
  final String image123Url;
  final String image1920Url;
  late bool isFavourite;
  final Map<String, String> imgCookie;
//  bool isFav;

  ProductByCat({
    required this.productTmplId,
    required this.productId,
    required this.productName,
    required this.hasDisPrice,
    required this.currency,
    required this.description,
    required this.listPrice,
    required this.price,
    required this.image123Url,
    required this.image1920Url,
    required this.imgCookie,
    required this.isFavourite,
    //  required this.isFav,
  });

  factory ProductByCat.fromJson(Map<String, dynamic> product) => ProductByCat(
        productTmplId: product["productTmplId"],
        productId: product["product_id"],
        productName: product["product_name"],
        hasDisPrice: product["has_discounted_price"],
        currency: product["price_currency"],
        description: product["description_sale"] == false
            ? ""
            : product["description_sale"],
        listPrice: product["list_price"],
        price: product["price"],
        image123Url: product["image_128_url"],
        imgCookie: product["img_cookie"],
        image1920Url: product["image_1920_url"],
        isFavourite: product["isFavourite"],
      );
}

// class ProductData {
//   List<ProductByCat> productList;
//   ProductData({required this.productList});
// }
