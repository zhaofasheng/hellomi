import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SharePostApi {
  static Future<void> callApi({required String token, required String uid, required String postId}) async {
    Utils.showLog("Share Post Api Calling...");

    final queryParameters = {ApiParams.postId: postId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.sharePost + query);

    Utils.showLog("Share Post Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.patch(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Share Post Api Api Response => ${response.body}");
      } else {
        Utils.showLog("Share Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Share Post Api Error => $error");
    }
  }
}
