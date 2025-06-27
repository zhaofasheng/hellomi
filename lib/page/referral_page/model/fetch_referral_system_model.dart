class FetchReferralSystemModel {
  FetchReferralSystemModel({
    bool? status,
    String? message,
    List<ReferralData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchReferralSystemModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReferralData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ReferralData>? _data;
  FetchReferralSystemModel copyWith({
    bool? status,
    String? message,
    List<ReferralData>? data,
  }) =>
      FetchReferralSystemModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ReferralData>? get data => _data;

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

class ReferralData {
  ReferralData({
    String? id,
    int? targetReferrals,
    int? rewardCoins,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _targetReferrals = targetReferrals;
    _rewardCoins = rewardCoins;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ReferralData.fromJson(dynamic json) {
    _id = json['_id'];
    _targetReferrals = json['targetReferrals'];
    _rewardCoins = json['rewardCoins'];
    _isActive = json['isActive'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  int? _targetReferrals;
  int? _rewardCoins;
  bool? _isActive;
  String? _createdAt;
  String? _updatedAt;
  ReferralData copyWith({
    String? id,
    int? targetReferrals,
    int? rewardCoins,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      ReferralData(
        id: id ?? _id,
        targetReferrals: targetReferrals ?? _targetReferrals,
        rewardCoins: rewardCoins ?? _rewardCoins,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  int? get targetReferrals => _targetReferrals;
  int? get rewardCoins => _rewardCoins;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['targetReferrals'] = _targetReferrals;
    map['rewardCoins'] = _rewardCoins;
    map['isActive'] = _isActive;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
