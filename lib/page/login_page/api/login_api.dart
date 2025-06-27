import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/login_page/model/login_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class LoginApi {
  static Future<LoginModel?> callApi({
    String? name,
    String? userName,
    String? image,
    String? mobileNumber,
    String? password,
    required String email,
    required String identity,
    required String fcmToken,
    required String token,
    required String uid,
    required int loginType,
  }) async {
    Utils.showLog("Login Api Calling...");

    final uri = Uri.parse(Api.login);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.contentType: ApiParams.applicationJson, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    final body = (mobileNumber != null)
        ? json.encode({
            ApiParams.mobileNumber: mobileNumber,
            ApiParams.loginType: loginType,
            ApiParams.identity: identity,
            ApiParams.fcmToken: fcmToken,
          })
        : (userName == null)
            ? json.encode({
                ApiParams.email: email,
                ApiParams.loginType: loginType,
                ApiParams.identity: identity,
                ApiParams.fcmToken: fcmToken,
                ApiParams.password: password,
              })
            : json.encode({
                ApiParams.name: name,
                ApiParams.userName: userName,
                ApiParams.email: email,
                ApiParams.loginType: loginType,
                ApiParams.identity: identity,
                ApiParams.fcmToken: fcmToken,
                ApiParams.image: image,
                ApiParams.password: password,
              });

    try {
      Utils.showLog("Login Api Uri => $uri");
      Utils.showLog("Login Api Headers => $headers");
      Utils.showLog("Login Api Body => $body");

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        Utils.showLog("Login Api Response => INN");
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Login Api Response LoginModel => ${LoginModel.fromJson(jsonResponse).toJson()}");
        if (LoginModel.fromJson(jsonResponse).status != true) {
          Utils.showToast(text: LoginModel.fromJson(jsonResponse).message.toString());
        }
        return LoginModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Login Api Response => OUT");
      }
    } catch (error) {
      Utils.showLog("Login Api Error => $error");
    }
    return null;
  }
}
