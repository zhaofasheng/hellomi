import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tingle/common/model/fetch_user_profile_images_model.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/utils.dart';

class FetchUserProfileImagesApi {
  static FetchUserProfileImagesModel? fetchUserProfileImagesModel;

  static List images = [];
  static Future<void> callApi() async {
    Utils.showLog("Fetch User Profile Images Api Calling...");

    final uri = Uri.parse(Api.fetchUserProfileImages);

    Utils.showLog("Fetch User Profile Images Api Response => $uri");

    final headers = {ApiParams.key: Api.secretKey};

    try {
      final response = await http.get(uri, headers: headers);

      Utils.showLog("Fetch User Profile Images Api Response => ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        fetchUserProfileImagesModel = FetchUserProfileImagesModel.fromJson(jsonResponse);

        images = fetchUserProfileImagesModel?.data ?? [];

        await Utils.onGetRandomFakeImage();
      } else {
        Utils.showLog("Fetch User Profile Images Api StateCode Error");
      }
    } catch (error) {
      Utils.showLog("Fetch User Profile Images Api Error => $error");
    }
  }
}
