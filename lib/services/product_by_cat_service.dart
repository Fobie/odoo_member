import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:c4e_rewards/models/point_history.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

import '../models/result_status.dart';

import '../common/custom_helper.dart';
import '../models/product_by_cat.dart';
import '../models/promotion_sheet.dart';
import './routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;

class ProductService {
  Future<List<ProductByCat>> getProductbyCatID(int catID) async {
    List<ProductByCat> productList = [];
    const secureStorage = storage.FlutterSecureStorage();
    //final storage = storage.FlutterSecureStorage();
    var sessionId = await secureStorage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var productbody = {
      "jsonrpc": "2.0",
      "params": {"category": catID}
    };

    Response productresponse =
        await dio.post(getProductListApi, options: options, data: productbody);

    // print(_productresponse.data["result"]["data"]["products"]);
    productresponse.data["result"]["data"]["products"].forEach((data) {
      data["img_cookie"] = {"cookie": sessionId!};
      ProductByCat product = ProductByCat.fromJson(data);
      productList.add(product);
    });

    return productList;
  }

  Future<List<ProductByCat>> serachProducts(String searchContext, int? catId) async {
    List<ProductByCat> productList = [];
    const secureStorage = storage.FlutterSecureStorage();
    //final storage = storage.FlutterSecureStorage();
    var sessionId = await secureStorage.read(key: 'sessionId');

    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var searchParams = <String, dynamic>{};
    searchParams["search"] = searchContext;
    searchParams["page"] = 0;
    searchParams["ppg"] = 100;
    if (catId != null) searchParams["category"] = catId;

    var productbody = {"jsonrpc": "2.0", "params": searchParams};

    Response productresponse =
        await dio.post(getProductListApi, options: options, data: productbody);

    // print(_productresponse.data["result"]["data"]["products"]);
    productresponse.data["result"]["data"]["products"].forEach((data) {
      data["img_cookie"] = {"cookie": sessionId!};
      ProductByCat product = ProductByCat.fromJson(data);
      productList.add(product);
    });
    return productList;
  }

  Future<ResultStatus> getProductAds() async {
    ResultStatus result = ResultStatus();
    const secureStorage = storage.FlutterSecureStorage();
    var sessionId = await secureStorage.read(key: 'sessionId');
    HttpProvider httpProvider = HttpProvider();

    var body = {
      "jsonrpc": "2.0",
      "params": {
        "types" : [
          "01_reward",
          "02_campaing",
          "03_banner"
        ]
      }
    };

    try {
      Response response = await httpProvider.post(
          route: promotionSheetsApi, body: body, session: sessionId);
      if (response.data['error'] != null) {
        result.status = false;
        result.message = response.data['error']['message'];
        // print(result.data);
        return result;
      }
      if (!response.data["result"]['status']) {
        result.status = false;
        result.message = response.data["result"]['message'];
        return result;
      }
        List<Products> sheets = [];
        for (var promodata in (response.data["result"]['data'] as List)) {
          promodata["sessionId"] = {"Cookie": sessionId!};
          Products newsheet = Products.fromJson(promodata);
          sheets.add(newsheet);
        }
        result.data = sheets;
      return result;
    } on DioException catch(e){
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> getPointHistory() async {
    ResultStatus result = ResultStatus();
    const secureStorage = storage.FlutterSecureStorage();
    var sessionId = await secureStorage.read(key: 'sessionId');
    HttpProvider httpProvider = HttpProvider();

    var body = {
      "jsonrpc": "2.0",
      "params": {
        "partner_id" : 14
      }
    };

    try {
      Response response = await httpProvider.post(
          route: pointHistoryApi, body: body, session: sessionId);
      // print(response.data);
      if (response.data['error'] != null) {
        result.status = false;
        result.message = response.data['error']['message'];
        return result;
      }
      if (!response.data["result"]['status']) {
        result.status = false;
        result.message = response.data["result"]['message'];
        return result;
      }
      List<PointHistory> sheets = [];

      response.data["result"]["data"].forEach((data) {
        data["date_order"] = {"cookie": sessionId!};
        PointHistory product = PointHistory.fromJson(data);
        sheets.add(product);
      });
      result.data = sheets;

      return result;
    } on DioException catch(e){
      return CustomHelper.catchDioError(e);
    }
  }

}
