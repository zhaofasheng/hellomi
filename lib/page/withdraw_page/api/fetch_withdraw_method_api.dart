import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/withdraw_page/model/fetch_withdraw_method_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/utils.dart';

class FetchWithdrawMethodApi {
  static Future<FetchWithdrawMethodModel?> callApi() async {
    Utils.showLog("Get Withdraw Method Api Calling...");

    final uri = Uri.parse(Api.fetchPayoutMethods);

    final headers = {"key": Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Withdraw Method Api Response => ${response.body}");

        return FetchWithdrawMethodModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Withdraw Method Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get Withdraw Method Api Error => $error");
    }
    return null;
  }
}
