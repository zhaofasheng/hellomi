import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/store_page/model/all_store_item_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchAllFramesApi {
  static int startPagination = 1;
  static int limitPagination = 20;
  static Future<AllStoreItemModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Get AllFrames Api Calling...");
    final queryParameters = {
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };
    String query = Uri(queryParameters: queryParameters).query;
    Utils.showLog("Get AllFrames  URI $query.");
    final uri = Uri.parse(Api.fetchListStoreItems + query);

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Get AllFrames Api Response => ${response.body}");

        return AllStoreItemModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Get AllFrames Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Get AllFrames Api Error => $error");
    }
    return null;
  }
}
