import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FavoriteUnFavoriteApi {
  static Future<void> callApi({required String token, required String uid, required String songId}) async {
    Utils.showLog("Sound Favorite-UnFavorite Api Calling...");

    final queryParameters = {ApiParams.songId: songId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.favoriteSong + query);

    Utils.showLog("Sound Favorite-UnFavorite Api => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Sound Favorite-UnFavorite Api Response => ${response.body}");
      } else {
        Utils.showLog("Sound Favorite-UnFavorite Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Sound Favorite-UnFavorite Api Error => $error");
    }
  }
}
