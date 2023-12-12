import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './routes.dart';
import '../models/result_status.dart';
import '../models/wish_list.dart';

class WishListService {
  Future<List<WishList>?> getWishList() async {
    // Future<WishListData?> getWishList() async {
    List<WishList> wishList = [];
    const storage = FlutterSecureStorage();
    //var sessionId = "session_id=b93668d91b8dedb78ee6ebec8e6a7b753192444a";
    var sessionId = await storage.read(key: 'sessionId');

    if (sessionId != null) {
      Dio dio = Dio();

      var options = Options(
        headers: {"Content-Type": "application/json", 'Cookie': sessionId},
      );

      var body = {"jsonrpc": "2.0", "params": {}};

      Response response =
          await dio.post(getWishListApi, options: options, data: body);

      response.data["result"]["data"].forEach(
        (data) {
          data["img_cookie"] = {"cookie": sessionId};
          WishList list = WishList.fromJson(data);
          wishList.add(list);
        },
      );
      //wishList: wishList));
      //return WishListData(wishList: wishList);
      return wishList;
    } else {
      return null;
    }
    // return null;
  }

  // Future<ResultStatus> addToWishList(int id) async {
  //   final storage = Storage.FlutterSecureStorage();
  //   var sessionId = await storage.read(key: 'sessionId');
  //   Dio dio = Dio();
  //   var options = Options(
  //     headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
  //   );

  //   var body = {
  //     "jsonrpc": "2.0",
  //     "params": {"product_id": id}
  //   };
  //   //   Response response =
  //       await dio.post(addWhishListApi, options: options, data: body);
  //     //   if (response.statusCode == 401) {
  //       //     return ResultStatus(
  //         status: false, statusCode: 401, message: 'Add to WishList Failed.');
  //   } else if (response.statusCode == 200) {
  //     var data = response.data["result"]["message"];
  //     return ResultStatus(status: true, statusCode: 200, message: data);
  //   } else {
  //     return ResultStatus(
  //         status: false,
  //         statusCode: response.statusCode!.toInt(),
  //         message: 'Add to WishList Failed.');
  //   }
  // }

  Future<ResultStatus> addRemoveWishListFromProductCart(
      int id, bool favourite) async {
    List<WishList> wishList = [];
    const storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );

    String api;
    Map<String, Object> body;

    if (favourite == true) {
      api = addWishListApi;
      body = {
        "jsonrpc": "2.0",
        "params": {"product_id": id}
      };
    } else {
      api = removeWishListApi;

      WishListService wishListDataService = WishListService();
      //WishListData? wishListData = await wishListDataService.getWishList();
      List<WishList>? wishListData = await wishListDataService.getWishList();
      if (wishListData != null) {
        wishList = wishListData;
      }
      for (var element in wishList) {
        if (element.product_id == id) {
          id = element.id;
        }
      }

      body = {
        "jsonrpc": "2.0",
        "params": {"wish_id": id}
      };
    }
    Response response = await dio.post(api, options: options, data: body);
    if (response.statusCode == 401) {
      return ResultStatus(status: false, message: 'Add to WishList Failed.');
    } else if (response.statusCode == 200) {
      var data = response.data["result"]["message"];
      return ResultStatus(status: true, message: data);
    } else {
      return ResultStatus(status: false, message: 'Add to WishList Failed.');
    }
  }
}
