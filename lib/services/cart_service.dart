// ignore_for_file: prefer_const_constructors

import '../models/cart.dart';
import '../models/result_status.dart';
import 'routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartService {
  Future<List<Cart>> getCart() async {
    List<Cart> cartList = [];
    final storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');

    // if (sessionId != null) {
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var cartbody = {"jsonrpc": "2.0", "params": {}};
    //print(body);
    Response cartresponse =
        await dio.post(getCartDataApi, options: options, data: cartbody);

    //_cartList = [];
    // Cart _cart = Cart.fromjson(cartresponse.data["result"]["data"]);

    Map<String, dynamic> resdata = cartresponse.data["result"]["data"];
    resdata["img_cookie"] = {"cookie": sessionId};
    Cart cart = Cart.fromjson(resdata);

    cartList.add(cart);

    // List<CartItem> _cartItemList = [];

    // for (int i = 0; i < _cart.orderLine.length; i++) {
    //   CartItem item = CartItem(
    //       line_id: _cart.orderLine[i].line_id,
    //       linked_line_id: _cart.orderLine[i].linked_line_id,
    //       product_tmpl_id: _cart.orderLine[i].product_tmpl_id,
    //       product_id: _cart.orderLine[i].product_id,
    //       image_128: _cart.orderLine[i].image_128,
    //       name_short: _cart.orderLine[i].name_short,
    //       product_desc: _cart.orderLine[i].product_desc,
    //       product_uom_qty: _cart.orderLine[i].product_uom_qty,
    //       list_price_converted: _cart.orderLine[i].list_price_converted,
    //       discount_policy: _cart.orderLine[i].discount_policy,
    //       price_reduce_taxexcl: _cart.orderLine[i].price_reduce_taxexcl,
    //       price_reduce_taxinc: _cart.orderLine[i].price_reduce_taxinc,
    //       price_unit: _cart.orderLine[i].price_unit,
    //       price_reduce: _cart.orderLine[i].price_reduce,
    //       display_currency: _cart.orderLine[i].display_currency,
    //       display_name: _cart.orderLine[i].combination_info.display_name,
    //       display_image: _cart.orderLine[i].combination_info.display_image,
    //       price: _cart.orderLine[i].combination_info.price,
    //       list_price: _cart.orderLine[i].combination_info.list_price,
    //       has_discounted_price:
    //           _cart.orderLine[i].combination_info.has_discounted_price);
    //   _cartItemList.add(item);
    // }
    return cartList;
    // }
    //  return null;
  }

  Future<ResultStatus> addToCart(int id, int numberOfItems) async {
    final storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );

    var body = {
      "jsonrpc": "2.0",
      "params": {"product_id": id, "add_qty": numberOfItems}
    };
    Response response =
        await dio.post(addToCartApi, options: options, data: body);

    if (response.statusCode == 401) {
      return ResultStatus(message: 'Add to Cart Failed.');
    } else if (response.statusCode == 200) {
      var data = response.data["result"]["message"];
      return ResultStatus(message: data);
    } else {
      return ResultStatus(message: 'Add to Cart Failed.');
    }
  }

  Future<ResultStatus> addToCartWithAttr(
      int productTempId,
      int productId,
      int numberOfItems,
      int colorId,
      int sizeId,
      int selectId,
      String customText) async {
    final storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    Map<String, Object> body;
    if (customText.isNotEmpty) {
      body = {
        "jsonrpc": "2.0",
        "params": {
          "product_id": productId,
          "add_qty": numberOfItems,
          "product_template_id": productTempId,
          "product_custom_attribute_values":
              '[{"custom_product_template_attribute_value_id":$productTempId,"attribute_value_name":"Custom","custom_value":"$customText"}]',
          "no_variant_attribute_values": "[]"
        }
      };
    } else {
      // body = {
      //   "jsonrpc": "2.0",
      //   "params": {
      //     "product_id": productId,
      //     "add_qty": 1,
      //     "product_template_id": productTempId,
      //     "ptal-1": colorId,
      //     "ptal-2": sizeId,
      //     "ptal-3": selectId,
      //     "product_custom_attribute_values": "[]",
      //     "no_variant_attribute_values": "[]"
      //   }
      body = {
        "jsonrpc": "2.0",
        "params": {
          "product_id": productId,
          "add_qty": numberOfItems,
          "product_template_id": productTempId,
          "product_custom_attribute_values": "[]",
          "no_variant_attribute_values": "[]"
        }
      };
    }

    Response response =
        await dio.post(addToCartApi, options: options, data: body);

    if (response.statusCode == 401) {
      return ResultStatus(message: 'Add to Cart Failed.');
    } else if (response.statusCode == 200) {
      var data = response.data["result"]["message"];
      return ResultStatus(message: data);
    } else {
      return ResultStatus(message: 'Add to Cart Failed.');
    }
  }

  Future<ResultStatus> removeOrAddCart(int id, int numberOfItems) async {
    final storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );

    var body = {
      "jsonrpc": "2.0",
      "params": {"product_id": id, "add_qty": null, "set_qty": numberOfItems}
    };
    Response response =
        await dio.post(addToCartApi, options: options, data: body);

    if (response.statusCode == 401) {
      return ResultStatus(message: 'Add to Cart Failed.');
    } else if (response.statusCode == 200) {
      var data = response.data["result"]["message"];
      return ResultStatus(message: data);
    } else {
      return ResultStatus(message: 'Add to Cart Failed.');
    }
  }

  Future<ResultStatus> removeFromCart(
    int id,
  ) async {
    final storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );

    var body = {
      "jsonrpc": "2.0",
      "params": {"product_id": id, "add_qty": null, "set_qty": 0}
    };
    Response response =
        await dio.post(addToCartApi, options: options, data: body);

    if (response.statusCode == 401) {
      return ResultStatus(message: 'Add to Cart Failed.');
    } else if (response.statusCode == 200) {
      var data = response.data["result"]["message"];
      return ResultStatus(message: data);
    } else {
      return ResultStatus(message: 'Add to Cart Failed.');
    }
  }
}
