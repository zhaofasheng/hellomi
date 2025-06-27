import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/fake_audio_room_gift_bottom_sheet_widget.dart';

import 'package:tingle/page/audio_room_page/widget/emoji_bottom_sheet_widget.dart';
import 'package:tingle/page/audio_room_page/widget/game_bottom_sheet_widget.dart';
import 'package:tingle/page/fake_audio_room_page/controller/fake_audio_room_controller.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_audio_room_text_field_widget.dart';
import 'package:tingle/page/fake_audio_room_page/widget/fake_emoji_bottom_sheet_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeAudioRoomBottomBarWidget extends GetView<FakeAudioRoomController> {
  const FakeAudioRoomBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Container(
        height: 50,
        width: Get.width,
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        // color: AppColor.white,
        decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
        child: Row(
          children: [
            GetBuilder<FakeAudioRoomController>(id: AppConstant.onChangeTextField, builder: (controller) => FakeAudioRoomTextFieldWidget()),
            10.width,
            GestureDetector(
              onTap: () => GameBottomSheetWidget.onShow(),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.icGame, width: 26),
              ),
            ),
            10.width,
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                FakeEmojiBottomSheetWidget.onShow();
              },
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppAssets.icAudioRoomEmoji, width: 35),
              ),
            ),
            10.width,
            GetBuilder<FakeAudioRoomController>(
              id: AppConstant.onSwitchMic,
              builder: (controller) => Visibility(
                visible: (controller.fakeAudioRoomModel?.audioRoomSeats.any((element) => element.userId == Database.loginUserId) ?? false),
                child: GestureDetector(
                  onTap: controller.onSwitchMic,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: controller.fakeAudioRoomModel?.mute == 3 ? AppColor.white.withValues(alpha: 0.5) : AppColor.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      controller.fakeAudioRoomModel?.mute == 2 ? AppAssets.icMicOn : AppAssets.icMicOff,
                      color: AppColor.white,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<FakeAudioRoomController>(
              id: AppConstant.onSeatUserUpdate,
              builder: (controller) => Visibility(
                visible: controller.fakeAudioRoomModel?.audioRoomSeats.isNotEmpty ?? false,
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    FakeAudioRoomGiftBottomSheetWidget.onShow(context: context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppAssets.icLightPinkGift, width: 24),
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
