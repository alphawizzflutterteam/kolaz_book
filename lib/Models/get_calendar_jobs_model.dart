/// freelancer : [{"type_of_photography":"249","photographer_name":"Vijay Chauhan","event_name":"Wedding","id":"1","user_id":"4","uid":"FRJ00001","photographer_id":"7","event_id":"1","city_name":"Visnagar","json_data":[{"date":"14-07-2023","description":"Wedding","amount":"5000"}],"created_at":"2023-07-10 12:31:44","updated_at":"2023-07-10 12:23:49","total_amount":"5000"},{"type_of_photography":"256","photographer_name":"Vijay Chauhan","event_name":"Pre Wedding","id":"2","user_id":"4","uid":"FRJ00002","photographer_id":"7","event_id":"2","city_name":"Visnagar","json_data":[{"date":"07-07-2023","description":"","amount":"55000"}],"created_at":"2023-07-10 12:47:43","updated_at":"2023-07-10 12:47:43","total_amount":"55000"},{"type_of_photography":"255","photographer_name":"Koushik Prajapati","event_name":"Pre Wedding","id":"3","user_id":"4","uid":"FRJ00003","photographer_id":"8","event_id":"2","city_name":"Palanpur","json_data":[{"date":"11-07-2023","description":"","amount":"2500"}],"created_at":"2023-07-10 12:49:20","updated_at":"2023-07-10 12:49:20","total_amount":"2500"},{"type_of_photography":"256","photographer_name":"Koushik Prajapati","event_name":"Pre Wedding","id":"4","user_id":"4","uid":"FRJ00004","photographer_id":"8","event_id":"2","city_name":"Palanpur","json_data":[{"date":"26-07-2023","description":"5600","amount":"2500"}],"created_at":"2023-07-10 12:58:22","updated_at":"2023-07-10 12:58:22","total_amount":"2500"}]
/// error : false
/// message : "All Job Lists"
/// data : [{"id":"7","client_name":"Keyur Patel","mobile":"1234567890","city":"Palanpur","qid":"JOB00001","user_id":"4","output":"Album and Video Full Edited","amount":"56000","type":"client","type_event":"2","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"11-07-2023","data":[{"photographer_type":"Fashion Photography","photographer_name":"","photographer_id":"7"},{"photographer_type":"Product Photography","photographer_name":"","photographer_id":"8"}]}],"update_date":"2023-07-10 12:56:51","event_name":"Pre Wedding"},{"id":"8","client_name":"Keyur Patel","mobile":"1234567890","city":"Palanpur","qid":"JOB00002","user_id":"4","output":"bbb","amount":"5000","type":"client","type_event":"2","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"11-07-2023","data":[{"photographer_type":"Video Editor","photographer_name":"","photographer_id":"9"},{"photographer_type":"Drone","photographer_name":"","photographer_id":"7"}]}],"update_date":"2023-07-10 12:59:44","event_name":"Pre Wedding"}]
/// dates : ["2023-07-11T00:00:00.000Z"]

class GetCalendarJobsModel {
  GetCalendarJobsModel({
      List<Freelancer>? freelancer, 
      bool? error, 
      String? message, 
      List<ClientJobs>? data,
      List<String>? dates,}){
    _freelancer = freelancer;
    _error = error;
    _message = message;
    _data = data;
    _dates = dates;
}

  GetCalendarJobsModel.fromJson(dynamic json) {
    if (json['freelancer'] != null) {
      _freelancer = [];
      json['freelancer'].forEach((v) {
        _freelancer?.add(Freelancer.fromJson(v));
      });
    }
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ClientJobs.fromJson(v));
      });
    }
    _dates = json['dates'] != null ? json['dates'].cast<String>() : [];
  }
  List<Freelancer>? _freelancer;
  bool? _error;
  String? _message;
  List<ClientJobs>? _data;
  List<String>? _dates;
