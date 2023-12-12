class ProductWithAttribute {
  final int id;
  final int templateId;
  final String displayName;
  final bool displayImage;
  final double price;
  final double listPrice;
  final bool hasDiscountedPrice;
  final bool isCombinationPossible;
  final String name;
  final String priceCurrency;
  final List<String> images;
  final Map<String, String> imgCookie;

  ProductWithAttribute(
      {required this.id,
      required this.templateId,
      required this.displayName,
      required this.displayImage,
      required this.price,
      required this.listPrice,
      required this.hasDiscountedPrice,
      required this.isCombinationPossible,
      required this.name,
      required this.priceCurrency,
      required this.imgCookie,
      required this.images});

  factory ProductWithAttribute.fromJson(Map<String, dynamic> jsonObj) =>
      ProductWithAttribute(
        id: jsonObj["product_id"] == false ? 0 : jsonObj["product_id"],
        templateId: jsonObj["product_template_id"],
        displayName: jsonObj["display_name"],
        displayImage: jsonObj["display_image"],
        price: jsonObj["price"],
        listPrice: jsonObj["list_price"],
        hasDiscountedPrice: jsonObj["has_discounted_price"],
        isCombinationPossible: jsonObj["is_combination_possible"],
        name: jsonObj["name"],
        priceCurrency: jsonObj["price_currency"],
        images: jsonObj["product_images"] == false
            ? []
            : (jsonObj["product_images"] as List)
                .map((value) => value['image_1920_url'] as String)
                .toList(),
        imgCookie: {'Cookie': jsonObj["cookie"]},
      );
}

class ProductAttribute {
  int index;
  String name;
  double extra;
  bool checked;
  String hexColor;

  ProductAttribute({
    required this.index,
    required this.name,
    required this.extra,
    required this.checked,
    required this.hexColor,
  });
}

class ProductVariant {
  int selectedIndex;
  String name;
  String displayType;
  List<ProductAttribute> attributes;

  ProductVariant(
      {required this.selectedIndex,
      required this.name,
      required this.displayType,
      required this.attributes});
}
