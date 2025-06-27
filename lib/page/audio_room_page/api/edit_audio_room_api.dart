import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class EditAudioRoomApi {
  static Future<CreateLiveUserModel?> callApi({
    required String uid,
    required String token,
    required String roomName,
    required String roomWelcome,
    required String liveHistoryId,
    required String roomImage,
    required String privateCode,
  }) async {
    Utils.showLog("Edit Audio Room Api Calling...");

    try {
      final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

      var request = http.MultipartRequest('PATCH', Uri.parse(Api.editAudioRoom));

      request.fields.addAll({
        ApiParams.roomName: roomName,
        ApiParams.roomWelcome: roomWelcome,
        ApiParams.liveHistoryId: liveHistoryId,
      });

      if (privateCode.trim().isNotEmpty) {
        request.fields.addAll({ApiParams.privateCode: privateCode});
      }

      if (roomImage.trim() != "") {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.roomImage, roomImage));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);

        Utils.showLog("Edit Audio Room Api Response => $responseBody");

        return CreateLiveUserModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Edit Audio Room Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Edit Audio Room Api Error => $e");
      return null;
    }
  }
}
