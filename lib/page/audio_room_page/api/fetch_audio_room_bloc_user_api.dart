import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/page/audio_room_page/model/fetch_audio_room_bloc_user_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchAudioRoomBlocUserApi {
  static FetchAudioRoomBlocUserModel? fetchAudioRoomBlocUserModel;
  static Future<void> callApi({
    required String token,
    required String uid,
    required String liveHistoryId,
  }) async {
    fetchAudioRoomBlocUserModel = null;

    Utils.showLog("Fetch Audio Room Bloc User Api Calling...");

    final queryParameters = {ApiParams.liveHistoryId: liveHistoryId};

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchAudioRoomBlocUserList + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Audio Room Bloc User Api Response => ${response.body}");

        fetchAudioRoomBlocUserModel = FetchAudioRoomBlocUserModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Audio Room Bloc User Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Audio Room Bloc User Api Error => $error");
    }
  }
}
