// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) => SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

  class SubscriptionModel {
  String? responseCode;
  String? msg;
  List<Datum>? data;

  SubscriptionModel({
    this.responseCode,
    this.msg,
    this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    responseCode: json["response_code"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? title;
  String? description;
  int? price;
  String? device;
  String? time;
  String? type;
  String? image;
  List<Json>? json;
  DateTime?createdAt;
  DateTime?updatedAt;
  String? timeText;
  String? planType;

  Datum({
    this.id,
    this.title,
    this.description,
    this.price,
    this.device,
    this.time,
    this.type,
    this.image,
    this.json,
    this.createdAt,
    this.updatedAt,
    this.timeText,
    this.planType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    device: json["device"],
    time: json["time"],
    type: json["type"],
    image: json["image"],
    json: List<Json>.from(json["json"].map((x) => Json.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    timeText: json["time_text"],
    planType: json["plan_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "device": device,
    "time": time,
    "type": type,
    "image": image,
    "json": List<dynamic>.from(json!.map((x) => x.toJson())),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "time_text": timeText,
    "plan_type": planType,
  };
}

class Json {
  String? title;
  dynamic isTrue;

  Json({
    this.title,
    this.isTrue,
  });

  factory Json.fromJson(Map<String, dynamic> json) => Json(
    title: json["title"],
    isTrue: json["is_true"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "is_true": isTrue,
  };
}
