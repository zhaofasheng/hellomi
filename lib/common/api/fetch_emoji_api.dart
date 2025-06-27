import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_emoji_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchEmojiApi {
  static Future<FetchEmojiModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Emoji Api Calling...");

    final uri = Uri.parse(Api.fetchEmoji);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Emoji Api Response => ${response.body}");

        return FetchEmojiModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Emoji Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Emoji Api Error => $error");
    }
    return null;
  }
}
