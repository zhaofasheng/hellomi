class FetchSearchMessageUserModel {
  FetchSearchMessageUserModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchSearchMessageUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  FetchSearchMessageUserModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      FetchSearchMessageUserModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

class Data {
  Data({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? activeAvtarFrame,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    String? chatTopicId,
    String? avtarFrame,
    int? avtarFrameType,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _activeAvtarFrame = activeAvtarFrame;
    _isFake = isFake;
    _isVerified = isVerified;
    _isOnline = isOnline;
    _chatTopicId = chatTopicId;
    _avtarFrame = avtarFrame;
    _avtarFrameType = avtarFrameType;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _activeAvtarFrame = json['activeAvtarFrame'];
    _isFake = json['isFake'];
    _isVerified = json['isVerified'];
    _isOnline = json['isOnline'];
    _chatTopicId = json['chatTopicId'];
    _avtarFrame = json['avtarFrame'];
    _avtarFrameType = json['avtarFrameType'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _activeAvtarFrame;
  bool? _isFake;
  bool? _isVerified;
  bool? _isOnline;
  String? _chatTopicId;
  String? _avtarFrame;
  int? _avtarFrameType;
  Data copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? activeAvtarFrame,
    bool? isFake,
    bool? isVerified,
    bool? isOnline,
    String? chatTopicId,
    String? avtarFrame,
    int? avtarFrameType,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        activeAvtarFrame: activeAvtarFrame ?? _activeAvtarFrame,
        isFake: isFake ?? _isFake,
        isVerified: isVerified ?? _isVerified,
        isOnline: isOnline ?? _isOnline,
        chatTopicId: chatTopicId ?? _chatTopicId,
        avtarFrame: avtarFrame ?? _avtarFrame,
        avtarFrameType: avtarFrameType ?? _avtarFrameType,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get activeAvtarFrame => _activeAvtarFrame;
  bool? get isFake => _isFake;
  bool? get isVerified => _isVerified;
  bool? get isOnline => _isOnline;
  String? get chatTopicId => _chatTopicId;
  String? get avtarFrame => _avtarFrame;
  int? get avtarFrameType => _avtarFrameType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['activeAvtarFrame'] = _activeAvtarFrame;
    map['isFake'] = _isFake;
    map['isVerified'] = _isVerified;
    map['isOnline'] = _isOnline;
    map['chatTopicId'] = _chatTopicId;
    map['avtarFrame'] = _avtarFrame;
    map['avtarFrameType'] = _avtarFrameType;
    return map;
  }
}
