import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_category_wise_gift_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchCategoryWiseGiftApi {
  static Map<String, List<CategoryWiseGift?>> categoryWiseGift = {};

  static Future<FetchCategoryWiseGiftModel?> callApi({
    required String token,
    required String uid,
    required String giftCategoryId,
  }) async {
    Utils.showLog("Fetch Gift Api Calling...");

    final queryParameters = {ApiParams.giftCategoryId: giftCategoryId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchGift + query);

    Utils.showLog("Fetch Gift Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    Utils.showLog("Fetch Gift Api Header => $headers");

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Gift Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchCategoryWiseGiftModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Gift Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Gift Api Error => $error");
    }
    return null;
  }
}
