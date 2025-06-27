import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tingle/page/fill_profile_page/model/edit_profile_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class EditProfileApi {
  static Future<EditProfileModel?> callApi({
    required String name,
    required String uid,
    required String token,
    required String userName,
    required String age,
    required String gender,
    required String country,
    required String countryFlagImage,
    required String bio,
    String? image,
  }) async {
    Utils.showLog("Edit Profile Api Calling...$image");

    try {
      final headers = {ApiParams.key: Api.secretKey, ApiParams.tokenKey: ApiParams.tokenStartPoint + token, ApiParams.uidKey: uid};

      var request = http.MultipartRequest('PATCH', Uri.parse(Api.editProfile));

      request.fields.addAll({
        ApiParams.name: name,
        ApiParams.userName: userName,
        ApiParams.age: age,
        ApiParams.gender: gender,
        ApiParams.country: country,
        ApiParams.countryFlagImage: countryFlagImage,
        ApiParams.bio: bio,
      });

      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(ApiParams.image, image));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResult = jsonDecode(responseBody);
        Utils.showLog("Edit Profile Api Response => $jsonResult");
        return EditProfileModel.fromJson(jsonResult);
      } else {
        Utils.showLog("Edit Profile Api Response Error");
        return null;
      }
    } catch (e) {
      Utils.showLog("Edit Profile Api Error => $e");
      return null;
    }
  }
}
