import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/page/withdraw_page/model/create_withdraw_request_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class CreateWithdrawRequestApi {
  static Future<CreateWithdrawRequestModel?> callApi({
    required String loginUserId,
    required String coin,
    required String uid,
    required String token,
    required String paymentGateway,
    required List<String> paymentDetails,
  }) async {
    final uri = Uri.parse(Api.submitPayoutRequest);

    final headers = {
      ApiParams.key: Api.secretKey, ApiParams.contentType: ApiParams.applicationJson,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,

      // "application/json; charset=UTF-8"
    };

    Utils.showLog("With Draw Request Api => $uri");

    final body = json.encode({
      ApiParams.userId: loginUserId,
      ApiParams.coin: coin,
      ApiParams.paymentGateway: paymentGateway,
      ApiParams.paymentDetails: paymentDetails,
    });

    Utils.showLog("With Draw Request Body => $body");

    try {
      final response = await http.post(uri, headers: headers, body: body);

      Utils.showLog("Withdraw Request Body => $body");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("With Draw Request Api Response => ${response.body}");
        return CreateWithdrawRequestModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("With Draw Request Api Response => ${response.body}");
        Utils.showLog("With Draw Request Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("With Draw Request Api Error => $error");
    }
    return null;
  }
}
