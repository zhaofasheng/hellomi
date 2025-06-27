import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchOtherUserProfileApi {
  static FetchUserProfileModel? fetchUserProfileModel;

  static Future<FetchUserProfileModel?> callApi({required String token, required String uid, required String toUserId}) async {
    Utils.showLog("Fetch Other User Profile Api Calling...");

    final queryParameters = {ApiParams.toUserId: toUserId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchOtherUserProfile + query);

    Utils.showLog("Fetch Other User Profile Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Fetch Other User Profile Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FetchUserProfileModel.fromJson(jsonResponse);
      }
    } catch (error) {
      Utils.showLog("Fetch Other User Profile Api Error => $error");
    }
    return null;
  }
}
