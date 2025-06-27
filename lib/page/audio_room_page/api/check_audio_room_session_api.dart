import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/audio_room_page/model/check_audio_room_session_model.dart';
import 'package:tingle/page/audio_room_page/model/fetch_audio_room_bloc_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class CheckAudioRoomSessionApi {
  static CheckAudioRoomSessionModel? checkAudioRoomSessionModel;

  static Future<void> callApi({required String token, required String uid}) async {
    checkAudioRoomSessionModel = null;

    Utils.showLog("Check Audio Room Session Api Calling...");

    final uri = Uri.parse(Api.checkAudioSession);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Check Audio Room Session Api Response => ${response.body}");
        checkAudioRoomSessionModel = CheckAudioRoomSessionModel.fromJson(jsonResponse);

        Utils.isShowAudioRoomIcon.value = checkAudioRoomSessionModel?.liveUser?.userId?.trim().isNotEmpty ?? false;
      } else {
        Utils.showLog("Check Audio Room Session Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Check Audio Room Session Api Error => $error");
    }
  }
}
