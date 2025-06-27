import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/go_live_page/api/start_live_steaming_api.dart';
import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/utils.dart';

class GoLiveController extends GetxController {
  CameraController? cameraController;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;

  bool isFlashOn = false;
  String channelId = "";
  int agoraId = 0;

  String? pickImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isPrivate = false;
  int privateCode = 0;

  @override
  void onInit() {
    onRequestPermissions();

    channelId = onGenerateRandomNumber();
    agoraId = 100000 + Random().nextInt(900000);

    privateCode = 1000 + Random().nextInt(9000);

    Utils.showLog("Generate AgoraUid => $agoraId **** ChannelId => $channelId");

    super.onInit();
  }

  @override
  void onClose() {
    onDisposeCamera();
    super.onClose();
  }

  Future<void> onClickGoLive() async {
    onVideoLive();
  }

  Future<void> onVideoLive() async {
    CreateLiveUserModel? createLiveUserModel;

    Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    createLiveUserModel = await StartLiveSteamingApi.callApi(
      token: token,
      uid: uid,
      userId: Database.loginUserId,
      liveType: 1,
      channel: channelId,
      agoraUID: agoraId.toString(),
    );

    Get.back(); // Stop Loading...

    if (createLiveUserModel?.data?.liveHistoryId != null) {
      Utils.showLog("Live User Room Id => ${createLiveUserModel?.data?.liveHistoryId}");

      Get.offAndToNamed(
        AppRoutes.livePage,
        arguments: {
          ApiParams.isHost: true,
          ApiParams.host2Uid: 0,
          ApiParams.isChannelMediaRelay: false,

          ApiParams.liveUserList: LiveUserList(
            isFollow: false,
            liveType: createLiveUserModel?.data?.liveType ?? 0,

            // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<

            token: createLiveUserModel?.data?.token ?? "",
            channel: channelId,
            agoraUid: createLiveUserModel?.data?.agoraUid ?? 0,
            liveHistoryId: createLiveUserModel?.data?.liveHistoryId ?? "",
            id: createLiveUserModel?.data?.id ?? "",

            // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<

            userId: Database.fetchLoginUserProfile()?.user?.id ?? "",
            name: Database.fetchLoginUserProfile()?.user?.name ?? "",
            userName: Database.fetchLoginUserProfile()?.user?.userName ?? "",
            uniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
            isProfilePicBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
            wealthLevelImage: Database.fetchLoginUserProfile()?.user?.wealthLevel?.levelImage ?? "",
            coin: Database.fetchLoginUserProfile()?.user?.coin ?? 0,

            // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<

            host2Id: "",
            host2Name: "",
            host2userName: "",
            host2UniqueId: "",
            host2Image: "",
            host2IsProfilePicBanned: false,
            host2wealthLevelImage: "",
            host2Coin: 0,

            // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<

            host2Channel: "",
            host2LiveId: "",
            host2Token: "",
            host2IsFollow: false,
          ),
          // ApiParams.liveModel: LiveModel(
          //   isHost: true,
          //   isFollow: false,
          //   liveType: 1,
          //   isChannelMediaRelay: false,
          //
          //   // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
          //
          //   host1Token: createLiveUserModel?.data?.token ?? "",
          //   host1Channel: channelId,
          //   host1Uid: createLiveUserModel?.data?.agoraUid ?? 0,
          //   host1LiveHistoryId: createLiveUserModel?.data?.liveHistoryId ?? "",
          //
          //   // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<
          //
          //   host1UserId: Database.fetchLoginUserProfile()?.user?.id ?? "",
          //   host1Name: Database.fetchLoginUserProfile()?.user?.name ?? "",
          //   host1UserName: Database.fetchLoginUserProfile()?.user?.userName ?? "",
          //   host1UniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
          //   host1Image: Database.fetchLoginUserProfile()?.user?.image ?? "",
          //   host1ProfilePicIsBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
          //   host1WealthLevelImage: "",
          //   host1Coin: Database.fetchLoginUserProfile()?.user?.coin ?? 0,
          //
          //   // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
          //   host2UserId: "",
          //   host2Name: "",
          //   host2UserName: "",
          //   host2UniqueId: "",
          //   host2Image: "",
          //   host2ProfilePicIsBanned: false,
          //   host2WealthLevelImage: "",
          //   host2Coin: 0,
          //
          //   // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
          //
          //   host2Uid: 0,
          //   host2Token: "",
          //   host2Channel: "",
          //   host2LiveHistoryId: "",
          // ),
        },
      );
    }
  }

  //************************************************************************************************************************
  Future<void> onRequestPermissions() async {
    AppPermission.onGetCameraPermission(
      onGranted: () {
        AppPermission.onGetMicrophonePermission(
          onGranted: () {
            onInitializeCamera();
          },
        );
      },
    );
  }

  Future<void> onInitializeCamera() async {
    try {
      final cameras = await availableCameras();
      final camera = cameras.last;
      cameraController = CameraController(camera, ResolutionPreset.medium);
      await cameraController?.initialize();
      update([AppConstant.onInitializeCamera]);
    } catch (e) {
      Utils.showLog("Error initializing camera: $e");
    }
  }

  Future<void> onDisposeCamera() async {
    cameraController?.dispose();
    cameraController = null;
    Utils.showLog("Camera Controller Dispose Success");
  }

  Future<void> onSwitchFlash() async {
    if (cameraLensDirection == CameraLensDirection.back) {
      if (isFlashOn) {
        isFlashOn = false;
        await cameraController?.setFlashMode(FlashMode.off);
      } else {
        isFlashOn = true;
        await cameraController?.setFlashMode(FlashMode.torch);
      }
      update([AppConstant.onSwitchFlash]);
    }
  }

  Future<void> onSwitchCamera() async {
    Utils.showLog("Switch Normal Camera Method Calling....");

    Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...
    if (isFlashOn) {
      onSwitchFlash();
    }

    cameraLensDirection = cameraLensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
    final cameras = await availableCameras();
    final camera = cameras.firstWhere((camera) => camera.lensDirection == cameraLensDirection);
    cameraController = CameraController(camera, ResolutionPreset.high);
    await cameraController?.initialize();
    Get.back(); // Stop Loading...
    update([AppConstant.onInitializeCamera]);
  }

  String onGenerateRandomNumber() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(
      25,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }
}
