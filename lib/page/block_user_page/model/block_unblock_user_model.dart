class BlockUnblockUserModel {
  BlockUnblockUserModel({
    bool? status,
    String? message,
    bool? isBlocked,
  }) {
    _status = status;
    _message = message;
    _isBlocked = isBlocked;
  }

  BlockUnblockUserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isBlocked = json['isBlocked'];
  }
  bool? _status;
  String? _message;
  bool? _isBlocked;
  BlockUnblockUserModel copyWith({
    bool? status,
    String? message,
    bool? isBlocked,
  }) =>
      BlockUnblockUserModel(
        status: status ?? _status,
        message: message ?? _message,
        isBlocked: isBlocked ?? _isBlocked,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isBlocked => _isBlocked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isBlocked'] = _isBlocked;
    return map;
  }
}
