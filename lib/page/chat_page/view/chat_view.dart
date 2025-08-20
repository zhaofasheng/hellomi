import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/custom/function/custom_format_audio_time.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/page/chat_page/widget/chat_app_bar_widget.dart';
import 'package:tingle/page/chat_page/widget/chat_text_field_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_audio_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_image_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_message_widget.dart';
import 'package:tingle/page/chat_page/widget/receiver_video_call_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_audio_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_image_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_message_widget.dart';
import 'package:tingle/page/chat_page/widget/sender_video_call_widget.dart';
import 'package:tingle/page/chat_page/widget/upload_audio_widget.dart';
import 'package:tingle/utils/api.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

// 消息类型常量
class MessageType {
  static const int text = 1;
  static const int image = 2;
  static const int videoCall = 3;
  static const int audio = 4;
}

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 300);
    return Scaffold(
      appBar: ChatAppBarWidget.appBar(
        context: context,
        name: controller.name,
        image: controller.image,
        isBanned: controller.isBanned,
        isVerify: controller.isVerify,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 背景图优化为decoration
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.imgChatBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                Expanded(
                  child: GetBuilder<ChatController>(
                    id: AppConstant.onFetchUserChat,
                    builder: (controller) {
                      if (controller.isLoading) {
                        return const LoadingWidget();
                      }
                      return Column(
                        children: [
                          GetBuilder<ChatController>(
                            id: AppConstant.onPaginationUserChat,
                            builder: (controller) => Visibility(
                              visible: controller.isPagination,
                              child: LinearProgressIndicator(color: AppColor.primary),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: controller.scrollController,
                              itemCount: controller.chatList.length,
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              itemBuilder: (context, index) {
                                final indexData = controller.chatList[index];
                                return _buildChatItem(indexData, controller);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const ChatTextFieldWidget(),
              ],
            ),
          ),
          // 录音提示条
          Positioned(
            top: 20,
            child: GetBuilder<ChatController>(
              id: AppConstant.onChangeAudioRecordingEvent,
              builder: (controller) => Visibility(
                visible: controller.isRecordingAudio,
                child: Container(
                  height: 40,
                  width: 110,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.colorBorder.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.icMicOn,
                        color: AppColor.primary,
                        width: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        CustomFormatAudioTime.convert(controller.countTime),
                        style: AppFontStyle.styleW500(AppColor.black, 13),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 消息渲染逻辑提取为私有方法
  Widget _buildChatItem(dynamic indexData, ChatController controller) {
    final bool isSender = indexData.senderId == Database.loginUserId;
    switch (indexData.messageType) {
      case MessageType.text:
        return isSender
            ? SenderMessageWidget(
                message: indexData.message ?? "",
                time: indexData.createdAt ?? "",
              )
            : ReceiverMessageWidget(
                message: indexData.message ?? "",
                time: indexData.createdAt ?? "",
                profileImage: controller.image,
                profileImageIsBanned: controller.isBanned,
              );
      case MessageType.image:
        return isSender
            ? SenderImageWidget(
                image: indexData.image ?? "",
                time: indexData.createdAt ?? "",
                isBanned: indexData.isMediaBanned ?? false,
              )
            : ReceiverImageWidget(
                image: indexData.image ?? "",
                time: indexData.createdAt ?? "",
                isBanned: indexData.isMediaBanned ?? false,
                receiverImage: controller.image,
                receiverImageIsBanned: controller.isBanned,
              );
      case MessageType.videoCall:
        return isSender
            ? SenderVideoCallWidget(
                time: indexData.createdAt ?? "",
                type: indexData.callType ?? 0,
                callDuration: indexData.callDuration ?? "",
              )
            : ReceiverVideoCallWidget(
                callDuration: indexData.callDuration ?? "",
                type: indexData.callType ?? 0,
                time: indexData.createdAt ?? "",
              );
      case MessageType.audio:
        return isSender
            ? SenderAudioWidget(
                id: indexData.id ?? "",
                audio: Api.baseUrl + (indexData.audio ?? ""),
                time: indexData.createdAt ?? "",
              )
            : ReceiverAudioWidget(
                id: indexData.id ?? "",
                audio: Api.baseUrl + (indexData.audio ?? ""),
                time: indexData.createdAt ?? "",
                receiverImage: controller.image,
                receiverImageIsBanned: controller.isBanned,
              );
      default:
        // 其他类型如上传中音频
        return isSender ? UploadAudioWidget() : const Offstage();
    }
  }
}
