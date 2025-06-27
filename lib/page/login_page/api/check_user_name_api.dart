import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/login_page/model/check_user_name_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class CheckUserNameApi {
  static Future<CheckUserNameModel?> callApi({required String userName, required String token, required String uid}) async {
    Utils.showLog("Check User Name Api Calling...");

    final uri = Uri.parse("${Api.checkUserNameExit}?userName=$userName");

    Utils.showLog("Check User Name Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Check User Name Api Response => ${response.body}");

        return CheckUserNameModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Check User Name Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Check User Name Api Error => $error");
    }
    return null;
  }
}
