/// response_code : "1"
/// msg : "Membership plans"
/// data : [{"id":"1","title":"FREE SUBSCRIPTION","description":"FREE SUBSCRIPTION","price":0,"device":"2","time":"14","type":"1","image":"https://developmentalphawizz.com/kolaz_book/uploads/6360fcc3c653a.jpg","created_at":"2022-09-28 08:15:01","updated_at":"2023-06-17 07:52:50","time_text":"14 Days","plan_type":"Days","is_purchased":false},{"id":"2","title":"ANBASIC","description":"ANBASIC","price":3100,"device":null,"time":"1","type":"3","image":"https://developmentalphawizz.com/kolaz_book/uploads/63343112edf05.jpeg","created_at":"2022-09-28 05:41:06","updated_at":"2023-02-13 12:38:32","time_text":"1 Year","plan_type":"Yearly","is_purchased":false},{"id":"3","title":"ANPLUS","description":"ANPLUS","price":7999,"device":null,"time":"1","type":"3","image":"https://developmentalphawizz.com/kolaz_book/uploads/633431231d7ad.jpeg","created_at":"2022-09-28 05:41:06","updated_at":"2023-02-02 13:25:11","time_text":"1 Year","plan_type":"Yearly","is_purchased":false},{"id":"5","title":"Gold Plan","description":"Gold Plan","price":599,"device":"3","time":"25","type":"1","image":"https://developmentalphawizz.com/kolaz_book/uploads/648d67468d9e6.png","created_at":"2023-06-17 07:56:54","updated_at":"2023-06-17 07:57:05","time_text":"25 Days","plan_type":"Days","is_purchased":false}]

class GetSubscriptionPlansModel {
  GetSubscriptionPlansModel({
      String? responseCode, 
      String? msg, 
      List<Plans>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  GetSubscriptionPlansModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Plans.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Plans>? _data;
GetSubscriptionPlansModel copyWith({  String? responseCode,
  String? msg,
  List<Plans>? data,
}) => GetSubscriptionPlansModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Plans>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// title : "FREE SUBSCRIPTION"
/// description : "FREE SUBSCRIPTION"
/// price : 0
/// device : "2"
/// time : "14"
/// type : "1"
/// image : "https://developmentalphawizz.com/kolaz_book/uploads/6360fcc3c653a.jpg"
/// created_at : "2022-09-28 08:15:01"
/// updated_at : "2023-06-17 07:52:50"
/// time_text : "14 Days"
/// plan_type : "Days"
/// is_purchased : false

class Plans {
  Plans({
      String? id, 
      String? title, 
      String? description, 
      num? price, 
      String? device, 
      String? time, 
      String? type, 
      String? image, 
      String? createdAt, 
      String? updatedAt, 
      String? timeText, 
      String? planType, 
      bool? isPurchased,}){
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _device = device;
    _time = time;
    _type = type;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timeText = timeText;
    _planType = planType;
    _isPurchased = isPurchased;
}

  Plans.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _price = json['price'];
    _device = json['device'];
    _time = json['time'];
    _type = json['type'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeText = json['time_text'];
    _planType = json['plan_type'];
    _isPurchased = json['is_purchased'];
  }
  String? _id;
  String? _title;
  String? _description;
  num? _price;
  String? _device;
  String? _time;
  String? _type;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _timeText;
  String? _planType;
  bool? _isPurchased;
Plans copyWith({  String? id,
  String? title,
  String? description,
  num? price,
  String? device,
  String? time,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  String? timeText,
  String? planType,
  bool? isPurchased,
}) => Plans(  id: id ?? _id,
  title: title ?? _title,
  description: description ?? _description,
  price: price ?? _price,
  device: device ?? _device,
  time: time ?? _time,
  type: type ?? _type,
  image: image ?? _image,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timeText: timeText ?? _timeText,
  planType: planType ?? _planType,
  isPurchased: isPurchased ?? _isPurchased,
);
  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  num? get price => _price;
  String? get device => _device;
  String? get time => _time;
  String? get type => _type;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeText => _timeText;
  String? get planType => _planType;
  bool? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['price'] = _price;
    map['device'] = _device;
    map['time'] = _time;
    map['type'] = _type;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_text'] = _timeText;
    map['plan_type'] = _planType;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}