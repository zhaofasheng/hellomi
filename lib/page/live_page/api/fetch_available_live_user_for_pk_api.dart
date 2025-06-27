import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/live_page/model/fetch_available_live_user_for_pk_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchAvailableLiveUserForPkApi {
  static Future<FetchAvailableLiveUserForPkModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Available Live User For Pk Api Calling...");

    final uri = Uri.parse(Api.fetchAvailableLiveUserForPk);

    Utils.showLog("Fetch Available Live User For Pk Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Available Live User For Pk Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchAvailableLiveUserForPkModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Available Live User For Pk Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Available Live User For Pk Api Error => $error");
    }
    return null;
  }
}
