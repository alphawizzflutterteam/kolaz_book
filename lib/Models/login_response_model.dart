import 'dart:convert';

/// error : false
/// message : "User Login Success"
/// data : [{"id":"283","username":"","email":"karanstomar@icloud.com","fname":"Karan","lname":"Tomar","countrycode":"","currency":"","mobile":"8770496666","company_logo":"","company_link":"","password":"25d55ad283aa400af464c76d713c07ad","profile_pic":"","facebook":null,"note":null,"instagram":null,"youtube":null,"company_name":null,"company_number":null,"type":"","isGold":"0","address":"","company_address":null,"city":"","country":"","device_token":"","date":"","agreecheck":"0","otp":"6481","status":"1","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-06-01 11:45:38","updated_at":"2023-06-01 11:45:38"}]

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());


class LoginResponseModel {
  LoginResponseModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  LoginResponseModel.fromJson(dynamic json) {
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
LoginResponseModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => LoginResponseModel(  error: error ?? _error,
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

/// id : "283"
/// username : ""
/// email : "karanstomar@icloud.com"
/// fname : "Karan"
/// lname : "Tomar"
/// countrycode : ""
/// currency : ""
/// mobile : "8770496666"
/// company_logo : ""
/// company_link : ""
/// password : "25d55ad283aa400af464c76d713c07ad"
/// profile_pic : ""
/// facebook : null
/// note : null
/// instagram : null
/// youtube : null
/// company_name : null
/// company_number : null
/// type : ""
/// isGold : "0"
/// address : ""
/// company_address : null
/// city : ""
/// country : ""
/// device_token : ""
/// date : ""
/// agreecheck : "0"
/// otp : "6481"
/// status : "1"
/// wallet : "0.00"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : null
/// created_at : "2023-06-01 11:45:38"
/// updated_at : "2023-06-01 11:45:38"

class Data {
  Data({
      String? id, 
      String? username, 
      String? email, 
      String? fname, 
      String? lname, 
      String? countrycode, 
      String? currency, 
      String? mobile, 
      String? companyLogo, 
      String? companyLink, 
      String? password, 
      String? profilePic, 
      dynamic facebook, 
      dynamic note, 
      dynamic instagram, 
      dynamic youtube, 
      dynamic companyName, 
      dynamic companyNumber, 
      String? type, 
      String? isGold, 
      String? address, 
      dynamic companyAddress, 
      String? city, 
      String? country, 
      String? deviceToken, 
      String? date, 
      String? agreecheck, 
      String? otp, 
      String? status, 
      String? wallet, 
      dynamic oauthProvider, 
      dynamic oauthUid, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _username = username;
    _email = email;
    _fname = fname;
    _lname = lname;
    _countrycode = countrycode;
    _currency = currency;
    _mobile = mobile;
    _companyLogo = companyLogo;
    _companyLink = companyLink;
    _password = password;
    _profilePic = profilePic;
    _facebook = facebook;
    _note = note;
    _instagram = instagram;
    _youtube = youtube;
    _companyName = companyName;
    _companyNumber = companyNumber;
    _type = type;
    _isGold = isGold;
    _address = address;
    _companyAddress = companyAddress;
    _city = city;
    _country = country;
    _deviceToken = deviceToken;
    _date = date;
    _agreecheck = agreecheck;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _oauthProvider = oauthProvider;
    _oauthUid = oauthUid;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _fname = json['fname'];
    _lname = json['lname'];
    _countrycode = json['countrycode'];
    _currency = json['currency'];
    _mobile = json['mobile'];
    _companyLogo = json['company_logo'];
    _companyLink = json['company_link'];
    _password = json['password'];
    _profilePic = json['profile_pic'];
    _facebook = json['facebook'];
    _note = json['note'];
    _instagram = json['instagram'];
    _youtube = json['youtube'];
    _companyName = json['company_name'];
    _companyNumber = json['company_number'];
    _type = json['type'];
    _isGold = json['isGold'];
    _address = json['address'];
    _companyAddress = json['company_address'];
    _city = json['city'];
    _country = json['country'];
    _deviceToken = json['device_token'];
    _date = json['date'];
    _agreecheck = json['agreecheck'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _oauthProvider = json['oauth_provider'];
    _oauthUid = json['oauth_uid'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _username;
  String? _email;
  String? _fname;
  String? _lname;
  String? _countrycode;
  String? _currency;
  String? _mobile;
  String? _companyLogo;
  String? _companyLink;
  String? _password;
  String? _profilePic;
  dynamic _facebook;
  dynamic _note;
  dynamic _instagram;
  dynamic _youtube;
  dynamic _companyName;
  dynamic _companyNumber;
  String? _type;
  String? _isGold;
  String? _address;
  dynamic _companyAddress;
  String? _city;
  String? _country;
  String? _deviceToken;
  String? _date;
  String? _agreecheck;
  String? _otp;
  String? _status;
  String? _wallet;
  dynamic _oauthProvider;
  dynamic _oauthUid;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? username,
  String? email,
  String? fname,
  String? lname,
  String? countrycode,
  String? currency,
  String? mobile,
  String? companyLogo,
  String? companyLink,
  String? password,
  String? profilePic,
  dynamic facebook,
  dynamic note,
  dynamic instagram,
  dynamic youtube,
  dynamic companyName,
  dynamic companyNumber,
  String? type,
  String? isGold,
  String? address,
  dynamic companyAddress,
  String? city,
  String? country,
  String? deviceToken,
  String? date,
  String? agreecheck,
  String? otp,
  String? status,
  String? wallet,
  dynamic oauthProvider,
  dynamic oauthUid,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  fname: fname ?? _fname,
  lname: lname ?? _lname,
  countrycode: countrycode ?? _countrycode,
  currency: currency ?? _currency,
  mobile: mobile ?? _mobile,
  companyLogo: companyLogo ?? _companyLogo,
  companyLink: companyLink ?? _companyLink,
  password: password ?? _password,
  profilePic: profilePic ?? _profilePic,
  facebook: facebook ?? _facebook,
  note: note ?? _note,
  instagram: instagram ?? _instagram,
  youtube: youtube ?? _youtube,
  companyName: companyName ?? _companyName,
  companyNumber: companyNumber ?? _companyNumber,
  type: type ?? _type,
  isGold: isGold ?? _isGold,
  address: address ?? _address,
  companyAddress: companyAddress ?? _companyAddress,
  city: city ?? _city,
  country: country ?? _country,
  deviceToken: deviceToken ?? _deviceToken,
  date: date ?? _date,
  agreecheck: agreecheck ?? _agreecheck,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  oauthProvider: oauthProvider ?? _oauthProvider,
  oauthUid: oauthUid ?? _oauthUid,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get fname => _fname;
  String? get lname => _lname;
  String? get countrycode => _countrycode;
  String? get currency => _currency;
  String? get mobile => _mobile;
  String? get companyLogo => _companyLogo;
  String? get companyLink => _companyLink;
  String? get password => _password;
  String? get profilePic => _profilePic;
  dynamic get facebook => _facebook;
  dynamic get note => _note;
  dynamic get instagram => _instagram;
  dynamic get youtube => _youtube;
  dynamic get companyName => _companyName;
  dynamic get companyNumber => _companyNumber;
  String? get type => _type;
  String? get isGold => _isGold;
  String? get address => _address;
  dynamic get companyAddress => _companyAddress;
  String? get city => _city;
  String? get country => _country;
  String? get deviceToken => _deviceToken;
  String? get date => _date;
  String? get agreecheck => _agreecheck;
  String? get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  dynamic get oauthProvider => _oauthProvider;
  dynamic get oauthUid => _oauthUid;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['fname'] = _fname;
    map['lname'] = _lname;
    map['countrycode'] = _countrycode;
    map['currency'] = _currency;
    map['mobile'] = _mobile;
    map['company_logo'] = _companyLogo;
    map['company_link'] = _companyLink;
    map['password'] = _password;
    map['profile_pic'] = _profilePic;
    map['facebook'] = _facebook;
    map['note'] = _note;
    map['instagram'] = _instagram;
    map['youtube'] = _youtube;
    map['company_name'] = _companyName;
    map['company_number'] = _companyNumber;
    map['type'] = _type;
    map['isGold'] = _isGold;
    map['address'] = _address;
    map['company_address'] = _companyAddress;
    map['city'] = _city;
    map['country'] = _country;
    map['device_token'] = _deviceToken;
    map['date'] = _date;
    map['agreecheck'] = _agreecheck;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['oauth_provider'] = _oauthProvider;
    map['oauth_uid'] = _oauthUid;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}