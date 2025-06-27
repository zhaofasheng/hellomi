import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserProfileApi {
  static FetchUserProfileModel? fetchUserProfileModel;

  static Future<FetchUserProfileModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Profile Api Api Calling...");

    final uri = Uri.parse(Api.fetchUserProfile);

    Utils.showLog("Fetch Profile Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Profile Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FetchUserProfileModel.fromJson(jsonResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showToast(text: jsonResponse["message"]);
      }
    } catch (error) {
      Utils.showLog("Fetch Profile Api Error => $error");
    }
    return null;
  }
}
