class FetchBlockUserModel {
  FetchBlockUserModel({
    bool? status,
    String? message,
    int? total,
    List<BlockedUsers>? blockedUsers,
  }) {
    _status = status;
    _message = message;
    _total = total;
    _blockedUsers = blockedUsers;
  }

  FetchBlockUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _total = json['total'];
    if (json['blockedUsers'] != null) {
      _blockedUsers = [];
      json['blockedUsers'].forEach((v) {
        _blockedUsers?.add(BlockedUsers.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  int? _total;
  List<BlockedUsers>? _blockedUsers;
  FetchBlockUserModel copyWith({
    bool? status,
    String? message,
    int? total,
    List<BlockedUsers>? blockedUsers,
  }) =>
      FetchBlockUserModel(
        status: status ?? _status,
        message: message ?? _message,
        total: total ?? _total,
        blockedUsers: blockedUsers ?? _blockedUsers,
      );
  bool? get status => _status;
  String? get message => _message;
  int? get total => _total;
  List<BlockedUsers>? get blockedUsers => _blockedUsers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['total'] = _total;
    if (_blockedUsers != null) {
      map['blockedUsers'] = _blockedUsers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BlockedUsers {
  BlockedUsers({
    String? id,
    ToUserId? toUserId,
  }) {
    _id = id;
    _toUserId = toUserId;
  }

  BlockedUsers.fromJson(dynamic json) {
    _id = json['_id'];
    _toUserId = json['toUserId'] != null ? ToUserId.fromJson(json['toUserId']) : null;
  }
  String? _id;
  ToUserId? _toUserId;
  BlockedUsers copyWith({
    String? id,
    ToUserId? toUserId,
  }) =>
      BlockedUsers(
        id: id ?? _id,
        toUserId: toUserId ?? _toUserId,
      );
  String? get id => _id;
  ToUserId? get toUserId => _toUserId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_toUserId != null) {
      map['toUserId'] = _toUserId?.toJson();
    }
    return map;
  }
}

class ToUserId {
  ToUserId({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    ActiveAvtarFrame? activeAvtarFrame,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _activeAvtarFrame = activeAvtarFrame;
  }

  ToUserId.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _activeAvtarFrame = json['activeAvtarFrame'] != null ? ActiveAvtarFrame.fromJson(json['activeAvtarFrame']) : null;
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _countryFlagImage;
  String? _country;
  ActiveAvtarFrame? _activeAvtarFrame;
  ToUserId copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    ActiveAvtarFrame? activeAvtarFrame,
  }) =>
      ToUserId(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        activeAvtarFrame: activeAvtarFrame ?? _activeAvtarFrame,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  ActiveAvtarFrame? get activeAvtarFrame => _activeAvtarFrame;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    if (_activeAvtarFrame != null) {
      map['activeAvtarFrame'] = _activeAvtarFrame?.toJson();
    }
    return map;
  }
}

class ActiveAvtarFrame {
  ActiveAvtarFrame({
    String? id,
    int? type,
    String? image,
  }) {
    _id = id;
    _type = type;
    _image = image;
  }

  ActiveAvtarFrame.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _image = json['image'];
  }
  String? _id;
  int? _type;
  String? _image;
  ActiveAvtarFrame copyWith({
    String? id,
    int? type,
    String? image,
  }) =>
      ActiveAvtarFrame(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
      );
  String? get id => _id;
  int? get type => _type;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    return map;
  }
}
