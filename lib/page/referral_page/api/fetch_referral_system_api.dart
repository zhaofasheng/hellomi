import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/referral_page/model/fetch_referral_system_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchReferralSystemApi {
  static Future<FetchReferralSystemModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Fetch Referral System Api Calling...");

    final uri = Uri.parse(Api.fetchReferralSystem);

    Utils.showLog("Fetch Referral System Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Referral System Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchReferralSystemModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Referral System Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Referral System Api Error => $error");
    }
    return null;
  }
}
