// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

Faq faqFromJson(String str) => Faq.fromJson(json.decode(str));

String faqToJson(Faq data) => json.encode(data.toJson());

class Faq {
  String? status;
  String? msg;
  List<Faqdata>? setting;

  Faq({
    this.status,
    this.msg,
    this.setting,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    status: json["status"],
    msg: json["msg"],
    setting: List<Faqdata>.from(json["setting"].map((x) => Faqdata.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "setting": List<dynamic>.from(setting!.map((x) => x.toJson())),
  };
}

class Faqdata {
  String? id;
  String? title;
  String? description;

  Faqdata({
    this.id,
    this.title,
    this.description,
  });

  factory Faqdata.fromJson(Map<String, dynamic> json) => Faqdata(
    id: json["id"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
  };
}
