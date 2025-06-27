import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/help_page/model/help_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class HelpApi {
  static Future<HelpModel?> callApi({
    required String token,
    required String uid,
    required String complaint,
    required String contact,
    String? image,
  }) async {
    Utils.showLog("Help Api Calling...");

    try {
      final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

      var request = http.MultipartRequest('POST', Uri.parse(Api.help));
      request.fields.addAll({
        ApiParams.help: complaint,
        ApiParams.contact: contact,
      });

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.image, image));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);
        Utils.showLog("Help Api Response => $jsonResult");
        return HelpModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Help Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Help Api Error => $e");
      return null;
    }
  }
}
