// class AddtoCart {
//   int statusCode = 0;
//   String message = '';

//   AddtoCart(this.statusCode, this.message);
// }

class Cart {
  final int saleOrderId;
  final double amountUntaxed;
  final double amountTax;
  double amountTotal;
  final int totalItem;
  final List<dynamic> orderLine;
  final String date;
  final List<dynamic> suggestedProducts;

  Cart(
      {required this.saleOrderId,
      required this.amountUntaxed,
      required this.amountTax,
      required this.amountTotal,
      required this.totalItem,
      required this.orderLine,
      required this.date,
      required this.suggestedProducts});

  factory Cart.fromjson(Map<String, dynamic> cart) => Cart(
      saleOrderId: cart["saleOrderId"] == false ? 0 : cart["saleOrderId"],
      amountUntaxed: cart["amountUntaxed"],
      amountTax: cart["amountTax"],
      amountTotal: cart["amountTotal"],
      totalItem: cart["totalItem"],
      orderLine: cart["order_lines"]
          .map((value) => OrderLine.fromjson(value))
          .toList(),
      date: cart["date"],
      suggestedProducts: cart["suggestedProducts"]);
}

class OrderLine {
  final int lineId;
  final String linkedLineId;
  final int productTmplId;
  final int productId;
  final String image128;
  final String nameShort;
  final List<dynamic> productDesc;
  double productUomQty;
  final CombinationInfo combinationinfo;
  final double listPriceConverted;
  final String discountPolicy;
  final double priceReduceTaxexcl;
  final double priceReduceTaxinc;
  final double priceUnit;
  final double priceReduce;
  final String displayCurrency;

  OrderLine(
      {required this.lineId,
      required this.linkedLineId,
      required this.productTmplId,
      required this.productId,
      required this.image128,
      required this.nameShort,
      required this.productDesc,
      required this.productUomQty,
      required this.combinationinfo,
      required this.listPriceConverted,
      required this.discountPolicy,
      required this.priceReduceTaxexcl,
      required this.priceReduceTaxinc,
      required this.priceUnit,
      required this.priceReduce,
      required this.displayCurrency});

  factory OrderLine.fromjson(Map<String, dynamic> orderline) => OrderLine(
      lineId: orderline["lineId"],
      linkedLineId: orderline["linkedLineId"],
      productTmplId: orderline["productTmplId"],
      productId: orderline["productId"],
      image128: orderline["image128"] == false ? "null" : orderline["image128"],
      nameShort: orderline["nameShort"],
      productDesc: orderline["productDesc"],
      productUomQty: orderline["productUomQty"],
      combinationinfo: CombinationInfo.fromjson(orderline["combinationinfo"]),
      listPriceConverted: orderline["listPriceConverted"],
      discountPolicy: orderline["discount_poPoy"] == false
          ? ""
          : orderline["discount_policy"],
      priceReduceTaxexcl: orderline["priceReduceTaxexcl"],
      priceReduceTaxinc: orderline["priceReduceTaxinc"],
      priceUnit: orderline["priceUnit"],
      priceReduce: orderline["priceReduce"],
      displayCurrency: orderline["displayCurrency"]);
}

class CombinationInfo {
  final int productId;
  final int productTemplateId;
  final String displayName;
  final bool displayImage;
  final double price;
  final double listPrice;
  final double hasDiscountedPrice;

  CombinationInfo(
      {required this.productId,
      required this.productTemplateId,
      required this.displayName,
      required this.displayImage,
      required this.price,
      required this.listPrice,
      required this.hasDiscountedPrice});

  factory CombinationInfo.fromjson(Map<String, dynamic> combination) =>
      CombinationInfo(
        productId: combination["productId"],
        productTemplateId: combination["productTemplateId"],
        displayName: combination["displayName"],
        displayImage: combination["displayImage"],
        price: combination["price"],
        listPrice: combination["listPrice"],
        hasDiscountedPrice: combination["hasDiscountedPrice"] == false
            ? 0.0
            : combination["hasDiscountedPrice"],
      );
}

class CartItem {
  int lineId;
  String linkedLineId;
  int productTmplId;
  int productId;
  String image128;
  String nameShort;
  List<dynamic> productDesc;
  double productUomQty;
  double listPriceConverted;
  String discountPolicy;
  double priceReduceTaxexcl;
  double priceReduceTaxinc;
  double priceUnit;
  double priceReduce;
  String displayCurrency;

  String displayName;
  bool displayImage;
  double price;
  double listPrice;
  double hasDiscountedPrice;

  CartItem(
      {required this.lineId,
      required this.linkedLineId,
      required this.productTmplId,
      required this.productId,
      required this.image128,
      required this.nameShort,
      required this.productDesc,
      required this.productUomQty,
      required this.listPriceConverted,
      required this.discountPolicy,
      required this.priceReduceTaxexcl,
      required this.priceReduceTaxinc,
      required this.priceUnit,
      required this.priceReduce,
      required this.displayCurrency,
      required this.displayName,
      required this.displayImage,
      required this.price,
      required this.listPrice,
      required this.hasDiscountedPrice});
}

class CartItemData {
  List<CartItem> cartList;
  CartItemData({required this.cartList});
}
