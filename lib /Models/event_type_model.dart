/// status : 1
/// msg : "Restaurnats Found"
/// categories : [{"id":"1","c_name":"Weeding","c_name_a":"","icon":"","sub_title":"Test","description":"Test","img":"6475eb725a28c.jpg","type":"vip","p_id":null,"addons":null,"lists":null}]
import 'dart:convert';

EventTypeModel eventTypeFromJson(String str) => EventTypeModel.fromJson(json.decode(str));

String eventTypeToJson(EventTypeModel data) => json.encode(data.toJson());


class EventTypeModel {
  EventTypeModel({
      num? status, 
      String? msg, 
      List<EventType>? categories,}){
    _status = status;
    _msg = msg;
    _categories = categories;
}

  EventTypeModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
    if (json['categories'] != null) {
      _categories = [];
      json['categories'].forEach((v) {
        _categories?.add(EventType.fromJson(v));
      });
    }
  }
  num? _status;
  String? _msg;
  List<EventType>? _categories;
EventTypeModel copyWith({  num? status,
  String? msg,
  List<EventType>? categories,
}) => EventTypeModel(  status: status ?? _status,
  msg: msg ?? _msg,
  categories: categories ?? _categories,
);
  num? get status => _status;
  String? get msg => _msg;
  List<EventType>? get categories => _categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    if (_categories != null) {
      map['categories'] = _categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// c_name : "Weeding"
/// c_name_a : ""
/// icon : ""
/// sub_title : "Test"
/// description : "Test"
/// img : "6475eb725a28c.jpg"
/// type : "vip"
/// p_id : null
/// addons : null
/// lists : null

class EventType {
  EventType({
      String? id, 
      String? cName, 
      String? cNameA, 
      String? icon, 
      String? subTitle, 
      String? description, 
      String? img, 
      String? type, 
      dynamic pId, 
      dynamic addons, 
      dynamic lists,}){
    _id = id;
    _cName = cName;
    _cNameA = cNameA;
    _icon = icon;
    _subTitle = subTitle;
    _description = description;
    _img = img;
    _type = type;
    _pId = pId;
    _addons = addons;
    _lists = lists;
}

  EventType.fromJson(dynamic json) {
    _id = json['id'];
    _cName = json['c_name'];
    _cNameA = json['c_name_a'];
    _icon = json['icon'];
    _subTitle = json['sub_title'];
    _description = json['description'];
    _img = json['img'];
    _type = json['type'];
    _pId = json['p_id'];
    _addons = json['addons'];
    _lists = json['lists'];
  }
  String? _id;
  String? _cName;
  String? _cNameA;
  String? _icon;
  String? _subTitle;
  String? _description;
  String? _img;
  String? _type;
  dynamic _pId;
  dynamic _addons;
  dynamic _lists;
EventType copyWith({  String? id,
  String? cName,
  String? cNameA,
  String? icon,
  String? subTitle,
  String? description,
  String? img,
  String? type,
  dynamic pId,
  dynamic addons,
  dynamic lists,
}) => EventType(  id: id ?? _id,
  cName: cName ?? _cName,
  cNameA: cNameA ?? _cNameA,
  icon: icon ?? _icon,
  subTitle: subTitle ?? _subTitle,
  description: description ?? _description,
  img: img ?? _img,
  type: type ?? _type,
  pId: pId ?? _pId,
  addons: addons ?? _addons,
  lists: lists ?? _lists,
);
  String? get id => _id;
  String? get cName => _cName;
  String? get cNameA => _cNameA;
  String? get icon => _icon;
  String? get subTitle => _subTitle;
  String? get description => _description;
  String? get img => _img;
  String? get type => _type;
  dynamic get pId => _pId;
  dynamic get addons => _addons;
  dynamic get lists => _lists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['c_name'] = _cName;
    map['c_name_a'] = _cNameA;
    map['icon'] = _icon;
    map['sub_title'] = _subTitle;
    map['description'] = _description;
    map['img'] = _img;
    map['type'] = _type;
    map['p_id'] = _pId;
    map['addons'] = _addons;
    map['lists'] = _lists;
    return map;
  }

}