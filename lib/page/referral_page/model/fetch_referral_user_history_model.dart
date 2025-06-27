class FetchReferralUserHistoryModel {
  FetchReferralUserHistoryModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchReferralUserHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  FetchReferralUserHistoryModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FetchReferralUserHistoryModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    List<Referees>? referees,
  }) {
    _id = id;
    _referees = referees;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['referees'] != null) {
      _referees = [];
      json['referees'].forEach((v) {
        _referees?.add(Referees.fromJson(v));
      });
    }
  }
  String? _id;
  List<Referees>? _referees;
  Data copyWith({
    String? id,
    List<Referees>? referees,
  }) =>
      Data(
        id: id ?? _id,
        referees: referees ?? _referees,
      );
  String? get id => _id;
  List<Referees>? get referees => _referees;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_referees != null) {
      map['referees'] = _referees?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Referees {
  Referees({
    UserId? userId,
    String? date,
    String? id,
  }) {
    _userId = userId;
    _date = date;
    _id = id;
  }

  Referees.fromJson(dynamic json) {
    _userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    _date = json['date'];
    _id = json['_id'];
  }
  UserId? _userId;
  String? _date;
  String? _id;
  Referees copyWith({
    UserId? userId,
    String? date,
    String? id,
  }) =>
      Referees(
        userId: userId ?? _userId,
        date: date ?? _date,
        id: id ?? _id,
      );
  UserId? get userId => _userId;
  String? get date => _date;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_userId != null) {
      map['userId'] = _userId?.toJson();
    }
    map['date'] = _date;
    map['_id'] = _id;
    return map;
  }
}

class UserId {
  UserId({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? uniqueId,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _uniqueId = uniqueId;
  }

  UserId.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _uniqueId = json['uniqueId'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  String? _uniqueId;
  UserId copyWith({
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    String? uniqueId,
  }) =>
      UserId(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        uniqueId: uniqueId ?? _uniqueId,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get uniqueId => _uniqueId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['uniqueId'] = _uniqueId;
    return map;
  }
}
