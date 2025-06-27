import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SendCommentApi {
  static Future<void> callApi({required String token, required String uid, required String id, required String type, required String commentText}) async {
    Utils.showLog("Send Comment Api Calling...");

    final queryParameters = {
      ApiParams.commentText: commentText,
      ApiParams.type: type,
      ApiParams.postId: id,
      ApiParams.videoId: id,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.sendComment + query);

    Utils.showLog("Send Comment Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Send Comment Api Response => ${response.body}");
      } else {
        Utils.showLog("Send Comment Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Send Comment Api Error => $error");
    }
  }
}
