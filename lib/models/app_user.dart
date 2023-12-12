import 'dart:io';

import '../../common/custom_helper.dart';

class AppUser {
  final int uid;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String barcode;
  final double loyaltyPoints;
  final String partnerDisplayName;
  final int partnerId;
  final String sessionId;
  final DateTime? sessionExpireDate;
  final String imgUrl128;
  final String base64Profile;
  final String street;
  final String street2;
  final String city;
  final String zip;
  final String state;
  final String country;

  AppUser({
    this.uid = -1,
    this.name = "",
    this.username = "",
    this.phone = "",
    this.email = "",
    this.barcode = "",
    this.loyaltyPoints = 0.0,
    this.partnerDisplayName = "",
    this.partnerId = -1,
    this.sessionId = "",
    this.sessionExpireDate,
    this.imgUrl128 = "",
    this.base64Profile = "",
    this.street = "",
    this.street2 = "",
    this.city = "",
    this.zip = "",
    this.state = "",
    this.country = "",
  });

  factory AppUser.fromJson(Map<String, dynamic> user) => AppUser(
      uid: user["uid"] ?? -1,
      name: user["name"],
      username: user["username"] ?? "",
      phone: user["phone"] == false
          ? ""
          : CustomHelper.makeValidNoToShow(
              (user["phone"] as String).replaceAll(" ", "")),
      email: user["email"] == false ? "" : user["email"],
      partnerDisplayName: user["partner_display_name"] ?? "",
      partnerId: user["partner_id"],
      barcode: user["barcode"] == false ? "" : user["barcode"],
      sessionId: user["session_id"] ?? "",
      sessionExpireDate: user["session_expire"] != null
          ? HttpDate.parse(user["session_expire"])
          : null,
      imgUrl128: user["image_url"],
      base64Profile: user["image"] == false ? "" : user["image"],
      city: user["city"] == false ? "" : user["city"],
      country: user["country"] == false ? "" : user["country"],
      state: user["state"] == false ? "" : user["state"],
      street: user["street"] == false ? "" : user["street"],
      street2: user["street2"] == false ? "" : user["street2"],
      zip: user["zip"] == false ? "" : user["zip"],
      loyaltyPoints: user['loyalty_points'] ?? 0.0);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'phone': phone,
      'email': email,
      'partner_display_name': partnerDisplayName,
      'partner_id': partnerId,
      'barcode': barcode,
      'session_id': sessionId,
      'session_expire':
          CustomHelper.toHttpDateFormat(sessionExpireDate ?? DateTime.now()),
      'image_url': imgUrl128,
      'image': base64Profile,
      'city': city,
      'country': country,
      'state': state,
      'street': street,
      'street2': street2,
      'zip': zip,
      'loyalty_points': loyaltyPoints,
    };
  }

  AppUser copyWith({
    int? uid,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? barcode,
    double? loyaltyPoints,
    String? partnerDisplayName,
    int? partnerId,
    String? sessionId,
    String? sessionExpireDate,
    String? imgUrl128,
    String? base64Profile,
    String? street,
    String? street2,
    String? city,
    String? zip,
    String? state,
    String? country,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      partnerDisplayName: partnerDisplayName ?? this.partnerDisplayName,
      partnerId: partnerId ?? this.partnerId,
      sessionId: sessionId ?? this.sessionId,
      sessionExpireDate: this.sessionExpireDate,
      name: name ?? this.name,
      username: username ?? this.username,
      base64Profile: base64Profile ?? this.base64Profile,
      city: city ?? this.city,
      country: country ?? this.country,
      email: email ?? this.email,
      imgUrl128: imgUrl128 ?? this.imgUrl128,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      street2: street2 ?? this.street2,
      street: street ?? this.street,
      barcode: barcode ?? this.barcode,
      zip: zip ?? this.zip,
    );
  }
}
