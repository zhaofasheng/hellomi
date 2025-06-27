import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchHashtagWisePostApi {
  static Future<FetchPostModel?> callApi({required String uid, required String token, required String hashTagId}) async {
    Utils.showLog("Fetch Hashtag Wise Post Api Calling... ");

    final queryParameters = {ApiParams.hashTagId: hashTagId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchHashtagWisePost + query);

    Utils.showLog("Fetch Hashtag Wise Post Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Hashtag Wise Post Api Response => ${response.body}");

        return FetchPostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Hashtag Wise Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Hashtag Wise Post Api Error => $error");
    }
    return null;
  }
}
