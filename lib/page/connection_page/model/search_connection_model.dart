class SearchConnectionModel {
  SearchConnectionModel({
    bool? status,
    String? message,
    List<SearchData>? searchData,
  }) {
    _status = status;
    _message = message;
    _searchData = searchData;
  }

  SearchConnectionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['searchData'] != null) {
      _searchData = [];
      json['searchData'].forEach((v) {
        _searchData?.add(SearchData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<SearchData>? _searchData;
  SearchConnectionModel copyWith({
    bool? status,
    String? message,
    List<SearchData>? searchData,
  }) =>
      SearchConnectionModel(
        status: status ?? _status,
        message: message ?? _message,
        searchData: searchData ?? _searchData,
      );
  bool? get status => _status;
  String? get message => _message;
  List<SearchData>? get searchData => _searchData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_searchData != null) {
      map['searchData'] = _searchData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SearchData {
  SearchData({
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
    String? date,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    bool? isFollow,
  }) {
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
    _date = date;
    _wealthLevelImage = wealthLevelImage;
    _avtarFrame = avtarFrame;
    _avtarFrameType = avtarFrameType;
    _isFollow = isFollow;
  }

  SearchData.fromJson(dynamic json) {
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
    _date = json['date'];
    _wealthLevelImage = json['wealthLevelImage'];
    _avtarFrame = json['avtarFrame'];
    _avtarFrameType = json['avtarFrameType'];
    _isFollow = json['isFollow'];
  }
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
  String? _date;
  String? _wealthLevelImage;
  String? _avtarFrame;
  int? _avtarFrameType;
  bool? _isFollow;

  SearchData copyWith({
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
    String? date,
    String? wealthLevelImage,
    String? avtarFrame,
    int? avtarFrameType,
    bool? isFollow,
  }) =>
      SearchData(
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
        date: date ?? _date,
        wealthLevelImage: wealthLevelImage ?? _wealthLevelImage,
        avtarFrame: avtarFrame ?? _avtarFrame,
        avtarFrameType: avtarFrameType ?? _avtarFrameType,
        isFollow: isFollow ?? _isFollow,
      );
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
  String? get date => _date;
  String? get wealthLevelImage => _wealthLevelImage;
  String? get avtarFrame => _avtarFrame;
  int? get avtarFrameType => _avtarFrameType;
  bool? get isFollow => _isFollow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['date'] = _date;
    map['wealthLevelImage'] = _wealthLevelImage;
    map['avtarFrame'] = _avtarFrame;
    map['avtarFrameType'] = _avtarFrameType;
    map['isFollow'] = _isFollow;
    return map;
  }
}
