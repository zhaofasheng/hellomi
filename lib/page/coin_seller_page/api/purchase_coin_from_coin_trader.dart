import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/coin_seller_page/model/purchase_coin_from_coin_trader_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class PurchaseCoinFromCoinTrader {
  static Future<PurchaseCoinFromCoinTraderModel?> callApi(
      {required String token, required String uniqueId, required String coinTraderId, required String coin, required String uid}) async {
    Utils.showLog("Purchase coin Api Calling...");

    final queryParameters = {
      ApiParams.uniqueId: uniqueId,
      ApiParams.coinTraderId: coinTraderId,
      ApiParams.coin: coin,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.purchaseCoinFromCoinTrader + query);

    Utils.showLog("Purchase coin from coin trader Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Purchase coin from coin trader Api Response => ${response.body}");

        return PurchaseCoinFromCoinTraderModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Purchase coin from coin trader Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Purchase coin from coin trader Api Error => $error");
    }
    return null;
  }
}
