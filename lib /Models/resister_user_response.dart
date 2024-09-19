// To parse this JSON data, do
//
//     final registerUserResponse = registerUserResponseFromJson(jsonString);

import 'dart:convert';

RegisterUserResponse registerUserResponseFromJson(String str) => RegisterUserResponse.fromJson(json.decode(str));

String registerUserResponseToJson(RegisterUserResponse data) => json.encode(data.toJson());

class RegisterUserResponse {
  bool? error;
  String? message;

  RegisterUserData? data;

  RegisterUserResponse({
    this.error,
    this.message,
    this.data,
  });

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) => RegisterUserResponse(
    error: json["error"],
    message: json["message"],
    data: RegisterUserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data!.toJson(),
  };
}

class RegisterUserData {
  String? fname;
  String? lname;
  String? email;
  String? mobile;
  String? password;
  int? otp;

  RegisterUserData({
    this.fname,
    this.lname,
    this.email,
    this.mobile,
    this.password,
    this.otp,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) => RegisterUserData(
    otp: json["otp"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    mobile: json["mobile"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "email": email,
    "mobile": mobile,
    "password": password,
    "otp":otp,
  };
}
