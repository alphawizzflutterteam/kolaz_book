/// error : false
/// message : "Broacast List"
/// left_message : "You have 2 left."
/// data : [{"type_of_photograpym":"Album Printing","county_name":"Australia","statename":"New South Wales","city_name":"Sydney","id":"38","user_id":"3","type":"254","date":"03/07/2023","country":"Australia","state":"New South Wales","city":"Sydney","created_at":"2023-07-03 06:38:50","updated_at":"2023-07-03 06:38:50","user_name":"Karan S Tomar","profile_pic":"https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/6492a88dc32b0.jpg"},{"type_of_photograpym":"Album Printing","county_name":"","statename":"Kerala","city_name":"Cochin","id":"39","user_id":"26","type":"254","date":"03/07/2023","country":"","state":"Kerala","city":"Cochin","created_at":"2023-07-03 07:01:15","updated_at":"2023-07-03 07:01:15","user_name":"Sparsh Bhawsaw","profile_pic":"https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/"}]

class BroadcastListModel {
  BroadcastListModel({
      bool? error,
      String? message,
      String? leftMessage,
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
}) => BroadcastListModel(  error: error ?? _error,
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

/// type_of_photograpym : "Album Printing"
/// county_name : "Australia"
/// statename : "New South Wales"
/// city_name : "Sydney"
/// id : "38"
/// user_id : "3"
/// type : "254"
/// date : "03/07/2023"
/// country : "Australia"
/// state : "New South Wales"
/// city : "Sydney"
/// created_at : "2023-07-03 06:38:50"
/// updated_at : "2023-07-03 06:38:50"
/// user_name : "Karan S Tomar"
/// profile_pic : "https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/6492a88dc32b0.jpg"

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
      String? createdAt,
      String? updatedAt,
      String? userName,
      String? mobile,
      String? profilePic,}){
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _mobile = mobile;
    _userName = userName;
    _profilePic = profilePic;
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
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userName = json['user_name'];
    _mobile = json['mobile'];
    _profilePic = json['profile_pic'];
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
  String? _createdAt;
  String? _updatedAt;
  String? _userName;
  String? _mobile;
  String? _profilePic;
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
  String? createdAt,
  String? updatedAt,
  String? mobile,
  String? userName,
  String? profilePic,
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
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  userName: userName ?? _userName,
  mobile: mobile ?? _mobile,
  profilePic: profilePic ?? _profilePic,
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
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get userName => _userName;
  String? get mobile => _mobile;
  String? get profilePic => _profilePic;

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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user_name'] = _userName;
    map['mobile'] = _mobile;
    map['profile_pic'] = _profilePic;
    return map;
  }
}