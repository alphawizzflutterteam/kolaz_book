// To parse this JSON data, do
//
//     final verifyOtpResponse = verifyOtpResponseFromJson(jsonString);

import 'dart:convert';

VerifyOtpResponse verifyOtpResponseFromJson(String str) => VerifyOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(VerifyOtpResponse data) => json.encode(data.toJson());

class VerifyOtpResponse {
  bool? error;
  String? message;
  String? otp;
  OtpVerifyData? data;

  VerifyOtpResponse({
    this.error,
    this.message,
    this.otp,
    this.data,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) => VerifyOtpResponse(
    error: json["error"],
    message: json["message"],
    otp: json["otp"],
    data: OtpVerifyData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "otp": otp,
    "data": data!.toJson(),
  };
}

class OtpVerifyData {
  String? id;
  String? username;
  String? email;
  String? fname;
  String? lname;
  String? countrycode;
  String? currency;
  String? mobile;
  String? companyLogo;
  String? companyLink;
  String? password;
  String? profilePic;

  String? type;
  String? isGold;
  String? address;
  String? city;
  String? country;
  String? deviceToken;
  String? date;
  String? agreecheck;
  String? otp;
  String? status;
  String? wallet;

  DateTime? createdAt;
  DateTime? updatedAt;

  OtpVerifyData({
    this.id,
    this.username,
    this.email,
    this.fname,
    this.lname,
    this.countrycode,
    this.currency,
    this.mobile,
    this.companyLogo,
    this.companyLink,
    this.password,
    this.profilePic,

    this.type,
    this.isGold,
    this.address,
    this.city,
    this.country,
    this.deviceToken,
    this.date,
    this.agreecheck,
    this.otp,
    this.status,
    this.wallet,

    this.createdAt,
    this.updatedAt,
  });

  factory OtpVerifyData.fromJson(Map<String, dynamic> json) => OtpVerifyData(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    fname: json["fname"],
    lname: json["lname"],
    countrycode: json["countrycode"],
    currency: json["currency"],
    mobile: json["mobile"],
    companyLogo: json["company_logo"],
    companyLink: json["company_link"],
    password: json["password"],
    profilePic: json["profile_pic"],

    type: json["type"],
    isGold: json["isGold"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    deviceToken: json["device_token"],
    date: json["date"],
    agreecheck: json["agreecheck"],
    otp: json["otp"],
    status: json["status"],
    wallet: json["wallet"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "fname": fname,
    "lname": lname,
    "countrycode": countrycode,
    "currency": currency,
    "mobile": mobile,
    "company_logo": companyLogo,
    "company_link": companyLink,
    "password": password,
    "profile_pic": profilePic,

    "type": type,
    "isGold": isGold,
    "address": address,
    "city": city,
    "country": country,
    "device_token": deviceToken,
    "date": date,
    "agreecheck": agreecheck,
    "otp": otp,
    "status": status,
    "wallet": wallet,

    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
