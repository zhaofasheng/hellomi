import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/follow_unfollow_user_model.dart';
import 'package:tingle/page/host_request_page/model/apply_host_request_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class ApplyHostRequestApi {
  static Future<ApplyHostRequestModel?> callApi({
    required String token,
    required String uid,
    required String uniqueId,
    required String agencyCode,
  }) async {
    Utils.showLog("Apply Host Request Api Calling...");

    final queryParameters = {
      ApiParams.uniqueId: uniqueId,
      ApiParams.agencyCode: agencyCode,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.applyHostRequest + query);

    Utils.showLog("Apply Host Request Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Apply Host Request Api Response => ${response.body}");

        return ApplyHostRequestModel.fromJson(jsonDecode(response.body));
      } else {
        Utils.showLog("Apply Host Request Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Apply Host Request Api Error => $error");
    }
    return null;
  }
}
