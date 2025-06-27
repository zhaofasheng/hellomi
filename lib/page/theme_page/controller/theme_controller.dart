import 'dart:developer';

import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/store_page/api/top_frame_api.dart';
import 'package:tingle/page/store_page/model/top_frame_model.dart';
import 'package:tingle/utils/api_params.dart';

class ThemeController extends GetxController {
  TopFramesModel? topFramesModel;

  bool isLoading = false;
  @override
  void onInit() {
    log("STORE COME ");
    init();
    super.onInit();
  }

  init() async {
    isLoading = true;

    log("STORE COME ");
    final token = await FirebaseAccessToken.onGet() ?? "";
    final uid = await FirebaseUid.onGet() ?? "";
    topFramesModel = await FetchTopFramesApi.callApi(token: token, uid: uid);
    isLoading = false;
    update([ApiParams.themeStore]);
  }
}
