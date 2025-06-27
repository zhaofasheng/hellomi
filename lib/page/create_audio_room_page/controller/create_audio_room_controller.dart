import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/go_live_page/api/create_audio_room_api.dart';
import 'package:tingle/page/go_live_page/model/create_live_user_model.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class CreateAudioRoomController extends GetxController {
  String channelId = "";
  int agoraId = 0;

  String? pickImage;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPrivate = false;
  // int privateCode = 0;

  @override
  void onInit() {
    channelId = onGenerateRandomNumber();

    agoraId = 100000 + Random().nextInt(900000);

    final privateCode = 100000 + Random().nextInt(900000);

    passwordController.text = privateCode.toString();

    Utils.showLog("Generate AgoraUid => $agoraId **** ChannelId => $channelId");

    super.onInit();
  }

  @override
  void onClose() {
    Utils.showLog("Dispose Create Audio Room Success");
    super.onClose();
  }

  Future<void> onClickGoLive() async {
    onAudioLive();
  }

  void onChangeRoomType(bool value) {
    isPrivate = value;
    update([AppConstant.onChangeRoomType]);
  }

  Future<void> onPickImage(BuildContext context) async {
    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);

        if (imagePath != null) {
          pickImage = imagePath;
          update([AppConstant.onPickImage]);
        }
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (imagePath != null) {
          pickImage = imagePath;
          update([AppConstant.onPickImage]);
        }
      },
    );
  }

  Future<void> onAudioLive() async {
    Utils.showLog("******* $isPrivate");
    CreateLiveUserModel? createLiveUserModel;

    if (pickImage == null) {
      Utils.showToast(text: EnumLocal.txtPleaseSelectRoomImage.name.tr);
    } else if (nameController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseSelectRoomName.name.tr);
    } else if (passwordController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterPassword.name.tr);
    } else {
      Get.dialog(barrierDismissible: false, PopScope(canPop: false, child: const LoadingWidget())); // Start Loading...

      final uid = FirebaseUid.onGet() ?? "";
      final token = await FirebaseAccessToken.onGet() ?? "";

      createLiveUserModel = await CreateAudioRoomApi.callApi(
        token: token,
        uid: uid,
        channel: channelId,
        liveType: 2, // Audio Live
        agoraUID: agoraId,
        audioLiveType: isPrivate ? 1 : 2,
        privateCode: isPrivate ? passwordController.text : "",
        roomName: nameController.text.trim(),
        roomWelcome: descriptionController.text.trim(),
        roomImage: pickImage ?? "",
        bgTheme: Database.fetchLoginUserProfile()?.user?.activeTheme?.image ?? "",
      );

      Get.back(); // Stop Loading...

      if (createLiveUserModel?.data?.liveHistoryId != null) {
        Utils.showLog("Live User Room Id => ${createLiveUserModel?.data?.liveHistoryId}");
        Utils.showLog("Live User Room Type => ${createLiveUserModel?.data?.audioLiveType}");

        Get.offAndToNamed(
          AppRoutes.audioRoomPage,
          arguments: {
            ApiParams.isHost: true,
            ApiParams.userUid: 0,
            ApiParams.liveUserList: LiveUserList(
              userId: createLiveUserModel?.data?.userId ?? "",
              agoraUid: createLiveUserModel?.data?.agoraUid ?? 0,
              liveHistoryId: createLiveUserModel?.data?.liveHistoryId ?? "",
              id: createLiveUserModel?.data?.id ?? "",
              roomName: createLiveUserModel?.data?.roomName ?? "",
              roomImage: createLiveUserModel?.data?.roomImage ?? "",
              roomWelcome: createLiveUserModel?.data?.roomWelcome ?? "",
              privateCode: createLiveUserModel?.data?.privateCode ?? 0,
              token: createLiveUserModel?.data?.token ?? "",
              channel: createLiveUserModel?.data?.channel ?? "",
              audioLiveType: createLiveUserModel?.data?.audioLiveType ?? 0,
              seat: createLiveUserModel?.data?.seat ?? [],
              isFollow: false,
              bgTheme: createLiveUserModel?.data?.bgTheme ?? "",
              uniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
              name: createLiveUserModel?.data?.name ?? "",
            ),
          },
        );
      }
    }
  }

  String onGenerateRandomNumber() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    return List.generate(
      25,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  void onClickCopy() async {
    if (passwordController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterPassword.name.tr);
    } else {
      Clipboard.setData(ClipboardData(text: passwordController.text));
      Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
    }
  }

  void onClickShare() async {
    if (passwordController.text.trim().isEmpty) {
      Utils.showToast(text: EnumLocal.txtPleaseEnterPassword.name.tr);
    } else {
      CommonShare.onShareText(text: passwordController.text);
    }
  }
}

// String onGenerateRandomPassword() {
//   const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
//   Random random = Random();
//   return List.generate(
//     25,
//         (index) => chars[random.nextInt(chars.length)],
//   ).join();
// }

// ApiParams.audioRoomModel: AudioRoomModel(
//   isHost: true,
//   hostUserId: createLiveUserModel?.data?.userId ?? "",
//   hostUid: createLiveUserModel?.data?.agoraUid ?? 0,
//   hostIsMuted: false,
//   liveHistoryId: createLiveUserModel?.data?.liveHistoryId ?? "",
//   liveUserObjId: createLiveUserModel?.data?.id ?? "",
//   roomName: createLiveUserModel?.data?.roomName ?? "",
//   roomImage: createLiveUserModel?.data?.roomImage ?? "",
//   roomWelcome: createLiveUserModel?.data?.roomWelcome ?? "",
//   privateCode: createLiveUserModel?.data?.privateCode ?? 0,
//   token: createLiveUserModel?.data?.token ?? "",
//   channel: createLiveUserModel?.data?.channel ?? "",
//   userUid: 0,
//   mute: 0,
//   audioLiveType: createLiveUserModel?.data?.audioLiveType ?? 0,
//   audioRoomPrivateCode: createLiveUserModel?.data?.privateCode ?? 0,
//   audioRoomSeats: createLiveUserModel?.data?.seat ?? [],
//   isFollow: false,
//   bgTheme: createLiveUserModel?.data?.bgTheme ?? "",
//   hostUniqueId: Database.fetchLoginUserProfile()?.user?.uniqueId ?? "",
//   seatLength: createLiveUserModel?.data?.seat?.length ?? 0,
//   hostName: createLiveUserModel?.data?.name ?? "",
// ),
