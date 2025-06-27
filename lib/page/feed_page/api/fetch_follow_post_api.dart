import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchFollowPostApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchPostModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Fetch Follow Post Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchFollowPost + query);

    Utils.showLog("Fetch Follow Post Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    Utils.showLog("Fetch Follow Post Api Response => $uri");
    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Follow Post Api Response => ${response.body}");

        return FetchPostModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Follow Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Follow Post Api Error => $error");
    }
    return null;
  }
}