GetCalendarJobsModel copyWith({  List<Freelancer>? freelancer,
  bool? error,
  String? message,
  List<ClientJobs>? data,
  List<String>? dates,
}) => GetCalendarJobsModel(  freelancer: freelancer ?? _freelancer,
  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  dates: dates ?? _dates,
);
  List<Freelancer>? get freelancer => _freelancer;
  bool? get error => _error;
  String? get message => _message;
  List<ClientJobs>? get data => _data;
  List<String>? get dates => _dates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_freelancer != null) {
      map['freelancer'] = _freelancer?.map((v) => v.toJson()).toList();
    }
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['dates'] = _dates;
    return map;
  }

}

/// id : "7"
/// client_name : "Keyur Patel"
/// mobile : "1234567890"
/// city : "Palanpur"
/// qid : "JOB00001"
/// user_id : "4"
/// output : "Album and Video Full Edited"
/// amount : "56000"
/// type : "client"
/// type_event : "2"
/// booking_id : "0"
/// grapher_id : "0"
/// status : "1"
/// photographers_details : [{"date":"11-07-2023","data":[{"photographer_type":"Fashion Photography","photographer_name":"","photographer_id":"7"},{"photographer_type":"Product Photography","photographer_name":"","photographer_id":"8"}]}]
/// update_date : "2023-07-10 12:56:51"
/// event_name : "Pre Wedding"

class ClientJobs {
  ClientJobs({
      String? id, 
      String? clientName, 
      String? mobile, 
      String? city, 
      String? qid, 
      String? userId, 
      String? output, 
      String? amount, 
      String? type, 
      String? typeEvent, 
      String? bookingId, 
      String? grapherId, 
      String? status, 
      List<PhotographersDetails>? photographersDetails, 
      String? updateDate, 
      String? eventName,}){
    _id = id;
    _clientName = clientName;
    _mobile = mobile;
    _city = city;
    _qid = qid;
    _userId = userId;
    _output = output;
    _amount = amount;
    _type = type;
    _typeEvent = typeEvent;
    _bookingId = bookingId;
    _grapherId = grapherId;
    _status = status;
    _photographersDetails = photographersDetails;
    _updateDate = updateDate;
    _eventName = eventName;
}

  ClientJobs.fromJson(dynamic json) {
    _id = json['id'];
    _clientName = json['client_name'];
    _mobile = json['mobile'];
    _city = json['city'];
    _qid = json['qid'];
    _userId = json['user_id'];
    _output = json['output'];
    _amount = json['amount'];
    _type = json['type'];
    _typeEvent = json['type_event'];
    _bookingId = json['booking_id'];
    _grapherId = json['grapher_id'];
    _status = json['status'];
    if (json['photographers_details'] != null) {
      _photographersDetails = [];
      json['photographers_details'].forEach((v) {
        _photographersDetails?.add(PhotographersDetails.fromJson(v));
      });
    }
    _updateDate = json['update_date'];
    _eventName = json['event_name'];
  }
  String? _id;
  String? _clientName;
  String? _mobile;
  String? _city;
  String? _qid;
  String? _userId;
  String? _output;
  String? _amount;
  String? _type;
  String? _typeEvent;
  String? _bookingId;
  String? _grapherId;
  String? _status;
  List<PhotographersDetails>? _photographersDetails;
  String? _updateDate;
  String? _eventName;
ClientJobs copyWith({  String? id,
  String? clientName,
  String? mobile,
  String? city,
  String? qid,
  String? userId,
  String? output,
  String? amount,
  String? type,
  String? typeEvent,
  String? bookingId,
  String? grapherId,
  String? status,
  List<PhotographersDetails>? photographersDetails,
  String? updateDate,
  String? eventName,
}) => ClientJobs(  id: id ?? _id,
  clientName: clientName ?? _clientName,
  mobile: mobile ?? _mobile,
  city: city ?? _city,
  qid: qid ?? _qid,
  userId: userId ?? _userId,
  output: output ?? _output,
  amount: amount ?? _amount,
  type: type ?? _type,
  typeEvent: typeEvent ?? _typeEvent,
  bookingId: bookingId ?? _bookingId,
  grapherId: grapherId ?? _grapherId,
  status: status ?? _status,
  photographersDetails: photographersDetails ?? _photographersDetails,
  updateDate: updateDate ?? _updateDate,
  eventName: eventName ?? _eventName,
);
  String? get id => _id;
  String? get clientName => _clientName;
  String? get mobile => _mobile;
  String? get city => _city;
  String? get qid => _qid;
  String? get userId => _userId;
  String? get output => _output;
  String? get amount => _amount;
  String? get type => _type;
  String? get typeEvent => _typeEvent;
  String? get bookingId => _bookingId;
  String? get grapherId => _grapherId;
  String? get status => _status;
  List<PhotographersDetails>? get photographersDetails => _photographersDetails;
  String? get updateDate => _updateDate;
  String? get eventName => _eventName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['client_name'] = _clientName;
    map['mobile'] = _mobile;
    map['city'] = _city;
    map['qid'] = _qid;
    map['user_id'] = _userId;
    map['output'] = _output;
    map['amount'] = _amount;
    map['type'] = _type;
    map['type_event'] = _typeEvent;
    map['booking_id'] = _bookingId;
    map['grapher_id'] = _grapherId;
    map['status'] = _status;
    if (_photographersDetails != null) {
      map['photographers_details'] = _photographersDetails?.map((v) => v.toJson()).toList();
    }
    map['update_date'] = _updateDate;
    map['event_name'] = _eventName;
    return map;
  }

}

