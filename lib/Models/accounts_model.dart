/// error : false
/// message : "All Ledgers"
/// data : {"all":[{"id":"69","is_job":"0","job_id":"207","user_id":"26","photographer_id":"292","type":"1","date":"2023-07-01","description":"Client Job ID: JOB00001","debit":"80000.00","credit":"0.00","status":"0","created_at":"2023-07-01 13:04:00","updated_at":"2023-07-01 13:04:00","name":"Kirtiraj singh","city":"Dewas","amount":"80000"}],"outstanting":[{"id":"69","is_job":"0","job_id":"207","user_id":"26","photographer_id":"292","type":"1","date":"2023-07-01","description":"Client Job ID: JOB00001","debit":"80000.00","credit":"0.00","status":"0","created_at":"2023-07-01 13:04:00","updated_at":"2023-07-01 13:04:00","name":"Kirtiraj singh","city":"Dewas","amount":"80000"}],"total_amount":"80000"}

class AccountsModel {
  AccountsModel({
      bool? error, 
      String? message, 
      AccountData? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  AccountsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? AccountData.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  AccountData? _data;
AccountsModel copyWith({  bool? error,
  String? message,
  AccountData? data,
}) => AccountsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  AccountData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// all : [{"id":"69","is_job":"0","job_id":"207","user_id":"26","photographer_id":"292","type":"1","date":"2023-07-01","description":"Client Job ID: JOB00001","debit":"80000.00","credit":"0.00","status":"0","created_at":"2023-07-01 13:04:00","updated_at":"2023-07-01 13:04:00","name":"Kirtiraj singh","city":"Dewas","amount":"80000"}]
/// outstanting : [{"id":"69","is_job":"0","job_id":"207","user_id":"26","photographer_id":"292","type":"1","date":"2023-07-01","description":"Client Job ID: JOB00001","debit":"80000.00","credit":"0.00","status":"0","created_at":"2023-07-01 13:04:00","updated_at":"2023-07-01 13:04:00","name":"Kirtiraj singh","city":"Dewas","amount":"80000"}]
/// total_amount : "80000"

class AccountData {
  AccountData({
      List<All>? all, 
      List<Outstanting>? outstanting, 
      String? totalAmount,}){
    _all = all;
    _outstanting = outstanting;
    _totalAmount = totalAmount;
}

  AccountData.fromJson(dynamic json) {
    if (json['all'] != null) {
      _all = [];
      json['all'].forEach((v) {
        _all?.add(All.fromJson(v));
      });
    }
    if (json['outstanting'] != null) {
      _outstanting = [];
      json['outstanting'].forEach((v) {
        _outstanting?.add(Outstanting.fromJson(v));
      });
    }
    _totalAmount = json['total_amount'];
  }
  List<All>? _all;
  List<Outstanting>? _outstanting;
  String? _totalAmount;
AccountData copyWith({  List<All>? all,
  List<Outstanting>? outstanting,
  String? totalAmount,
}) => AccountData(  all: all ?? _all,
  outstanting: outstanting ?? _outstanting,
  totalAmount: totalAmount ?? _totalAmount,
);
  List<All>? get all => _all;
  List<Outstanting>? get outstanting => _outstanting;
  String? get totalAmount => _totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_all != null) {
      map['all'] = _all?.map((v) => v.toJson()).toList();
    }
    if (_outstanting != null) {
      map['outstanting'] = _outstanting?.map((v) => v.toJson()).toList();
    }
    map['total_amount'] = _totalAmount;
    return map;
  }

}

/// id : "69"
/// is_job : "0"
/// job_id : "207"
/// user_id : "26"
/// photographer_id : "292"
/// type : "1"
/// date : "2023-07-01"
/// description : "Client Job ID: JOB00001"
/// debit : "80000.00"
/// credit : "0.00"
/// status : "0"
/// created_at : "2023-07-01 13:04:00"
/// updated_at : "2023-07-01 13:04:00"
/// name : "Kirtiraj singh"
/// city : "Dewas"
/// amount : "80000"

class Outstanting {
  Outstanting({
      String? id, 
      String? isJob, 
      String? jobId, 
      String? userId, 
      String? photographerId, 
      String? type, 
      String? date, 
      String? description, 
      String? debit, 
      String? credit, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? name, 
      String? city, 
      String? amount,}){
    _id = id;
    _isJob = isJob;
    _jobId = jobId;
    _userId = userId;
    _photographerId = photographerId;
    _type = type;
    _date = date;
    _description = description;
    _debit = debit;
    _credit = credit;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _city = city;
    _amount = amount;
}

