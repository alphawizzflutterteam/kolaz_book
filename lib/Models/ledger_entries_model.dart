/// error : true
/// message : "Ledgers List"
/// data : [{"id":"22","is_job":"0","job_id":"164","user_id":"5","photographer_id":"251","type":"1","date":"2023-06-24","description":"Client Job ID: JOB00002","debit":"50000.00","credit":"0.00","status":"0","created_at":"2023-06-24 12:11:49","updated_at":"2023-06-24 12:11:49","name":"Surendra Singh","city":"Lalitpur"},{"id":"25","is_job":"0","job_id":"0","user_id":"5","photographer_id":"251","type":"1","date":"2023-06-24","description":"Amount Added to wallet","debit":"0.00","credit":"500.00","status":"0","created_at":"2023-06-24 13:35:56","updated_at":"2023-06-24 13:34:44","name":"Surendra Singh","city":"Lalitpur"},{"id":"26","is_job":"0","job_id":"0","user_id":"5","photographer_id":"251","type":"1","date":"2023-06-24","description":"Amount Added to wallet","debit":"0.00","credit":"500.00","status":"0","created_at":"2023-06-24 13:35:50","updated_at":"2023-06-24 13:35:50","name":"Surendra Singh","city":"Lalitpur"}]

class LedgerEntriesModel {
  LedgerEntriesModel({
      bool? error, 
      String? message, 
      List<LedgerData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  LedgerEntriesModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LedgerData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<LedgerData>? _data;
LedgerEntriesModel copyWith({  bool? error,
  String? message,
  List<LedgerData>? data,
}) => LedgerEntriesModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<LedgerData>? get data => _data;

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

/// id : "22"
/// is_job : "0"
/// job_id : "164"
/// user_id : "5"
/// photographer_id : "251"
/// type : "1"
/// date : "2023-06-24"
/// description : "Client Job ID: JOB00002"
/// debit : "50000.00"
/// credit : "0.00"
/// status : "0"
/// created_at : "2023-06-24 12:11:49"
/// updated_at : "2023-06-24 12:11:49"
/// name : "Surendra Singh"
/// city : "Lalitpur"

class LedgerData {
  LedgerData({
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
      String? city,}){
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
}

  LedgerData.fromJson(dynamic json) {
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
LedgerData copyWith({  String? id,
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
}) => LedgerData(
  id: id ?? _id,
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
    return map;
  }

}