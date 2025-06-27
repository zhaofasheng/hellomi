import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/coin_history_page/model/fetch_coin_history_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchCoinHistoryApi {
  static Future<FetchCoinHistoryModel?> callApi({
    required String token,
    required String uid,
    required String startDate,
    required String endDate,
  }) async {
    Utils.showLog("Get Coin History Api Calling...");

    final queryParameters = {
      ApiParams.startDate: startDate,
      ApiParams.endDate: endDate,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchCoinHistory + query);

    Utils.showLog("Get Coin History Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Coin History Api Response => ${response.body}");

        return FetchCoinHistoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Coin History Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Coin History Api Error => $error");
    }
    return null;
  }
}
