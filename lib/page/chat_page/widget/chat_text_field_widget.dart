import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_audio_time.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:vibration/vibration.dart';

class ChatTextFieldWidget extends GetView<ChatController> {
  const ChatTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.secondary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GetBuilder<ChatController>(
                        id: AppConstant.onChangeAudioRecordingEvent,
                        builder: (controller) => TextFormField(
                          controller: controller.messageController,
                          cursorColor: AppColor.secondary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(bottom: 2),
                            hintText: controller.isRecordingAudio ? CustomFormatAudioTime.convert(controller.countTime) : EnumLocal.txtSaySomething.name.tr,
                            hintStyle: AppFontStyle.styleW500(controller.isRecordingAudio ? AppColor.primary : AppColor.secondary, 15),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Vibration.vibrate(duration: 50, amplitude: 128);
                        Utils.showToast(text: EnumLocal.txtLongPressToEnableAudioRecording.name.tr);
                      },
                      onLongPressStart: (details) {
                        if (controller.isSendingAudioFile.value == false) {
                          Vibration.vibrate(duration: 50, amplitude: 128);
                          controller.onLongPressStartMic();
                        }
                      },
                      onLongPressEnd: (details) {
                        if (controller.isSendingAudioFile.value == false) {
                          Vibration.vibrate(duration: 50, amplitude: 128);
                          controller.onLongPressEndMic();
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.transparent,
                        ),
                        child: Image.asset(
                          AppAssets.icMicOn,
                          color: AppColor.grayText.withValues(alpha: 0.6),
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onClickImage(context),
                      child: Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.transparent,
                        ),
                        child: Image.asset(
                          height: 23,
                          width: 23,
                          AppAssets.icGallery,
                          color: AppColor.secondary,
                        ),
                      ),
                    ),
                    10.width,
                  ],
                ),
              ),
            ),
            15.width,
            GestureDetector(
              onTap: controller.onClickSend,
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  gradient: AppColor.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    height: 28,
                    width: 28,
                    AppAssets.icSend,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
