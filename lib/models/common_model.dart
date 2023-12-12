class CommonModel {
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
  final int wishListId;
  final Map<String, String> imgCookie;
  CommonModel({
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
    required this.wishListId,
  });
}
