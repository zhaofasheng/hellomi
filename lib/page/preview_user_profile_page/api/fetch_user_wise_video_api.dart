import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/feed_page/model/fetch_video_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserWiseVideoApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchVideoModel?> callApi({required String uid, required String token, required String toUserId}) async {
    Utils.showLog("Fetch User Wise Video Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.toUserId: toUserId,
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchUserWiseVideo + query);

    Utils.showLog("Fetch User Wise Video Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch User Wise Video Api Response => ${response.body}");

        return FetchVideoModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch User Wise Video Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch User Wise Video Api Error => $error");
    }
    return null;
  }
}
