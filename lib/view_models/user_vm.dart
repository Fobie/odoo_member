import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/common.dart';
import '../models/app_user.dart';
import '../models/result_status.dart';
import '../common/custom_helper.dart';
import '../constants.dart';
import '../services/user_service.dart';

class UserVM extends ChangeNotifier {
  AppUser _user = AppUser();
  AppUser _existingUser = AppUser();
  AppUser get existingUser => _existingUser;
  String _qrString = "";

  bool get isAuth {
    return _user.sessionId != "";
  }

  String get qrData {
    return _qrString;
  }

  AppUser get user {
    return _user;
  }

  Future<void> changeSearchCount({int searchLimit = 5}) async {
    bool hasSearchCount = await LocalStorageManager.hasData(CachedKey.count);
    int searchCount = 1;
    if (hasSearchCount) {
      searchCount = await LocalStorageManager.readData(CachedKey.count) as int;
      searchCount++;
      if (kDebugMode) print('hasSearchCount true with count : $searchCount');
      LocalStorageManager.saveData(CachedKey.count, searchCount);
    } else {
      if (kDebugMode) print('hasSearchCount false with count: $searchCount');
      LocalStorageManager.saveData(CachedKey.count, ++searchCount);
    }
    if (searchCount == searchLimit) {
      if (kDebugMode) print('time cached');
      LocalStorageManager.saveData(CachedKey.time, DateTime.now().toString());
    }
  }

  Future<bool> isValidToSearch(
      {Duration duration = const Duration(minutes: 15)}) async {
    bool hasDateTime = await LocalStorageManager.hasData(CachedKey.time);
    if (hasDateTime) {
      String stringTime = await LocalStorageManager.readData(CachedKey.time);
      if (DateTime.now().isBefore(DateTime.parse(stringTime).add(duration))) {
        if (kDebugMode) print('invalid search');
        return false;
      } else {
        if (kDebugMode) print('valid search');
        LocalStorageManager.deleteData(CachedKey.count);
        LocalStorageManager.deleteData(CachedKey.time);
        return true;
      }
    } else {
      if (kDebugMode) print('valid search');
      return true;
    }
  }

  Future<ResultStatus> resetForgetPassword(
      String loginId, String password) async {
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.resetPassword(loginId, password);
    return result;
  }

  Future<ResultStatus> requestOtp(String phone) async {
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.requestOtpCode(phone);
    return result;
  }

  Future<ResultStatus> fetchMemberPoint() async {
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.fetchMemberPoint(_user.partnerId);
    if (result.status) {
      final user = AppUser.fromJson(result.data);
      _user = _user.copyWith(loyaltyPoints: user.loyaltyPoints);
      notifyListeners();
    }
    return result;
    // _memberPoint += 10;
  }

  Future<dynamic> searchExitingMember(
      MemberSearchType methods, String value) async {
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.searchExitingMember(methods, value);
    if (result.status) {
      _existingUser = result.data;
      notifyListeners();
    }
    return result;
  }

  Future<ResultStatus> changePassword(String oldpwd, String newpwd) async {
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.changePassword(oldpwd, newpwd);
    return result;
  }

  Future<ResultStatus> updateDetailInfo(
      {XFile? img,
      String? name,
      String? email,
      String? phone,
      String? address1,
      String? address2,
      String? township,
      String? city,
      String? state,
      String? zipcode}) async {
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.updateDetail(
        partnerId: user.partnerId,
        email: email,
        phone: phone,
        image: img,
        name: name,
        address1: address1,
        address2: address2,
        township: township,
        city: city,
        state: state,
        zipcode: zipcode);
    if (result.status == true) {
      Map<String, dynamic> newdata = user.toJson();
      if (img != null && img.path != "") {
        final bytes = File(img.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        newdata["image"] = img64;
      }
      if (name != null && name != "") newdata["name"] = name;
      if (email != null && email != "") newdata["email"] = email;
      if (phone != null && phone != "") newdata["phone"] = phone;
      if (address1 != null && address1 != "") newdata["street"] = address1;
      if (address2 != null && address2 != "") newdata["street2"] = address2;
      if (state != null && state != "") newdata["state"] = state;
      if (city != null && city != "") newdata["city"] = city;
      if (township != null && township != "") newdata["township"] = township;
      if (zipcode != null && zipcode != "") newdata["zip"] = zipcode;
      AppUser tempuser = AppUser.fromJson(newdata);
      _user = tempuser;
      notifyListeners();
      LocalStorageManager.saveData(
          CachedKey.odooUser, json.encode(tempuser.toJson()));
    }
    return result;
  }

  Future<ResultStatus> updateShippingAddress(String address1, String address2,
      String township, String city, String state, String zipcode) async {
    // print(
    //     'Name :${user.name} \n Address1 :$address1 \n Address2 :$address2 \n township :$township \n city: $city \n Country :$country \n State :$state \n Zipcode :$zipcode');
    UserService userSvr = UserService();
    ResultStatus result = await userSvr.updateDetail(
        partnerId: user.partnerId,
        address1: address1,
        address2: address2,
        township: township,
        city: city,
        state: state,
        zipcode: zipcode);
    return result;
  }

  Future<void> userQrGenerate() async {
    int timestamp = (DateTime.now().millisecondsSinceEpoch * 4) - 11272968;

    _qrString = "${_user.barcode}|$timestamp";
  }

  Future<void> tryAutoLogin() async {
    final extracedUserData =
        await LocalStorageManager.readData(CachedKey.odooUser) as String?;
    if (extracedUserData != null) {
      _user = AppUser.fromJson(json.decode(extracedUserData));
      _tryAutoLogout();
    }
    if (isAuth) {
      notifyListeners();
    }
  }

  Future<ResultStatus> login(String email, String password) async {
    UserService userSvr = UserService();
    final authResult = await userSvr.authenticate(
      email: email,
      password: password,
    );
    if (authResult.status) {
      tryAutoLogin();
    }
    return authResult;
  }

  Future<ResultStatus> signup(String phone, String name, String password,
      XFile? profileImg, int? partnerId) async {
    UserService userSvr = UserService();
    ResultStatus authResult = await userSvr.signUp(
        phone: phone,
        name: name,
        password: password,
        profileImg: profileImg,
        partnerId: partnerId);
    return authResult;
  }

  // void _autoLogout() {
  //   DateTime newDt = _user.sessionExpireDate!;
  //   final timeToExpiry = newDt.difference(DateTime.now()).inSeconds;
  //   Timer(Duration(seconds: timeToExpiry), logout);
  // }

  void _tryAutoLogout() {
    final currentTime = DateTime.now();
    final expireDate = _user.sessionExpireDate;
    if (kDebugMode) {
      print('$currentTime is current Time');
      print('$expireDate is expireDate Time');
    }
    if (expireDate != null) {
      if (expireDate.isBefore(currentTime)) {
        if (kDebugMode) {
          print(
              '${expireDate.isBefore(currentTime)}: currentTime is after expire Date');
        }
        logout();
      } else {
        final timeToExpiry = expireDate.difference(currentTime).inSeconds;
        Timer(Duration(seconds: timeToExpiry), logout);
      }
    }
  }

  Future<void> logout() async {
    _user = AppUser();

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    const secureStorage = FlutterSecureStorage();
    // prefs.remove('userData');
    secureStorage.delete(key: "sessionId");
    prefs.clear();
  }
}
