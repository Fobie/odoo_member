// ignore_for_file: non_constant_identifier_names

import 'package:c4e_rewards/common/custom_helper.dart';

class ProductDetail {
  final String name;
  final String saleDescription;
  final String fullDescription;
  final int productTmplId;
  int productId;
  final bool isActive;
  final bool isPossibleAddTocart;
  final bool hasDiscountPrice;
  final double listPrice;
  final double price;
  final String priceCurrency;
  final int isSingleAttribute;
  // final List<dynamic> singleValueAttributes;
  final List<dynamic> theme_prime_description;
  final List<ProductTemplateAttribute> productTmplAttributeLines;
  final List<dynamic> alternativeProducts;
  String image1920;
  final String image128;
  Map<String, String> imgCookie;

  ProductDetail({
    required this.name,
    required this.saleDescription,
    required this.fullDescription,
    required this.productTmplId,
    required this.productId,
    required this.isActive,
    required this.isPossibleAddTocart,
    required this.hasDiscountPrice,
    required this.listPrice,
    required this.price,
    required this.priceCurrency,
    required this.isSingleAttribute,
    // required this.singleValueAttributes,
    required this.productTmplAttributeLines,
    required this.theme_prime_description,
    required this.alternativeProducts,
    required this.image1920,
    required this.image128,
    required this.imgCookie,
  });
  ProductDetail copyWith({
    String? name,
    String? saleDescription,
    String? fullDescription,
    int? productTmplId,
    int? productId,
    bool? isActive,
    bool? isPossibleAddTocart,
    bool? hasDiscountPrice,
    double? listPrice,
    double? price,
    String? priceCurrency,
    int? isSingleAttribute,
    List<dynamic>? theme_prime_description,
    List<ProductTemplateAttribute>? productTmplAttributeLines,
    List<dynamic>? alternativeProducts,
    String? image1920,
    String? image128,
    Map<String, String>? imgCookie,
  }) {
    return ProductDetail(
        name: name ?? this.name,
        saleDescription: saleDescription ?? this.saleDescription,
        fullDescription: fullDescription ?? this.fullDescription,
        productTmplId: productTmplId ?? this.productTmplId,
        productId: productId ?? this.productId,
        isActive: isActive ?? this.isActive,
        isPossibleAddTocart: isPossibleAddTocart ?? this.isPossibleAddTocart,
        hasDiscountPrice: hasDiscountPrice ?? this.hasDiscountPrice,
        listPrice: listPrice ?? this.listPrice,
        price: price ?? this.price,
        priceCurrency: priceCurrency ?? this.priceCurrency,
        isSingleAttribute: isSingleAttribute ?? this.isSingleAttribute,
        productTmplAttributeLines:
            productTmplAttributeLines ?? this.productTmplAttributeLines,
        theme_prime_description:
            theme_prime_description ?? this.theme_prime_description,
        alternativeProducts: alternativeProducts ?? this.alternativeProducts,
        image1920: image1920 ?? this.image1920,
        image128: image128 ?? this.image1920,
        imgCookie: imgCookie ?? this.imgCookie);
  }

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        name: json["name"],
        saleDescription:
            json["description_sale"] == false ? "" : json["description_sale"],
        fullDescription:
            json["full_description"] == false ? "" : json["full_description"],
        productTmplId: json["product_tmpl_id"],
        productId: json["product_id"],
        isActive: json["is_active"],
        isPossibleAddTocart: json["is_possible_add2cart"],
        hasDiscountPrice: json["has_discount_price"],
        listPrice: json["list_price"],
        price: json["price"],
        priceCurrency: json["price_currency"],
        isSingleAttribute: json["is_single_attribute"],
        // singleValueAttributes: json["single_value_attributes"] == false
        //     ? []
        //     : json["single_value_attributes"],
        productTmplAttributeLines:
            (json["product_tmpl_attribute_lines"] as List)
                .map((value) => ProductTemplateAttribute.fromJson(value))
                .toList(),
        alternativeProducts: json["alternative_products"],
        theme_prime_description: json["theme_prime_description"],
        image1920:
            json["image_1920_url"] == false ? "null" : json["image_1920_url"],
        image128:
            json["image_128_url"] == false ? "null" : json["image_128_url"], //
        imgCookie: json["img_cookie"],
      );
}

// class ProductDetailData {
//   List<ProductDetail> productList = [];
//   ProductDetailData({required this.productList});
// }

class ProductTemplateAttribute {
  final int id;
  final String name;
  final String displayType;
  final bool single_and_custom;
  final List<AttributeValue> values;

  ProductTemplateAttribute(
      {required this.id,
      required this.name,
      required this.displayType,
      required this.single_and_custom,
      required this.values});

  factory ProductTemplateAttribute.fromJson(
          Map<String, dynamic> attributeline) =>
      ProductTemplateAttribute(
        id: attributeline["attribute_id"],
        name: attributeline["attribute_name"],
        displayType: attributeline["display_type"],
        single_and_custom: attributeline["single_and_custom"],
        values: (attributeline["attribute_values"] as List).map((value) {
          return AttributeValue.fromJson(value);
        }).toList(),
      );
}

class AttributeValue {
  final int id;
  final String name;
  final String htmlColor;
  final bool isCustom;
  final bool selected;
  final double priceExtra;
  final String fromCurrency;
  final String displayCurrency;
  final int? selectedId;

  AttributeValue(
      {required this.id,
      required this.name,
      required this.htmlColor,
      required this.isCustom,
      required this.selected,
      required this.priceExtra,
      required this.fromCurrency,
      required this.displayCurrency,
      this.selectedId});
  AttributeValue copyWith({
    int? id,
    String? name,
    String? htmlColor,
    bool? isCustom,
    bool? selected,
    double? priceExtra,
    String? fromCurrency,
    String? displayCurrency,
    int? selectedId,
  }) {
    return AttributeValue(
        id: id ?? this.id,
        name: name ?? this.name,
        htmlColor: htmlColor ?? this.htmlColor,
        isCustom: isCustom ?? this.isCustom,
        selected: selected ?? this.selected,
        selectedId: selectedId ?? this.selectedId,
        priceExtra: priceExtra ?? this.priceExtra,
        fromCurrency: fromCurrency ?? this.fromCurrency,
        displayCurrency: displayCurrency ?? this.displayCurrency);
  }

  factory AttributeValue.fromJson(Map<String, dynamic> attributevalue) =>
      AttributeValue(
          id: attributevalue["attribute_value_id"],
          name: attributevalue["attribute_value_name"],
          isCustom: attributevalue["is_custom"],
          htmlColor: attributevalue["html_color"] == false
              ? ""
              : CustomHelper.makeHtmlColorToRGBCode(
                  attributevalue["html_color"]),
          selected: attributevalue["selected"],
          priceExtra: attributevalue["price_extra"],
          fromCurrency: attributevalue["from_currency"],
          displayCurrency: attributevalue["display_currency"],
          selectedId: attributevalue["selected"]
              ? attributevalue["attribute_value_id"]
              : null);
}
