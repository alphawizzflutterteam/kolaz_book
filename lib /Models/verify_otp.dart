// To parse this JSON data, do
//
//     final verifyOtpResponse = verifyOtpResponseFromJson(jsonString);

import 'dart:convert';

ResendOtpResponse resendOtpResponseFromJson(String str) => ResendOtpResponse.fromJson(json.decode(str));

String verifyOtpResponseToJson(ResendOtpResponse data) => json.encode(data.toJson());

class ResendOtpResponse {
  bool? error;
  String? message;
  String? mobile;
  int? otp;

  ResendOtpResponse({
    this.error,
    this.message,
    this.mobile,
    this.otp,
  });

  factory ResendOtpResponse.fromJson(Map<String, dynamic> json) => ResendOtpResponse(
    error: json["error"],
    message: json["message"],
    mobile: json["mobile"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "mobile": mobile,
    "otp": otp,
  };
}
