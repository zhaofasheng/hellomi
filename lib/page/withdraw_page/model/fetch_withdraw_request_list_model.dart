// To parse this JSON data, do
//
//     final retrieveUserPayouts = retrieveUserPayoutsFromJson(jsonString);

import 'dart:convert';

FetchRetrieveUserPayoutsModel retrieveUserPayoutsFromJson(String str) => FetchRetrieveUserPayoutsModel.fromJson(json.decode(str));

String retrieveUserPayoutsToJson(FetchRetrieveUserPayoutsModel data) => json.encode(data.toJson());

class FetchRetrieveUserPayoutsModel {
  bool? status;
  String? message;
  List<PayoutRequest>? payoutRequests;

  FetchRetrieveUserPayoutsModel({
    this.status,
    this.message,
    this.payoutRequests,
  });

  factory FetchRetrieveUserPayoutsModel.fromJson(Map<String, dynamic> json) => FetchRetrieveUserPayoutsModel(
        status: json["status"],
        message: json["message"],
        payoutRequests: json["payoutRequests"] == null ? [] : List<PayoutRequest>.from(json["payoutRequests"]!.map((x) => PayoutRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "payoutRequests": payoutRequests == null ? [] : List<dynamic>.from(payoutRequests!.map((x) => x.toJson())),
      };
}

class PayoutRequest {
  String? id;
  String? uniqueId;
  int? status;
  int? coin;
  num? amount;
  String? paymentGateway;
  List<String>? paymentDetails;
  String? reason;
  String? requestDate;
  String? acceptOrDeclineDate;

  PayoutRequest({
    this.id,
    this.uniqueId,
    this.status,
    this.coin,
    this.amount,
    this.paymentGateway,
    this.paymentDetails,
    this.reason,
    this.requestDate,
    this.acceptOrDeclineDate,
  });

  factory PayoutRequest.fromJson(Map<String, dynamic> json) => PayoutRequest(
        id: json["_id"],
        uniqueId: json["uniqueId"],
        status: json["status"],
        coin: json["coin"],
        amount: json["amount"],
        paymentGateway: json["paymentGateway"],
        paymentDetails: json["paymentDetails"] == null ? [] : List<String>.from(json["paymentDetails"]!.map((x) => x)),
        reason: json["reason"],
        requestDate: json["requestDate"],
        acceptOrDeclineDate: json["acceptOrDeclineDate"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "uniqueId": uniqueId,
        "status": status,
        "coin": coin,
        "amount": amount,
        "paymentGateway": paymentGateway,
        "paymentDetails": paymentDetails == null ? [] : List<dynamic>.from(paymentDetails!.map((x) => x)),
        "reason": reason,
        "requestDate": requestDate,
        "acceptOrDeclineDate": acceptOrDeclineDate,
      };
}
