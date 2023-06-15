// To parse this JSON data, do
//
//     final addPhotographer = addPhotographerFromJson(jsonString);

import 'dart:convert';

AddPhotographer addPhotographerFromJson(String str) => AddPhotographer.fromJson(json.decode(str));

String addPhotographerToJson(AddPhotographer data) => json.encode(data.toJson());

class AddPhotographer {
  bool? error;
  String? message;
  Data? data;

  AddPhotographer({
    this.error,
    this.message,
    this.data,
  });

  factory AddPhotographer.fromJson(Map<String, dynamic> json) => AddPhotographer(
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
  String? photographerType;
  String? compnyName;
  String? perDayCharges;
  String? type;
  String? userId;

  Data({
    this.firstName,
    this.lastName,
    this.city,
    this.mobile,
    this.photographerType,
    this.compnyName,
    this.perDayCharges,
    this.type,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    city: json["city"],
    mobile: json["mobile"],
    photographerType: json["photographer_type"],
    compnyName: json["compny_name"],
    perDayCharges: json["per_day_charges"],
    type: json["type"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "city": city,
    "mobile": mobile,
    "photographer_type": photographerType,
    "compny_name": compnyName,
    "per_day_charges": perDayCharges,
    "type": type,
    "user_id": userId,
  };
}
