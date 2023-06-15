/// response_code : "1"
/// msg : "Get Date"
/// data : [{"id":"176","first_name":"client","last_name":"gi","city":"bombay","mobile":"2147483647","photographer_type":null,"compny_name":null,"per_day_charges":null,"type":"client","status":"1","created_at":"2023-06-08 12:39:28","user_id":"5"}]
import 'dart:convert';

ClientModel clientModelFromJson(String str) => ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());


class ClientModel {
  ClientModel({
      String? responseCode, 
      String? msg, 
      List<ClientList>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  ClientModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ClientList.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<ClientList>? _data;
ClientModel copyWith({  String? responseCode,
  String? msg,
  List<ClientList>? data,
}) => ClientModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<ClientList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "176"
/// first_name : "client"
/// last_name : "gi"
/// city : "bombay"
/// mobile : "2147483647"
/// photographer_type : null
/// compny_name : null
/// per_day_charges : null
/// type : "client"
/// status : "1"
/// created_at : "2023-06-08 12:39:28"
/// user_id : "5"

class ClientList {
  ClientList({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? city, 
      String? mobile, 
      dynamic photographerType, 
      dynamic compnyName, 
      dynamic perDayCharges, 
      String? type, 
      String? status, 
      String? createdAt, 
      String? userId,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _city = city;
    _mobile = mobile;
    _photographerType = photographerType;
    _compnyName = compnyName;
    _perDayCharges = perDayCharges;
    _type = type;
    _status = status;
    _createdAt = createdAt;
    _userId = userId;
}

  ClientList.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _city = json['city'];
    _mobile = json['mobile'];
    _photographerType = json['photographer_type'];
    _compnyName = json['compny_name'];
    _perDayCharges = json['per_day_charges'];
    _type = json['type'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _userId = json['user_id'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _city;
  String? _mobile;
  dynamic _photographerType;
  dynamic _compnyName;
  dynamic _perDayCharges;
  String? _type;
  String? _status;
  String? _createdAt;
  String? _userId;
ClientList copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? city,
  String? mobile,
  dynamic photographerType,
  dynamic compnyName,
  dynamic perDayCharges,
  String? type,
  String? status,
  String? createdAt,
  String? userId,
}) => ClientList(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  city: city ?? _city,
  mobile: mobile ?? _mobile,
  photographerType: photographerType ?? _photographerType,
  compnyName: compnyName ?? _compnyName,
  perDayCharges: perDayCharges ?? _perDayCharges,
  type: type ?? _type,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  userId: userId ?? _userId,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get city => _city;
  String? get mobile => _mobile;
  dynamic get photographerType => _photographerType;
  dynamic get compnyName => _compnyName;
  dynamic get perDayCharges => _perDayCharges;
  String? get type => _type;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['city'] = _city;
    map['mobile'] = _mobile;
    map['photographer_type'] = _photographerType;
    map['compny_name'] = _compnyName;
    map['per_day_charges'] = _perDayCharges;
    map['type'] = _type;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['user_id'] = _userId;
    return map;
  }

}