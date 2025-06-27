class FetchLiveSummaryModel {
  FetchLiveSummaryModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchLiveSummaryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  FetchLiveSummaryModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FetchLiveSummaryModel(
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
    User? user,
    int? joinedUsers,
    int? receivedGifts,
    int? publicComments,
    int? increasedFans,
    int? coinsCollected,
    String? duration,
  }) {
    _user = user;
    _joinedUsers = joinedUsers;
    _receivedGifts = receivedGifts;
    _publicComments = publicComments;
    _increasedFans = increasedFans;
    _coinsCollected = coinsCollected;
    _duration = duration;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _joinedUsers = json['joinedUsers'];
    _receivedGifts = json['receivedGifts'];
    _publicComments = json['publicComments'];
    _increasedFans = json['increasedFans'];
    _coinsCollected = json['coinsCollected'];
    _duration = json['duration'];
  }
  User? _user;
  int? _joinedUsers;
  int? _receivedGifts;
  int? _publicComments;
  int? _increasedFans;
  int? _coinsCollected;
  String? _duration;
  Data copyWith({
    User? user,
    int? joinedUsers,
    int? receivedGifts,
    int? publicComments,
    int? increasedFans,
    int? coinsCollected,
    String? duration,
  }) =>
      Data(
        user: user ?? _user,
        joinedUsers: joinedUsers ?? _joinedUsers,
        receivedGifts: receivedGifts ?? _receivedGifts,
        publicComments: publicComments ?? _publicComments,
        increasedFans: increasedFans ?? _increasedFans,
        coinsCollected: coinsCollected ?? _coinsCollected,
        duration: duration ?? _duration,
      );
  User? get user => _user;
  int? get joinedUsers => _joinedUsers;
  int? get receivedGifts => _receivedGifts;
  int? get publicComments => _publicComments;
  int? get increasedFans => _increasedFans;
  int? get coinsCollected => _coinsCollected;
  String? get duration => _duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['joinedUsers'] = _joinedUsers;
    map['receivedGifts'] = _receivedGifts;
    map['publicComments'] = _publicComments;
    map['increasedFans'] = _increasedFans;
    map['coinsCollected'] = _coinsCollected;
    map['duration'] = _duration;
    return map;
  }
}

class User {
  User({
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isVerified,
    String? uniqueId,
    String? gender,
    int? age,
    String? countryFlagImage,
    String? country,
    int? coin,
    WealthLevel? wealthLevel,
    AvtarFrame? avtarFrame,
  }) {
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _isVerified = isVerified;
    _uniqueId = uniqueId;
    _gender = gender;
    _age = age;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _coin = coin;
    _wealthLevel = wealthLevel;
    _avtarFrame = avtarFrame;
  }

  User.fromJson(dynamic json) {
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isVerified = json['isVerified'];
    _uniqueId = json['uniqueId'];
    _gender = json['gender'];
    _age = json['age'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _coin = json['coin'];
    _wealthLevel = json['wealthLevel'] != null ? WealthLevel.fromJson(json['wealthLevel']) : null;
    _avtarFrame = json['avtarFrame'] != null ? AvtarFrame.fromJson(json['avtarFrame']) : null;
  }
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  bool? _isVerified;
  String? _uniqueId;
  String? _gender;
  int? _age;
  String? _countryFlagImage;
  String? _country;
  int? _coin;
  WealthLevel? _wealthLevel;
  AvtarFrame? _avtarFrame;
  User copyWith({
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isVerified,
    String? uniqueId,
    String? gender,
    int? age,
    String? countryFlagImage,
    String? country,
    int? coin,
    WealthLevel? wealthLevel,
    AvtarFrame? avtarFrame,
  }) =>
      User(
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isVerified: isVerified ?? _isVerified,
        uniqueId: uniqueId ?? _uniqueId,
        gender: gender ?? _gender,
        age: age ?? _age,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        coin: coin ?? _coin,
        wealthLevel: wealthLevel ?? _wealthLevel,
        avtarFrame: avtarFrame ?? _avtarFrame,
      );
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isVerified => _isVerified;
  String? get uniqueId => _uniqueId;
  String? get gender => _gender;
  int? get age => _age;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  int? get coin => _coin;
  WealthLevel? get wealthLevel => _wealthLevel;
  AvtarFrame? get avtarFrame => _avtarFrame;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isVerified'] = _isVerified;
    map['uniqueId'] = _uniqueId;
    map['gender'] = _gender;
    map['age'] = _age;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['coin'] = _coin;
    if (_wealthLevel != null) {
      map['wealthLevel'] = _wealthLevel?.toJson();
    }
    if (_avtarFrame != null) {
      map['avtarFrame'] = _avtarFrame?.toJson();
    }
    return map;
  }
}

class AvtarFrame {
  AvtarFrame({
    String? id,
    int? type,
    String? image,
    String? svgaImage,
  }) {
    _id = id;
    _type = type;
    _image = image;
    _svgaImage = svgaImage;
  }

  AvtarFrame.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _image = json['image'];
    _svgaImage = json['svgaImage'];
  }
  String? _id;
  int? _type;
  String? _image;
  String? _svgaImage;
  AvtarFrame copyWith({
    String? id,
    int? type,
    String? image,
    String? svgaImage,
  }) =>
      AvtarFrame(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
        svgaImage: svgaImage ?? _svgaImage,
      );
  String? get id => _id;
  int? get type => _type;
  String? get image => _image;
  String? get svgaImage => _svgaImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    map['svgaImage'] = _svgaImage;
    return map;
  }
}

class WealthLevel {
  WealthLevel({
    String? id,
    String? levelImage,
  }) {
    _id = id;
    _levelImage = levelImage;
  }

  WealthLevel.fromJson(dynamic json) {
    _id = json['_id'];
    _levelImage = json['levelImage'];
  }
  String? _id;
  String? _levelImage;
  WealthLevel copyWith({
    String? id,
    String? levelImage,
  }) =>
      WealthLevel(
        id: id ?? _id,
        levelImage: levelImage ?? _levelImage,
      );
  String? get id => _id;
  String? get levelImage => _levelImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['levelImage'] = _levelImage;
    return map;
  }
}
