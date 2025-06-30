import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
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

import '../../../assets/assets.gen.dart';
import '../../fake_chat_page/widget/fake_chat_text_field_widget.dart';
import '../../profile_page/controller/profile_controller.dart';

// class ChatTextFieldWidget extends GetView<ChatController> {
//   const ChatTextFieldWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             color: AppColor.white,
//             child: SafeArea(
//               bottom: !controller.isShowMorePanel.value,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // 👉 语音 / 键盘切换按钮
//                     GestureDetector(
//                       onTap: () {
//                         controller.isVoiceMode.value = !controller.isVoiceMode.value;
//                         FocusScope.of(context).unfocus();
//                         controller.isShowMorePanel.value = false;
//                       },
//                       child: Container(
//                         height: 50,
//                         width: 40,
//                         alignment: Alignment.center,
//                         child: Obx(() => controller.isVoiceMode.value
//                             ? Assets.images.chatSendimg.image(width: 32, height: 32) // 切换回键盘
//                             : Assets.images.chatCamram.image(width: 32, height: 32)), // 切换到语音
//                       ),
//                     ),
//                     10.width,
//
//                     // 👉 输入框或“按住说话”
//                     Expanded(
//                       child: Obx(() {
//                         if (controller.isVoiceMode.value) {
//                           return GestureDetector(
//                             onLongPressStart: (_) {
//                               if (!controller.isSendingAudioFile.value) {
//                                 controller.isRecording.value = true;
//                                 Vibration.vibrate(duration: 50, amplitude: 128);
//                                 controller.onLongPressStartMic();
//                               }
//                             },
//                             onLongPressEnd: (_) {
//                               if (!controller.isSendingAudioFile.value) {
//                                 controller.isRecording.value = false;
//                                 Vibration.vibrate(duration: 50, amplitude: 128);
//                                 controller.onLongPressEndMic();
//                               }
//                             },
//                             child: Container(
//                               height: 50,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(color: HexColor('#00E4A6')),
//                                 color: AppColor.white,
//                               ),
//                               child: Obx(() => Text(
//                                 controller.isRecording.value ? "松开 结束" : "按住 说话",
//                                 style: AppFontStyle.styleW500(AppColor.black, 15),
//                               )),
//                             ),
//                           );
//                         } else {
//                           return Container(
//                             height: 50,
//                             padding: const EdgeInsets.only(left: 10, right: 5),
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: HexColor('#F8F8F8'),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Expanded(
//                                   child: GetBuilder<ChatController>(
//                                     id: AppConstant.onChangeAudioRecordingEvent,
//                                     builder: (controller) => TextFormField(
//                                       controller: controller.messageController,
//                                       cursorColor: AppColor.secondary,
//                                       onTap: () => controller.isShowMorePanel.value = false,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: const EdgeInsets.only(bottom: 2),
//                                         hintText: controller.isRecordingAudio
//                                             ? CustomFormatAudioTime.convert(controller.countTime)
//                                             : EnumLocal.txtSaySomething.name.tr,
//                                         hintStyle: AppFontStyle.styleW500(
//                                           controller.isRecordingAudio ? AppColor.primary : HexColor('#A8A8AC'),
//                                           15,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                       }),
//                     ),
//                     5.width,
//
//                     // 👉 发送按钮
//                     GestureDetector(
//                       onTap: controller.onClickSend,
//                       child: Container(
//                         height: 50,
//                         width: 40,
//                         padding: const EdgeInsets.only(bottom: 3),
//                         decoration: BoxDecoration(
//                           gradient: AppColor.primaryGradient,
//                           shape: BoxShape.circle,
//                         ),
//                         child: Center(
//                           child: Image.asset(
//                             AppAssets.icSend,
//                             height: 28,
//                             width: 28,
//                             color: AppColor.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // 👉 更多功能面板
//           if (controller.isShowMorePanel.value)
//             Container(
//               width: double.infinity,
//               height: 250,
//               color: AppColor.white,
//               child: SafeArea(
//                 top: false,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Wrap(
//                     spacing: 20,
//                     runSpacing: 15,
//                     children: [
//                       MoreOption(
//                           icon: Assets.images.chatSendimg.image(width: 32, height: 32),
//                           onTap: controller.choiceImage),
//                       MoreOption(
//                           icon: Assets.images.chatCamram.image(width: 32, height: 32),
//                           onTap: controller.choiceCameraImage),
//                       MoreOption(
//                           icon: Assets.images.chatVideo.image(width: 32, height: 32),
//                           onTap: () {
//                             final profileController = Get.find<ProfileController>();
//                             if (Utils.isDemoApp || profileController.fetchUserProfileModel?.user?.wealthLevel?.permissions?.freeCall == true) {
//                               controller.onClickVideoCall();
//                             } else {
//                               Utils.showToast(text: EnumLocal.txtTopUpYourBalanceToReachTheNext.name.tr);
//                             }
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       );
//     });
//   }
// }


