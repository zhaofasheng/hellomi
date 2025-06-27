import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_setting_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/utils.dart';

class FetchSettingApi {
  static FetchSettingModel? fetchSettingModel;
  static Future<void> callApi({required String uid, required String token}) async {
    Utils.showLog("Fetch Setting Api Calling...");

    final uri = Uri.parse(Api.fetchSetting);

    Utils.showLog("Fetch Setting Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    Utils.showLog("Fetch Setting Api Response => $headers");
    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Setting Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        fetchSettingModel = FetchSettingModel.fromJson(jsonResponse);
        Database.onSetAdminSetting(jsonEncode(fetchSettingModel?.toJson()));
      } else {
        Utils.showLog("Fetch Setting Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Setting Api Error => $error");
    }
  }
}
