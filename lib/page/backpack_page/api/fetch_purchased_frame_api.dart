import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/backpack_page/model/fetch_purchased_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchPurchasedFrameApi {
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<FetchPurchasedFrameModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Get PurchaseFrame Api Calling...");
    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get PurchaseFrame  URI $query.");
    final uri = Uri.parse(Api.listUserPurchasedItems + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get PurchaseFrame Api Response => ${response.body}");

        return FetchPurchasedFrameModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get PurchaseFrame Api StateCode Error");
        Utils.showLog("Get PurchaseFrame Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get PurchaseFrame Api Error => $error");
    }
    return null;
  }
}
