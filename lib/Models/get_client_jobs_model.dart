/// error : false
/// message : "All Job Lists"
/// data : [{"all_jobs":[{"id":"113","client_name":"Piyush","mobile":"9875546464","city":"14","qid":"3442","user_id":"3","output":"znsjdjfjfjejsjfjx hdudbehdud","amount":"50000","type":"client","type_event":"1","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"2023-06-15","data":[{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]},{"date":"2023-06-17","data":[{"photographer_type":"Traditional Cinematography","photographer_name":""},{"photographer_type":"Drone","photographer_name":""}]},{"date":"2023-06-20","data":[{"photographer_type":"Traditional Photography","photographer_name":""},{"photographer_type":"Candid Photography","photographer_name":""}]}],"update_date":"2023-06-15 09:33:23","event_name":"Weding"}],"upcoming_jobs":[{"id":"113","client_name":"Piyush","mobile":"9875546464","city":"14","qid":"3442","user_id":"3","output":"znsjdjfjfjejsjfjx hdudbehdud","amount":"50000","type":"client","type_event":"1","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"2023-06-15","data":[{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]},{"date":"2023-06-17","data":[{"photographer_type":"Traditional Cinematography","photographer_name":""},{"photographer_type":"Drone","photographer_name":""}]},{"date":"2023-06-20","data":[{"photographer_type":"Traditional Photography","photographer_name":""},{"photographer_type":"Candid Photography","photographer_name":""}]}],"update_date":"2023-06-15 09:33:23","event_name":"Weding"}]}]

