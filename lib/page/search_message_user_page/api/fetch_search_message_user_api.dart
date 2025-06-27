import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/search_message_user_page/model/fetch_search_message_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchSearchMessageUserApi {
  static Future<FetchSearchMessageUserModel?> callApi({required String uid, required String token, required String searchString}) async {
    Utils.showLog("Fetch Search Message User Api Calling... ");

    final searchText = searchString.isEmpty ? ApiParams.All : searchString;

    final queryParameters = {ApiParams.searchString: searchText};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchSearchMessageUser + query);

    Utils.showLog("Fetch Search Message User Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Search Message User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchSearchMessageUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Search Message User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Search Message User Api Error => $error");
    }
    return null;
  }
}
