import 'dart:convert';
import 'package:tingle/page/other_user_connection_page/model/fetch_other_user_connection_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:http/http.dart' as http;

class FetchOtherUserConnectionApi {
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<FetchOtherUserConnectionModel?> callApi({required String uid, required String token, required String userId}) async {
    Utils.showLog("Get Other User Connection Following Api Calling...");

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
      ApiParams.toUserId: userId,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.otherUserConnections + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Other User Connection Following Api Response => ${response.body}");

        return FetchOtherUserConnectionModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Other User Connection Following Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Other User Connection Following Api Error => $error");
    }

    return null;
  }
}
