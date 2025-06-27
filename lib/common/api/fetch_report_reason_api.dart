import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_report_reason_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchReportReasonApi {
  static Future<FetchReportReasonModel?> callApi({required String uid, required String token}) async {
    Utils.showLog("Get Friends Api Calling...");

    final uri = Uri.parse(Api.fetchReportReason);

    Utils.showLog("Fetch Report Reason Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Report Reason Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchReportReasonModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Report Reason Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Report Reason Api Error => $error");
    }
    return null;
  }
}
