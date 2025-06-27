import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/audio_wise_videos_page/model/fetch_audio_wise_videos_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchAudioWiseVideosApi {
  static int startPagination = 0;
  static int limitPagination = 20;

  static Future<FetchAudioWiseVideosModel?> callApi({
    required String token,
    required String uid,
    required String songId,
  }) async {
    Utils.showLog("Fetch Audio Wise Videos Api Calling...");
    startPagination += 1;

    final queryParameters = {
      ApiParams.songId: songId,
      ApiParams.start: startPagination.toString(),
      ApiParams.limit: limitPagination.toString(),
    };

    String query = Uri(queryParameters: queryParameters).query;

    final uri = Uri.parse(Api.fetchSongWiseVideo + query);

    final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        Utils.showLog("Fetch Audio Wise Videos Api Response => ${response.body}");

        return FetchAudioWiseVideosModel.fromJson(jsonResponse);
      } else {
        Utils.showLog("Fetch Audio Wise Videos Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch Audio Wise Videos Api Error => $error");
    }
    return null;
  }
}
