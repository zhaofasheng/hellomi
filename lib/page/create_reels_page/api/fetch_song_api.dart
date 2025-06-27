import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/create_reels_page/model/fetch_song_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchSongApi {
  static Future<FetchSongModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Song Api Calling...");

    final uri = Uri.parse(Api.fetchSong);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Song Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchSongModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Song Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Song Api Error => $error");
    }
    return null;
  }
}
