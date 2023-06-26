/// error : false
/// message : "All Job Lists"
/// data : [{"id":"162","client_name":"Harish choudhary","mobile":"","city":"Itarsi","qid":"QUA00001","user_id":"5","output":"I want a best offer from you for this full package","amount":"50000","type":"client","type_event":"2","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"2023-06-26","data":[{"photographer_type":"LED Wall","photographer_id":"248","photographer_name":""},{"photographer_type":"Candid Cinematography","photographer_id":"249","photographer_name":""}]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-25","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-25","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]}],"update_date":"2023-06-24 12:06:43","event_name":"Pre Wedding"}]
/// dates : ["2023-06-24","2023-06-25","2023-06-26","2023-06-27","2023-06-28","2023-06-29","2023-06-30","2023-07-20","2023-09-14","2023-09-15"]

class GetCalendarJobsModel {
  GetCalendarJobsModel({
      bool? error, 
      String? message, 
      List<CalendarJobs>? data,
      List<String>? dates,}){
    _error = error;
    _message = message;
    _data = data;
    _dates = dates;
}

  GetCalendarJobsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CalendarJobs.fromJson(v));
      });
    }
    _dates = json['dates'] != null ? json['dates'].cast<String>() : [];
  }
  bool? _error;
  String? _message;
  List<CalendarJobs>? _data;
  List<String>? _dates;
GetCalendarJobsModel copyWith({  bool? error,
  String? message,
  List<CalendarJobs>? data,
  List<String>? dates,
}) => GetCalendarJobsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  dates: dates ?? _dates,
);
  bool? get error => _error;
  String? get message => _message;
  List<CalendarJobs>? get data => _data;
  List<String>? get dates => _dates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['dates'] = _dates;
    return map;
  }

}

/// id : "162"
/// client_name : "Harish choudhary"
/// mobile : ""
/// city : "Itarsi"
/// qid : "QUA00001"
/// user_id : "5"
/// output : "I want a best offer from you for this full package"
/// amount : "50000"
/// type : "client"
/// type_event : "2"
/// booking_id : "0"
/// grapher_id : "0"
/// status : "1"
/// photographers_details : [{"date":"2023-06-26","data":[{"photographer_type":"LED Wall","photographer_id":"248","photographer_name":""},{"photographer_type":"Candid Cinematography","photographer_id":"249","photographer_name":""}]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-25","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-25","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]},{"date":"2023-06-26","data":[]}]
/// update_date : "2023-06-24 12:06:43"
/// event_name : "Pre Wedding"

class CalendarJobs {
  CalendarJobs({
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

  CalendarJobs.fromJson(dynamic json) {
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
CalendarJobs copyWith({  String? id,
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
}) => CalendarJobs(  id: id ?? _id,
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

/// date : "2023-06-26"
/// data : [{"photographer_type":"LED Wall","photographer_id":"248","photographer_name":""},{"photographer_type":"Candid Cinematography","photographer_id":"249","photographer_name":""}]

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

/// photographer_type : "LED Wall"
/// photographer_id : "248"
/// photographer_name : ""

class Data {
  Data({
      String? photographerType, 
      String? photographerId, 
      String? photographerName,}){
    _photographerType = photographerType;
    _photographerId = photographerId;
    _photographerName = photographerName;
}

  Data.fromJson(dynamic json) {
    _photographerType = json['photographer_type'];
    _photographerId = json['photographer_id'];
    _photographerName = json['photographer_name'];
  }
  String? _photographerType;
  String? _photographerId;
  String? _photographerName;
Data copyWith({  String? photographerType,
  String? photographerId,
  String? photographerName,
}) => Data(  photographerType: photographerType ?? _photographerType,
  photographerId: photographerId ?? _photographerId,
  photographerName: photographerName ?? _photographerName,
);
  String? get photographerType => _photographerType;
  String? get photographerId => _photographerId;
  String? get photographerName => _photographerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photographer_type'] = _photographerType;
    map['photographer_id'] = _photographerId;
    map['photographer_name'] = _photographerName;
    return map;
  }

}