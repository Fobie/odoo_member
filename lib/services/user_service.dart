// import 'package:ai_ecom_f3/view_models/user_vm.dart';
import 'dart:async';
import 'dart:io' as dart_io;
import 'dart:convert';

import '../models/common.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../common/custom_helper.dart';
import '../constants.dart';
import '../models/country.dart';
import './routes.dart';
import '../models/result_status.dart';
import '../models/app_user.dart';

class UserService {
  Future<CountryData> getCountry() async {
    List<Country> countryList = [];
    const storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');

    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var cartbody = {"jsonrpc": "2.0", "params": {}};
    //print(body);
    Response cartresponse =
        await dio.post(getCountryApi, options: options, data: cartbody);
    //print(cartresponse);
    countryList = [];

    cartresponse.data["result"]["data"].forEach((data) {
      Country country = Country.fromJson(data);
      countryList.add(country);
    });

    return CountryData(countryList: countryList);
  }

  Future<ResultStatus> fetchMemberPoint(int partnerId) async {
    ResultStatus result = ResultStatus();
    const storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", "cookie": sessionId},
    );
    var detailBody = {
      "jsonrpc": "2.0",
      "params": {
        "partner_id": partnerId,
      }
    };
    try {
      Response response = await dio.post(
        userDetailApi,
        options: options,
        data: detailBody,
      );
      if (!response.data["result"]["status"]) {
        result.status = false;
        result.message = response.data["result"]["message"];
        return result;
      }
      result = ResultStatus.formJson(response.data["result"]);
      return result;
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> requestOtpCode(String phone) async {
    Dio dio = Dio();
    var options = Options(
      // sendTimeout: 2 * 1000,
      // receiveTimeout: 2 * 1000,
      headers: {"Content-Type": "application/json"},
    );
    var body = {
      "jsonrpc": "2.0",
      "params": {"phone_nb": phone}
    };
    try {
      Response response =
          await dio.post(verifyPhApi, options: options, data: body);
      if (response.data["result"] != null) {
        return ResultStatus(
            status: true,
            message: "Success",
            data: response.data["result"]["data"]);
      } else {
        return ResultStatus(
            status: false, message: response.data["result"]["message"]);
      }
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> resetPassword(String phone, String password) async {
    HttpProvider httpProvider = HttpProvider();
    var body = {
      "jsonrpc": "2.0",
      "params": {"login_id": phone, "new_password": password}
    };
    try {
      Response response =
          await httpProvider.post(route: resetPasswordApi, body: body);
      return ResultStatus(
          status: response.data["result"]["status"],
          message: response.data["result"]["message"],
          data: null);
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> searchExitingMember(
      MemberSearchType searchMethods, String searchValue) async {
    HttpProvider httpProvider = HttpProvider();
    Map<String, String> dynamicParam = {};
    if (searchMethods == MemberSearchType.barcode) {
      dynamicParam["barcode"] = searchValue;
    } else {
      dynamicParam["phone"] = '+959$searchValue';
    }
    var detailBody = {"jsonrpc": "2.0", "params": dynamicParam};
    try {
      Response response = await httpProvider.post(
        route: searchUserApi,
        body: detailBody,
      );
      // dynamic response.statusCode == 200;
      if (response.data["result"]["data"] != null &&
          response.data["result"]["data"] != "0001") {
        return ResultStatus(
            status: true,
            message: "Success",
            data: AppUser.fromJson(response.data["result"]["data"]));
      } else {
        return ResultStatus(
            status: false, message: response.data["result"]["message"]);
      }
    } on DioException catch (error) {
      return CustomHelper.catchDioError(error);
    }
  }

  Future<ResultStatus> authenticate(
      {required String email, required String password}) async {
    HttpProvider httpProvider = HttpProvider();
    var body = {
      "jsonrpc": "2.0",
      "params": {
        "login": email.trim(),
        "password": password.trim(),
      }
    };
    try {
      Response response = await httpProvider.post(route: loginApi, body: body);
      // print(response);
      final cookies = response.headers.map['set-cookie'];
      var sessionId = cookies![0].split(";")[0];
      String expString =
          cookies[0].split(";")[1].substring(9).replaceAll("-", " ");
      if (response.statusCode == 401) {
        return ResultStatus(
          status: false,
          message: 'Login Failed.',
        );
      } else if (response.statusCode == 200) {
        // Create storage
        const secureStorage = FlutterSecureStorage();
        // Write value
        await secureStorage.write(key: 'sessionId', value: sessionId);
        if (response.data["result"]["uid"] != null) {
          if (response.data["result"]["uid"] > 0) {
            Map<String, dynamic> jsonuser = response.data["result"];
            jsonuser.addAll({"session_id": sessionId});
            jsonuser.addAll({'session_expire': expString});

            // jsonuser["session_expire"] = expString;
            var detailBody = {
              "jsonrpc": "2.0",
              "params": {
                "partner_id": "${jsonuser["partner_id"]}",
              }
            };
            Response userDetailRes = await httpProvider.post(
                route: userDetailApi, body: detailBody, reqWithCookie: true);
            Map<String, dynamic> jsonuserDetail =
                userDetailRes.data["result"]["data"];
            jsonuser.addAll(jsonuserDetail);
            AppUser user = AppUser.fromJson(jsonuser);
            LocalStorageManager.saveData(
                CachedKey.odooUser, json.encode(user.toJson()));
            return ResultStatus(status: true, message: "Success");
          } else {
            return ResultStatus(status: false, message: "Not Found");
          }
        } else {
          return ResultStatus(status: false, message: "Invalid Credentials");
        }
      } else {
        return ResultStatus(status: false, message: 'Login Failed.');
      }
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> signUp(
      {phone, name, password, profileImg, partnerId}) async {
    String img64 = "";
    if (profileImg != null) {
      final bytes = dart_io.File(profileImg.path).readAsBytesSync();
      img64 = base64Encode(bytes);
    }
    HttpProvider httpProvider = HttpProvider();
    var body = {
      "jsonrpc": "2.0",
      "params": {
        "login_id": phone,
        "phone": phone,
        "name": name,
        "password": password,
        "profile_image": img64 == "" ? null : img64,
        "partner_id": partnerId,
      }
    };
    try {
      Response response = await httpProvider.post(route: signUpApi, body: body);
      if (response.statusCode == 200) {
        var data = response.data["result"];
        return ResultStatus(status: data["status"], message: data["message"]);
        // print(data);
        // return ResultStatus(
        //     status: true, message: "Successfully Signup.");
      } else {
        return ResultStatus(status: false, message: 'Signup failed.');
      }
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> changePassword(String oldpwd, String newpwd) async {
    const storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var body = {
      "jsonrpc": "2.0",
      "params": {"old_pwd": oldpwd, "new_pwd": newpwd}
    };
    try {
      Response response =
          await dio.post(changePasswordApi, options: options, data: body);
      if (response.statusCode == 401) {
        return ResultStatus(status: false, message: 'Update Failed');
      } else if (response.statusCode == 200) {
        var resData = response.data["result"];
        return ResultStatus(
            status: resData["status"], message: resData["message"]);
      } else {
        return ResultStatus(
            status: false,
            message: 'Requeest Failed with ${response.statusCode}');
      }
    } on DioException catch (e) {
      return CustomHelper.catchDioError(e);
    }
  }

  Future<ResultStatus> updateDetail(
      {required int partnerId,
      XFile? image,
      String? name,
      String? phone,
      String? email,
      String? address1,
      String? address2,
      String? country,
      String? state,
      String? city,
      String? township,
      String? zipcode}) async {
    const storage = FlutterSecureStorage();
    var sessionId = await storage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );
    var dynamicParam = <String, dynamic>{};
    dynamicParam["partner_id"] = partnerId;
    if (image != null) {
      final bytes = dart_io.File(image.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      dynamicParam["image_1920"] = img64;
    }
    if (name != null && name != "") dynamicParam["name"] = name;
    if (phone != null && phone != "") dynamicParam["phone"] = phone;
    if (email != null && email != "") dynamicParam["email"] = email;
    if (address1 != null && address1 != "") dynamicParam["street"] = address1;
    if (address2 != null && address2 != "") dynamicParam["street2"] = address2;
    if (country != null && country != "") dynamicParam["country_id"] = country;
    if (state != null && state != "") dynamicParam["state_id"] = state;
    if (city != null && city != "") dynamicParam["city"] = city;
    if (township != null && township != "") dynamicParam["township"] = township;
    if (zipcode != null && city != "") dynamicParam["zip"] = zipcode;

    var body = {
      "jsonrpc": "2.0",
      "params": dynamicParam,
    };
    Response response =
        await dio.post(updateUserDetailApi, options: options, data: body);
    if (response.statusCode == 401) {
      return ResultStatus(status: false, message: 'Update Failed');
    } else if (response.statusCode == 200) {
      var resData = response.data["result"];
      if (resData != null) {
        return ResultStatus(
            status: resData["status"], message: resData["message"]);
      } else {
        return ResultStatus(
            status: false, message: "some requested data might be failed!");
      }
    } else {
      return ResultStatus(
          status: false,
          message: 'Requeest Failed with ${response.statusCode}');
    }
  }
}
