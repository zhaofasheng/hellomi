import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/visit_profile_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class VisitProfileApi {
  static Future<VisitProfileModel?> callApi({
    required String token,
    required String uid,
    required String profileOwnerId,
  }) async {
    Utils.showLog("Visit Profile Api Calling...");

    final queryParameters = {ApiParams.profileOwnerId: profileOwnerId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.visitProfile + query);

    Utils.showLog("Visit Profile Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      Utils.showLog("Visit Profile Api Response => ${response.body}");

      if (response.statusCode == 200) {
        return VisitProfileModel.fromJson(jsonDecode(response.body));
      } else {
        Utils.showLog("Visit Profile Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Visit Profile Api Error => $error");
    }
    return null;
  }
}
