/// error : false
/// message : "Freelance job list"
/// data : [{"all_jobs":[{"type_of_photography":"249","photographer_name":"atul1 gautam","event_name":"Weding","id":"8","user_id":"3","uid":"52348","photographer_id":"8","event_id":"1","city_name":"Indore","json_data":[{"id":"1","job_id":"8","date":"2023-06-25","from_time":"10","to_time":"18","amount":"10000","is_paid":"0","created_at":"2023-06-16 09:21:05","updated_at":"2023-06-16 08:24:52"}],"created_at":"2023-06-16 08:24:52","updated_at":"2023-06-16 08:24:52"}],"upcoming_jobs":[{"type_of_photography":"249","photographer_name":"atul1 gautam","event_name":"Weding","id":"8","user_id":"3","uid":"52348","photographer_id":"8","event_id":"1","city_name":"Indore","json_data":[{"id":"1","job_id":"8","date":"2023-06-25","from_time":"10","to_time":"18","amount":"10000","is_paid":"0","created_at":"2023-06-16 09:21:05","updated_at":"2023-06-16 08:24:52"}],"created_at":"2023-06-16 08:24:52","updated_at":"2023-06-16 08:24:52"}]}]

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

/// all_jobs : [{"type_of_photography":"249","photographer_name":"atul1 gautam","event_name":"Weding","id":"8","user_id":"3","uid":"52348","photographer_id":"8","event_id":"1","city_name":"Indore","json_data":[{"id":"1","job_id":"8","date":"2023-06-25","from_time":"10","to_time":"18","amount":"10000","is_paid":"0","created_at":"2023-06-16 09:21:05","updated_at":"2023-06-16 08:24:52"}],"created_at":"2023-06-16 08:24:52","updated_at":"2023-06-16 08:24:52"}]
/// upcoming_jobs : [{"type_of_photography":"249","photographer_name":"atul1 gautam","event_name":"Weding","id":"8","user_id":"3","uid":"52348","photographer_id":"8","event_id":"1","city_name":"Indore","json_data":[{"id":"1","job_id":"8","date":"2023-06-25","from_time":"10","to_time":"18","amount":"10000","is_paid":"0","created_at":"2023-06-16 09:21:05","updated_at":"2023-06-16 08:24:52"}],"created_at":"2023-06-16 08:24:52","updated_at":"2023-06-16 08:24:52"}]

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
/// photographer_name : "atul1 gautam"
/// event_name : "Weding"
/// id : "8"
/// user_id : "3"
/// uid : "52348"
/// photographer_id : "8"
/// event_id : "1"
/// city_name : "Indore"
/// json_data : [{"id":"1","job_id":"8","date":"2023-06-25","from_time":"10","to_time":"18","amount":"10000","is_paid":"0","created_at":"2023-06-16 09:21:05","updated_at":"2023-06-16 08:24:52"}]
/// created_at : "2023-06-16 08:24:52"
/// updated_at : "2023-06-16 08:24:52"

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
      String? updatedAt,}){
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
    return map;
  }

}

/// id : "1"
/// job_id : "8"
/// date : "2023-06-25"
/// from_time : "10"
/// to_time : "18"
/// amount : "10000"
/// is_paid : "0"
/// created_at : "2023-06-16 09:21:05"
/// updated_at : "2023-06-16 08:24:52"

class JsonData {
  JsonData({
      String? id, 
      String? jobId, 
      String? date, 
      String? fromTime, 
      String? toTime, 
      String? amount, 
      String? isPaid, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _jobId = jobId;
    _date = date;
    _fromTime = fromTime;
    _toTime = toTime;
    _amount = amount;
    _isPaid = isPaid;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  JsonData.fromJson(dynamic json) {
    _id = json['id'];
    _jobId = json['job_id'];
    _date = json['date'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _amount = json['amount'];
    _isPaid = json['is_paid'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _jobId;
  String? _date;
  String? _fromTime;
  String? _toTime;
  String? _amount;
  String? _isPaid;
  String? _createdAt;
  String? _updatedAt;
JsonData copyWith({  String? id,
  String? jobId,
  String? date,
  String? fromTime,
  String? toTime,
  String? amount,
  String? isPaid,
  String? createdAt,
  String? updatedAt,
}) => JsonData(  id: id ?? _id,
  jobId: jobId ?? _jobId,
  date: date ?? _date,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  amount: amount ?? _amount,
  isPaid: isPaid ?? _isPaid,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get jobId => _jobId;
  String? get date => _date;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get amount => _amount;
  String? get isPaid => _isPaid;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_id'] = _jobId;
    map['date'] = _date;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['amount'] = _amount;
    map['is_paid'] = _isPaid;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// type_of_photography : "249"
/// photographer_name : "atul1 gautam"
/// event_name : "Weding"
/// id : "8"
/// user_id : "3"
/// uid : "52348"
/// photographer_id : "8"
/// event_id : "1"
/// city_name : "Indore"
/// json_data : [{"id":"1","job_id":"8","date":"2023-06-25","from_time":"10","to_time":"18","amount":"10000","is_paid":"0","created_at":"2023-06-16 09:21:05","updated_at":"2023-06-16 08:24:52"}]
/// created_at : "2023-06-16 08:24:52"
/// updated_at : "2023-06-16 08:24:52"

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
      String? updatedAt,}){
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
    return map;
  }

}

/// id : "1"
/// job_id : "8"
/// date : "2023-06-25"
/// from_time : "10"
/// to_time : "18"
/// amount : "10000"
/// is_paid : "0"
/// created_at : "2023-06-16 09:21:05"
/// updated_at : "2023-06-16 08:24:52"

class JsonData1 {
  JsonData1({
      String? id, 
      String? jobId, 
      String? date, 
      String? fromTime, 
      String? toTime, 
      String? amount, 
      String? isPaid, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _jobId = jobId;
    _date = date;
    _fromTime = fromTime;
    _toTime = toTime;
    _amount = amount;
    _isPaid = isPaid;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  JsonData1.fromJson(dynamic json) {
    _id = json['id'];
    _jobId = json['job_id'];
    _date = json['date'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _amount = json['amount'];
    _isPaid = json['is_paid'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _jobId;
  String? _date;
  String? _fromTime;
  String? _toTime;
  String? _amount;
  String? _isPaid;
  String? _createdAt;
  String? _updatedAt;
JsonData1 copyWith({  String? id,
  String? jobId,
  String? date,
  String? fromTime,
  String? toTime,
  String? amount,
  String? isPaid,
  String? createdAt,
  String? updatedAt,
}) => JsonData1(  id: id ?? _id,
  jobId: jobId ?? _jobId,
  date: date ?? _date,
  fromTime: fromTime ?? _fromTime,
  toTime: toTime ?? _toTime,
  amount: amount ?? _amount,
  isPaid: isPaid ?? _isPaid,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get jobId => _jobId;
  String? get date => _date;
  String? get fromTime => _fromTime;
  String? get toTime => _toTime;
  String? get amount => _amount;
  String? get isPaid => _isPaid;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['job_id'] = _jobId;
    map['date'] = _date;
    map['from_time'] = _fromTime;
    map['to_time'] = _toTime;
    map['amount'] = _amount;
    map['is_paid'] = _isPaid;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}