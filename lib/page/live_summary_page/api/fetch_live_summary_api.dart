import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/live_summary_page/model/fetch_live_summary_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchLiveSummaryApi {
  static Future<FetchLiveSummaryModel?> callApi({
    required String uid,
    required String token,
    required String liveHistoryId,
  }) async {
    Utils.showLog("Fetch Live Summary Api Calling... ");

    final queryParameters = {ApiParams.liveHistoryId: liveHistoryId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchLiveSummary + query);

    Utils.showLog("Fetch Live Summary Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Live Summary Api Response => ${response.body}");

        return FetchLiveSummaryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Live Summary Api StateCode Error => $response");
      }
    } catch (error) {
      Utils.showLog("Fetch Live Summary Api Error => $error");
    }
    return null;
  }
}
