import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/upload_feed_page/model/fetch_all_hashtag_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchAllHashtagApi {
  static Future<FetchAllHashtagModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch All Hashtag Api Calling...");

    final uri = Uri.parse(Api.fetchAllHashtag);

    Utils.showLog("Fetch All Hashtag Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch All Hashtag Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchAllHashtagModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch All Hashtag Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch All Hashtag Api Error => $error");
    }
    return null;
  }
}
