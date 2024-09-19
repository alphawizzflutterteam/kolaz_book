/// error : false
/// message : "Banners Found"
/// data : ["https://developmentalphawizz.com/kolaz_book/uploads/649efcfdc030a.jpg","https://developmentalphawizz.com/kolaz_book/uploads/649efce4c69cf.jpg"]

class BannerListModel {
  BannerListModel({
      bool? error, 
      String? message, 
      List<String>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  BannerListModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  bool? _error;
  String? _message;
  List<String>? _data;
BannerListModel copyWith({  bool? error,
  String? message,
  List<String>? data,
}) => BannerListModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<String>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}