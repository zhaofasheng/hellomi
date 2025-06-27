import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_comment_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchCommentApi {
  static Future<FetchCommentModel?> callApi({required String token, required String uid, required String id, required String type}) async {
    Utils.showLog("Get Comment Api Calling...");

    final queryParameters = {
      ApiParams.type: type,
      ApiParams.postId: id,
      ApiParams.videoId: id,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchComment + query);

    Utils.showLog("Get Comment Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Comment Api Response => ${response.body}");

        return FetchCommentModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Comment Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Comment Api Error => $error");
    }
    return null;
  }
}
