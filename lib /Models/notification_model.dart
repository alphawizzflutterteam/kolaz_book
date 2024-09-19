/// error : false
/// message : "All Notifications"
/// data : [{"not_id":"562","user_id":"3","data_id":"192","type":"quotation","title":"Quotation Created: Quotation ID192","message":"Quotation Created Successfully","is_read":"0","created_at":"2023-06-29 13:14:30","date":"2023-06-29 13:14:30"}]

class NotificationModel {
  NotificationModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  NotificationModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
NotificationModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => NotificationModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// not_id : "562"
/// user_id : "3"
/// data_id : "192"
/// type : "quotation"
/// title : "Quotation Created: Quotation ID192"
/// message : "Quotation Created Successfully"
/// is_read : "0"
/// created_at : "2023-06-29 13:14:30"
/// date : "2023-06-29 13:14:30"

class Data {
  Data({
      String? notId, 
      String? userId, 
      String? dataId, 
      String? type, 
      String? title, 
      String? message, 
      String? isRead, 
      String? createdAt, 
      String? date,}){
    _notId = notId;
    _userId = userId;
    _dataId = dataId;
    _type = type;
    _title = title;
    _message = message;
    _isRead = isRead;
    _createdAt = createdAt;
    _date = date;
}

  Data.fromJson(dynamic json) {
    _notId = json['not_id'];
    _userId = json['user_id'];
    _dataId = json['data_id'];
    _type = json['type'];
    _title = json['title'];
    _message = json['message'];
    _isRead = json['is_read'];
    _createdAt = json['created_at'];
    _date = json['date'];
  }
  String? _notId;
  String? _userId;
  String? _dataId;
  String? _type;
  String? _title;
  String? _message;
  String? _isRead;
  String? _createdAt;
  String? _date;
Data copyWith({  String? notId,
  String? userId,
  String? dataId,
  String? type,
  String? title,
  String? message,
  String? isRead,
  String? createdAt,
  String? date,
}) => Data(  notId: notId ?? _notId,
  userId: userId ?? _userId,
  dataId: dataId ?? _dataId,
  type: type ?? _type,
  title: title ?? _title,
  message: message ?? _message,
  isRead: isRead ?? _isRead,
  createdAt: createdAt ?? _createdAt,
  date: date ?? _date,
);
  String? get notId => _notId;
  String? get userId => _userId;
  String? get dataId => _dataId;
  String? get type => _type;
  String? get title => _title;
  String? get message => _message;
  String? get isRead => _isRead;
  String? get createdAt => _createdAt;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['not_id'] = _notId;
    map['user_id'] = _userId;
    map['data_id'] = _dataId;
    map['type'] = _type;
    map['title'] = _title;
    map['message'] = _message;
    map['is_read'] = _isRead;
    map['created_at'] = _createdAt;
    map['date'] = _date;
    return map;
  }

}