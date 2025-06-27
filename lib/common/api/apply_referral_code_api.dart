import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/apply_referral_code_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class ApplyReferralCodeApi {
  static Future<ApplyReferralCodeModel?> callApi({
    required String token,
    required String uid,
    required String referralCode,
  }) async {
    Utils.showLog("Apply Referral Code Api Calling...");

    final queryParameters = {ApiParams.referralCode: referralCode};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.applyReferralCode + query);

    Utils.showLog("Apply Referral Code Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Apply Referral Code Api Response => ${response.body}");
        return ApplyReferralCodeModel.fromJson(jsonDecode(response.body));
      } else {
        Utils.showLog("Apply Referral Code Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Apply Referral Code Api Error => $error");
    }
    return null;
  }
}
