import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tingle/page/recharge_coin_page/model/fetch_coin_plan_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

import '../../../common/api_service.dart';

class FetchCoinPlanApi {
  static Future<FetchCoinPlanModel?> callApi({required String token, required String uid}) async {
    Utils.showLog("Fetch Coin Plan Api Calling...");

    final url = Api.fetchCoinPlan;
    Utils.showLog("Fetch Coin Plan Api Url => $url");

    try {
      // 注意：headers 会自动由 ApiService 拦截器添加
      final response = await ApiService().get(
        url,
        queryParameters:{
          'platform':Platform.isIOS ? 'ios':'android',
        },
      );

      if (response?.statusCode == 200) {
        final jsonResponse = response?.data;

        Utils.showLog("Fetch Coin Plan Api Response => ${response?.data}");

        return FetchCoinPlanModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Coin Plan Api StatusCode Error => ${response?.statusCode}");
      }
    } catch (error) {
      Utils.showLog("Fetch Coin Plan Api Error => $error");
    }

    return null;
  }
}
