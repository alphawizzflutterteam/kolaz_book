/// error : false
/// message : "All Job Lists"
/// data : [{"client_name":"Shivani","city_name":"Manali","id":"130","date":"2023-06-15","quotation_id":"122","photographer_id":"","photographer_type":"Candid Cinematography,LED Wall","json":"{\"date\":\"2023-06-15\",\"data\":[{\"photographer_type\":\"Candid Cinematography\"},{\"photographer_type\":\"LED Wall\"}]}","sub_amount":"0.00","event_name":"Weding","photographers":[{"name":"","type":"Candid Cinematography"},{"name":"","type":"LED Wall"}]},{"client_name":"Shivani","city_name":"Manali","id":"131","date":"2023-06-17","quotation_id":"122","photographer_id":"","photographer_type":"LED Wall,Traditional Photography,Candid Photography","json":"{\"date\":\"2023-06-17\",\"data\":[{\"photographer_type\":\"LED Wall\"},{\"photographer_type\":\"Traditional Photography\"},{\"photographer_type\":\"Candid Photography\"}]}","sub_amount":"0.00","event_name":"Weding","photographers":[{"name":"","type":"LED Wall"},{"name":"","type":"Traditional Photography"},{"name":"","type":"Candid Photography"}]},{"client_name":"Shivani","city_name":"Manali","id":"132","date":"2023-06-20","quotation_id":"122","photographer_id":"","photographer_type":"Candid Photography","json":"{\"date\":\"2023-06-20\",\"data\":[{\"photographer_type\":\"Candid Photography\"}]}","sub_amount":"0.00","event_name":"Weding","photographers":[{"name":"","type":"Candid Photography"}]}]

class GetUpcomingJobsModel {
  GetUpcomingJobsModel({
      bool? error, 
      String? message, 
      List<Teams>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetUpcomingJobsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Teams.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Teams>? _data;
GetUpcomingJobsModel copyWith({  bool? error,
  String? message,
  List<Teams>? data,
}) => GetUpcomingJobsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Teams>? get data => _data;

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

/// client_name : "Shivani"
/// city_name : "Manali"
/// id : "130"
/// date : "2023-06-15"
/// quotation_id : "122"
/// photographer_id : ""
/// photographer_type : "Candid Cinematography,LED Wall"
/// json : "{\"date\":\"2023-06-15\",\"data\":[{\"photographer_type\":\"Candid Cinematography\"},{\"photographer_type\":\"LED Wall\"}]}"
/// sub_amount : "0.00"
/// event_name : "Weding"
/// photographers : [{"name":"","type":"Candid Cinematography"},{"name":"","type":"LED Wall"}]

class Teams {
  Teams({
      String? clientName, 
      String? cityName, 
      String? id, 
      String? date, 
      String? quotationId, 
      String? photographerId, 
      String? photographerType, 
      String? json, 
      String? subAmount, 
      String? eventName, 
      List<Photographers>? photographers,}){
    _clientName = clientName;
    _cityName = cityName;
    _id = id;
    _date = date;
    _quotationId = quotationId;
    _photographerId = photographerId;
    _photographerType = photographerType;
    _json = json;
    _subAmount = subAmount;
    _eventName = eventName;
    _photographers = photographers;
}

  Teams.fromJson(dynamic json) {
    _clientName = json['client_name'];
    _cityName = json['city_name'];
    _id = json['id'];
    _date = json['date'];
    _quotationId = json['quotation_id'];
    _photographerId = json['photographer_id'];
    _photographerType = json['photographer_type'];
    _json = json['json'];
    _subAmount = json['sub_amount'];
    _eventName = json['event_name'];
    if (json['photographers'] != null) {
      _photographers = [];
      json['photographers'].forEach((v) {
        _photographers?.add(Photographers.fromJson(v));
      });
    }
  }
  String? _clientName;
  String? _cityName;
  String? _id;
  String? _date;
  String? _quotationId;
  String? _photographerId;
  String? _photographerType;
  String? _json;
  String? _subAmount;
  String? _eventName;
  List<Photographers>? _photographers;
Teams copyWith({  String? clientName,
  String? cityName,
  String? id,
  String? date,
  String? quotationId,
  String? photographerId,
  String? photographerType,
  String? json,
  String? subAmount,
  String? eventName,
  List<Photographers>? photographers,
}) => Teams(  clientName: clientName ?? _clientName,
  cityName: cityName ?? _cityName,
  id: id ?? _id,
  date: date ?? _date,
  quotationId: quotationId ?? _quotationId,
  photographerId: photographerId ?? _photographerId,
  photographerType: photographerType ?? _photographerType,
  json: json ?? _json,
  subAmount: subAmount ?? _subAmount,
  eventName: eventName ?? _eventName,
  photographers: photographers ?? _photographers,
);
  String? get clientName => _clientName;
  String? get cityName => _cityName;
  String? get id => _id;
  String? get date => _date;
  String? get quotationId => _quotationId;
  String? get photographerId => _photographerId;
  String? get photographerType => _photographerType;
  String? get json => _json;
  String? get subAmount => _subAmount;
  String? get eventName => _eventName;
  List<Photographers>? get photographers => _photographers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['client_name'] = _clientName;
    map['city_name'] = _cityName;
    map['id'] = _id;
    map['date'] = _date;
    map['quotation_id'] = _quotationId;
    map['photographer_id'] = _photographerId;
    map['photographer_type'] = _photographerType;
    map['json'] = _json;
    map['sub_amount'] = _subAmount;
    map['event_name'] = _eventName;
    if (_photographers != null) {
      map['photographers'] = _photographers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : ""
/// type : "Candid Cinematography"

class Photographers {
  Photographers({
      String? name, 
      String? type,}){
    _name = name;
    _type = type;
}

  Photographers.fromJson(dynamic json) {
    _name = json['name'];
    _type = json['type'];
  }
  String? _name;
  String? _type;
Photographers copyWith({  String? name,
  String? type,
}) => Photographers(  name: name ?? _name,
  type: type ?? _type,
);
  String? get name => _name;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['type'] = _type;
    return map;
  }

}