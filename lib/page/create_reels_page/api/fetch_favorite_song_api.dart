import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/create_reels_page/model/fetch_favorite_sound_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchFavoriteSongApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchFavoriteSoundModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Favorite Song Api Calling...");

    startPagination++;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchFavoriteSong + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Favorite Song Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchFavoriteSoundModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Favorite Song Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Favorite Song Api Error => $error");
    }
    return null;
  }
}
