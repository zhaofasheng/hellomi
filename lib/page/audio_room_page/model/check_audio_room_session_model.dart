import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';

class CheckAudioRoomSessionModel {
  CheckAudioRoomSessionModel({
    bool? status,
    String? message,
    LiveUser? liveUser,
  }) {
    _status = status;
    _message = message;
    _liveUser = liveUser;
  }

  CheckAudioRoomSessionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _liveUser = json['liveUser'] != null ? LiveUser.fromJson(json['liveUser']) : null;
  }
  bool? _status;
  String? _message;
  LiveUser? _liveUser;
  CheckAudioRoomSessionModel copyWith({
    bool? status,
    String? message,
    LiveUser? liveUser,
  }) =>
      CheckAudioRoomSessionModel(
        status: status ?? _status,
        message: message ?? _message,
        liveUser: liveUser ?? _liveUser,
      );
  bool? get status => _status;
  String? get message => _message;
  LiveUser? get liveUser => _liveUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveUser != null) {
      map['liveUser'] = _liveUser?.toJson();
    }
    return map;
  }
}

class LiveUser {
  LiveUser({
    String? id,
    String? userId,
    String? liveHistoryId,
    int? agoraUid,
    String? channel,
    String? token,
    int? earnedCoins,
    int? view,
    int? liveType,
    int? audioLiveType,
    int? privateCode,
    String? roomName,
    String? roomWelcome,
    String? roomImage,
    String? bgTheme,
    bool? isAudio,
    bool? isHostActiveInRoom,
    int? hostIsMuted,
    List<BlockedUsers>? blockedUsers,
    List<Seat>? seat,
  }) {
    _id = id;
    _userId = userId;
    _liveHistoryId = liveHistoryId;
    _agoraUid = agoraUid;
    _channel = channel;
    _token = token;
    _earnedCoins = earnedCoins;
    _view = view;
    _liveType = liveType;
    _audioLiveType = audioLiveType;
    _privateCode = privateCode;
    _roomName = roomName;
    _roomWelcome = roomWelcome;
    _roomImage = roomImage;
    _bgTheme = bgTheme;
    _isAudio = isAudio;
    _isHostActiveInRoom = isHostActiveInRoom;
    _hostIsMuted = hostIsMuted;
    _blockedUsers = blockedUsers;
    _seat = seat;
  }

