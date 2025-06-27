import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/coin_seller_page/model/filter_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchFilterUserListApi {
  static Future<FilterUserModel?> callApi({
    required String uid,
    required String token,
    required String search,
  }) async {
    Utils.showLog("Fetch Filter user Api Calling...");

    final queryParameters = {
      ApiParams.search: search,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.getFilteredUserList + query);

    Utils.showLog("Fetch Filter user Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Filter user Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FilterUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Filter user Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Filter user Api Error => $error");
    }
    return null;
  }
}
