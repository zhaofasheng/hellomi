import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/block_user_page/model/block_unblock_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class BlockUnblockUserApi {
  static BlockUnblockUserModel? blockUnblockUserModel;

  static Future<void> callApi({required String token, required String uid, required String toUserId}) async {
    Utils.showLog("Block Unblock User Model Calling...");

    final queryParameters = {ApiParams.toUserId: toUserId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.blockUnblockUser + query);

    Utils.showLog("Block Unblock User Model Uri => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        Utils.showLog("Block Unblock User Model Response => ${response.body}");

        blockUnblockUserModel = BlockUnblockUserModel.fromJson(jsonDecode(response.body));
      } else {
        Utils.showLog("Block Unblock User Model StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Block Unblock User Model Error => $error");
    }
  }
}
