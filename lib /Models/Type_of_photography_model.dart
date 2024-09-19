// To parse this JSON data, do
//
//     final typeofPhotography = typeofPhotographyFromJson(jsonString);

import 'dart:convert';

TypeofPhotography typeofPhotographyFromJson(String str) => TypeofPhotography.fromJson(json.decode(str));

String typeofPhotographyToJson(TypeofPhotography data) => json.encode(data.toJson());

class TypeofPhotography {
  int? status;
  String? msg;
  List<Categories>? categories;

  TypeofPhotography({this.status, this.msg, this.categories});

  TypeofPhotography.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? resId;
  String? catId;
  Null? scatId;
  String? resName;
  Null? resNameU;
  Null? resDesc;
  Null? resDescU;
  Null? resWebsite;
  Null? resImage;
  Null? logo;
  Null? resPhone;
  Null? resAddress;
  Null? resIsOpen;
  Null? resStatus;
  Null? resCreateDate;
  Null? resRatings;
  Null? status;
  Null? resVideo;
  Null? resUrl;
  Null? mfo;
  Null? lat;
  Null? lon;
  String? vid;
  Null? countryId;
  Null? stateId;
  Null? cityId;
  Null? structure;
  Null? hours;
  String? hourType;
  Null? experts;
  Null? serviceOffered;
  Null? price;
  String? baseCurrency;
  Null? type;
  Categories? selectedValue;

  Categories(
      {this.resId,
        this.catId,
        this.scatId,
        this.resName,
        this.resNameU,
        this.resDesc,
        this.resDescU,
        this.resWebsite,
        this.resImage,
        this.logo,
        this.resPhone,
        this.resAddress,
        this.resIsOpen,
        this.resStatus,
        this.resCreateDate,
        this.resRatings,
        this.status,
        this.resVideo,
        this.resUrl,
        this.mfo,
        this.lat,
        this.lon,
        this.vid,
        this.countryId,
        this.stateId,
        this.cityId,
        this.structure,
        this.hours,
        this.hourType,
        this.experts,
        this.serviceOffered,
        this.price,
        this.baseCurrency,
        this.type, this.selectedValue});

  Categories.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    catId = json['cat_id'];
    scatId = json['scat_id'];
    resName = json['res_name'];
    resNameU = json['res_name_u'];
    resDesc = json['res_desc'];
    resDescU = json['res_desc_u'];
    resWebsite = json['res_website'];
    resImage = json['res_image'];
    logo = json['logo'];
    resPhone = json['res_phone'];
    resAddress = json['res_address'];
    resIsOpen = json['res_isOpen'];
    resStatus = json['res_status'];
    resCreateDate = json['res_create_date'];
    resRatings = json['res_ratings'];
    status = json['status'];
    resVideo = json['res_video'];
    resUrl = json['res_url'];
    mfo = json['mfo'];
    lat = json['lat'];
    lon = json['lon'];
    vid = json['vid'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    structure = json['structure'];
    hours = json['hours'];
    hourType = json['hour_type'];
    experts = json['experts'];
    serviceOffered = json['service_offered'];
    price = json['price'];
    baseCurrency = json['base_currency'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['cat_id'] = this.catId;
    data['scat_id'] = this.scatId;
    data['res_name'] = this.resName;
    data['res_name_u'] = this.resNameU;
    data['res_desc'] = this.resDesc;
    data['res_desc_u'] = this.resDescU;
    data['res_website'] = this.resWebsite;
    data['res_image'] = this.resImage;
    data['logo'] = this.logo;
    data['res_phone'] = this.resPhone;
    data['res_address'] = this.resAddress;
    data['res_isOpen'] = this.resIsOpen;
    data['res_status'] = this.resStatus;
    data['res_create_date'] = this.resCreateDate;
    data['res_ratings'] = this.resRatings;
    data['status'] = this.status;
    data['res_video'] = this.resVideo;
    data['res_url'] = this.resUrl;
    data['mfo'] = this.mfo;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['vid'] = this.vid;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['structure'] = this.structure;
    data['hours'] = this.hours;
    data['hour_type'] = this.hourType;
    data['experts'] = this.experts;
    data['service_offered'] = this.serviceOffered;
    data['price'] = this.price;
    data['base_currency'] = this.baseCurrency;
    data['type'] = this.type;
    return data;
  }
}