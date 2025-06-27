import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/validate_user.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class UserExistsForResetApi {
  static Future<ValidateUserModel?> callApi({
    required int loginType,
    required String email,
  }) async {
    Utils.showLog("Validate User Exist Api Calling... ");
    final queryParameters = {
      ApiParams.email: email,
      ApiParams.loginType: loginType.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get Select Query  URI $query");

    final uri = Uri.parse(Api.userExistsForReset + query);
    Utils.showLog("Get Select Query  URI $uri");
    final headers = {
      ApiParams.key: Api.secretKey,
    };

    try {
      var response = await http.post(uri, headers: headers);

      Utils.showLog("Validate User Exist Api  Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return ValidateUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Validate User Exist Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Validate User Exist Api Error => $error");
    }
    return null;
  }
}
