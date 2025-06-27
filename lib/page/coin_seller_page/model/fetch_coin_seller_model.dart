import 'dart:convert';

FetchCoinSellerModel coinSellerModelFromJson(String str) => FetchCoinSellerModel.fromJson(json.decode(str));

String coinSellerModelToJson(FetchCoinSellerModel data) => json.encode(data.toJson());

class FetchCoinSellerModel {
  bool? status;
  String? message;
  Data? data;

  FetchCoinSellerModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchCoinSellerModel.fromJson(Map<String, dynamic> json) => FetchCoinSellerModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? id;
  String? userId;
  int? uniqueId;
  String? countryCode;
  String? mobileNumber;
  int? coin;
  int? spendCoin;
  DateTime? createdAt;

  Data({
    this.id,
    this.userId,
    this.uniqueId,
    this.countryCode,
    this.mobileNumber,
    this.coin,
    this.spendCoin,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"],
        uniqueId: json["uniqueId"],
        countryCode: json["countryCode"],
        mobileNumber: json["mobileNumber"],
        coin: json["coin"],
        spendCoin: json["spendCoin"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "uniqueId": uniqueId,
        "countryCode": countryCode,
        "mobileNumber": mobileNumber,
        "coin": coin,
        "spendCoin": spendCoin,
        "createdAt": createdAt?.toIso8601String(),
      };
}
