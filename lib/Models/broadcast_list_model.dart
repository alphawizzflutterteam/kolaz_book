/// error : false
/// message : "Broacast List"
/// data : [{"type_of_photograpym":"Candid Cinematography","county_name":"India","statename":"Maharastra","city_name":"Jaipur","id":"5","user_id":"11","type":"249","date":"11,2","country":"3","state":"1","city":"1","user_name":"Parth Lakshman Verma"}]

class BroadcastListModel {
  BroadcastListModel({
      bool? error, 
      String? message,
    String?  leftMessage,
      List<BroadcastList>? data,}){
    _error = error;
    _message = message;
    _leftMessage = leftMessage;
    _data = data;
}

  BroadcastListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _leftMessage = json['left_message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BroadcastList.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  String? _leftMessage;
  List<BroadcastList>? _data;
BroadcastListModel copyWith({  bool? error,
  String? message,
  String? leftMessage,
  List<BroadcastList>? data,
}) => BroadcastListModel(
  error: error ?? _error,
  message: message ?? _message,
  leftMessage: leftMessage ?? _leftMessage,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  String? get leftMessage => _leftMessage;
  List<BroadcastList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['left_message'] = _leftMessage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type_of_photograpym : "Candid Cinematography"
/// county_name : "India"
/// statename : "Maharastra"
/// city_name : "Jaipur"
/// id : "5"
/// user_id : "11"
/// type : "249"
/// date : "11,2"
/// country : "3"
/// state : "1"
/// city : "1"
/// user_name : "Parth Lakshman Verma"

class BroadcastList {
  BroadcastList({
      String? typeOfPhotograpym, 
      String? countyName, 
      String? statename, 
      String? cityName, 
      String? id, 
      String? userId, 
      String? type, 
      String? date, 
      String? country, 
      String? state, 
      String? city, 
      String? userName,}){
    _typeOfPhotograpym = typeOfPhotograpym;
    _countyName = countyName;
    _statename = statename;
    _cityName = cityName;
    _id = id;
    _userId = userId;
    _type = type;
    _date = date;
    _country = country;
    _state = state;
    _city = city;
    _userName = userName;
}

  BroadcastList.fromJson(dynamic json) {
    _typeOfPhotograpym = json['type_of_photograpym'];
    _countyName = json['county_name'];
    _statename = json['statename'];
    _cityName = json['city_name'];
    _id = json['id'];
    _userId = json['user_id'];
    _type = json['type'];
    _date = json['date'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _userName = json['user_name'];
  }
  String? _typeOfPhotograpym;
  String? _countyName;
  String? _statename;
  String? _cityName;
  String? _id;
  String? _userId;
  String? _type;
  String? _date;
  String? _country;
  String? _state;
  String? _city;
  String? _userName;
BroadcastList copyWith({  String? typeOfPhotograpym,
  String? countyName,
  String? statename,
  String? cityName,
  String? id,
  String? userId,
  String? type,
  String? date,
  String? country,
  String? state,
  String? city,
  String? userName,
}) => BroadcastList(  typeOfPhotograpym: typeOfPhotograpym ?? _typeOfPhotograpym,
  countyName: countyName ?? _countyName,
  statename: statename ?? _statename,
  cityName: cityName ?? _cityName,
  id: id ?? _id,
  userId: userId ?? _userId,
  type: type ?? _type,
  date: date ?? _date,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
  userName: userName ?? _userName,
);
  String? get typeOfPhotograpym => _typeOfPhotograpym;
  String? get countyName => _countyName;
  String? get statename => _statename;
  String? get cityName => _cityName;
  String? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get date => _date;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_of_photograpym'] = _typeOfPhotograpym;
    map['county_name'] = _countyName;
    map['statename'] = _statename;
    map['city_name'] = _cityName;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['date'] = _date;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['user_name'] = _userName;
    return map;
  }

}