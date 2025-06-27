import 'dart:convert';

ValidateUserModel validateUserModelFromJson(String str) => ValidateUserModel.fromJson(json.decode(str));

String validateUserModelToJson(ValidateUserModel data) => json.encode(data.toJson());

class ValidateUserModel {
  bool? status;
  String? message;
  bool? isLogin;

  ValidateUserModel({
    this.status,
    this.message,
    this.isLogin,
  });

  factory ValidateUserModel.fromJson(Map<String, dynamic> json) => ValidateUserModel(
        status: json["status"],
        message: json["message"],
        isLogin: json["isLogin"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "isLogin": isLogin,
      };
}
