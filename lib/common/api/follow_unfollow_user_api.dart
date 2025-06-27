import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/follow_unfollow_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FollowUnfollowUserApi {
  static Future<FollowUnfollowUserModel?> callApi({required String token, required String uid, required String toUserId}) async {
    Utils.showLog("Follow UnFollow User Api Calling...");

    final queryParameters = {ApiParams.toUserId: toUserId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.followUnfollow + query);

    Utils.showLog("Follow UnFollow User Api Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Follow UnFollow User Api Response => ${response.body}");

        return FollowUnfollowUserModel.fromJson(jsonDecode(response.body));
      } else {
        Utils.showLog("Follow UnFollow User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Follow UnFollow User Api Error => $error");
    }
    return null;
  }
}
