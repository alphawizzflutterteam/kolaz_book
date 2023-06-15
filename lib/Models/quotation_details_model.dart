/// status : "1"
/// msg : "Get Date"
/// setting : [{"id":"96","client_name":"Karan","city":"3","qid":"2604","user_id":"3","output":"kuch u I ","amount":"60000","type":"client","type_event":"1","booking_id":"0","grapher_id":"0","status":"0","update_date":"2023-06-13 12:32:56","event_name":"Weeding","data":[{"id":"116","date":"2023-06-19","qid":"2604","photographer_id":"","event":"Candid Cinematography,Traditional Cinematography,Drone,Candid Photography","time":"","sub_amount":"","event_data":[{"event_name":"Candid Cinematography","photographer":""},{"event_name":"Traditional Cinematography","photographer":""},{"event_name":"Drone","photographer":""},{"event_name":"Candid Photography","photographer":""}]}]}]

class QuotationDetailsModel {
  QuotationDetailsModel({
      String? status,
      String? msg,
      List<Setting>? setting,}){
    _status = status;
    _msg = msg;
    _setting = setting;
}

  QuotationDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['setting'] != null) {
      _setting = [];
      json['setting'].forEach((v) {
        _setting?.add(Setting.fromJson(v));
      });
    }
  }
  String? _status;
  String? _msg;
  List<Setting>? _setting;
QuotationDetailsModel copyWith({  String? status,
  String? msg,
  List<Setting>? setting,
}) => QuotationDetailsModel(  status: status ?? _status,
  msg: msg ?? _msg,
  setting: setting ?? _setting,
);
  String? get status => _status;
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

/// id : "96"
/// client_name : "Karan"
/// city : "3"
/// qid : "2604"
/// user_id : "3"
/// output : "kuch u I "
/// amount : "60000"
/// type : "client"
/// type_event : "1"
/// booking_id : "0"
/// grapher_id : "0"
/// status : "0"
/// update_date : "2023-06-13 12:32:56"
/// event_name : "Weeding"
/// data : [{"id":"116","date":"2023-06-19","qid":"2604","photographer_id":"","event":"Candid Cinematography,Traditional Cinematography,Drone,Candid Photography","time":"","sub_amount":"","event_data":[{"event_name":"Candid Cinematography","photographer":""},{"event_name":"Traditional Cinematography","photographer":""},{"event_name":"Drone","photographer":""},{"event_name":"Candid Photography","photographer":""}]}]

class Setting {
  Setting({
      String? id,
      String? clientName,
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
      String? updateDate,
      String? eventName,
      List<Data>? data,}){
    _id = id;
    _clientName = clientName;
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
    _updateDate = updateDate;
    _eventName = eventName;
    _data = data;
}

  Setting.fromJson(dynamic json) {
    _id = json['id'];
    _clientName = json['client_name'];
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
    _updateDate = json['update_date'];
    _eventName = json['event_name'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _id;
  String? _clientName;
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
  String? _updateDate;
  String? _eventName;
  List<Data>? _data;
Setting copyWith({  String? id,
  String? clientName,
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
  String? updateDate,
  String? eventName,
  List<Data>? data,
}) => Setting(  id: id ?? _id,
  clientName: clientName ?? _clientName,
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
  updateDate: updateDate ?? _updateDate,
  eventName: eventName ?? _eventName,
  data: data ?? _data,
);
  String? get id => _id;
  String? get clientName => _clientName;
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
  String? get updateDate => _updateDate;
  String? get eventName => _eventName;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['client_name'] = _clientName;
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
    map['update_date'] = _updateDate;
    map['event_name'] = _eventName;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "116"
/// date : "2023-06-19"
/// qid : "2604"
/// photographer_id : ""
/// event : "Candid Cinematography,Traditional Cinematography,Drone,Candid Photography"
/// time : ""
/// sub_amount : ""
/// event_data : [{"event_name":"Candid Cinematography","photographer":""},{"event_name":"Traditional Cinematography","photographer":""},{"event_name":"Drone","photographer":""},{"event_name":"Candid Photography","photographer":""}]

class Data {
  Data({
      String? id,
      String? date,
      String? qid,
      String? photographerId,
      String? event,
      String? time,
      String? subAmount,
      List<EventData>? eventData,}){
    _id = id;
    _date = date;
    _qid = qid;
    _photographerId = photographerId;
    _event = event;
    _time = time;
    _subAmount = subAmount;
    _eventData = eventData;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _qid = json['qid'];
    _photographerId = json['photographer_id'];
    _event = json['event'];
    _time = json['time'];
    _subAmount = json['sub_amount'];
    if (json['event_data'] != null) {
      _eventData = [];
      json['event_data'].forEach((v) {
        _eventData?.add(EventData.fromJson(v));
      });
    }
  }
  String? _id;
  String? _date;
  String? _qid;
  String? _photographerId;
  String? _event;
  String? _time;
  String? _subAmount;
  List<EventData>? _eventData;
Data copyWith({  String? id,
  String? date,
  String? qid,
  String? photographerId,
  String? event,
  String? time,
  String? subAmount,
  List<EventData>? eventData,
}) => Data(  id: id ?? _id,
  date: date ?? _date,
  qid: qid ?? _qid,
  photographerId: photographerId ?? _photographerId,
  event: event ?? _event,
  time: time ?? _time,
  subAmount: subAmount ?? _subAmount,
  eventData: eventData ?? _eventData,
);
  String? get id => _id;
  String? get date => _date;
  String? get qid => _qid;
  String? get photographerId => _photographerId;
  String? get event => _event;
  String? get time => _time;
  String? get subAmount => _subAmount;
  List<EventData>? get eventData => _eventData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['qid'] = _qid;
    map['photographer_id'] = _photographerId;
    map['event'] = _event;
    map['time'] = _time;
    map['sub_amount'] = _subAmount;
    if (_eventData != null) {
      map['event_data'] = _eventData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// event_name : "Candid Cinematography"
/// photographer : ""

class EventData {
  EventData({
      String? eventName,
      String? photographer,}){
    _eventName = eventName;
    _photographer = photographer;
}

  EventData.fromJson(dynamic json) {
    _eventName = json['event_name'];
    _photographer = json['photographer'];
  }
  String? _eventName;
  String? _photographer;
EventData copyWith({  String? eventName,
  String? photographer,
}) => EventData(  eventName: eventName ?? _eventName,
  photographer: photographer ?? _photographer,
);
  String? get eventName => _eventName;
  String? get photographer => _photographer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_name'] = _eventName;
    map['photographer'] = _photographer;
    return map;
  }

}