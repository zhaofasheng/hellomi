import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_friends_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchFriendsApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchFriendsModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Get Friends Api Calling...");

    startPagination++;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchFriends + query);

    Utils.showLog("Get Friends Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Get Friends Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchFriendsModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Friends Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Friends Api Error => $error");
    }
    return null;
  }
}
