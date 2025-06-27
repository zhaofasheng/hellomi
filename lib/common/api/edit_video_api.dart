import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/common/model/edit_video_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class EditVideoApi {
  static Future<EditVideoModel?> callApi({
    required String token,
    required String uid,
    required String videoId,
    required String caption,
    required String hashTagId,
    String? videoImage,
  }) async {
    try {
      Utils.showLog("Edit Video Api Calling...");

      final queryParameters = {ApiParams.videoId: videoId};

      String query = Uri(queryParameters: queryParameters).query;

      final uri = Uri.parse(Api.editVideo + query);

      final headers = {
        ApiParams.key: Api.secretKey,
        ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
        ApiParams.uidKey: uid,
        ApiParams.contentType: ApiParams.multipartFormData,
      };

      var request = http.MultipartRequest('PATCH', uri);

      request.fields.addAll({
        ApiParams.caption: caption,
        ApiParams.hashTagId: hashTagId,
      });

      if (videoImage != null) {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.videoImage, videoImage));
      }

      request.headers.addAll(headers);

      Utils.showLog("Edit Video Api Request URI => $uri");
      Utils.showLog("Edit Video Api Request Body => ${request.fields}");

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      Utils.showLog("Edit Video Api Response => $responseBody");
      Utils.showLog("Edit Video Api Status Code => ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(responseBody);

        return EditVideoModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Edit Video Api Status Code Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Utils.showLog("Edit Video Api Error => $e");
      return null;
    }
  }
}
