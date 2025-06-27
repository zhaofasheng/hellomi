import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/message_page/model/fetch_message_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchMessageUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchMessageUserModel?> callApi({
    required String uid,
    required String token,
    required String type,
  }) async {
    Utils.showLog("Fetch Message User Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.type: type, // all,online,unread
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchMessageUser + query);

    Utils.showLog("Fetch Message User Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Message User Api Response => ${response.body}");

        return FetchMessageUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Message User Api StateCode Error => ${response.body}");
      }
    } catch (error) {
      Utils.showLog("Fetch Message User Api Error => $error");
    }
    return null;
  }
}
