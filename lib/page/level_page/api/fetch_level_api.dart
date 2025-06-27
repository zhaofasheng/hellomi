import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/level_page/model/fetch_level_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchLevelApi {
  static Future<FetchLevelModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Fetch Level Api Calling...");

    final uri = Uri.parse(Api.fetchLevel);

    Utils.showLog("Fetch Level Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Level Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchLevelModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Level Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Level Api Error => $error");
    }
    return null;
  }
}
