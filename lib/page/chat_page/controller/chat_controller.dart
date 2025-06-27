import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:tingle/common/function/generate_random_name.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_image_picker.dart';
import 'package:tingle/custom/widget/custom_image_picker_bottom_sheet_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/chat_page/api/fetch_user_chat_api.dart';
import 'package:tingle/page/chat_page/api/send_file_to_chat_api.dart';
import 'package:tingle/page/chat_page/model/fetch_user_chat_model.dart';
import 'package:tingle/page/chat_page/model/send_file_to_chat_model.dart';
import 'package:tingle/socket/socket_emit.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/permission.dart';
import 'package:tingle/utils/socket_params.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';

class ChatController extends GetxController {
  // GET ARGUMENT FROM [MESSAGE_PAGE, SEARCH_PAGE]

  String roomId = "";
  String receiverUserId = "";
  String name = "";
  String image = "";
  bool isBanned = false;
  bool isVerify = false;

  // FETCH OLD CHAT BETWEEN TWO USER
  bool isLoading = false;
  FetchUserChatModel? fetchUserChatModel;
  bool isPagination = false;

  List<Chat> chatList = [];

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  // SEND FILE ON CHAT

  SendFileToChatModel? sendFileToChatModel;

  String channelName = "";

  AudioRecorder audioRecorder = AudioRecorder();

  bool isRecordingAudio = false;

  RxBool isSendingAudioFile = false.obs;
  String currentPlayAudioId = ""; // This is use to one time only one play audio...
  Timer? timer;
  int countTime = 0;

  @override
  void onInit() {
    final argument = Get.arguments;
    Utils.showLog("CHAT ARGUMENT => $argument");

    roomId = argument[ApiParams.roomId]; // IF USER ALREADY CREATE ROOM THEN GET ROOM ID ELSE GET ROOM ID IN FETCH CHAT API...
    receiverUserId = argument[ApiParams.receiverUserId]; // SENDER MEAN LOGIN USER AND RECEIVER MEAN OTHER USER...
    name = argument[ApiParams.name];
    image = argument[ApiParams.image];
    isBanned = argument[ApiParams.isBanned];
    isVerify = argument[ApiParams.isVerify];

    onRefreshUserChat();
    scrollController.addListener(onPaginationUserChat);
    channelName = channelName = GenerateRandomName.onGenerate();
    super.onInit();
  }

  @override
  void onClose() {
    onRefreshUserChat(); // Use To Read Latest Messages...
    super.onClose();
  }

  Future<void> onClickVideoCall() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

    Utils.showLog("Video Calling...");

    Vibration.vibrate(duration: 50, amplitude: 128);

