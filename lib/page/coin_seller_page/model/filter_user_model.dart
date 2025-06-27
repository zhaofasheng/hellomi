class FilterUserModel {
  FilterUserModel({
    bool? status,
    String? message,
    List<UserData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FilterUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<UserData>? _data;
  FilterUserModel copyWith({
    bool? status,
    String? message,
    List<UserData>? data,
  }) =>
      FilterUserModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<UserData>? get data => _data;

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

class UserData {
  UserData({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? uniqueId,
    String? avtarFrame,
    int? avtarFrameType,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _uniqueId = uniqueId;
    _avtarFrame = avtarFrame;
    _avtarFrameType = avtarFrameType;
  }

  UserData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _uniqueId = json['uniqueId'];
    _avtarFrame = json['avtarFrame'];
    _avtarFrameType = json['avtarFrameType'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _uniqueId;
  String? _avtarFrame;
  int? _avtarFrameType;
  UserData copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? uniqueId,
    String? avtarFrame,
    int? avtarFrameType,
  }) =>
      UserData(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        uniqueId: uniqueId ?? _uniqueId,
        avtarFrame: avtarFrame ?? _avtarFrame,
        avtarFrameType: avtarFrameType ?? _avtarFrameType,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get uniqueId => _uniqueId;
  String? get avtarFrame => _avtarFrame;
  int? get avtarFrameType => _avtarFrameType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['uniqueId'] = _uniqueId;
    map['avtarFrame'] = _avtarFrame;
    map['avtarFrameType'] = _avtarFrameType;
    return map;
  }
}
