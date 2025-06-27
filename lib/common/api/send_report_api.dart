import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/send_report_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SendReportApi {
  static Future<SendReportModel?> callApi({
    required String token,
    required String uid,
    required String type,
    required String id,
    required String reportReason,
  }) async {
    Utils.showLog("Send Report Api Calling...");

    final queryParameters = {
      ApiParams.type: type,
      ApiParams.reportReason: reportReason,
    };

    switch (type) {
      case ApiParams.post:
        queryParameters.addAll({ApiParams.postId: id});
      case ApiParams.video:
        queryParameters.addAll({ApiParams.videoId: id});
      case ApiParams.user:
        queryParameters.addAll({ApiParams.toUserId: id});
      default:
    }

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.sendReport + query);

    Utils.showLog("Send Report Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Send Report Api Response => ${response.body}");
        return SendReportModel.fromJson(jsonDecode(response.body));
      } else {
        Utils.showLog("Send Report Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Send Report Api Error => $error");
    }
    return null;
  }
}
