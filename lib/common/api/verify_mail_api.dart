import 'dart:convert';

import 'package:tingle/common/model/validate_user.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';
import 'package:http/http.dart' as http;

class VerifyMailApi {
  static Future<ValidateUserModel?> callApi({
    required int loginType,
    required String email,
    required String password,
  }) async {
    Utils.showLog("Validate User Api Calling... ");
    final queryParameters = password.isEmpty
        ? {
            ApiParams.identity: Database.identity,
            ApiParams.email: email,
            ApiParams.loginType: loginType.toString(),
          }
        : {
            ApiParams.identity: Database.identity,
            ApiParams.email: email,
            ApiParams.password: password,
            ApiParams.loginType: loginType.toString(),
          };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get Select Query  URI $query");

    final uri = Uri.parse(Api.validateUser + query);
    Utils.showLog("Get Select Query  URI $uri");
    final headers = {
      ApiParams.key: Api.secretKey,
    };

    try {
      var response = await http.post(uri, headers: headers);

      Utils.showLog("Validate User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return ValidateUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Validate User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Validate User Api Error => $error");
    }
    return null;
  }
}
