import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_emoji_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchPurchaseThemeApi {
  static int startPagination = 0;
  static int limitPagination = 20;
  static Future<FetchEmojiModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Purchase Theme Api Calling...");

    startPagination++;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchPurchaseTheme + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Purchase Theme Api Response => ${response.body}");

        return FetchEmojiModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Purchase Theme Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Purchase Theme Api Error => $error");
    }
    return null;
  }
}
