import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/chat_page/model/fetch_user_chat_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserChatApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchUserChatModel?> callApi({required String uid, required String token, required String receiverId}) async {
    Utils.showLog("Fetch User Chat Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.receiverId: receiverId,
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchUserChat + query);

    Utils.showLog("Fetch User Chat Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch User Chat Api Response => ${response.body}");

        return FetchUserChatModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch User Chat Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch User Chat Api Error => $error");
    }
    return null;
  }
}
