import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/search_page/model/search_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SearchUserApi {
  static Future<SearchUserModel?> callApi({required String token, required String uid, required String searchText}) async {
    Utils.showLog("Search User Api Calling...");
    Utils.showLog("Search User Api Calling...m${searchText}");

    final queryParameters = {ApiParams.userSearchString: searchText};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.searchUser + query);

    Utils.showLog("Search User Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);
      Utils.showLog("Search User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return SearchUserModel.fromJson(jsonResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        Utils.showToast(text: jsonResponse["message"]);
      }
    } catch (error) {
      Utils.showLog("Search User Api Error => $error");
    }
    return null;
  }
}
