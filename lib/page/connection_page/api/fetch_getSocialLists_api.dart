import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/connection_page/model/fetch_follower_following_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchGetSocialListsApi {
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<FetchFollowerFollowingModel?> callApi({required String userId, required String token}) async {
    Utils.showLog("Get SocialLists Following Api Calling...");
    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get SocialLists Following URI $query.");
    final uri = Uri.parse(Api.fetchGetSocialLists + query);
    Utils.showLog("Get SocialLists Following URI $uri.");
    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: userId};
    Utils.showLog("Get SocialLists Following headers $headers.");
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get SocialLists Following Api Response => ${response.body}");

        return FetchFollowerFollowingModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get SocialLists Following Api StateCode Error");
        Utils.showLog("Get SocialLists Following Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get SocialLists Following Api Error => $error");
    }

    return null;
  }
}
