// To parse this JSON data, do
//
//     final purchaseCoinFromCoinTraderModel = purchaseCoinFromCoinTraderModelFromJson(jsonString);

import 'dart:convert';

PurchaseCoinFromCoinTraderModel purchaseCoinFromCoinTraderModelFromJson(String str) => PurchaseCoinFromCoinTraderModel.fromJson(json.decode(str));

String purchaseCoinFromCoinTraderModelToJson(PurchaseCoinFromCoinTraderModel data) => json.encode(data.toJson());

class PurchaseCoinFromCoinTraderModel {
  bool? status;
  String? message;

  PurchaseCoinFromCoinTraderModel({
    this.status,
    this.message,
  });

  factory PurchaseCoinFromCoinTraderModel.fromJson(Map<String, dynamic> json) => PurchaseCoinFromCoinTraderModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
