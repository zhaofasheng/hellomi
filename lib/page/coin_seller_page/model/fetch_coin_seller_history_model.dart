// To parse this JSON data, do
//
//     final fetchCoinSellerHistoryModel = fetchCoinSellerHistoryModelFromJson(jsonString);

import 'dart:convert';

FetchCoinSellerHistoryModel fetchCoinSellerHistoryModelFromJson(String str) => FetchCoinSellerHistoryModel.fromJson(json.decode(str));

String fetchCoinSellerHistoryModelToJson(FetchCoinSellerHistoryModel data) => json.encode(data.toJson());

class FetchCoinSellerHistoryModel {
  bool? status;
  String? message;
  List<History>? history;

  FetchCoinSellerHistoryModel({
    this.status,
    this.message,
    this.history,
  });

  factory FetchCoinSellerHistoryModel.fromJson(Map<String, dynamic> json) => FetchCoinSellerHistoryModel(
        status: json["status"],
        message: json["message"],
        history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}

class History {
  String? id;
  UserId? userId;
  int? coin;
  String? date;
  bool? isIncome;
  DateTime? createdAt;

  History({
    this.id,
    this.userId,
    this.coin,
    this.date,
    this.isIncome,
    this.createdAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["_id"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        coin: json["coin"],
        date: json["date"],
        isIncome: json["isIncome"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId?.toJson(),
        "coin": coin,
        "isIncome": isIncome,
        "date": date,
        "createdAt": createdAt?.toIso8601String(),
      };
}

class UserId {
  String? id;
  String? name;
  String? userName;
  String? gender;
  String? image;
  bool? isProfilePicBanned;
  String? countryFlagImage;
  String? country;
  String? uniqueId;

  UserId({
    this.id,
    this.name,
    this.userName,
    this.gender,
    this.image,
    this.isProfilePicBanned,
    this.countryFlagImage,
    this.country,
    this.uniqueId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        gender: json["gender"],
        image: json["image"],
        isProfilePicBanned: json["isProfilePicBanned"],
        countryFlagImage: json["countryFlagImage"],
        country: json["country"],
        uniqueId: json["uniqueId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userName": userName,
        "gender": gender,
        "image": image,
        "isProfilePicBanned": isProfilePicBanned,
        "countryFlagImage": countryFlagImage,
        "country": country,
        "uniqueId": uniqueId,
      };
}
