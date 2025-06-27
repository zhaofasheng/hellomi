import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/connection_page/model/search_connection_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SearchConnectionApi {
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<SearchConnectionModel?> callApi({required String searchString, required String type}) async {
    Utils.showLog("Search Connection Api Calling...");

    final token = await FirebaseAccessToken.onGet() ?? "";
    final uid = FirebaseUid.onGet() ?? "";

    final queryParameters = {
      ApiParams.type: type.toString(),
      ApiParams.userSearchString: searchString,
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    Utils.showLog("Get SocialLists Following URI $query.");

    final uri = Uri.parse(Api.searchUserConnections + query);

    Utils.showLog("Search Connection Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Visitor Api Response => ${response.body}");

        return SearchConnectionModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Visitor Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Visitor Api Error => $error");
    }
    return null;
  }
}
