import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class LikePostApi {
  static Future<void> callApi({required String token, required String uid, required String postId}) async {
    Utils.showLog("Like Post Api Calling...");

    final queryParameters = {ApiParams.postId: postId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.likePost + query);

    Utils.showLog("Like Post Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Like Post Api Response => ${response.body}");
      } else {
        Utils.showLog("Like Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Like Post Api Error => $error");
    }
  }
}
