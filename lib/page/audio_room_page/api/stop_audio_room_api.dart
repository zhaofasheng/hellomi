import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/audio_room_page/model/stop_audio_room_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class StopAudioRoomApi {
  static StopAudioRoomModel? stopAudioRoomModel;
  static Future<void> callApi({required String token, required String uid}) async {
    Utils.showLog("Stop Audio Room Api Calling... ");

    final uri = Uri.parse(Api.stopAudioRoomSession);

    final headers = {
      ApiParams.key: Api.secretKey,
      ApiParams.tokenKey: ApiParams.tokenStartPoint + token,
      ApiParams.uidKey: uid,
    };

    try {
      var response = await http.delete(uri, headers: headers);

      Utils.showLog("Stop Audio Room Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        stopAudioRoomModel = StopAudioRoomModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Stop Audio Room Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Stop Audio Room Api Error => $error");
    }
  }
}
