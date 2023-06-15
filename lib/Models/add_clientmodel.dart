// To parse this JSON data, do
//
//     final addclientmodel = addclientmodelFromJson(jsonString);

import 'dart:convert';

Addclientmodel addclientmodelFromJson(String str) => Addclientmodel.fromJson(json.decode(str));

String addclientmodelToJson(Addclientmodel data) => json.encode(data.toJson());

class Addclientmodel {
  bool? error;
  String? message;
  Data? data;

  Addclientmodel({
    this.error,
    this.message,
    this.data,
  });

  factory Addclientmodel.fromJson(Map<String, dynamic> json) => Addclientmodel(
    error: json["error"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? firstName;
  String? lastName;
  String? city;
  String? mobile;
  String? type;
  String? userId;

  Data({
    this.firstName,
    this.lastName,
    this.city,
    this.mobile,
    this.type,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    city: json["city"],
    mobile: json["mobile"],
    type: json["type"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "city": city,
    "mobile": mobile,
    "type": type,
    "user_id": userId,
  };
}
