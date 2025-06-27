import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/login_page/model/fetch_login_user_profile_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class FetchLoginUserProfileApi {
  static FetchLoginUserProfileModel? fetchLoginUserProfileModel;

  static Future<void> callApi({required String token, required String uid}) async {
    Utils.showLog("Get Login User Profile Api Calling...");

    final uri = Uri.parse(Api.fetchLoginUserProfile);

    Utils.showLog("Get Login User Profile Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Get Login User Profile Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        fetchLoginUserProfileModel = FetchLoginUserProfileModel.fromJson(jsonResponse);
        Database.onSetLoginUserProfile(jsonEncode(fetchLoginUserProfileModel?.toJson()));
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showToast(text: jsonResponse["message"]);
      }
    } catch (error) {
      Utils.showLog("Get Login User Profile Api Error => $error");
    }
  }
}
