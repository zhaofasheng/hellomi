import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/audio_wise_videos_page/model/fetch_audio_room_join_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchAudioRoomJoinUserApi {
  static Future<FetchAudioRoomJoinUserModel?> callApi({
    required String token,
    required String uid,
    required String liveHistoryId,
  }) async {
    Utils.showLog("Fetch Audio Room Join User Api Calling...");

    final queryParameters = {ApiParams.liveHistoryId: liveHistoryId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchAudioRoomJoinUser + query);

    Utils.showLog("Fetch Audio Room Join User Api Url => $uri");

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch Audio Room Join User Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        return FetchAudioRoomJoinUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Audio Room Join User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Audio Room Join User Api Error => $error");
    }
    return null;
  }
}
