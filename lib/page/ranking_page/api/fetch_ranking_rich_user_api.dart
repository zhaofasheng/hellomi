import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/ranking_page/model/fetch_ranking_rich_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchRankingRichUserApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchRankingRichUserModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Fetch Ranking Rich User Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchRankingRichUser + query);

    Utils.showLog("Fetch Ranking Rich User Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Ranking Rich User Api Response => ${response.body}");

        return FetchRankingRichUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Ranking Rich User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Ranking Rich User Api Error => $error");
    }
    return null;
  }
}
