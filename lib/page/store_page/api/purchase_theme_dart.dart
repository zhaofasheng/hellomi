import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tingle/common/function/fetch_user_coin.dart';

import 'package:tingle/page/store_page/model/purchase_theme.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class PurchaseThemeApi {
  static Future<Fetchpurchasedtheme?> callApi({required String token, required String itemType, required String itemId, required String userId, required bool directWear}) async {
    Utils.showLog("Get AllFrames Api Calling...");
    int newItemType = await getItemTypeCode(itemType);
    final queryParameters = {
      ApiParams.itemType: newItemType.toString(),
      ApiParams.itemId: itemId,
      ApiParams.directWear: directWear.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get executePurchaseItem  URI query $query.");
    final uri = Uri.parse(Api.executePurchaseItem + query);
    Utils.showLog("Get executePurchaseItem  URI $uri.");

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: userId,
    };
    Utils.showLog("Get executePurchaseItem  URI $headers.");

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get executePurchaseItem Api Response => ${response.body}");
        Utils.showToast(text: Fetchpurchasedtheme.fromJson(jsonResponse).message ?? "", textColor: AppColor.white);
        FetchUserCoin.init();

        Future.delayed(
          Duration(milliseconds: 500),
          () => Get.back(),
        );
        return Fetchpurchasedtheme.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get executePurchaseItem Api StateCode Error");
        Utils.showLog("Get executePurchaseItem Api StateCode ${response.body}");
      }
    } catch (error) {
      Utils.showLog("Get executePurchaseItem Api Error => $error");
    }
    return null;
  }
}

int getItemTypeCode(String? itemType) {
  switch (itemType?.toLowerCase()) {
    case "theme":
      return 1;
    case "frame":
      return 2;
    case "ride":
      return 3;
    default:
      return 0; // Fallback for unknown types
  }
}