  Outstanting.fromJson(dynamic json) {
    _id = json['id'];
    _isJob = json['is_job'];
    _jobId = json['job_id'];
    _userId = json['user_id'];
    _photographerId = json['photographer_id'];
    _type = json['type'];
    _date = json['date'];
    _description = json['description'];
    _debit = json['debit'];
    _credit = json['credit'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
    _city = json['city'];
    _amount = json['amount'];
  }
  String? _id;
  String? _isJob;
  String? _jobId;
  String? _userId;
  String? _photographerId;
  String? _type;
  String? _date;
  String? _description;
  String? _debit;
  String? _credit;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  String? _city;
  String? _amount;
Outstanting copyWith({  String? id,
  String? isJob,
  String? jobId,
  String? userId,
  String? photographerId,
  String? type,
  String? date,
  String? description,
  String? debit,
  String? credit,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? name,
  String? city,
  String? amount,
}) => Outstanting(  id: id ?? _id,
  isJob: isJob ?? _isJob,
  jobId: jobId ?? _jobId,
  userId: userId ?? _userId,
  photographerId: photographerId ?? _photographerId,
  type: type ?? _type,
  date: date ?? _date,
  description: description ?? _description,
  debit: debit ?? _debit,
  credit: credit ?? _credit,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  name: name ?? _name,
  city: city ?? _city,
  amount: amount ?? _amount,
);
  String? get id => _id;
  String? get isJob => _isJob;
  String? get jobId => _jobId;
  String? get userId => _userId;
  String? get photographerId => _photographerId;
  String? get type => _type;
  String? get date => _date;
  String? get description => _description;
  String? get debit => _debit;
  String? get credit => _credit;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get name => _name;
  String? get city => _city;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_job'] = _isJob;
    map['job_id'] = _jobId;
    map['user_id'] = _userId;
    map['photographer_id'] = _photographerId;
    map['type'] = _type;
    map['date'] = _date;
    map['description'] = _description;
    map['debit'] = _debit;
    map['credit'] = _credit;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['name'] = _name;
    map['city'] = _city;
    map['amount'] = _amount;
    return map;
  }

}

/// id : "69"
/// is_job : "0"
/// job_id : "207"
/// user_id : "26"
/// photographer_id : "292"
/// type : "1"
/// date : "2023-07-01"
/// description : "Client Job ID: JOB00001"
/// debit : "80000.00"
/// credit : "0.00"
/// status : "0"
/// created_at : "2023-07-01 13:04:00"
/// updated_at : "2023-07-01 13:04:00"
/// name : "Kirtiraj singh"
/// city : "Dewas"
/// amount : "80000"

class All {
  All({
      String? id, 
      String? isJob, 
      String? jobId, 
      String? userId, 
      String? photographerId, 
      String? type, 
      String? date, 
      String? description, 
      String? debit, 
      String? credit, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? name, 
      String? city, 
      String? amount,}){
    _id = id;
    _isJob = isJob;
    _jobId = jobId;
    _userId = userId;
    _photographerId = photographerId;
    _type = type;
    _date = date;
    _description = description;
    _debit = debit;
    _credit = credit;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _name = name;
    _city = city;
    _amount = amount;
}

  All.fromJson(dynamic json) {
    _id = json['id'];
    _isJob = json['is_job'];
    _jobId = json['job_id'];
    _userId = json['user_id'];
    _photographerId = json['photographer_id'];
    _type = json['type'];
    _date = json['date'];
    _description = json['description'];
    _debit = json['debit'];
    _credit = json['credit'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _name = json['name'];
    _city = json['city'];
    _amount = json['amount'];
  }
  String? _id;
  String? _isJob;
  String? _jobId;
  String? _userId;
  String? _photographerId;
  String? _type;
  String? _date;
  String? _description;
  String? _debit;
  String? _credit;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _name;
  String? _city;
  String? _amount;
All copyWith({  String? id,
  String? isJob,
  String? jobId,
  String? userId,
  String? photographerId,
  String? type,
  String? date,
  String? description,
  String? debit,
  String? credit,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? name,
  String? city,
  String? amount,
}) => All(  id: id ?? _id,
  isJob: isJob ?? _isJob,
  jobId: jobId ?? _jobId,
  userId: userId ?? _userId,
  photographerId: photographerId ?? _photographerId,
  type: type ?? _type,
  date: date ?? _date,
  description: description ?? _description,
  debit: debit ?? _debit,
  credit: credit ?? _credit,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  name: name ?? _name,
  city: city ?? _city,
  amount: amount ?? _amount,
);
  String? get id => _id;
  String? get isJob => _isJob;
  String? get jobId => _jobId;
  String? get userId => _userId;
  String? get photographerId => _photographerId;
  String? get type => _type;
  String? get date => _date;
  String? get description => _description;
  String? get debit => _debit;
  String? get credit => _credit;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get name => _name;
  String? get city => _city;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['is_job'] = _isJob;
    map['job_id'] = _jobId;
    map['user_id'] = _userId;
    map['photographer_id'] = _photographerId;
    map['type'] = _type;
    map['date'] = _date;
    map['description'] = _description;
    map['debit'] = _debit;
    map['credit'] = _credit;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['name'] = _name;
    map['city'] = _city;
    map['amount'] = _amount;
    return map;
  }

}