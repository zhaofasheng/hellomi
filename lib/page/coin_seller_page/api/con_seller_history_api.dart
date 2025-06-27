import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/coin_seller_page/model/fetch_coin_seller_history_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchCoinSellerHistoryApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchCoinSellerHistoryModel?> callApi({required String uid, required String token, required String coinTraderId}) async {
    Utils.showLog("Fetch Coin Seller History Gallery Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
      ApiParams.coinTraderId: coinTraderId,
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.historyOfCoinTraderToUser + query);

    Utils.showLog("Fetch Coin Seller History Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Coin Seller History Api Response => ${response.body}");

        return FetchCoinSellerHistoryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Coin Seller History Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Coin Seller History Api Error => $error");
    }
    return null;
  }
}
