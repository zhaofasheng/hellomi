import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/page/recharge_coin_page/model/create_coin_plan_history_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class CreateCoinPlanHistoryApi {
  static Future<CreateCoinPlanHistoryModel?> callApi({
    required String token,
    required String uid,
    required String coinPlanId,
    required String paymentGateway,
  }) async {
    Utils.showLog("Create Coin Plan History Api Calling...");

    final queryParameters = {
      ApiParams.coinPlanId: coinPlanId,
      ApiParams.paymentGateway: paymentGateway,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.createCoinPlanHistory + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);
      Utils.showLog("Create Coin Plan History Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        FetchUserCoin.init();

        FetchLoginUserProfileApi.callApi(token: token, uid: uid);

        return CreateCoinPlanHistoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Create Coin Plan History Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Create Coin Plan History Api Error => $error");
    }
    return null;
  }
}
