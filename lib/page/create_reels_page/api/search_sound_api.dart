import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/create_reels_page/model/search_sound_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SearchSoundApi {
  static Future<SearchSoundModel?> callApi({required String token, required String uid, required String searchString}) async {
    Utils.showLog("Search Sound Api Calling...");

    final queryParameters = {ApiParams.searchString: searchString};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.searchSong + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Search Sound Api Response => ${response.body}");

        return SearchSoundModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Search Sound Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Search Sound Api Error => $error");
    }
    return null;
  }
}
