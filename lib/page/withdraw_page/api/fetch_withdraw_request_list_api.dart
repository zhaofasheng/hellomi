import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/withdraw_page/model/fetch_withdraw_request_list_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchWithdrawListApi {
  static Future<FetchRetrieveUserPayoutsModel?> callApi({required String uid, required String token, required String startDate, required String endDate}) async {
    Utils.showLog("Get Withdraw List Method Api Calling...");

    final queryParameters = {
      ApiParams.startDate: startDate,
      ApiParams.endDate: endDate,
    };

    Utils.showLog("Get Withdraw List Method Api ${queryParameters.toString()}");

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.retrieveUserPayouts + query);

    Utils.showLog("Get Withdraw List Method Api $query");

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.contentType: ApiParams.applicationJson,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Withdraw List Method Response => ${response.body}");

        return FetchRetrieveUserPayoutsModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Withdraw List Method Response => ${response.body}");
        Utils.showLog("Get Withdraw List Method StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Withdraw List Method Error => $error");
    }
    return null;
  }
}
