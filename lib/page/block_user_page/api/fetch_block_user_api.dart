import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/block_user_page/model/fetch_block_user_model.dart';
import 'package:tingle/page/login_page/model/fetch_login_user_profile_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchBlockUserApi {
  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  static Future<FetchBlockUserModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Block User Api Calling...");

    final uri = Uri.parse(Api.fetchBlockUser);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Fetch Block User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FetchBlockUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Block User Api StateCode Error => $response");
      }
    } catch (error) {
      Utils.showLog("Fetch Block User Api Error => $error");
    }
    return null;
  }
}
