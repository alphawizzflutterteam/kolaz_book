// To parse this JSON data, do
//
//     final addQuatation = addQuatationFromJson(jsonString);

import 'dart:convert';

AddQuatation addQuatationFromJson(String str) => AddQuatation.fromJson(json.decode(str));

String addQuatationToJson(AddQuatation data) => json.encode(data.toJson());

class AddQuatation {
  bool? error;
  String? message;
  Data? data;

  AddQuatation({this.error, this.message, this.data});

  AddQuatation.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? clientName;
  String? type;
  String? city;
  String? userId;
  int? qid;
  String? output;
  String? amount;

  Data(
      {this.clientName,
        this.type,
        this.city,
        this.userId,
        this.qid,
        this.output,
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    clientName = json['client_name'];
    type = json['type'];
    city = json['city'];
    userId = json['user_id'];
    qid = json['qid'];
    output = json['output'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_name'] = this.clientName;
    data['type'] = this.type;
    data['city'] = this.city;
    data['user_id'] = this.userId;
    data['qid'] = this.qid;
    data['output'] = this.output;
    data['amount'] = this.amount;
    return data;
  }
}
