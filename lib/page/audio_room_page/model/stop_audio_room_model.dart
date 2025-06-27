class StopAudioRoomModel {
  StopAudioRoomModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  StopAudioRoomModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  StopAudioRoomModel copyWith({
    bool? status,
    String? message,
  }) =>
      StopAudioRoomModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
