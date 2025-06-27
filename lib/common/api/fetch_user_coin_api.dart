import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_user_coin_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserCoinApi {
  static Future<FetchUserCoinModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch User Coin Api Calling...");

    final uri = Uri.parse(Api.fetchUserCoin);

    Utils.showLog("Fetch User Coin Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch User Coin Api Response => ${response.body}");

        return FetchUserCoinModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch User Coin Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch User Coin Api Error => $error");
    }
    return null;
  }
}
