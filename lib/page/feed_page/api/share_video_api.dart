import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class ShareVideoApi {
  static Future<void> callApi({required String token, required String uid, required String videoId}) async {
    Utils.showLog("Share Video Api Calling...");

    final queryParameters = {ApiParams.videoId: videoId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.shareVideo + query);

    Utils.showLog("Share Video Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.patch(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Share Video Api Api Response => ${response.body}");
      } else {
        Utils.showLog("Share Video Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Share Video Api Error => $error");
    }
  }
}
