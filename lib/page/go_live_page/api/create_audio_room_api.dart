import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class CreateAudioRoomApi {
  static Future<CreateLiveUserModel?> callApi({
    required String token,
    required String uid,
    required String channel,
    required int liveType,
    required int agoraUID,
    required int audioLiveType,
    required String privateCode,
    required String roomName,
    required String roomWelcome,
    required String roomImage,
    required String bgTheme,
  }) async {
    Utils.showLog("Create Audio Room Api Calling...");

    final uri = Uri.parse(Api.createAudioRoom);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    Utils.showLog("Create Audio Room Api Url => $uri");

    try {
      final request = http.MultipartRequest('POST', uri);

      request.fields.addAll({
        ApiParams.liveType: liveType.toString(),
        ApiParams.channel: channel,
        ApiParams.agoraUID: agoraUID.toString(),
        ApiParams.audioLiveType: audioLiveType.toString(),
        ApiParams.roomName: roomName,
        ApiParams.roomWelcome: roomWelcome,
        ApiParams.privateCode: privateCode,
        ApiParams.bgTheme: bgTheme,
      });

      if (roomImage.trim().isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.roomImage, roomImage));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      Utils.showLog("Create Audio Room Api StateCode => ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseBody);

        Utils.showLog("Create Audio Room Api Response => $responseBody");

        return CreateLiveUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Create Audio Room Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Create Audio Room Api Error => $error");
    }
    return null;
  }
}
