import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/status_and_message_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class DeletePostApi {
  static StatusAndMessageModel? statusAndMessageModel;
  static Future<void> callApi({
    required String token,
    required String uid,
    required String postId,
  }) async {
    Utils.showLog("Delete Post Api Calling... ");

    final queryParameters = {ApiParams.postId: postId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.deletePost + query);

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,
    };

    try {
      var response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        Utils.showLog("Delete Post Api Response => ${response.body}");

        statusAndMessageModel = StatusAndMessageModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Delete Post Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Delete Post Api Error => $error");
    }
  }
}
