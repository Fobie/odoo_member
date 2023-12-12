import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/app_user.dart';
import '../models/result_status.dart';

class CustomHelper {
  static ResultStatus catchDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.receiveTimeout:
        return ResultStatus(
          data: null,
          message: error.message ?? "Receive connection timeout.",
          status: false,
        );
      case DioExceptionType.sendTimeout:
        return ResultStatus(
          data: null,
          message: error.message ?? "Request connection timeout.",
          status: false,
        );
      case DioExceptionType.badCertificate:
        return ResultStatus(
          data: null,
          message: error.message ?? "Authorization error.",
          status: false,
        );
      case DioExceptionType.cancel:
        return ResultStatus(
          data: null,
          message: "Server can't be response right now",
          status: false,
        );
      case DioExceptionType.connectionError:
        return ResultStatus(
          data: null,
          message: error.message ?? "Network connection error.",
          status: false,
        );
      case DioExceptionType.unknown:
        return ResultStatus(
          data: null,
          message: error.message ?? "Unknown connection error occur.",
          status: false,
        );
      case DioExceptionType.badResponse:
        return ResultStatus(
          data: null,
          message: error.message ?? "Server can't be response right now.",
          status: false,
        );
      default:
        return ResultStatus(
          data: null,
          message: error.message ?? "Unhandle unknown error.",
          status: false,
        );
    }
  }

  // static String makeValidPhForApi(String phone) {
  //   if(phone.length>){

  //   }
  // }
  static String makeHtmlColorToRGBCode(String code) {
    return code.toUpperCase().replaceAll("#", "0xFF");
  }

  static String toHttpDateFormat(DateTime date) {
    const String httpDateFormat = 'EEE, dd MMM yyyy HH:mm:ss';
    final formatedDate = DateFormat(httpDateFormat).format(date);
    return '$formatedDate GMT';
  }

  static String makeValidNoToShow(String phone) {
    int subLength = 0;

    if (phone.startsWith('+959')) {
      subLength = 4;
    } else if (phone.trim().startsWith('959')) {
      subLength = 3;
    } else if (phone.trim().startsWith('09')) {
      subLength = 2;
    }
    return phone
        .substring(subLength)
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "");
  }

  static String? validateMobile(String? value) {
    String pattern = r'(^\+?[0-9]*$)';
    RegExp regExp = RegExp(pattern);

    if (value?.isEmpty ?? true) {
      return "Mobile phone number is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Mobile phone number must contain only digits";
    } else if (value!.startsWith("09")) {
      return "Please remove 09 from phone number";
    } else if (value.length < 7) {
      return "Please enter valid number";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);
    if (value != "" && value != null) {
      if (!regExp.hasMatch(value)) {
        return "Please enter valid email addresss";
      }
    }
    return null;
  }

  static String? validateBarcode(String? value) {
    String pattern = r'(^\+?[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value?.isEmpty ?? true) {
      return "Barcode is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Barcode must contain only digits";
    } else if (value!.length < 8) {
      return "Member barcode must be at leaset 8 characters";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value!.isEmpty) {
      return 'Comfirm password can\'t be blank.';
    } else if (value != password) {
      return 'Password and comfirm password doesn\'t match';
    }
    return null;
  }
}

class HttpProvider {
  Dio dioClient = Dio();
  final options = Options(
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {"Content-Type": "application/json"},
  );
  Future<Response> get(
      {required String route,
      required Map<String, dynamic> body,
      bool reqWithCookie = false}) async {
    if (reqWithCookie) {
      const storage = FlutterSecureStorage();
      var sessionId = await storage.read(key: 'sessionId');
      options.headers!["Cookie"] = sessionId;
    }
    return dioClient.get(route, options: options);
  }

  Future<Response> post(
      {required String route,
      required Map<String, dynamic> body,
      String? session,
      bool reqWithCookie = false}) async {
    if (session != null) {
      options.headers!["Cookie"] = session;
    }
    if (session == null && reqWithCookie) {
      const storage = FlutterSecureStorage();
      session = await storage.read(key: 'sessionId');
      options.headers!["Cookie"] = session;
    }
    return dioClient.post(route, data: body, options: options);
  }
}

class LocalStorageManager {
  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      if (kDebugMode) print('save in string');
      prefs.setString(key, value.toString());
    }
  }

  static void saveListOfData(String key, dynamic value) async {}

  static Future<bool> hasData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  ///must use [hasData] method to prevent from data being null
  static Future<dynamic> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic obj = prefs.get(key);
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  ///getting cached user from shareprefencenses reducing boilerplate code
  static Future<AppUser> getCachedUserData() async {
    var extractedUser =
        await LocalStorageManager.readData(CachedKey.odooUser) as String;
    var decodeRes = json.decode(extractedUser);
    return AppUser.fromJson(decodeRes);
  }
}
