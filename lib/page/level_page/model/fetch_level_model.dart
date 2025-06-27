class FetchLevelModel {
  FetchLevelModel({
    bool? status,
    String? message,
    List<LevelData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchLevelModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LevelData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<LevelData>? _data;
  FetchLevelModel copyWith({
    bool? status,
    String? message,
    List<LevelData>? data,
  }) =>
      FetchLevelModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<LevelData>? get data => _data;

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

class LevelData {
  LevelData({
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

  LevelData.fromJson(dynamic json) {
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
  LevelData copyWith({
    String? id,
    int? level,
    String? levelName,
    String? levelImage,
    int? coinThreshold,
    Permissions? permissions,
  }) =>
      LevelData(
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
