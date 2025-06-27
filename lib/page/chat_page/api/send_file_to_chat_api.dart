import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/chat_page/model/send_file_to_chat_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class SendFileToChatApi {
  static Future<SendFileToChatModel?> callApi({
    required String token,
    required String uid,
    required String receiverUserId,
    required int messageType,
    required String filePath,
  }) async {
    Utils.showLog("Send File To Chat Api Calling...");

    try {
      final queryParameters = {
        ApiParams.receiverId: receiverUserId,
        ApiParams.messageType: messageType.toString(),
      };

      String query = Uri(queryParameters: queryParameters).query;

      final uri = Uri.parse(Api.sendFileToChat + query);

      final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

      var request = http.MultipartRequest('POST', uri);

      if (messageType == 2) {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.image, filePath)); // Message Type Image => 2
      } else if (messageType == 4) {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.audio, filePath)); // Message Type Audio => 4
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();

        final jsonResult = jsonDecode(responseBody);

        Utils.showLog("Send File To Chat Api Response => $jsonResult");

        return SendFileToChatModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Send File To Chat Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Send File To Chat Api Error => $e");
      return null;
    }
  }
}