/// date : "11-07-2023"
/// data : [{"photographer_type":"Fashion Photography","photographer_name":"","photographer_id":"7"},{"photographer_type":"Product Photography","photographer_name":"","photographer_id":"8"}]

class PhotographersDetails {
  PhotographersDetails({
      String? date, 
      List<Data>? data,}){
    _date = date;
    _data = data;
}

  PhotographersDetails.fromJson(dynamic json) {
    _date = json['date'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _date;
  List<Data>? _data;
PhotographersDetails copyWith({  String? date,
  List<Data>? data,
}) => PhotographersDetails(  date: date ?? _date,
  data: data ?? _data,
);
  String? get date => _date;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// photographer_type : "Fashion Photography"
/// photographer_name : ""
/// photographer_id : "7"

class Data {
  Data({
      String? photographerType, 
      String? photographerName, 
      String? photographerId,}){
    _photographerType = photographerType;
    _photographerName = photographerName;
    _photographerId = photographerId;
}

  Data.fromJson(dynamic json) {
    _photographerType = json['photographer_type'];
    _photographerName = json['photographer_name'];
    _photographerId = json['photographer_id'];
  }
  String? _photographerType;
  String? _photographerName;
  String? _photographerId;
Data copyWith({  String? photographerType,
  String? photographerName,
  String? photographerId,
}) => Data(  photographerType: photographerType ?? _photographerType,
  photographerName: photographerName ?? _photographerName,
  photographerId: photographerId ?? _photographerId,
);
  String? get photographerType => _photographerType;
  String? get photographerName => _photographerName;
  String? get photographerId => _photographerId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photographer_type'] = _photographerType;
    map['photographer_name'] = _photographerName;
    map['photographer_id'] = _photographerId;
    return map;
  }

}

/// type_of_photography : "249"
/// photographer_name : "Vijay Chauhan"
/// event_name : "Wedding"
/// id : "1"
/// user_id : "4"
/// uid : "FRJ00001"
/// photographer_id : "7"
/// event_id : "1"
/// city_name : "Visnagar"
/// json_data : [{"date":"14-07-2023","description":"Wedding","amount":"5000"}]
/// created_at : "2023-07-10 12:31:44"
/// updated_at : "2023-07-10 12:23:49"
/// total_amount : "5000"

class Freelancer {
  Freelancer({
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
      String? totalAmount,}){
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

  Freelancer.fromJson(dynamic json) {
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
Freelancer copyWith({  String? typeOfPhotography,
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
  String? totalAmount,
}) => Freelancer(  typeOfPhotography: typeOfPhotography ?? _typeOfPhotography,
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
  totalAmount: totalAmount ?? _totalAmount,
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

/// date : "14-07-2023"
/// description : "Wedding"
/// amount : "5000"

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['description'] = _description;
    map['amount'] = _amount;
    return map;
  }

}