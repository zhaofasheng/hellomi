class FetchUserProfileModel {
  FetchUserProfileModel({
    bool? status,
    String? message,
    User? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  FetchUserProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _status;
  String? _message;
  User? _user;
  FetchUserProfileModel copyWith({
    bool? status,
    String? message,
    User? user,
  }) =>
      FetchUserProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );
  bool? get status => _status;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    String? id,
    String? name,
    String? userName,
    String? gender,
    String? bio,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    int? coin,
    int? receivedCoins,
    int? receivedGifts,
    WealthLevel? wealthLevel,
    ActiveAvtarFrame? activeAvtarFrame,
    bool? isVerified,
    List<int>? role,
    String? agencyId,
    String? agencyOwnerId,
    int? totalFollowers,
    int? totalFollowing,
    int? totalFriends,
    int? totalVisitors,
  }) {
    _id = id;
    _name = name;
    _userName = userName;
    _gender = gender;
    _bio = bio;
    _age = age;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _countryFlagImage = countryFlagImage;
    _country = country;
    _uniqueId = uniqueId;
    _coin = coin;
    _receivedCoins = receivedCoins;
    _receivedGifts = receivedGifts;
    _wealthLevel = wealthLevel;
    _activeAvtarFrame = activeAvtarFrame;
    _isVerified = isVerified;
    _role = role;
    _agencyId = agencyId;
    _agencyOwnerId = agencyOwnerId;
    _totalFollowers = totalFollowers;
    _totalFollowing = totalFollowing;
    _totalFriends = totalFriends;
    _totalVisitors = totalVisitors;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _userName = json['userName'];
    _gender = json['gender'];
    _bio = json['bio'];
    _age = json['age'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _countryFlagImage = json['countryFlagImage'];
    _country = json['country'];
    _uniqueId = json['uniqueId'];
    _coin = json['coin'];
    _receivedCoins = json['receivedCoins'];
    _receivedGifts = json['receivedGifts'];
    _wealthLevel = json['wealthLevel'] != null ? WealthLevel.fromJson(json['wealthLevel']) : null;
    _activeAvtarFrame = json['activeAvtarFrame'] != null ? ActiveAvtarFrame.fromJson(json['activeAvtarFrame']) : null;
    _isVerified = json['isVerified'];
    _role = json['role'] != null ? json['role'].cast<int>() : [];
    _agencyId = json['agencyId'];
    _agencyOwnerId = json['agencyOwnerId'];
    _totalFollowers = json['totalFollowers'];
    _totalFollowing = json['totalFollowing'];
    _totalFriends = json['totalFriends'];
    _totalVisitors = json['totalVisitors'];
  }
  String? _id;
  String? _name;
  String? _userName;
  String? _gender;
  String? _bio;
  int? _age;
  String? _image;
  bool? _isProfilePicBanned;
  String? _countryFlagImage;
  String? _country;
  String? _uniqueId;
  int? _coin;
  int? _receivedCoins;
  int? _receivedGifts;
  WealthLevel? _wealthLevel;
  ActiveAvtarFrame? _activeAvtarFrame;
  bool? _isVerified;
  List<int>? _role;
  String? _agencyId;
  String? _agencyOwnerId;
  int? _totalFollowers;
  int? _totalFollowing;
  int? _totalFriends;
  int? _totalVisitors;
  User copyWith({
    String? id,
    String? name,
    String? userName,
    String? gender,
    String? bio,
    int? age,
    String? image,
    bool? isProfilePicBanned,
    String? countryFlagImage,
    String? country,
    String? uniqueId,
    int? coin,
    int? receivedCoins,
    int? receivedGifts,
    WealthLevel? wealthLevel,
    ActiveAvtarFrame? activeAvtarFrame,
    bool? isVerified,
    List<int>? role,
    String? agencyId,
    String? agencyOwnerId,
    int? totalFollowers,
    int? totalFollowing,
    int? totalFriends,
    int? totalVisitors,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        userName: userName ?? _userName,
        gender: gender ?? _gender,
        bio: bio ?? _bio,
        age: age ?? _age,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        countryFlagImage: countryFlagImage ?? _countryFlagImage,
        country: country ?? _country,
        uniqueId: uniqueId ?? _uniqueId,
        coin: coin ?? _coin,
        receivedCoins: receivedCoins ?? _receivedCoins,
        receivedGifts: receivedGifts ?? _receivedGifts,
        wealthLevel: wealthLevel ?? _wealthLevel,
        activeAvtarFrame: activeAvtarFrame ?? _activeAvtarFrame,
        isVerified: isVerified ?? _isVerified,
        role: role ?? _role,
        agencyId: agencyId ?? _agencyId,
        agencyOwnerId: agencyOwnerId ?? _agencyOwnerId,
        totalFollowers: totalFollowers ?? _totalFollowers,
        totalFollowing: totalFollowing ?? _totalFollowing,
        totalFriends: totalFriends ?? _totalFriends,
        totalVisitors: totalVisitors ?? _totalVisitors,
      );
  String? get id => _id;
  String? get name => _name;
  String? get userName => _userName;
  String? get gender => _gender;
  String? get bio => _bio;
  int? get age => _age;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  String? get countryFlagImage => _countryFlagImage;
  String? get country => _country;
  String? get uniqueId => _uniqueId;
  int? get coin => _coin;
  int? get receivedCoins => _receivedCoins;
  int? get receivedGifts => _receivedGifts;
  WealthLevel? get wealthLevel => _wealthLevel;
  ActiveAvtarFrame? get activeAvtarFrame => _activeAvtarFrame;
  bool? get isVerified => _isVerified;
  List<int>? get role => _role;
  String? get agencyId => _agencyId;
  String? get agencyOwnerId => _agencyOwnerId;
  int? get totalFollowers => _totalFollowers;
  int? get totalFollowing => _totalFollowing;
  int? get totalFriends => _totalFriends;
  int? get totalVisitors => _totalVisitors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['userName'] = _userName;
    map['gender'] = _gender;
    map['bio'] = _bio;
    map['age'] = _age;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['countryFlagImage'] = _countryFlagImage;
    map['country'] = _country;
    map['uniqueId'] = _uniqueId;
    map['coin'] = _coin;
    map['receivedCoins'] = _receivedCoins;
    map['receivedGifts'] = _receivedGifts;
    if (_wealthLevel != null) {
      map['wealthLevel'] = _wealthLevel?.toJson();
    }
    if (_activeAvtarFrame != null) {
      map['activeAvtarFrame'] = _activeAvtarFrame?.toJson();
    }
    map['isVerified'] = _isVerified;
    map['role'] = _role;
    map['agencyId'] = _agencyId;
    map['agencyOwnerId'] = _agencyOwnerId;
    map['totalFollowers'] = _totalFollowers;
    map['totalFollowing'] = _totalFollowing;
    map['totalFriends'] = _totalFriends;
    map['totalVisitors'] = _totalVisitors;
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

class WealthLevel {
  WealthLevel({
    String? id,
    int? level,
    String? levelName,
    String? levelImage,
    int? coinThreshold,
    Permissions? permissions,
  }) {
    _id = id;
    _level = level;
    _levelName = levelName;
    _levelImage = levelImage;
    _coinThreshold = coinThreshold;
    _permissions = permissions;
  }

  WealthLevel.fromJson(dynamic json) {
    _id = json['_id'];
    _level = json['level'];
    _levelName = json['levelName'];
    _levelImage = json['levelImage'];
    _coinThreshold = json['coinThreshold'];
    _permissions = json['permissions'] != null ? Permissions.fromJson(json['permissions']) : null;
  }
  String? _id;
  int? _level;
  String? _levelName;
  String? _levelImage;
  int? _coinThreshold;
  Permissions? _permissions;
  WealthLevel copyWith({
    String? id,
    int? level,
    String? levelName,
    String? levelImage,
    int? coinThreshold,
    Permissions? permissions,
  }) =>
      WealthLevel(
        id: id ?? _id,
        level: level ?? _level,
        levelName: levelName ?? _levelName,
        levelImage: levelImage ?? _levelImage,
        coinThreshold: coinThreshold ?? _coinThreshold,
        permissions: permissions ?? _permissions,
      );
  String? get id => _id;
  int? get level => _level;
  String? get levelName => _levelName;
  String? get levelImage => _levelImage;
  int? get coinThreshold => _coinThreshold;
  Permissions? get permissions => _permissions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['level'] = _level;
    map['levelName'] = _levelName;
    map['levelImage'] = _levelImage;
    map['coinThreshold'] = _coinThreshold;
    if (_permissions != null) {
      map['permissions'] = _permissions?.toJson();
    }
    return map;
  }
}

class Permissions {
  Permissions({
    bool? liveStreaming,
    bool? freeCall,
    bool? redeemCashout,
    bool? uploadSocialPost,
    bool? uploadVideo,
  }) {
    _liveStreaming = liveStreaming;
    _freeCall = freeCall;
    _redeemCashout = redeemCashout;
    _uploadSocialPost = uploadSocialPost;
    _uploadVideo = uploadVideo;
  }

  Permissions.fromJson(dynamic json) {
    _liveStreaming = json['liveStreaming'];
    _freeCall = json['freeCall'];
    _redeemCashout = json['redeemCashout'];
    _uploadSocialPost = json['uploadSocialPost'];
    _uploadVideo = json['uploadVideo'];
  }
  bool? _liveStreaming;
  bool? _freeCall;
  bool? _redeemCashout;
  bool? _uploadSocialPost;
  bool? _uploadVideo;
  Permissions copyWith({
    bool? liveStreaming,
    bool? freeCall,
    bool? redeemCashout,
    bool? uploadSocialPost,
    bool? uploadVideo,
  }) =>
      Permissions(
        liveStreaming: liveStreaming ?? _liveStreaming,
        freeCall: freeCall ?? _freeCall,
        redeemCashout: redeemCashout ?? _redeemCashout,
        uploadSocialPost: uploadSocialPost ?? _uploadSocialPost,
        uploadVideo: uploadVideo ?? _uploadVideo,
      );
  bool? get liveStreaming => _liveStreaming;
  bool? get freeCall => _freeCall;
  bool? get redeemCashout => _redeemCashout;
  bool? get uploadSocialPost => _uploadSocialPost;
  bool? get uploadVideo => _uploadVideo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['liveStreaming'] = _liveStreaming;
    map['freeCall'] = _freeCall;
    map['redeemCashout'] = _redeemCashout;
    map['uploadSocialPost'] = _uploadSocialPost;
    map['uploadVideo'] = _uploadVideo;
    return map;
  }
}
