class FetchBannerModel {
  FetchBannerModel({
    bool? status,
    String? message,
    List<BannerData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<BannerData>? _data;
  FetchBannerModel copyWith({
    bool? status,
    String? message,
    List<BannerData>? data,
  }) =>
      FetchBannerModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<BannerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BannerData {
  BannerData({
    String? id,
    String? imageUrl,
    String? redirectUrl,
    int? bannerType,
  }) {
    _id = id;
    _imageUrl = imageUrl;
    _redirectUrl = redirectUrl;
    _bannerType = bannerType;
  }

  BannerData.fromJson(dynamic json) {
    _id = json['_id'];
    _imageUrl = json['imageUrl'];
    _redirectUrl = json['redirectUrl'];
    _bannerType = json['bannerType'];
  }
  String? _id;
  String? _imageUrl;
  String? _redirectUrl;
  int? _bannerType;
  BannerData copyWith({
    String? id,
    String? imageUrl,
    String? redirectUrl,
    int? bannerType,
  }) =>
      BannerData(
        id: id ?? _id,
        imageUrl: imageUrl ?? _imageUrl,
        redirectUrl: redirectUrl ?? _redirectUrl,
        bannerType: bannerType ?? _bannerType,
      );
  String? get id => _id;
  String? get imageUrl => _imageUrl;
  String? get redirectUrl => _redirectUrl;
  int? get bannerType => _bannerType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['redirectUrl'] = _redirectUrl;
    map['bannerType'] = _bannerType;
    return map;
  }
}
