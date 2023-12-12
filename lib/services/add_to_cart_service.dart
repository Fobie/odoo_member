// import 'package:flutter/material.dart';
// import './routes.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;

// import '../models/add_to_cart.dart';
// import '../models/product_detail.dart';

// class AddToCartService {
//   Future<AddtoCart> addToCart(List<ProductDetail> _productDetailList) async {
//     const secureStorage = storage.FlutterSecureStorage();
//     //final storage = storage.FlutterSecureStorage();
//     var sessionId = await secureStorage.read(key: 'sessionId');

//     Dio dio = Dio();
//     var options = Options(
//       headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
//     );

//     var body = {
//       "jsonrpc": "2.0",
//       "params": {
//         // "product_id": _productDetailList[0].id,
//         // "add_qty": _productDetailList[0].qty
//       }
//     };
//     Response response =
//         await dio.post(getProductListApi, options: options, data: body);

//     if (response.statusCode == 401) {
//       print('fail');
//       return AddtoCart(401, 'Add to Cart Failed.');
//     } else if (response.statusCode == 200) {
//       var data = response.data["result"]["message"];
//       return AddtoCart(200, data);
//     } else {
//       return AddtoCart(response.statusCode!.toInt(), 'Add to Cart Failed.');
//     }
//   }
// }