class GetClientJobsModel {
  GetClientJobsModel({
      bool? error,
      String? message,
      List<JobData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetClientJobsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JobData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<JobData>? _data;
GetClientJobsModel copyWith({  bool? error,
  String? message,
  List<JobData>? data,
}) => GetClientJobsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<JobData>? get data => _data;

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

/// all_jobs : [{"id":"113","client_name":"Piyush","mobile":"9875546464","city":"14","qid":"3442","user_id":"3","output":"znsjdjfjfjejsjfjx hdudbehdud","amount":"50000","type":"client","type_event":"1","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"2023-06-15","data":[{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]},{"date":"2023-06-17","data":[{"photographer_type":"Traditional Cinematography","photographer_name":""},{"photographer_type":"Drone","photographer_name":""}]},{"date":"2023-06-20","data":[{"photographer_type":"Traditional Photography","photographer_name":""},{"photographer_type":"Candid Photography","photographer_name":""}]}],"update_date":"2023-06-15 09:33:23","event_name":"Weding"}]
/// upcoming_jobs : [{"id":"113","client_name":"Piyush","mobile":"9875546464","city":"14","qid":"3442","user_id":"3","output":"znsjdjfjfjejsjfjx hdudbehdud","amount":"50000","type":"client","type_event":"1","booking_id":"0","grapher_id":"0","status":"1","photographers_details":[{"date":"2023-06-15","data":[{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]},{"date":"2023-06-17","data":[{"photographer_type":"Traditional Cinematography","photographer_name":""},{"photographer_type":"Drone","photographer_name":""}]},{"date":"2023-06-20","data":[{"photographer_type":"Traditional Photography","photographer_name":""},{"photographer_type":"Candid Photography","photographer_name":""}]}],"update_date":"2023-06-15 09:33:23","event_name":"Weding"}]

class JobData {
  JobData({
      List<AllJobs>? allJobs,
      List<UpcomingJobs>? upcomingJobs,}){
    _allJobs = allJobs;
    _upcomingJobs = upcomingJobs;
}

  JobData.fromJson(dynamic json) {
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
JobData copyWith({  List<AllJobs>? allJobs,
  List<UpcomingJobs>? upcomingJobs,
}) => JobData(  allJobs: allJobs ?? _allJobs,
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

/// id : "113"
/// client_name : "Piyush"
/// mobile : "9875546464"
/// city : "14"
/// qid : "3442"
/// user_id : "3"
/// output : "znsjdjfjfjejsjfjx hdudbehdud"
/// amount : "50000"
/// type : "client"
/// type_event : "1"
/// booking_id : "0"
/// grapher_id : "0"
/// status : "1"
/// photographers_details : [{"date":"2023-06-15","data":[{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]},{"date":"2023-06-17","data":[{"photographer_type":"Traditional Cinematography","photographer_name":""},{"photographer_type":"Drone","photographer_name":""}]},{"date":"2023-06-20","data":[{"photographer_type":"Traditional Photography","photographer_name":""},{"photographer_type":"Candid Photography","photographer_name":""}]}]
/// update_date : "2023-06-15 09:33:23"
/// event_name : "Weding"

class UpcomingJobs {
  UpcomingJobs({
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

  UpcomingJobs.fromJson(dynamic json) {
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
UpcomingJobs copyWith({  String? id,
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
}) => UpcomingJobs(  id: id ?? _id,
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

/// date : "2023-06-15"
/// data : [{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]

class PhotographersDetails {
  PhotographersDetails({
      String? date,
      List<Data1>? data,}){
    _date = date;
    _data = data;
}

  PhotographersDetails.fromJson(dynamic json) {
    _date = json['date'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data1.fromJson(v));
      });
    }
  }
  String? _date;
  List<Data1>? _data;
PhotographersDetails copyWith({  String? date,
  List<Data1>? data,
}) => PhotographersDetails(  date: date ?? _date,
  data: data ?? _data,
);
  String? get date => _date;
  List<Data1>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// photographer_type : "Candid Cinematography"
/// photographer_name : ""

class Data1 {
  Data1({
      String? photographerType,
      String? photographerName,}){
    _photographerType = photographerType;
    _photographerName = photographerName;
}

  Data1.fromJson(dynamic json) {
    _photographerType = json['photographer_type'];
    _photographerName = json['photographer_name'];
  }
  String? _photographerType;
  String? _photographerName;
Data1 copyWith({  String? photographerType,
  String? photographerName,
}) => Data1(  photographerType: photographerType ?? _photographerType,
  photographerName: photographerName ?? _photographerName,
);
  String? get photographerType => _photographerType;
  String? get photographerName => _photographerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photographer_type'] = _photographerType;
    map['photographer_name'] = _photographerName;
    return map;
  }

}

/// id : "113"
/// client_name : "Piyush"
/// mobile : "9875546464"
/// city : "14"
/// qid : "3442"
/// user_id : "3"
/// output : "znsjdjfjfjejsjfjx hdudbehdud"
/// amount : "50000"
/// type : "client"
/// type_event : "1"
/// booking_id : "0"
/// grapher_id : "0"
/// status : "1"
/// photographers_details : [{"date":"2023-06-15","data":[{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]},{"date":"2023-06-17","data":[{"photographer_type":"Traditional Cinematography","photographer_name":""},{"photographer_type":"Drone","photographer_name":""}]},{"date":"2023-06-20","data":[{"photographer_type":"Traditional Photography","photographer_name":""},{"photographer_type":"Candid Photography","photographer_name":""}]}]
/// update_date : "2023-06-15 09:33:23"
/// event_name : "Weding"

class AllJobs {
  AllJobs({
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

  AllJobs.fromJson(dynamic json) {
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
AllJobs copyWith({  String? id,
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
}) => AllJobs(  id: id ?? _id,
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

/// date : "2023-06-15"
/// data : [{"photographer_type":"Candid Cinematography","photographer_name":""},{"photographer_type":"LED Wall","photographer_name":""}]

// class PhotographersDetails1 {
//   PhotographersDetails1({
//       String? date,
//       List<Data3>? data,}){
//     _date = date;
//     _data = data;
// }
//
//   PhotographersDetails1.fromJson(dynamic json) {
//     _date = json['date'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data3.fromJson(v));
//       });
//     }
//   }
//   String? _date;
//   List<Data3>? _data;
// PhotographersDetails1 copyWith({  String? date,
//   List<Data3>? data,
// }) => PhotographersDetails1(  date: date ?? _date,
//   data: data ?? _data,
// );
//   String? get date => _date;
//   List<Data3>? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['date'] = _date;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// photographer_type : "Candid Cinematography"
// /// photographer_name : ""
//
// class Data2 {
//   Data2({
//       String? photographerType,
//       String? photographerName,}){
//     _photographerType = photographerType;
//     _photographerName = photographerName;
// }
//
//   Data2.fromJson(dynamic json) {
//     _photographerType = json['photographer_type'];
//     _photographerName = json['photographer_name'];
//   }
//   String? _photographerType;
//   String? _photographerName;
// Data2 copyWith({  String? photographerType,
//   String? photographerName,
// }) => Data2(  photographerType: photographerType ?? _photographerType,
//   photographerName: photographerName ?? _photographerName,
// );
//   String? get photographerType => _photographerType;
//   String? get photographerName => _photographerName;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['photographer_type'] = _photographerType;
//     map['photographer_name'] = _photographerName;
//     return map;
//   }
//
// }