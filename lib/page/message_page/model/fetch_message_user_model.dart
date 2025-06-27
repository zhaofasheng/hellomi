class FetchMessageUserModel {
  FetchMessageUserModel({
    bool? status,
    String? message,
    List<MessageData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchMessageUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MessageData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<MessageData>? _data;
  FetchMessageUserModel copyWith({
    bool? status,
    String? message,
    List<MessageData>? data,
  }) =>
      FetchMessageUserModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<MessageData>? get data => _data;

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

class MessageData {
  MessageData({
    String? id,
    String? userId,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isOnline,
    bool? isVerified,
    bool? isFake,
    String? chatTopicId,
    String? senderId,
    String? message,
    String? lastChatMessageTime,
    int? unreadCount,
    int? avatarFrameType,
    String? avatarFrameImage,
    String? time,
  }) {
    _id = id;
    _userId = userId;
    _name = name;
    _userName = userName;
    _image = image;
    _isProfilePicBanned = isProfilePicBanned;
    _isOnline = isOnline;
    _isVerified = isVerified;
    _isFake = isFake;
    _chatTopicId = chatTopicId;
    _senderId = senderId;
    _message = message;
    _lastChatMessageTime = lastChatMessageTime;
    _unreadCount = unreadCount;
    _avatarFrameType = avatarFrameType;
    _avatarFrameImage = avatarFrameImage;
    _time = time;
  }

  MessageData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _name = json['name'];
    _userName = json['userName'];
    _image = json['image'];
    _isProfilePicBanned = json['isProfilePicBanned'];
    _isOnline = json['isOnline'];
    _isVerified = json['isVerified'];
    _isFake = json['isFake'];
    _chatTopicId = json['chatTopicId'];
    _senderId = json['senderId'];
    _message = json['message'];
    _lastChatMessageTime = json['lastChatMessageTime'];
    _unreadCount = json['unreadCount'];
    _avatarFrameType = json['avatarFrameType'];
    _avatarFrameImage = json['avatarFrameImage'];
    _time = json['time'];
  }
  String? _id;
  String? _userId;
  String? _name;
  String? _userName;
  String? _image;
  bool? _isProfilePicBanned;
  bool? _isOnline;
  bool? _isVerified;
  bool? _isFake;
  String? _chatTopicId;
  String? _senderId;
  String? _message;
  String? _lastChatMessageTime;
  int? _unreadCount;
  int? _avatarFrameType;
  String? _avatarFrameImage;
  String? _time;
  MessageData copyWith({
    String? id,
    String? userId,
    String? name,
    String? userName,
    String? image,
    bool? isProfilePicBanned,
    bool? isOnline,
    bool? isVerified,
    bool? isFake,
    String? chatTopicId,
    String? senderId,
    String? message,
    String? lastChatMessageTime,
    int? unreadCount,
    int? avatarFrameType,
    String? avatarFrameImage,
    String? time,
  }) =>
      MessageData(
        id: id ?? _id,
        userId: userId ?? _userId,
        name: name ?? _name,
        userName: userName ?? _userName,
        image: image ?? _image,
        isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
        isOnline: isOnline ?? _isOnline,
        isVerified: isVerified ?? _isVerified,
        isFake: isFake ?? _isFake,
        chatTopicId: chatTopicId ?? _chatTopicId,
        senderId: senderId ?? _senderId,
        message: message ?? _message,
        lastChatMessageTime: lastChatMessageTime ?? _lastChatMessageTime,
        unreadCount: unreadCount ?? _unreadCount,
        avatarFrameType: avatarFrameType ?? _avatarFrameType,
        avatarFrameImage: avatarFrameImage ?? _avatarFrameImage,
        time: time ?? _time,
      );
  String? get id => _id;
  String? get userId => _userId;
  String? get name => _name;
  String? get userName => _userName;
  String? get image => _image;
  bool? get isProfilePicBanned => _isProfilePicBanned;
  bool? get isOnline => _isOnline;
  bool? get isVerified => _isVerified;
  bool? get isFake => _isFake;
  String? get chatTopicId => _chatTopicId;
  String? get senderId => _senderId;
  String? get message => _message;
  String? get lastChatMessageTime => _lastChatMessageTime;
  int? get unreadCount => _unreadCount;
  int? get avatarFrameType => _avatarFrameType;
  String? get avatarFrameImage => _avatarFrameImage;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['name'] = _name;
    map['userName'] = _userName;
    map['image'] = _image;
    map['isProfilePicBanned'] = _isProfilePicBanned;
    map['isOnline'] = _isOnline;
    map['isVerified'] = _isVerified;
    map['isFake'] = _isFake;
    map['chatTopicId'] = _chatTopicId;
    map['senderId'] = _senderId;
    map['message'] = _message;
    map['lastChatMessageTime'] = _lastChatMessageTime;
    map['unreadCount'] = _unreadCount;
    map['avatarFrameType'] = _avatarFrameType;
    map['avatarFrameImage'] = _avatarFrameImage;
    map['time'] = _time;
    return map;
  }
}
