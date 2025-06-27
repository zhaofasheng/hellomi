class VisitProfileModel {
  VisitProfileModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  VisitProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  VisitProfileModel copyWith({
    bool? status,
    String? message,
  }) =>
      VisitProfileModel(
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
