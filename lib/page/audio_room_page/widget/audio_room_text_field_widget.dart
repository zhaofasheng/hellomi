import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/chat_page/controller/chat_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class AudioRoomTextFieldWidget extends GetView<ChatController> {
  const AudioRoomTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        width: Get.width,
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.black.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GetBuilder<AudioRoomController>(
                builder: (controller) => Row(
                  children: [
                    Assets.images.liveMsg.image(width: 20),
                    VerticalDivider(indent: 12, endIndent: 12, color: HexColor('#B9BCC1')),
                    Expanded(
                      child: TextFormField(
                        controller: controller.audioRoomModel?.commentController,
                        cursorColor: AppColor.secondary,
                        style: AppFontStyle.styleW600(AppColor.white, 13),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(bottom: 8),
                          hintText: EnumLocal.txtSaySomething.name.tr,
                          hintStyle: AppFontStyle.styleW500(HexColor('#B9BCC1'), 11),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.onSendComment(),
                      child: Container(
                        height: 45,
                        width: 30,
                        color: AppColor.transparent,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Image.asset(AppAssets.icSend, width: 24,color: HexColor('#B9BCC1'),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.width,
          ],
        ),
      ),
    );
  }
}
