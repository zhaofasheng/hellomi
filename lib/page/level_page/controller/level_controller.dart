import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/level_page/api/fetch_level_api.dart';
import 'package:tingle/page/level_page/model/fetch_level_model.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class LevelController extends GetxController {
  bool isLoading = false;
  List<LevelData> levelList = [];
  FetchLevelModel? fetchLevelModel;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    onGetLevel();
  }

  Future<void> onGetLevel() async {
    isLoading = true;
    update([AppConstant.onGetLevel]);

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    fetchLevelModel = await FetchLevelApi.callApi(token: token, uid: uid);

    levelList = fetchLevelModel?.data ?? [];

    isLoading = false;
    update([AppConstant.onGetLevel]);

    Utils.onChangeStatusBar(brightness: Brightness.light, delay: 200);
  }
}
