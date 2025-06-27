import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_banner_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchBannerApi {
  static Future<FetchBannerModel?> callApi({
    required String uid,
    required String token,
    required int bannerType,
  }) async {
    Utils.showLog("Fetch Banner Api Calling... ");

    final queryParameters = {ApiParams.bannerType: bannerType.toString()};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchBanner + query);

    Utils.showLog("Fetch Banner Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      var response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Banner Api Response => ${response.body}");

        return FetchBannerModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Banner Api StateCode Error => $response");
      }
    } catch (error) {
      Utils.showLog("Fetch Banner Api Error => $error");
    }
    return null;
  }
}
