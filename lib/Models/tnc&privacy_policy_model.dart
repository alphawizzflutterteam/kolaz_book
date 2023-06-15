// To parse this JSON data, do
//
//     final getsetting = getsettingFromJson(jsonString);

import 'dart:convert';

Getsetting getsettingFromJson(String str) => Getsetting.fromJson(json.decode(str));

String getsettingToJson(Getsetting data) => json.encode(data.toJson());

class Getsetting {
  String? status;
  String? msg;
  List<Setting>? setting;

  Getsetting({
    this.status,
    this.msg,
    this.setting,
  });

  factory Getsetting.fromJson(Map<String, dynamic> json) => Getsetting(
    status: json["status"],
    msg: json["msg"],
    setting: List<Setting>.from(json["setting"].map((x) => Setting.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "setting": List<dynamic>.from(setting!.map((x) => x.toJson())),
  };
}

class Setting {
  String?id;
  String?title;
  String?slug;
  String?html;
  DateTime? createdAt;
  DateTime? updatedAt;

  Setting({
    this.id,
    this.title,
    this.slug,
    this.html,
    this.createdAt,
    this.updatedAt,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    html: json["html"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "html": html,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
