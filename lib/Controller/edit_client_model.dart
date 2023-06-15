import 'dart:convert';

/// error : false
/// message : "photographer Update Successfully"
/// data : {"first_name":"surendra","last_name":"aingh","city":"UP","mobile":"9797679777","photographer_type":null,"compny_name":null,"per_day_charges":null,"type":" client","user_id":" 158"}

EditClientModel editClientModelFromJson(String str) => EditClientModel.fromJson(json.decode(str));

String editClientModelToJson(EditClientModel data) => json.encode(data.toJson());

class EditClientModel {
  EditClientModel({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  EditClientModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
EditClientModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => EditClientModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// first_name : "surendra"
/// last_name : "aingh"
/// city : "UP"
/// mobile : "9797679777"
/// photographer_type : null
/// compny_name : null
/// per_day_charges : null
/// type : " client"
/// user_id : " 158"

class Data {
  Data({
      String? firstName, 
      String? lastName, 
      String? city, 
      String? mobile, 
      dynamic photographerType, 
      dynamic compnyName, 
      dynamic perDayCharges, 
      String? type, 
      String? userId,}){
    _firstName = firstName;
    _lastName = lastName;
    _city = city;
    _mobile = mobile;
    _photographerType = photographerType;
    _compnyName = compnyName;
    _perDayCharges = perDayCharges;
    _type = type;
    _userId = userId;
}

  Data.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _city = json['city'];
    _mobile = json['mobile'];
    _photographerType = json['photographer_type'];
    _compnyName = json['compny_name'];
    _perDayCharges = json['per_day_charges'];
    _type = json['type'];
    _userId = json['user_id'];
  }
  String? _firstName;
  String? _lastName;
  String? _city;
  String? _mobile;
  dynamic _photographerType;
  dynamic _compnyName;
  dynamic _perDayCharges;
  String? _type;
  String? _userId;
Data copyWith({  String? firstName,
  String? lastName,
  String? city,
  String? mobile,
  dynamic photographerType,
  dynamic compnyName,
  dynamic perDayCharges,
  String? type,
  String? userId,
}) => Data(  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  city: city ?? _city,
  mobile: mobile ?? _mobile,
  photographerType: photographerType ?? _photographerType,
  compnyName: compnyName ?? _compnyName,
  perDayCharges: perDayCharges ?? _perDayCharges,
  type: type ?? _type,
  userId: userId ?? _userId,
);
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get city => _city;
  String? get mobile => _mobile;
  dynamic get photographerType => _photographerType;
  dynamic get compnyName => _compnyName;
  dynamic get perDayCharges => _perDayCharges;
  String? get type => _type;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['city'] = _city;
    map['mobile'] = _mobile;
    map['photographer_type'] = _photographerType;
    map['compny_name'] = _compnyName;
    map['per_day_charges'] = _perDayCharges;
    map['type'] = _type;
    map['user_id'] = _userId;
    return map;
  }

}