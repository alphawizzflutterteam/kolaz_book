// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  String?status;
  String?msg;
  bool? setting;

  LogoutModel({
    this.status,
    this.msg,
    this.setting,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    status: json["status"],
    msg: json["msg"],
    setting: json["setting"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "setting": setting,
  };
}
