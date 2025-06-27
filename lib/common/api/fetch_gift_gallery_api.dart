import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_gift_gallery_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchGiftGalleryApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchGiftGalleryModel?> callApi({required String uid, required String token, required String userId}) async {
    Utils.showLog("Fetch Gift Gallery Api Calling... ");

    startPagination += 1;

    final queryParameters = {
      ApiParams.userId: userId,
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchOtherUserGiftGallery + query);

    Utils.showLog("Fetch Gift Gallery Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Gift Gallery Api Response => ${response.body}");

        return FetchGiftGalleryModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Gift Gallery Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Gift Gallery Api Error => $error");
    }
    return null;
  }
}
