import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class LikeVideoApi {
  static Future<void> callApi({required String token, required String uid, required String videoId}) async {
    Utils.showLog("Like Video Api Calling...");

    final queryParameters = {ApiParams.videoId: videoId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.likeVideo + query);

    Utils.showLog("Like Video Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Like Video Api Response => ${response.body}");
      } else {
        Utils.showLog("Like Video Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Like Video Api Error => $error");
    }
  }
}
