// To parse this JSON data, do
//
//     final forgotPassword = forgotPasswordFromJson(jsonString);

import 'dart:convert';

ForgotPassword forgotPasswordFromJson(String str) => ForgotPassword.fromJson(json.decode(str));

String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());

class ForgotPassword {
  int? status;
  String? msg;
  int? newPass;

  ForgotPassword({
    this.status,
    this.msg,
    this.newPass,
  });

  factory ForgotPassword.fromJson(Map<String, dynamic> json) => ForgotPassword(
    status: json["status"],
    msg: json["msg"],
    newPass: json["new_pass"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "new_pass": newPass,
  };
}
