import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/profile_page/api/fetch_user_profile_api.dart';
import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class ProfileController extends GetxController with GetTickerProviderStateMixin {
  final bottomBarController = Get.find<BottomBarController>();

  FetchUserProfileModel? fetchUserProfileModel;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  ReceivePort? _receivePort;
  Isolate? _isolate;

  @override
  void onInit() {
    Utils.showLog("Profile Controller Init Success");
    onGetProfile();
    super.onInit();
  }

  Future<void> init() async {
    if (Get.currentRoute == AppRoutes.bottomBarPage && bottomBarController.selectedTabIndex == 4) {
      await onGetProfile();
    }
  }

  Future<void> onGetProfile() async {
    try {
      isLoading = true;
      update([AppConstant.onGetProfile]);

      final uid = FirebaseUid.onGet() ?? "";
      final token = await FirebaseAccessToken.onGet() ?? "";

      if (uid.isNotEmpty && token.isNotEmpty) {
        _receivePort = ReceivePort();

        _isolate = await Isolate.spawn(
          onGetProfileIsolate,
          FetchProfileArgumentModel(sendPort: _receivePort?.sendPort ?? ReceivePort().sendPort, token: token, uid: uid),
        );

        _receivePort?.listen(
          (message) {
            if (message is FetchUserProfileModel) {
              fetchUserProfileModel = message;
              // Utils.showLog("Fetch Profile Success => ${fetchUserProfileModel?.toJson()}");
            } else if (message is String) {
              Utils.showLog(message);
            }

            isLoading = false;
            update([AppConstant.onGetProfile]);
            onClearIsolate();
          },
        );
      }
    } catch (e) {
      Utils.showLog("Fetch Profile Method Call Failed !!");

      isLoading = false;
      update([AppConstant.onGetProfile]);
    }
  }

  void onClearIsolate() {
    _receivePort?.close();
    _isolate?.kill();
    _receivePort = null;
    _isolate = null;
  }
}

// ***************************************************** ISOLATE METHOD *****************************************************

// THIS IS ISOLATE METHOD USING CALL API IN BACKGROUND...
@pragma('vm:entry-point')
Future<void> onGetProfileIsolate(FetchProfileArgumentModel argument) async {
  try {
    final profile = await FetchUserProfileApi.callApi(
      token: argument.token,
      uid: argument.uid,
    );

    if (profile != null) {
      argument.sendPort.send(profile);
    } else {
      argument.sendPort.send("Fetch Profile SendPort Error !!");
    }
  } catch (e) {
    argument.sendPort.send("Fetch Profile Failed => $e");
  }
}

class FetchProfileArgumentModel {
  final String token;
  final String uid;
  final SendPort sendPort;

  FetchProfileArgumentModel({
    required this.token,
    required this.uid,
    required this.sendPort,
  });
}
