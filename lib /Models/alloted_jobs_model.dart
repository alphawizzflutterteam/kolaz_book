/// error : false
/// message : "All alloted Job Lists"
/// data : [{"c_name":"Pre Wedding","date":"2023-07-06","photographer_name":"Parth Verma","client_name":"Kirtiraj singh","mobile":"6794949454","city":"Dewas","qid":"JOB00002","amount":"60000","photographer_type":"Candid Cinematography,Candid Photography"},{"c_name":"Wedding","date":"2023-07-07","photographer_name":"Tanmay Vaishnav","client_name":"Nikit Dwivedi","mobile":"9467675757","city":"Indore","qid":"JOB00001","amount":"10000","photographer_type":"Candid Cinematography,Album Printing"},{"c_name":"Pre Wedding","date":"2023-07-08","photographer_name":"Parth Verma","client_name":"Kirtiraj singh","mobile":"6794949454","city":"Dewas","qid":"JOB00002","amount":"60000","photographer_type":"Traditional Cinematography,Traditional Photography,Candid Photography"}]

class AllotedJobsModel {
  AllotedJobsModel({
      bool? error, 
      String? message, 
      List<AllotedJobs>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  AllotedJobsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AllotedJobs.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<AllotedJobs>? _data;
AllotedJobsModel copyWith({  bool? error,
  String? message,
  List<AllotedJobs>? data,
}) => AllotedJobsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<AllotedJobs>? get data => _data;

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

/// c_name : "Pre Wedding"
/// date : "2023-07-06"
/// photographer_name : "Parth Verma"
/// client_name : "Kirtiraj singh"
/// mobile : "6794949454"
/// city : "Dewas"
/// qid : "JOB00002"
/// amount : "60000"
/// photographer_type : "Candid Cinematography,Candid Photography"

class AllotedJobs {
  AllotedJobs({
      String? cName, 
      String? date, 
      String? photographerName, 
      String? clientName, 
      String? mobile, 
      String? city, 
      String? qid, 
      String? amount, 
      String? photographerType,}){
    _cName = cName;
    _date = date;
    _photographerName = photographerName;
    _clientName = clientName;
    _mobile = mobile;
    _city = city;
    _qid = qid;
    _amount = amount;
    _photographerType = photographerType;
}

  AllotedJobs.fromJson(dynamic json) {
    _cName = json['c_name'];
    _date = json['date'];
    _photographerName = json['photographer_name'];
    _clientName = json['client_name'];
    _mobile = json['mobile'];
    _city = json['city'];
    _qid = json['qid'];
    _amount = json['amount'];
    _photographerType = json['photographer_type'];
  }
  String? _cName;
  String? _date;
  String? _photographerName;
  String? _clientName;
  String? _mobile;
  String? _city;
  String? _qid;
  String? _amount;
  String? _photographerType;
AllotedJobs copyWith({  String? cName,
  String? date,
  String? photographerName,
  String? clientName,
  String? mobile,
  String? city,
  String? qid,
  String? amount,
  String? photographerType,
}) => AllotedJobs(  cName: cName ?? _cName,
  date: date ?? _date,
  photographerName: photographerName ?? _photographerName,
  clientName: clientName ?? _clientName,
  mobile: mobile ?? _mobile,
  city: city ?? _city,
  qid: qid ?? _qid,
  amount: amount ?? _amount,
  photographerType: photographerType ?? _photographerType,
);
  String? get cName => _cName;
  String? get date => _date;
  String? get photographerName => _photographerName;
  String? get clientName => _clientName;
  String? get mobile => _mobile;
  String? get city => _city;
  String? get qid => _qid;
  String? get amount => _amount;
  String? get photographerType => _photographerType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['c_name'] = _cName;
    map['date'] = _date;
    map['photographer_name'] = _photographerName;
    map['client_name'] = _clientName;
    map['mobile'] = _mobile;
    map['city'] = _city;
    map['qid'] = _qid;
    map['amount'] = _amount;
    map['photographer_type'] = _photographerType;
    return map;
  }

}