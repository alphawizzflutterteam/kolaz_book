/// error : false
/// message : "Freelance job list"
/// data : [{"all_jobs":[{"type_of_photography":"249","photographer_name":"Ajay M","event_name":"Pre Wedding","id":"30","user_id":"3","uid":"FRJ00002","photographer_id":"263","event_id":"2","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description ","amount":"50000"},{"date":"27-06-2023","description":"this is new description data for tetsing","amount":"5000"},{"date":"28-06-2023","description":"description testing hg gdg yg y fydfyfy yyugdcy ygyg ydgg w6dqrwtdf cxcvxg","amount":"100000"}],"created_at":"2023-06-27 07:49:45","updated_at":"2023-06-27 07:49:45"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"33","user_id":"3","uid":"FRJ00005","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"}],"created_at":"2023-06-27 07:51:36","updated_at":"2023-06-27 07:51:36"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"34","user_id":"3","uid":"FRJ00006","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"},{"date":"28-06-2023","description":"this is another description this is another description","amount":"80000"}],"created_at":"2023-06-27 07:52:25","updated_at":"2023-06-27 07:52:25"},{"type_of_photography":"249","photographer_name":"Shivani Verma","event_name":"Engagement","id":"35","user_id":"3","uid":"FRJ00007","photographer_id":"264","event_id":"3","city_name":"Dewas","json_data":[{"date":"27-06-2023","description":"test ","amount":"10000"},{"date":"28-06-2023","description":"test tset tsest test tsettet testt testtt testttt","amount":"10000"}],"created_at":"2023-06-27 10:46:13","updated_at":"2023-06-27 10:46:13"}],"upcoming_jobs":[{"type_of_photography":"249","photographer_name":"Ajay M","event_name":"Pre Wedding","id":"30","user_id":"3","uid":"FRJ00002","photographer_id":"263","event_id":"2","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description ","amount":"50000"},{"date":"27-06-2023","description":"this is new description data for tetsing","amount":"5000"},{"date":"28-06-2023","description":"description testing hg gdg yg y fydfyfy yyugdcy ygyg ydgg w6dqrwtdf cxcvxg","amount":"100000"}],"created_at":"2023-06-27 07:49:45","updated_at":"2023-06-27 07:49:45"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"33","user_id":"3","uid":"FRJ00005","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"}],"created_at":"2023-06-27 07:51:36","updated_at":"2023-06-27 07:51:36"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"34","user_id":"3","uid":"FRJ00006","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"},{"date":"28-06-2023","description":"this is another description this is another description","amount":"80000"}],"created_at":"2023-06-27 07:52:25","updated_at":"2023-06-27 07:52:25"},{"type_of_photography":"249","photographer_name":"Shivani Verma","event_name":"Engagement","id":"35","user_id":"3","uid":"FRJ00007","photographer_id":"264","event_id":"3","city_name":"Dewas","json_data":[{"date":"27-06-2023","description":"test ","amount":"10000"},{"date":"28-06-2023","description":"test tset tsest test tsettet testt testtt testttt","amount":"10000"}],"created_at":"2023-06-27 10:46:13","updated_at":"2023-06-27 10:46:13"}]}]

