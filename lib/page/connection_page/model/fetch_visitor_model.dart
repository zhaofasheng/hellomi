class FetchVisitorModel {
  FetchVisitorModel({
    bool? status,
    String? message,
    List<VisitedData>? profileVisitors,
    List<VisitedData>? visitedProfiles,
  }) {
    _status = status;
    _message = message;
    _profileVisitors = profileVisitors;
    _visitedProfiles = visitedProfiles;
  }

  FetchVisitorModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['profileVisitors'] != null) {
      _profileVisitors = [];
      json['profileVisitors'].forEach((v) {
        _profileVisitors?.add(VisitedData.fromJson(v));
      });
    }
    if (json['visitedProfiles'] != null) {
      _visitedProfiles = [];
      json['visitedProfiles'].forEach((v) {
        _visitedProfiles?.add(VisitedData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<VisitedData>? _profileVisitors;
  List<VisitedData>? _visitedProfiles;
  FetchVisitorModel copyWith({
    bool? status,
    String? message,
    List<VisitedData>? profileVisitors,
    List<VisitedData>? visitedProfiles,
  }) =>
      FetchVisitorModel(
        status: status ?? _status,
        message: message ?? _message,
        profileVisitors: profileVisitors ?? _profileVisitors,
        visitedProfiles: visitedProfiles ?? _visitedProfiles,
      );
  bool? get status => _status;
  String? get message => _message;
  List<VisitedData>? get profileVisitors => _profileVisitors;
  List<VisitedData>? get visitedProfiles => _visitedProfiles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_profileVisitors != null) {
      map['profileVisitors'] = _profileVisitors?.map((v) => v.toJson()).toList();
    }
    if (_visitedProfiles != null) {
      map['visitedProfiles'] = _visitedProfiles?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class VisitedData {
  VisitedData({
    bool? isFollow,
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    int? age,
    bool? isVerified,
    String? country,
    String? countryFlagImage,
    int? coin,
    String? uniqueId,
    bool? isOnline,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    String? date,
  }) {
    _isFollow = isFollow;
    _id = id;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _age = age;
    _isVerified = isVerified;
    _country = country;
    _countryFlagImage = countryFlagImage;
    _coin = coin;
    _uniqueId = uniqueId;
    _isOnline = isOnline;
    _wealthLevelImage = wealthLevelImage;
    _avtarFrame = avtarFrame;
    _avtarFrameType = avtarFrameType;
    _date = date;
  }

  VisitedData.fromJson(dynamic json) {
    _isFollow = json['isFollow'];
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _age = json['age'];
    _isVerified = json['isVerified'];
    _country = json['country'];
    _countryFlagImage = json['countryFlagImage'];
    _coin = json['coin'];
    _uniqueId = json['uniqueId'];
    _isOnline = json['isOnline'];
    _wealthLevelImage = json['wealthLevelImage'];
    _avtarFrame = json['avtarFrame'];
    _avtarFrameType = json['avtarFrameType'];
    _date = json['date'];
  }
  bool? _isFollow;
  String? _id;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  int? _age;
  bool? _isVerified;
  String? _country;
  String? _countryFlagImage;
  int? _coin;
  String? _uniqueId;
  bool? _isOnline;
  String? _wealthLevelImage;
  String? _avtarFrame;
  int? _avtarFrameType;
  String? _date;
  VisitedData copyWith({
    bool? isFollow,
    String? id,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    int? age,
    bool? isVerified,
    String? country,
    String? countryFlagImage,
    int? coin,
    String? uniqueId,
    bool? isOnline,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    String? date,
  }) =>
      VisitedData(
        isFollow: isFollow ?? _isFollow,
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        age: age ?? _age,
        isVerified: isVerified ?? _isVerified,
        country: country ?? _country,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        coin: coin ?? _coin,
        uniqueId: uniqueId ?? _uniqueId,
        isOnline: isOnline ?? _isOnline,
        wealthLevelImage: wealthLevelImage ?? _wealthLevelImage,
        avtarFrame: avtarFrame ?? _avtarFrame,
        avtarFrameType: avtarFrameType ?? _avtarFrameType,
        date: date ?? _date,
      );
  bool? get isFollow => _isFollow;
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  int? get age => _age;
  bool? get isVerified => _isVerified;
  String? get country => _country;
  String? get countryFlagImage => _countryFlagImage;
  int? get coin => _coin;
  String? get uniqueId => _uniqueId;
  bool? get isOnline => _isOnline;
  String? get wealthLevelImage => _wealthLevelImage;
  String? get avtarFrame => _avtarFrame;
  int? get avtarFrameType => _avtarFrameType;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isFollow'] = _isFollow;
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['age'] = _age;
    map['isVerified'] = _isVerified;
    map['country'] = _country;
    map['countryFlagImage'] = _countryFlagImage;
    map['coin'] = _coin;
    map['uniqueId'] = _uniqueId;
    map['isOnline'] = _isOnline;
    map['wealthLevelImage'] = _wealthLevelImage;
    map['avtarFrame'] = _avtarFrame;
    map['avtarFrameType'] = _avtarFrameType;
    map['date'] = _date;
    return map;
  }
}
