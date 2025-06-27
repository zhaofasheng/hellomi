import 'package:http/http.dart' as http;
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class ToggleNotificationApi {
  static Future<void> callApi({required String token, required String uid}) async {
    Utils.showLog("Toggle Notification Api Calling...");

    final uri = Uri.parse(Api.toggleNotification);

    Utils.showLog("Toggle Notification Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.patch(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Toggle Notification Api Api Response => ${response.body}");
      } else {
        Utils.showLog("Toggle Notification Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Toggle Notification Api Error => $error");
    }
  }
}
