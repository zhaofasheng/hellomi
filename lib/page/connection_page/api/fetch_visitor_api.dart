import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/connection_page/model/fetch_visitor_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchVisitorApi {
  static Future<FetchVisitorModel?> callApi({required String userId, required String token}) async {
    Utils.showLog("Get Visitor Api Calling...");

    final uri = Uri.parse(Api.fetchVisitedProfilesAndVisitors);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: userId};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Visitor Api Response => ${response.body}");

        return FetchVisitorModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Visitor Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Visitor Api Error => $error");
    }
    return null;
  }
}