  LiveUser.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _liveHistoryId = json['liveHistoryId'];
    _agoraUid = json['agoraUid'];
    _channel = json['channel'];
    _token = json['token'];
    _earnedCoins = json['earnedCoins'];
    _view = json['view'];
    _liveType = json['liveType'];
    _audioLiveType = json['audioLiveType'];
    _privateCode = json['privateCode'];
    _roomName = json['roomName'];
    _roomWelcome = json['roomWelcome'];
    _roomImage = json['roomImage'];
    _bgTheme = json['bgTheme'];
    _isAudio = json['isAudio'];
    _isHostActiveInRoom = json['isHostActiveInRoom'];
    _hostIsMuted = json['hostIsMuted'];
    if (json['blockedUsers'] != null) {
      _blockedUsers = [];
      json['blockedUsers'].forEach((v) {
        _blockedUsers?.add(BlockedUsers.fromJson(v));
      });
    }
    if (json['seat'] != null) {
      _seat = [];
      json['seat'].forEach((v) {
        _seat?.add(Seat.fromJson(v));
      });
    }
  }
  String? _id;
  String? _userId;
  String? _liveHistoryId;
  int? _agoraUid;
  String? _channel;
  String? _token;
  int? _earnedCoins;
  int? _view;
  int? _liveType;
  int? _audioLiveType;
  dynamic _privateCode;
  String? _roomName;
  String? _roomWelcome;
  String? _roomImage;
  String? _bgTheme;
  bool? _isAudio;
  bool? _isHostActiveInRoom;
  int? _hostIsMuted;
  List<BlockedUsers>? _blockedUsers;
  List<Seat>? _seat;
  LiveUser copyWith({
    String? id,
    String? userId,
    String? liveHistoryId,
    int? agoraUid,
    String? channel,
    String? token,
    int? earnedCoins,
    int? view,
    int? liveType,
    int? audioLiveType,
    int? privateCode,
    String? roomName,
    String? roomWelcome,
    String? roomImage,
    String? bgTheme,
    bool? isAudio,
    bool? isHostActiveInRoom,
    int? hostIsMuted,
    List<BlockedUsers>? blockedUsers,
    List<Seat>? seat,
  }) =>
      LiveUser(
        id: id ?? _id,
        userId: userId ?? _userId,
        liveHistoryId: liveHistoryId ?? _liveHistoryId,
        agoraUid: agoraUid ?? _agoraUid,
        channel: channel ?? _channel,
        token: token ?? _token,
        earnedCoins: earnedCoins ?? _earnedCoins,
        view: view ?? _view,
        liveType: liveType ?? _liveType,
        audioLiveType: audioLiveType ?? _audioLiveType,
        privateCode: privateCode ?? _privateCode,
        roomName: roomName ?? _roomName,
        roomWelcome: roomWelcome ?? _roomWelcome,
        roomImage: roomImage ?? _roomImage,
        bgTheme: bgTheme ?? _bgTheme,
        isAudio: isAudio ?? _isAudio,
        isHostActiveInRoom: isHostActiveInRoom ?? _isHostActiveInRoom,
        hostIsMuted: hostIsMuted ?? _hostIsMuted,
        blockedUsers: blockedUsers ?? _blockedUsers,
        seat: seat ?? _seat,
      );
  String? get id => _id;
  String? get userId => _userId;
  String? get liveHistoryId => _liveHistoryId;
  int? get agoraUid => _agoraUid;
  String? get channel => _channel;
  String? get token => _token;
  int? get earnedCoins => _earnedCoins;
  int? get view => _view;
  int? get liveType => _liveType;
  int? get audioLiveType => _audioLiveType;
  int? get privateCode => _privateCode;
  String? get roomName => _roomName;
  String? get roomWelcome => _roomWelcome;
  String? get roomImage => _roomImage;
  String? get bgTheme => _bgTheme;
  bool? get isAudio => _isAudio;
  bool? get isHostActiveInRoom => _isHostActiveInRoom;
  int? get hostIsMuted => _hostIsMuted;
  List<BlockedUsers>? get blockedUsers => _blockedUsers;
  List<Seat>? get seat => _seat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['liveHistoryId'] = _liveHistoryId;
    map['agoraUid'] = _agoraUid;
    map['channel'] = _channel;
    map['token'] = _token;
    map['earnedCoins'] = _earnedCoins;
    map['view'] = _view;
    map['liveType'] = _liveType;
    map['audioLiveType'] = _audioLiveType;
    map['privateCode'] = _privateCode;
    map['roomName'] = _roomName;
    map['roomWelcome'] = _roomWelcome;
    map['roomImage'] = _roomImage;
    map['bgTheme'] = _bgTheme;
    map['isAudio'] = _isAudio;
    map['isHostActiveInRoom'] = _isHostActiveInRoom;
    map['hostIsMuted'] = _hostIsMuted;
    if (_blockedUsers != null) {
      map['blockedUsers'] = _blockedUsers?.map((v) => v.toJson()).toList();
    }
    if (_seat != null) {
      map['seat'] = _seat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class BlockedUsers {
  BlockedUsers({
    String? blockedUserId,
    String? id,
  }) {
    _blockedUserId = blockedUserId;
    _id = id;
  }

  BlockedUsers.fromJson(dynamic json) {
    _blockedUserId = json['blockedUserId'];
    _id = json['_id'];
  }
  String? _blockedUserId;
  String? _id;
  BlockedUsers copyWith({
    String? blockedUserId,
    String? id,
  }) =>
      BlockedUsers(
        blockedUserId: blockedUserId ?? _blockedUserId,
        id: id ?? _id,
      );
  String? get blockedUserId => _blockedUserId;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['blockedUserId'] = _blockedUserId;
    map['_id'] = _id;
    return map;
  }
}