class GetFreelancerJobsModel {
  GetFreelancerJobsModel({
      bool? error, 
      String? message, 
      List<FreelancerJobs>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetFreelancerJobsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FreelancerJobs.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<FreelancerJobs>? _data;
GetFreelancerJobsModel copyWith({  bool? error,
  String? message,
  List<FreelancerJobs>? data,
}) => GetFreelancerJobsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<FreelancerJobs>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// all_jobs : [{"type_of_photography":"249","photographer_name":"Ajay M","event_name":"Pre Wedding","id":"30","user_id":"3","uid":"FRJ00002","photographer_id":"263","event_id":"2","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description ","amount":"50000"},{"date":"27-06-2023","description":"this is new description data for tetsing","amount":"5000"},{"date":"28-06-2023","description":"description testing hg gdg yg y fydfyfy yyugdcy ygyg ydgg w6dqrwtdf cxcvxg","amount":"100000"}],"created_at":"2023-06-27 07:49:45","updated_at":"2023-06-27 07:49:45"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"33","user_id":"3","uid":"FRJ00005","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"}],"created_at":"2023-06-27 07:51:36","updated_at":"2023-06-27 07:51:36"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"34","user_id":"3","uid":"FRJ00006","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"},{"date":"28-06-2023","description":"this is another description this is another description","amount":"80000"}],"created_at":"2023-06-27 07:52:25","updated_at":"2023-06-27 07:52:25"},{"type_of_photography":"249","photographer_name":"Shivani Verma","event_name":"Engagement","id":"35","user_id":"3","uid":"FRJ00007","photographer_id":"264","event_id":"3","city_name":"Dewas","json_data":[{"date":"27-06-2023","description":"test ","amount":"10000"},{"date":"28-06-2023","description":"test tset tsest test tsettet testt testtt testttt","amount":"10000"}],"created_at":"2023-06-27 10:46:13","updated_at":"2023-06-27 10:46:13"}]
/// upcoming_jobs : [{"type_of_photography":"249","photographer_name":"Ajay M","event_name":"Pre Wedding","id":"30","user_id":"3","uid":"FRJ00002","photographer_id":"263","event_id":"2","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description ","amount":"50000"},{"date":"27-06-2023","description":"this is new description data for tetsing","amount":"5000"},{"date":"28-06-2023","description":"description testing hg gdg yg y fydfyfy yyugdcy ygyg ydgg w6dqrwtdf cxcvxg","amount":"100000"}],"created_at":"2023-06-27 07:49:45","updated_at":"2023-06-27 07:49:45"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"33","user_id":"3","uid":"FRJ00005","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"}],"created_at":"2023-06-27 07:51:36","updated_at":"2023-06-27 07:51:36"},{"type_of_photography":"254","photographer_name":"Ajay M","event_name":"Wedding","id":"34","user_id":"3","uid":"FRJ00006","photographer_id":"263","event_id":"1","city_name":"Indore","json_data":[{"date":"27-06-2023","description":"this is my new description jfsd","amount":"50000"},{"date":"28-06-2023","description":"this is another description this is another description","amount":"80000"}],"created_at":"2023-06-27 07:52:25","updated_at":"2023-06-27 07:52:25"},{"type_of_photography":"249","photographer_name":"Shivani Verma","event_name":"Engagement","id":"35","user_id":"3","uid":"FRJ00007","photographer_id":"264","event_id":"3","city_name":"Dewas","json_data":[{"date":"27-06-2023","description":"test ","amount":"10000"},{"date":"28-06-2023","description":"test tset tsest test tsettet testt testtt testttt","amount":"10000"}],"created_at":"2023-06-27 10:46:13","updated_at":"2023-06-27 10:46:13"}]

class FreelancerJobs {
  FreelancerJobs({
      List<AllJobs>? allJobs, 
      List<UpcomingJobs>? upcomingJobs,}){
    _allJobs = allJobs;
    _upcomingJobs = upcomingJobs;
}

  FreelancerJobs.fromJson(dynamic json) {
    if (json['all_jobs'] != null) {
      _allJobs = [];
      json['all_jobs'].forEach((v) {
        _allJobs?.add(AllJobs.fromJson(v));
      });
    }
    if (json['upcoming_jobs'] != null) {
      _upcomingJobs = [];
      json['upcoming_jobs'].forEach((v) {
        _upcomingJobs?.add(UpcomingJobs.fromJson(v));
      });
    }
  }
  List<AllJobs>? _allJobs;
  List<UpcomingJobs>? _upcomingJobs;
FreelancerJobs copyWith({  List<AllJobs>? allJobs,
  List<UpcomingJobs>? upcomingJobs,
}) => FreelancerJobs(  allJobs: allJobs ?? _allJobs,
  upcomingJobs: upcomingJobs ?? _upcomingJobs,
);
  List<AllJobs>? get allJobs => _allJobs;
  List<UpcomingJobs>? get upcomingJobs => _upcomingJobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allJobs != null) {
      map['all_jobs'] = _allJobs?.map((v) => v.toJson()).toList();
    }
    if (_upcomingJobs != null) {
      map['upcoming_jobs'] = _upcomingJobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// type_of_photography : "249"
/// photographer_name : "Ajay M"
/// event_name : "Pre Wedding"
/// id : "30"
/// user_id : "3"
/// uid : "FRJ00002"
/// photographer_id : "263"
/// event_id : "2"
/// city_name : "Indore"
/// json_data : [{"date":"27-06-2023","description":"this is my new description ","amount":"50000"},{"date":"27-06-2023","description":"this is new description data for tetsing","amount":"5000"},{"date":"28-06-2023","description":"description testing hg gdg yg y fydfyfy yyugdcy ygyg ydgg w6dqrwtdf cxcvxg","amount":"100000"}]
/// created_at : "2023-06-27 07:49:45"
/// updated_at : "2023-06-27 07:49:45"

class UpcomingJobs {
  UpcomingJobs({
      String? typeOfPhotography, 
      String? photographerName, 
      String? eventName, 
      String? id, 
      String? userId, 
      String? uid, 
      String? photographerId, 
      String? eventId, 
      String? cityName, 
      List<JsonData>? jsonData, 
      String? createdAt, 
      String? updatedAt,
    String? totalAmount
  }){
    _typeOfPhotography = typeOfPhotography;
    _photographerName = photographerName;
    _eventName = eventName;
    _id = id;
    _userId = userId;
    _uid = uid;
    _photographerId = photographerId;
    _eventId = eventId;
    _cityName = cityName;
    _jsonData = jsonData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _totalAmount = totalAmount;
}

  UpcomingJobs.fromJson(dynamic json) {
    _typeOfPhotography = json['type_of_photography'];
    _photographerName = json['photographer_name'];
    _eventName = json['event_name'];
    _id = json['id'];
    _userId = json['user_id'];
    _uid = json['uid'];
    _photographerId = json['photographer_id'];
    _eventId = json['event_id'];
    _cityName = json['city_name'];
    if (json['json_data'] != null) {
      _jsonData = [];
      json['json_data'].forEach((v) {
        _jsonData?.add(JsonData.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _totalAmount = json['total_amount'];
  }
  String? _typeOfPhotography;
  String? _photographerName;
  String? _eventName;
  String? _id;
  String? _userId;
  String? _uid;
  String? _photographerId;
  String? _eventId;
  String? _cityName;
  List<JsonData>? _jsonData;
  String? _createdAt;
  String? _updatedAt;
  String? _totalAmount;
UpcomingJobs copyWith({  String? typeOfPhotography,
  String? photographerName,
  String? eventName,
  String? id,
  String? userId,
  String? uid,
  String? photographerId,
  String? eventId,
  String? cityName,
  List<JsonData>? jsonData,
  String? createdAt,
  String? updatedAt,
  String? totalAmount
}) => UpcomingJobs(  typeOfPhotography: typeOfPhotography ?? _typeOfPhotography,
  photographerName: photographerName ?? _photographerName,
  eventName: eventName ?? _eventName,
  id: id ?? _id,
  userId: userId ?? _userId,
  uid: uid ?? _uid,
  photographerId: photographerId ?? _photographerId,
  eventId: eventId ?? _eventId,
  cityName: cityName ?? _cityName,
  jsonData: jsonData ?? _jsonData,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  totalAmount: totalAmount ?? _totalAmount
);
  String? get typeOfPhotography => _typeOfPhotography;
  String? get photographerName => _photographerName;
  String? get eventName => _eventName;
  String? get id => _id;
  String? get userId => _userId;
  String? get uid => _uid;
  String? get photographerId => _photographerId;
  String? get eventId => _eventId;
  String? get cityName => _cityName;
  List<JsonData>? get jsonData => _jsonData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get totalAmount => _totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_of_photography'] = _typeOfPhotography;
    map['photographer_name'] = _photographerName;
    map['event_name'] = _eventName;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['uid'] = _uid;
    map['photographer_id'] = _photographerId;
    map['event_id'] = _eventId;
    map['city_name'] = _cityName;
    if (_jsonData != null) {
      map['json_data'] = _jsonData?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['total_amount'] = _totalAmount;
    return map;
  }

}

/// date : "27-06-2023"
/// description : "this is my new description "
/// amount : "50000"

class JsonData {
  JsonData({
      String? date, 
      String? description, 
      String? amount,}){
    _date = date;
    _description = description;
    _amount = amount;
}

  JsonData.fromJson(dynamic json) {
    _date = json['date'];
    _description = json['description'];
    _amount = json['amount'];
  }
  String? _date;
  String? _description;
  String? _amount;
JsonData copyWith({  String? date,
  String? description,
  String? amount,
}) => JsonData(  date: date ?? _date,
  description: description ?? _description,
  amount: amount ?? _amount,
);
  String? get date => _date;
  String? get description => _description;
  String? get amount => _amount;

  set setDate(var value) {
    _date = value;
  }
  set setAmount(var value) {
    _amount = value;
  }
  set setDescription(var value) {
    _description = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['description'] = _description;
    map['amount'] = _amount;
    return map;
  }

}

/// type_of_photography : "249"
/// photographer_name : "Ajay M"
/// event_name : "Pre Wedding"
/// id : "30"
/// user_id : "3"
/// uid : "FRJ00002"
/// photographer_id : "263"
/// event_id : "2"
/// city_name : "Indore"
/// json_data : [{"date":"27-06-2023","description":"this is my new description ","amount":"50000"},{"date":"27-06-2023","description":"this is new description data for tetsing","amount":"5000"},{"date":"28-06-2023","description":"description testing hg gdg yg y fydfyfy yyugdcy ygyg ydgg w6dqrwtdf cxcvxg","amount":"100000"}]
/// created_at : "2023-06-27 07:49:45"
/// updated_at : "2023-06-27 07:49:45"

class AllJobs {
  AllJobs({
      String? typeOfPhotography, 
      String? photographerName, 
      String? eventName, 
      String? id, 
      String? userId, 
      String? uid, 
      String? photographerId, 
      String? eventId, 
      String? cityName, 
      List<JsonData>? jsonData, 
      String? createdAt, 
      String? updatedAt,
    String? totalAmount
  }){
    _typeOfPhotography = typeOfPhotography;
    _photographerName = photographerName;
    _eventName = eventName;
    _id = id;
    _userId = userId;
    _uid = uid;
    _photographerId = photographerId;
    _eventId = eventId;
    _cityName = cityName;
    _jsonData = jsonData;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _totalAmount = totalAmount;
}

  AllJobs.fromJson(dynamic json) {
    _typeOfPhotography = json['type_of_photography'];
    _photographerName = json['photographer_name'];
    _eventName = json['event_name'];
    _id = json['id'];
    _userId = json['user_id'];
    _uid = json['uid'];
    _photographerId = json['photographer_id'];
    _eventId = json['event_id'];
    _cityName = json['city_name'];
    if (json['json_data'] != null) {
      _jsonData = [];
      json['json_data'].forEach((v) {
        _jsonData?.add(JsonData.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _totalAmount = json['total_amount'];
  }
  String? _typeOfPhotography;
  String? _photographerName;
  String? _eventName;
  String? _id;
  String? _userId;
  String? _uid;
  String? _photographerId;
  String? _eventId;
  String? _cityName;
  List<JsonData>? _jsonData;
  String? _createdAt;
  String? _updatedAt;
  String? _totalAmount;
AllJobs copyWith({  String? typeOfPhotography,
  String? photographerName,
  String? eventName,
  String? id,
  String? userId,
  String? uid,
  String? photographerId,
  String? eventId,
  String? cityName,
  List<JsonData>? jsonData,
  String? createdAt,
  String? updatedAt,
  String? totalAmount
}) => AllJobs(  typeOfPhotography: typeOfPhotography ?? _typeOfPhotography,
  photographerName: photographerName ?? _photographerName,
  eventName: eventName ?? _eventName,
  id: id ?? _id,
  userId: userId ?? _userId,
  uid: uid ?? _uid,
  photographerId: photographerId ?? _photographerId,
  eventId: eventId ?? _eventId,
  cityName: cityName ?? _cityName,
  jsonData: jsonData ?? _jsonData,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  totalAmount: totalAmount ?? _totalAmount
);
  String? get typeOfPhotography => _typeOfPhotography;
  String? get photographerName => _photographerName;
  String? get eventName => _eventName;
  String? get id => _id;
  String? get userId => _userId;
  String? get uid => _uid;
  String? get photographerId => _photographerId;
  String? get eventId => _eventId;
  String? get cityName => _cityName;
  List<JsonData>? get jsonData => _jsonData;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get totalAmount => _totalAmount;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_of_photography'] = _typeOfPhotography;
    map['photographer_name'] = _photographerName;
    map['event_name'] = _eventName;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['uid'] = _uid;
    map['photographer_id'] = _photographerId;
    map['event_id'] = _eventId;
    map['city_name'] = _cityName;
    if (_jsonData != null) {
      map['json_data'] = _jsonData?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['total_amount'] = _totalAmount;
    return map;
  }

}

/// date : "27-06-2023"
/// description : "this is my new description "
/// amount : "50000"

