class ValidateAgencyModel {
  ValidateAgencyModel({
    bool? status,
    String? message,
    bool? isValid,
  }) {
    _status = status;
    _message = message;
    _isValid = isValid;
  }

  ValidateAgencyModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isValid = json['isValid'];
  }
  bool? _status;
  String? _message;
  bool? _isValid;
  ValidateAgencyModel copyWith({
    bool? status,
    String? message,
    bool? isValid,
  }) =>
      ValidateAgencyModel(
        status: status ?? _status,
        message: message ?? _message,
        isValid: isValid ?? _isValid,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isValid => _isValid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isValid'] = _isValid;
    return map;
  }
}
