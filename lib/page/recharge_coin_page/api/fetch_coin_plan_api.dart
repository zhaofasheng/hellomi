import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchCoinPlanApi {
  static Future<FetchCoinPlanModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Coin Plan Api Calling...");

    final uri = Uri.parse(Api.fetchCoinPlan);
    Utils.showLog("Fetch Coin Plan Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Coin Plan Api Response => ${response.body}");

        return FetchCoinPlanModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Coin Plan Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Coin Plan Api Error => $error");
    }
    return null;
  }
}
