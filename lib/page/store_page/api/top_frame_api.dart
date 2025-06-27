import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/connection_page/model/fetch_visitor_model.dart';
import 'package:tingle/page/store_page/model/top_frame_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchTopFramesApi {
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<TopFramesModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Get TopFrames Api Calling...");
    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get TopFrames  URI $query.");
    final uri = Uri.parse(Api.fetchRecommendations + query);

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get TopFrames Api Response => ${response.body}");

        return TopFramesModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get TopFrames Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get TopFrames Api Error => $error");
    }
    return null;
  }
}
