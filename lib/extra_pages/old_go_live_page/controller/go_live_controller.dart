// import 'dart:math';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tingle/common/widget/loading_widget.dart';
// import 'package:tingle/custom/function/custom_image_picker.dart';
// import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
// import 'package:tingle/page/extra_pages/old_go_live_page/widget/camera_widget.dart';
// import 'package:tingle/page/extra_pages/old_go_live_page/widget/create_audio_room_widget.dart';
// import 'package:tingle/page/go_live_page/api/create_audio_room_api.dart';
// import 'package:tingle/page/go_live_page/api/start_live_steaming_api.dart';
// import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
// import 'package:tingle/page/live_page/model/live_model.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/database.dart';
// import 'package:tingle/utils/permission.dart';
// import 'package:tingle/utils/utils.dart';
//
// class GoLiveController extends GetxController {
//   CameraController? cameraController;
//   CameraLensDirection cameraLensDirection = CameraLensDirection.front;
//
//   bool isFlashOn = false;
//   String channelId = "";
//   int agoraId = 0;
//
//   int selectedLiveType = 0;
//
//   List<Widget> pages = [
//     CameraWidget(),
//     CreateAudioRoomWidget(),
//     CameraWidget(),
//   ];
//
//   String? pickImage;
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//
//   bool isPrivate = false;
//   int privateCode = 0;
//
//   @override
//   void onInit() {
//     onRequestPermissions();
//
//     channelId = onGenerateRandomNumber();
//     agoraId = 100000 + Random().nextInt(900000);
//     privateCode = 1000 + Random().nextInt(9000);
//
//     Utils.showLog("Generate AgoraUid => $agoraId **** ChannelId => $channelId");
//
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     onDisposeCamera();
//     super.onClose();
//   }
//
//   Future<void> onChangeLiveType(int value) async {
//     selectedLiveType = value;
//     update([AppConstant.onChangeLiveType]);
//   }
//
//   Future<void> onClickGoLive() async {
//     if (selectedLiveType == 1) {
//       onAudioLive();
//     } else {
//       onVideoLive();
//     }
//   }
//
//   void onChangeRoomType(bool value) {
//     isPrivate = value;
//     update(["onChangeRoomType"]);
//   }
//
//   Future<void> onPickImage(BuildContext context) async {
//     await CustomImagePickerBottomSheetWidget.show(
//       context: context,
//       onClickCamera: () async {
//         final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
//
//         if (imagePath != null) {
//           pickImage = imagePath;
//           update(["onPickImage"]);
//         }
//       },
//       onClickGallery: () async {
//         final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
//         if (imagePath != null) {
//           pickImage = imagePath;
//           update(["onPickImage"]);
//         }
//       },
//     );
//   }
//
//   Future<void> onAudioLive() async {
//     CreateLiveUserModel? createLiveUserModel;
//
//     if (pickImage == null) {
//       Utils.showToast(text: "Please select room image");
//     } else if (nameController.text.trim().isEmpty) {
//       Utils.showToast(text: "Please enter room name");
//     } else {
//       Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...
//
//       final uid = FirebaseUid.onGet() ?? "";
//       final token = await FirebaseAccessToken.onGet() ?? "";
//
//       createLiveUserModel = await CreateAudioRoomApi.callApi(
//         token: token,
//         uid: uid,
//         channel: channelId,
//         liveType: 2, // Audio Live
//         agoraUID: agoraId,
//         audioLiveType: isPrivate ? 1 : 2,
//         privateCode: isPrivate ? privateCode : 0,
//         roomName: nameController.text.trim(),
//         roomWelcome: descriptionController.text.trim(),
//         roomImage: pickImage ?? "",
//         bgTheme: Database.fetchLoginUserProfile()?.user?.activeTheme?.image ?? "",
//       );
//
//       Get.back(); // Stop Loading...
//
//       if (createLiveUserModel?.data?.liveHistoryId != null) {
//         Utils.showLog("Live User Room Id => ${createLiveUserModel?.data?.liveHistoryId}");
//         Get.offAndToNamed(
//           AppRoutes.audioRoomPage,
//           arguments: AudioRoomModel(
//             isHost: true,
//             hostUserId: createLiveUserModel?.data?.userId?.value?.activeTheme?.id ?? "",
//             hostUid: createLiveUserModel?.data?.agoraUid ?? 0,
//             hostIsMuted: false,
//             liveHistoryId: createLiveUserModel?.data?.liveHistoryId ?? "",
//             liveUserObjId: createLiveUserModel?.data?.id ?? "",
//             roomName: createLiveUserModel?.data?.roomName ?? "",
//             roomImage: createLiveUserModel?.data?.roomImage ?? "",
//             roomWelcome: createLiveUserModel?.data?.roomWelcome ?? "",
//             token: createLiveUserModel?.data?.token ?? "",
//             channel: createLiveUserModel?.data?.channel ?? "",
//             userUid: 0,
//             mute: 0,
//             audioLiveType: createLiveUserModel?.data?.audioLiveType ?? 0,
//             audioRoomPrivateCode: createLiveUserModel?.data?.privateCode ?? 0,
//             audioRoomSeats: createLiveUserModel?.data?.seat ?? [],
//             isFollow: false,
//             bgTheme: createLiveUserModel?.data?.bgTheme ?? "",
//           ),
//         );
//       }
//     }
//   }
//
//   Future<void> onVideoLive() async {
//     CreateLiveUserModel? createLiveUserModel;
//
//     Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...
//
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//
//     createLiveUserModel = await StartLiveSteamingApi.callApi(
//       token: token,
//       uid: uid,
//       userId: Database.loginUserId,
//       liveType: 1,
//       channel: channelId,
//       agoraUID: agoraId.toString(),
//     );
//
//     Get.back(); // Stop Loading...
//
//     if (createLiveUserModel?.data?.liveHistoryId != null) {
//       Utils.showLog("Live User Room Id => ${createLiveUserModel?.data?.liveHistoryId}");
//
//       Get.offAndToNamed(
//         AppRoutes.livePage,
//         arguments: LiveModel(
//           isHost: true,
//           isFollow: false,
//           liveType: selectedLiveType,
//           isChannelMediaRelay: false,
//
//           // >>>>>>>>>> HOST_1_AGORA_INFO <<<<<<<<<<
//
//           host1Token: createLiveUserModel?.data?.token ?? "",
//           host1Channel: channelId,
//           host1Uid: createLiveUserModel?.data?.agoraUid ?? 0,
//           host1LiveHistoryId: createLiveUserModel?.data?.liveHistoryId ?? "",
//
//           // >>>>>>>>>> HOST_1_USER_INFO <<<<<<<<<<
//
//           host1UserId: Database.fetchLoginUserProfile()?.user?.id ?? "",
//           host1Name: Database.fetchLoginUserProfile()?.user?.name ?? "",
//           host1UserName: Database.fetchLoginUserProfile()?.user?.userName ?? "",
//           host1UniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
//           host1Image: Database.fetchLoginUserProfile()?.user?.image ?? "",
//           host1ProfilePicIsBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned ?? false,
//           host1WealthLevelImage: "",
//           host1Coin: Database.fetchLoginUserProfile()?.user?.coin ?? 0,
//
//           // >>>>>>>>>> HOST_2_USER_INFO <<<<<<<<<<
//           host2UserId: "",
//           host2Name: "",
//           host2UserName: "",
//           host2UniqueId: "",
//           host2Image: "",
//           host2ProfilePicIsBanned: false,
//           host2WealthLevelImage: "",
//           host2Coin: 0,
//
//           // >>>>>>>>>> HOST_2_AGORA_INFO <<<<<<<<<<
//
//           host2Uid: 0,
//           host2Token: "",
//           host2Channel: "",
//           host2LiveHistoryId: "",
//         ),
//       );
//     }
//   }
//
//   //************************************************************************************************************************
//   Future<void> onRequestPermissions() async {
//     AppPermission.onGetCameraPermission(
//       onGranted: () {
//         AppPermission.onGetMicrophonePermission(
//           onGranted: () {
//             onInitializeCamera();
//           },
//         );
//       },
//     );
//   }
//
//   Future<void> onInitializeCamera() async {
//     try {
//       final cameras = await availableCameras();
//       final camera = cameras.last;
//       cameraController = CameraController(camera, ResolutionPreset.medium);
//       await cameraController?.initialize();
//       update([AppConstant.onInitializeCamera]);
//     } catch (e) {
//       Utils.showLog("Error initializing camera: $e");
//     }
//   }
//
//   Future<void> onDisposeCamera() async {
//     cameraController?.dispose();
//     cameraController = null;
//     Utils.showLog("Camera Controller Dispose Success");
//   }
//
//   Future<void> onSwitchFlash() async {
//     if (cameraLensDirection == CameraLensDirection.back) {
//       if (isFlashOn) {
//         isFlashOn = false;
//         await cameraController?.setFlashMode(FlashMode.off);
//       } else {
//         isFlashOn = true;
//         await cameraController?.setFlashMode(FlashMode.torch);
//       }
//       update([AppConstant.onSwitchFlash]);
//     }
//   }
//
//   Future<void> onSwitchCamera() async {
//     Utils.showLog("Switch Normal Camera Method Calling....");
//
//     Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...
//     if (isFlashOn) {
//       onSwitchFlash();
//     }
//
//     cameraLensDirection = cameraLensDirection == CameraLensDirection.back ? CameraLensDirection.front : CameraLensDirection.back;
//     final cameras = await availableCameras();
//     final camera = cameras.firstWhere((camera) => camera.lensDirection == cameraLensDirection);
//     cameraController = CameraController(camera, ResolutionPreset.high);
//     await cameraController?.initialize();
//     Get.back(); // Stop Loading...
//     update([AppConstant.onInitializeCamera]);
//   }
//
//   String onGenerateRandomNumber() {
//     const String chars = 'abcdefghijklmnopqrstuvwxyz';
//     Random random = Random();
//     return List.generate(
//       25,
//       (index) => chars[random.nextInt(chars.length)],
//     ).join();
//   }
// }
