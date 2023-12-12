// import '../view_models/user_vm.dart';
import 'dart:async';

import '../common/custom_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/product_by_cat.dart';
import '../models/result_status.dart';
import '../models/product_detail.dart';
import '../models/product_detail_with_attr_model.dart';
import './routes.dart';

class ProductDetailService {
  Future<ResultStatus> getDetailProducts(String prdId) async {
    ResultStatus result = ResultStatus();
    const secureStorage = FlutterSecureStorage();
    var sessionId = await secureStorage.read(key: 'sessionId');
    HttpProvider httpProvider = HttpProvider();

    var body = {
      "jsonrpc": "2.0",
      "params": {"barcode": prdId}
    };

    try {
      Response response = await httpProvider.post(
          reqWithCookie: true,
          route: getProductDetailWithProductTempIdApi,
          body: body);
      if (response.data["result"]["data"] != null) {
        Map<String, dynamic> resdata = response.data["result"]["data"];
        resdata["img_cookie"] = {"cookie": sessionId!};
        ProductDetail productDetail = ProductDetail.fromJson(resdata);
        result.data = productDetail;
      }
      return result;
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  static Future<ResultStatus> getProductDetailWithAttrCheck(
      int tempId, int productid, List<int> comList) async {
    HttpProvider httpProvider = HttpProvider();
    //category
    var body = {
      "jsonrpc": "2.0",
      "params": {
        "product_template_id": tempId,
        "product_id": productid,
        "combination": comList,
        "add_qty": 1,
        "pricelist_id": null,
        "parent_combination": []
      }
    };
    ResultStatus result = ResultStatus();
    Response response = await httpProvider.post(
        route: getProductDetailWithAttrApi, body: body, reqWithCookie: true);
    const storage = FlutterSecureStorage();
    if (response.data["result"] == null) {
      result.status = false;
      result.message = response.data["result"]["messgae"];
      return result;
    }
    var sessionId = await storage.read(key: 'sessionId');
    Map<String, dynamic> data = response.data["result"]["data"];
    data.addEntries({'cookie': sessionId}.entries);
    result.data = ProductWithAttribute.fromJson(data);
    return result;
  }

  Future<List<ProductByCat>> getPopularProduct() async {
    List<ProductByCat> productList = [];
    const storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');

    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var productbody = {"jsonrpc": "2.0", "params": {}};
    Response productResponse = await dio.post(getProductBestSellerApi,
        options: options, data: productbody);
    // print(_productresponse.data["result"]["data"]["products"]);
    productResponse.data["result"]["data"]["products"].forEach((data) {
      data["img_cookie"] = {"cookie": sessionId!};
      ProductByCat products = ProductByCat.fromJson(data);
      productList.add(products);
    });
    return productList;
  }
}
