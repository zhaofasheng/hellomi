import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/host_request_page/model/validate_agency_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class ValidateAgencyApi {
  static Future<ValidateAgencyModel?> callApi({
    required String token,
    required String uid,
    required String uniqueId,
    required String agencyCode,
  }) async {
    Utils.showLog("Validate Agency Api Calling...");

    final queryParameters = {
      ApiParams.uniqueId: uniqueId,
      ApiParams.agencyCode: agencyCode,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.validateAgency + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Validate Agency Api Response => ${response.body}");

        return ValidateAgencyModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Validate Agency Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Validate Agency Api Error => $error");
    }
    return null;
  }
}