    AppPermission.onGetCameraPermission(
      onGranted: () {
        AppPermission.onGetMicrophonePermission(
          onGranted: () async {
            await Random().nextInt(500).milliseconds.delay();
            Get.back(); // Stop Loading...

            SocketEmit.onInitiateCall(
              callerId: Database.loginUserId,
              receiverId: receiverUserId,
              agoraUID: 0,
              channel: channelName,
            );
          },
          onDenied: () => Get.back(), // Stop Loading...
        );
      },
      onDenied: () => Get.back(), // Stop Loading...
    );
  }

  // *****************************************************************************************************************************

  Future<void> onRefreshUserChat() async {
    isLoading = true;
    chatList.clear();
    update([AppConstant.onFetchUserChat]);
    FetchUserChatApi.startPagination = 0;
    await onFetchUserChat();
    onScrollDown();
  }

  Future<void> onFetchUserChat() async {
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchUserChatModel = await FetchUserChatApi.callApi(uid: uid, token: token, receiverId: receiverUserId);
    roomId = fetchUserChatModel?.chatTopic ?? "";
    final chat = fetchUserChatModel?.chat ?? [];
    chatList.insertAll(0, chat.reversed); // REVERSED USE TO SHOW NEW MESSAGE ON TOP...
    isLoading = false;
    update([AppConstant.onFetchUserChat]);
    if (fetchUserChatModel?.chat?.isEmpty ?? true) {
      FetchUserChatApi.startPagination--;
    }
  }

  Future<void> onPaginationUserChat() async {
    if (scrollController.position.pixels == scrollController.position.minScrollExtent) {
      isPagination = true;
      update([AppConstant.onPaginationUserChat]);
      await onFetchUserChat();
      isPagination = false;
      update([AppConstant.onPaginationUserChat]);
    }
  }

  //******************************************************************************************************************************************

  Future<void> onClickSend() async {
    if (messageController.text.trim().isNotEmpty) {
      chatList.add(
        // ADD FAKE TEXT MESSAGE FOR REAL TIME UPDATE..

        Chat(
          messageType: 1,
          message: messageController.text.trim(),
          date: DateTime.now().toString(),
          senderId: Database.loginUserId,
        ),
      );

      onScrollDown();

      update([AppConstant.onFetchUserChat]);

      onSendMessageToSocket(
        type: 1,
        message: messageController.text,
      );
      messageController.clear();
    }
  }

  Future<void> onClickImage(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();

    await CustomImagePickerBottomSheetWidget.show(
      context: context,
      onClickCamera: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.camera);
        if (imagePath != null) onSendImage(imagePath);
      },
      onClickGallery: () async {
        final imagePath = await CustomImagePicker.pickImage(ImageSource.gallery);
        if (imagePath != null) onSendImage(imagePath);
      },
    );
  }

  Future<void> onSendImage(String imagePath) async {
    chatList.add(Chat(messageType: 2, date: DateTime.now().toString(), senderId: Database.loginUserId)); // USE TO => (ADD) IMAGE UPLOAD TIME SHOW PLACEHOLDER...
    update([AppConstant.onFetchUserChat]);

    onScrollDown();

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    sendFileToChatModel = await SendFileToChatApi.callApi(
      uid: uid,
      token: token,
      receiverUserId: receiverUserId,
      messageType: 2,
      filePath: imagePath,
    );

    chatList.removeLast(); // USE TO => (REMOVE) IMAGE UPLOAD TIME SHOW PLACEHOLDER...

    if (sendFileToChatModel?.chat?.image != null) {
      onSendMessageToSocket(
        type: 2,
        message: sendFileToChatModel?.chat?.image ?? "",
        messageId: sendFileToChatModel?.chat?.id ?? "",
        isMediaBanned: sendFileToChatModel?.chat?.isMediaBanned ?? false,
      );
    }
  }

  //******************************************************************************************************************************************

  Future<void> onSendMessageToSocket({
    required String message,
    required int type,
    String? messageId,
    bool? isMediaBanned,
  }) async {
    SocketEmit.onSendMessage(
      chatTopicId: roomId,
      senderId: Database.loginUserId,
      receiverId: receiverUserId,
      message: message,
      messageType: type,
      date: DateTime.now().toString(),
      messageId: messageId,
      isMediaBanned: isMediaBanned,
    );
  }

  Future<void> onGetMessageFromSocket({required Map message}) async {
    try {
      chatList.removeWhere((chat) => chat.createdAt?.isEmpty ?? true); // FAKE SHOW TEXT MESSAGE REMOVE FROM LIST...

      chatList.add(
        Chat(
          message: message[SocketParams.message],
          messageType: message[SocketParams.messageType],
          senderId: message[SocketParams.senderId],
          image: message[SocketParams.message],
          audio: message[SocketParams.message],
          date: message[SocketParams.date],
          createdAt: message[SocketParams.date],
        ),
      );

      update([AppConstant.onFetchUserChat]);

      await onScrollDown();

      // if (message[SocketParams.messageId] != null) SocketEmit.onMessageSeen(messageId: message[SocketParams.messageId]); // READ NEW INCOMING MESSAGE...
    } catch (e) {
      Utils.showLog("New Message Get Filed => $e");
    }
  }

  //******************************************************************************************************************************************

  Future<void> onChangeTimer() async {
    if (isRecordingAudio && countTime == 0) {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          countTime++;
          update([AppConstant.onChangeAudioRecordingEvent]);
          if (isRecordingAudio == false) {
            countTime = 0;
            this.timer?.cancel();
            update([AppConstant.onChangeAudioRecordingEvent]);
          }
        },
      );
    } else {
      countTime = 0;
      timer?.cancel();
      update([AppConstant.onChangeAudioRecordingEvent]);
    }
  }

  Future<void> onStartAudioRecording() async {
    Utils.showLog("Audio Recording Start");
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = "${appDocDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await audioRecorder.start(const RecordConfig(), path: filePath);

    isRecordingAudio = true;
    update([AppConstant.onChangeAudioRecordingEvent]);

    onChangeTimer();
  }

  Future<void> onLongPressStartMic() async {
    FocusManager.instance.primaryFocus?.unfocus();
    AppPermission.onGetMicrophonePermission(
      onGranted: () {
        onStartAudioRecording();
      },
    );
  }

  Future<void> onLongPressEndMic() async {
    PermissionStatus status = await Permission.microphone.status;

    if (isRecordingAudio && status.isGranted) {
      onStopAudioRecording();
    }
  }

  Future<void> onStopAudioRecording() async {
    try {
      Utils.showLog("Audio Recording Stop");

      isSendingAudioFile.value = true;

      final audioPath = await audioRecorder.stop();

      isRecordingAudio = false;
      update([AppConstant.onChangeAudioRecordingEvent]);
      onChangeTimer();

      Utils.showLog("Recording Audio Path => $audioPath");

      if (audioPath != null) {
        chatList.add(
          Chat(
            messageType: 5, // Extra Type Use For Show Static Upload Process.
            createdAt: DateTime.now().toString(),
            senderId: Database.loginUserId,
          ),
        ); // Static Show...

        onScrollDown();
      }

      update([AppConstant.onFetchUserChat]);

      await 3.seconds.delay();

      if (audioPath != null) {
        final uid = FirebaseUid.onGet() ?? "";
        final token = await FirebaseAccessToken.onGet() ?? "";

        sendFileToChatModel = await SendFileToChatApi.callApi(
          token: token,
          uid: uid,
          receiverUserId: receiverUserId,
          messageType: 4,
          filePath: audioPath,
        );
      }

      chatList.removeLast(); // Static Show Remove...

      if (sendFileToChatModel?.chat?.audio != null) {
        onSendMessageToSocket(
          type: 4,
          message: sendFileToChatModel?.chat?.audio ?? "",
          isMediaBanned: sendFileToChatModel?.chat?.isMediaBanned ?? false,
          messageId: sendFileToChatModel?.chat?.id ?? "",
        );
      }
      isSendingAudioFile.value = false;
    } catch (e) {
      isSendingAudioFile.value = false;
      Utils.showLog("Audio Recording Stop Failed => $e");
    }
  }

  //******************************************************************************************************************************************

  Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      update([AppConstant.onFetchUserChat]);
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }
}
