import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/edit_post_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class EditPostApi {
  static Future<EditPostModel?> callApi({
    required String token,
    required String uid,
    required String postId,
    required String caption,
    required String hashTagId,
  }) async {
    try {
      Utils.showLog("Edit Post Api Calling...");

      final queryParameters = {ApiParams.postId: postId};

      String query = Uri(queryParameters: queryParameters).query;

      final uri = Uri.parse(Api.editPost + query);

      final headers = {
        ApiParams.key: Api.secretKey,
        ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
        ApiParams.uidKey: uid,
        ApiParams.contentType: ApiParams.applicationJson,
      };

      final body = json.encode({
        ApiParams.caption: caption,
        ApiParams.hashTagId: hashTagId,
      });

      Utils.showLog("Edit Post Api Uri => $uri");

      Utils.showLog("Edit Post Api Body => $body");

      final response = await http.patch(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Edit Post Api Response => ${response.body}");
        return EditPostModel.fromJson(jsonResponse);
      }
    } catch (e) {
      Utils.showLog("Edit Post Api Error => $e");
      return null;
    }
    return null;
  }
}
