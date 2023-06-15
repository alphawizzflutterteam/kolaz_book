// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

GetProfile getProfileFromJson(String str) => GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
  bool? error;
  String? message;
  ProfileDataList? data;

  GetProfile({
    this.error,
    this.message,
    this.data,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
    error: json["error"],
    message: json["message"],
    data: ProfileDataList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileDataList {
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
  dynamic facebook;
  dynamic note;
  dynamic instagram;
  dynamic youtube;
  dynamic companyName;
  dynamic companyNumber;
  String? type;
  String? isGold;
  String? address;
  dynamic companyAddress;
  String? city;
  String? country;
  String? deviceToken;
  String? date;
  String? agreecheck;
  String? otp;
  String? status;
  String? wallet;
  dynamic oauthProvider;
  dynamic oauthUid;
  dynamic lastLogin;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileDataList({
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
    this.facebook,
    this.note,
    this.instagram,
    this.youtube,
    this.companyName,
    this.companyNumber,
    this.type,
    this.isGold,
    this.address,
    this.companyAddress,
    this.city,
    this.country,
    this.deviceToken,
    this.date,
    this.agreecheck,
    this.otp,
    this.status,
    this.wallet,
    this.oauthProvider,
    this.oauthUid,
    this.lastLogin,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileDataList.fromJson(Map<String, dynamic> json) => ProfileDataList(
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
    facebook: json["facebook"],
    note: json["note"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    companyName: json["company_name"],
    companyNumber: json["company_number"],
    type: json["type"],
    isGold: json["isGold"],
    address: json["address"],
    companyAddress: json["company_address"],
    city: json["city"],
    country: json["country"],
    deviceToken: json["device_token"],
    date: json["date"],
    agreecheck: json["agreecheck"],
    otp: json["otp"],
    status: json["status"],
    wallet: json["wallet"],
    oauthProvider: json["oauth_provider"],
    oauthUid: json["oauth_uid"],
    lastLogin: json["last_login"],
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
    "facebook": facebook,
    "note": note,
    "instagram": instagram,
    "youtube": youtube,
    "company_name": companyName,
    "company_number": companyNumber,
    "type": type,
    "isGold": isGold,
    "address": address,
    "company_address": companyAddress,
    "city": city,
    "country": country,
    "device_token": deviceToken,
    "date": date,
    "agreecheck": agreecheck,
    "otp": otp,
    "status": status,
    "wallet": wallet,
    "oauth_provider": oauthProvider,
    "oauth_uid": oauthUid,
    "last_login": lastLogin,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
