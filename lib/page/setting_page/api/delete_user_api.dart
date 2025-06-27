import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/setting_page/model/delete_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class DeleteUserApi {
  static Future<DeleteUserModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Delete User Api Calling... ");

    final uri = Uri.parse(Api.deleteUser);

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,
    };

    try {
      var response = await http.delete(uri, headers: headers);

      Utils.showLog("Delete User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return DeleteUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Delete User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Delete User Api Error => $error");
    }
    return null;
  }
}
