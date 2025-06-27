import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/coin_seller_page/model/fetch_coin_seller_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchCoinSellerProfileApi {
  static Future<FetchCoinSellerModel?> callApi({
    required String uid,
    required String token,
  }) async {
    Utils.showLog("Fetch Coin seller Api Calling...");

    final uri = Uri.parse(Api.fetchCoinTraderProfile);

    Utils.showLog("Fetch Coin seller Api url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Coin seller Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchCoinSellerModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Coin seller Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Coin seller Api Error => $error");
    }
    return null;
  }
}
