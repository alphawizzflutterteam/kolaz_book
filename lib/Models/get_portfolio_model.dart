/// error : false
/// message : "Portfolio"
/// data : [{"id":"16","username":"KB00020","email":"roshanali.nandoliya@gmail.com","fname":"Roshanali","lname":"Nandoliya","countrycode":"","currency":"","mobile":"8200969457","company_logo":"","company_link":"www.snapoflife.com","password":"e10adc3949ba59abbe56e057f20f883e","profile_pic":"https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/649ad7e54c2a4.jpg","facebook":"www.facebook.com","note":"","instagram":"www.instagram.com","youtube":"www.youtube.com","company_name":null,"company_number":"2147483647","type":"","isGold":"0","address":"","company_address":"Palanpur","city":"Patan","state":"Gujarat","country":"India","device_token":"","date":"2024-07-24","agreecheck":"0","otp":"2297","status":"1","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"is_freelancer":"1","category_id":"249","about":"This is text box","equipments":"This is text box","country_visited":"India","cover_image":"https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/649ac651c8219.jpg","created_at":"2023-06-21 16:47:31","updated_at":"2023-06-27 12:36:53"}]

class GetPortfolioModel {
  GetPortfolioModel({
      bool? error, 
      String? message, 
      List<Portfolio>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetPortfolioModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Portfolio.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Portfolio>? _data;
GetPortfolioModel copyWith({  bool? error,
  String? message,
  List<Portfolio>? data,
}) => GetPortfolioModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Portfolio>? get data => _data;

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

/// id : "16"
/// username : "KB00020"
/// email : "roshanali.nandoliya@gmail.com"
/// fname : "Roshanali"
/// lname : "Nandoliya"
/// countrycode : ""
/// currency : ""
/// mobile : "8200969457"
/// company_logo : ""
/// company_link : "www.snapoflife.com"
/// password : "e10adc3949ba59abbe56e057f20f883e"
/// profile_pic : "https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/649ad7e54c2a4.jpg"
/// facebook : "www.facebook.com"
/// note : ""
/// instagram : "www.instagram.com"
/// youtube : "www.youtube.com"
/// company_name : null
/// company_number : "2147483647"
/// type : ""
/// isGold : "0"
/// address : ""
/// company_address : "Palanpur"
/// city : "Patan"
/// state : "Gujarat"
/// country : "India"
/// device_token : ""
/// date : "2024-07-24"
/// agreecheck : "0"
/// otp : "2297"
/// status : "1"
/// wallet : "0.00"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : null
/// is_freelancer : "1"
/// category_id : "249"
/// about : "This is text box"
/// equipments : "This is text box"
/// country_visited : "India"
/// cover_image : "https://developmentalphawizz.com/kolaz_book/uploads/profile_pics/649ac651c8219.jpg"
/// created_at : "2023-06-21 16:47:31"
/// updated_at : "2023-06-27 12:36:53"

class Portfolio {
  Portfolio({
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
      String? facebook, 
      String? note, 
      String? instagram, 
      String? youtube, 
      dynamic companyName, 
      String? companyNumber, 
      String? type, 
      String? isGold, 
      String? address, 
      String? companyAddress, 
      String? city, 
      String? state, 
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
      String? isFreelancer, 
      String? categoryId,
    String? categoryName,
    String? about,
      String? equipments, 
      String? countryVisited, 
      String? coverImage, 
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
    _state = state;
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
    _isFreelancer = isFreelancer;
    _categoryId = categoryId;
    _categoryName = categoryName;
    _about = about;
    _equipments = equipments;
    _countryVisited = countryVisited;
    _coverImage = coverImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Portfolio.fromJson(dynamic json) {
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
    _state = json['state'];
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
    _isFreelancer = json['is_freelancer'];
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _about = json['about'];
    _equipments = json['equipments'];
    _countryVisited = json['country_visited'];
    _coverImage = json['cover_image'];
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
  String? _facebook;
  String? _note;
  String? _instagram;
  String? _youtube;
  dynamic _companyName;
  String? _companyNumber;
  String? _type;
  String? _isGold;
  String? _address;
  String? _companyAddress;
  String? _city;
  String? _state;
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
  String? _isFreelancer;
  String? _categoryId;
  String? _categoryName;
  String? _about;
  String? _equipments;
  String? _countryVisited;
  String? _coverImage;
  String? _createdAt;
  String? _updatedAt;
Portfolio copyWith({  String? id,
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
  String? facebook,
  String? note,
  String? instagram,
  String? youtube,
  dynamic companyName,
  String? companyNumber,
  String? type,
  String? isGold,
  String? address,
  String? companyAddress,
  String? city,
  String? state,
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
  String? isFreelancer,
  String? categoryId,
  String? about,
  String? equipments,
  String? countryVisited,
  String? coverImage,
  String? createdAt,
  String? updatedAt,
}) => Portfolio(  id: id ?? _id,
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
  state: state ?? _state,
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
  isFreelancer: isFreelancer ?? _isFreelancer,
  categoryId: categoryId ?? _categoryId,
  categoryName: categoryId ?? _categoryName,
  about: about ?? _about,
  equipments: equipments ?? _equipments,
  countryVisited: countryVisited ?? _countryVisited,
  coverImage: coverImage ?? _coverImage,
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
  String? get facebook => _facebook;
  String? get note => _note;
  String? get instagram => _instagram;
  String? get youtube => _youtube;
  dynamic get companyName => _companyName;
  String? get companyNumber => _companyNumber;
  String? get type => _type;
  String? get isGold => _isGold;
  String? get address => _address;
  String? get companyAddress => _companyAddress;
  String? get city => _city;
  String? get state => _state;
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
  String? get isFreelancer => _isFreelancer;
  String? get categoryId => _categoryId;
  String? get categoryName => _categoryName;
  String? get about => _about;
  String? get equipments => _equipments;
  String? get countryVisited => _countryVisited;
  String? get coverImage => _coverImage;
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
    map['state'] = _state;
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
    map['is_freelancer'] = _isFreelancer;
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['about'] = _about;
    map['equipments'] = _equipments;
    map['country_visited'] = _countryVisited;
    map['cover_image'] = _coverImage;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}