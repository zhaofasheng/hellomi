import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/backpack_page/model/fetch_purchased_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SelectThemeApi {
  static Future<FetchPurchasedFrameModel?> callApi({
    required String token,
    required String uid,
    required String itemId,
    required String action,
    required int itemType,
  }) async {
    Utils.showLog("Get Select theme Api Calling...");
    final queryParameters = {
      ApiParams.itemId: itemId,
      ApiParams.action: action,
      ApiParams.itemType: itemType.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get Select theme  URI $query");
    final uri = Uri.parse(Api.wearOrTakeOffItem + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.patch(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get Select theme Api Response => ${response.body}");
        Utils.showToast(text: "${jsonResponse['message']}");

        return FetchPurchasedFrameModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get Select theme Api StateCode Error");
        Utils.showLog("Get Select theme Api StateCode ${response.body}");
      }
    } catch (error) {
      Utils.showLog("Get Select theme Api Error => $error");
    }
    return null;
  }
}
