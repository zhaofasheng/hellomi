// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
// import 'package:tingle/utils/api.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/utils.dart';
//
// class StartLiveSteamingApi {
//   static Future<CreateLiveUserModel?> callApi({
//     required String token,
//     required String uid,
//     required String userId,
//     required String liveType,
//     required String channel,
//     required String agoraUID,
//   }) async {
//     Utils.showLog("Start Live Streaming Api Calling...");
//
//     final queryParameters = {
//       ApiParams.userId: userId,
//       ApiParams.liveType: liveType,
//       ApiParams.channel: channel,
//       ApiParams.agoraUID: agoraUID,
//     };
//
//     String query = Uri(queryParameters: queryParameters).query;
//
//     final uri = Uri.parse(Api.startLiveStream + query);
//
//     final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};
//
//     try {
//       final response = await http.post(uri, headers: headers);
//
//       if (response.statusCode == 200) {
//         Utils.showLog("Start Live Streaming Api Response => ${response.body}");
//
//         final jsonResponse = json.decode(response.body);
//
//         return CreateLiveUserModel.fromJson(jsonResponse);
//       } else {
//         Utils.showLog("Start Live Streaming Api StateCode Error");
//       }
//     } catch (error) {
//       Utils.showLog("Start Live Streaming Api Error => $error");
//     }
//     return null;
//   }
// }
