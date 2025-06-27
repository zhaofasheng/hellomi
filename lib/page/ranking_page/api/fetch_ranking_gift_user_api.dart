import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/feed_page/model/fetch_video_model.dart';
import 'package:tingle/page/ranking_page/model/fetch_ranking_gift_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchRankingGiftUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchRankingGiftUserModel?> callApi({
    required String uid,
    required String token,
    required String date,
  }) async {
    Utils.showLog("Fetch Ranking Gift User Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
      ApiParams.date: date,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchRankingGiftUser + query);

    Utils.showLog("Fetch Ranking Gift User Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Ranking Gift User Api Response => ${response.body}");

        return FetchRankingGiftUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Ranking Gift User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Ranking Gift User Api Error => $error");
    }
    return null;
  }
}