class ChatTextFieldWidget extends GetView<ChatController> {
  const ChatTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColor.white,
            child: SafeArea(
              bottom: !controller.isShowMorePanel.value, // 展示更多面板时不保留底部安全区域
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 👉 更多按钮
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.isShowMorePanel.value = !controller.isShowMorePanel.value;
                      },
                      child: Container(
                        height: 50,
                        width: 40,
                        alignment: Alignment.center,
                        child: Center(child: Assets.images.chatMore.image(width: 32, height: 32)),
                      ),
                    ),
                    10.width,

                    // 👉 输入框
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 10, right: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: HexColor('#F8F8F8'),
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
                                  onTap: () => controller.isShowMorePanel.value = false, // 点击输入框时关闭更多面板
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.only(bottom: 2),
                                    hintText: controller.isRecordingAudio
                                        ? CustomFormatAudioTime.convert(controller.countTime)
                                        : EnumLocal.txtSaySomething.name.tr,
                                    hintStyle: AppFontStyle.styleW500(
                                      controller.isRecordingAudio ? AppColor.primary : HexColor('#A8A8AC'),
                                      15,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 👉 语音按钮
                            GestureDetector(
                              onTap: () {
                                Vibration.vibrate(duration: 50, amplitude: 128);
                                Utils.showToast(text: EnumLocal.txtLongPressToEnableAudioRecording.name.tr);
                              },
                              onLongPressStart: (details) {
                                if (!controller.isSendingAudioFile.value) {
                                  Vibration.vibrate(duration: 50, amplitude: 128);
                                  controller.onLongPressStartMic();
                                }
                              },
                              onLongPressEnd: (details) {
                                if (!controller.isSendingAudioFile.value) {
                                  Vibration.vibrate(duration: 50, amplitude: 128);
                                  controller.onLongPressEndMic();
                                }
                              },
                              child: Container(
                                height: 45,
                                width: 35,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppAssets.icMicOn,
                                  color: HexColor('#00E4A6'),
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),

                            5.width,
                          ],
                        ),
                      ),
                    ),
                    5.width,

                    // 👉 发送按钮
                    GestureDetector(
                      onTap: controller.onClickSend,
                      child: Container(
                        height: 50,
                        width: 40,
                        padding: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          gradient: AppColor.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppAssets.icSend,
                            height: 28,
                            width: 28,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 👉 更多功能面板
          if (controller.isShowMorePanel.value)
            Container(
              width: double.infinity,
              height: 250,
              color: AppColor.white,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 15,
                    children: [
                      MoreOption(icon: Assets.images.chatSendimg.image(width: 32,height: 32),  onTap: () {
                        controller.choiceImage();
                      }),
                      MoreOption(icon: Assets.images.chatCamram.image(width: 32,height: 32),  onTap: () {
                        controller.choiceCameraImage();
                      }),

                      MoreOption(icon: Assets.images.chatVideo.image(width: 32,height: 32),  onTap: () {
                        final profileController = Get.find<ProfileController>();
                        if (Utils.isDemoApp || profileController.fetchUserProfileModel?.user?.wealthLevel?.permissions?.freeCall == true) {
                          controller.onClickVideoCall();
                        } else {
                          Utils.showToast(text: EnumLocal.txtTopUpYourBalanceToReachTheNext.name.tr);
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}


// class ChatTextFieldWidget extends GetView<ChatController> {
//   const ChatTextFieldWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColor.white,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 height: 50,
//                 padding: const EdgeInsets.only(left: 20),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: AppColor.secondary.withValues(alpha: 0.12),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: GetBuilder<ChatController>(
//                         id: AppConstant.onChangeAudioRecordingEvent,
//                         builder: (controller) => TextFormField(
//                           controller: controller.messageController,
//                           cursorColor: AppColor.secondary,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             contentPadding: const EdgeInsets.only(bottom: 2),
//                             hintText: controller.isRecordingAudio ? CustomFormatAudioTime.convert(controller.countTime) : EnumLocal.txtSaySomething.name.tr,
//                             hintStyle: AppFontStyle.styleW500(controller.isRecordingAudio ? AppColor.primary : AppColor.secondary, 15),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Vibration.vibrate(duration: 50, amplitude: 128);
//                         Utils.showToast(text: EnumLocal.txtLongPressToEnableAudioRecording.name.tr);
//                       },
//                       onLongPressStart: (details) {
//                         if (controller.isSendingAudioFile.value == false) {
//                           Vibration.vibrate(duration: 50, amplitude: 128);
//                           controller.onLongPressStartMic();
//                         }
//                       },
//                       onLongPressEnd: (details) {
//                         if (controller.isSendingAudioFile.value == false) {
//                           Vibration.vibrate(duration: 50, amplitude: 128);
//                           controller.onLongPressEndMic();
//                         }
//                       },
//                       child: Container(
//                         height: 45,
//                         width: 45,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColor.transparent,
//                         ),
//                         child: Image.asset(
//                           AppAssets.icMicOn,
//                           color: AppColor.grayText.withValues(alpha: 0.6),
//                           width: 25,
//                           height: 25,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => controller.onClickImage(context),
//                       child: Container(
//                         height: 45,
//                         width: 45,
//                         alignment: Alignment.center,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColor.transparent,
//                         ),
//                         child: Image.asset(
//                           height: 23,
//                           width: 23,
//                           AppAssets.icGallery,
//                           color: AppColor.secondary,
//                         ),
//                       ),
//                     ),
//                     10.width,
//                   ],
//                 ),
//               ),
//             ),
//             15.width,
//             GestureDetector(
//               onTap: controller.onClickSend,
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 padding: const EdgeInsets.only(bottom: 3),
//                 decoration: BoxDecoration(
//                   gradient: AppColor.primaryGradient,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Image.asset(
//                     height: 28,
//                     width: 28,
//                     AppAssets.icSend,
//                     color: AppColor.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
