/// status : false
/// msg : "All Quotation list"
/// setting : [{"city_name":"Agra","id":"131","client_name":"Ajay","mobile":"9686211755","city":"14","qid":"QUA00001","user_id":"3","output":"h jcuskcdovdgjfic","amount":"20000","type":"client","type_event":"1","booking_id":"0","grapher_id":"0","status":"0","photographers_details":[{"date":"2023-06-17","data":[{"photographer_type":"Candid Cinematography"},{"photographer_type":"LED Wall"}]},{"date":"2023-06-20","data":[{"photographer_type":"Drone"},{"photographer_type":"Candid Photography"}]}],"update_date":"2023-06-17 12:58:12","event_name":"Weding"}]

import 'dart:convert';

GetQuotationModel getQuotationModelFromJson(String str) => GetQuotationModel.fromJson(json.decode(str));

String getQuotationModelToJson(GetQuotationModel data) => json.encode(data.toJson());

class GetQuotationModel {
  GetQuotationModel({
      bool? status, 
      String? msg, 
      List<Setting>? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  GetQuotationModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['setting'] != null) {
      _setting = [];
      json['setting'].forEach((v) {
        _setting?.add(Setting.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _msg;
  List<Setting>? _setting;
GetQuotationModel copyWith({  bool? status,
  String? msg,
  List<Setting>? setting,
}) => GetQuotationModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  bool? get status => _status;
  String? get msg => _msg;
  List<Setting>? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_setting != null) {
      map['setting'] = _setting?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// city_name : "Agra"
/// id : "131"
/// client_name : "Ajay"
/// mobile : "9686211755"
/// city : "14"
/// qid : "QUA00001"
/// user_id : "3"
/// output : "h jcuskcdovdgjfic"
/// amount : "20000"
/// type : "client"
/// type_event : "1"
/// booking_id : "0"
/// grapher_id : "0"
/// status : "0"
/// photographers_details : [{"date":"2023-06-17","data":[{"photographer_type":"Candid Cinematography"},{"photographer_type":"LED Wall"}]},{"date":"2023-06-20","data":[{"photographer_type":"Drone"},{"photographer_type":"Candid Photography"}]}]
/// update_date : "2023-06-17 12:58:12"
/// event_name : "Weding"

class Setting {
  Setting({
      String? cityName, 
      String? id, 
      String? clientName,
    String? clientId,
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
    _cityName = cityName;
    _id = id;
    _clientName = clientName;
    _clientId = clientId;
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

  Setting.fromJson(dynamic json) {
    _cityName = json['city_name'];
    _id = json['id'];
    _clientName = json['client_name'];
    _clientId = json['cliend_id'];
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
    }else{
      _photographersDetails = [];
    }
    _updateDate = json['update_date'];
    _eventName = json['event_name'];
  }
  String? _cityName;
  String? _id;
  String? _clientName;
  String? _clientId;
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
Setting copyWith({  String? cityName,
  String? id,
  String? clientName,
  String? clientId,
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
}) => Setting(  cityName: cityName ?? _cityName,
  id: id ?? _id,
  clientName: clientName ?? _clientName,
  clientId: clientId ?? _clientId,
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
  String? get cityName => _cityName;
  String? get id => _id;
  String? get clientName => _clientName;
  String? get clientId => _clientId;
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
  List<PhotographersDetails>? get photographersDetails => _photographersDetails ;
  String? get updateDate => _updateDate;
  String? get eventName => _eventName;

  set setNewList(List<PhotographersDetails> newData) {
    _photographersDetails = newData;
  }
  // set setNewList(List value){
  //   _photographersDetails = value.cast<PhotographersDetails>();
  // }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_name'] = _cityName;
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

/// date : "2023-06-17"
/// data : [{"photographer_type":"Candid Cinematography"},{"photographer_type":"LED Wall"}]

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
    }else{
      _data = [];
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

  set setNewData(List newData) {
    _data = newData.cast<Data>();
  }



  set setDate(var value) {
    _date = value;
  }

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

class Data {
  Data({
      String? photographerType,}){
    _photographerType = photographerType;
}

  Data.fromJson(dynamic json) {
    _photographerType = json['photographer_type'];
  }
  String? _photographerType;
Data copyWith({  String? photographerType,
}) => Data(  photographerType: photographerType ?? _photographerType,
);
  String? get photographerType => _photographerType;

  set setPhotographer(var value) {
    _photographerType = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['photographer_type'] = _photographerType;
    return map;
  }

}