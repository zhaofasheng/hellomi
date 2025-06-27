import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchLiveUserApi {
  static Map<String, int> startPagination = {
    ApiParams.explore: 0,
    ApiParams.new_: 0,
    ApiParams.pk: 0,
    ApiParams.follow: 0,
    ApiParams.audio: 0,
    ApiParams.followLiveAudio: 0,
  };
  static int limitPagination = 20;

  static Future<FetchLiveUserModel?> callApi({
    required String token,
    required String uid,
    required String liveType,
    required int startPage,
    String? country,
  }) async {
    // startPagination[liveType] = (startPagination[liveType] ?? 0) + 1;

    Utils.showLog("Get Live User Api Calling => LiveType => $liveType : Page => $startPage");

    final queryParameters = {
      ApiParams.liveType: liveType,
      ApiParams.country: country,
      ApiParams.start: startPage.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchLiveStream + query);

    Utils.showLog("Get Live User Api Calling Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Live User Api Response => ${response.body}");

        return FetchLiveUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Live User Api StateCode Error => ${response.body}");
      }
    } catch (error) {
      Utils.showLog("Get Live User Api Error => $error");
    }
    return null;
  }
}
