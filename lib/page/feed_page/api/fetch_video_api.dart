import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/feed_page/model/fetch_video_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchVideoApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchVideoModel?> callApi({required String uid, required String token, required String videoId}) async {
    Utils.showLog("Fetch Video Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
      ApiParams.videoId: videoId,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchVideo + query);

    Utils.showLog("Fetch Video Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    Utils.showLog("Fetch Video Api Response => $uri");
    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Video Api Response => ${response.body}");

        return FetchVideoModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Video Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Video Api Error => $error");
    }
    return null;
  }
}
