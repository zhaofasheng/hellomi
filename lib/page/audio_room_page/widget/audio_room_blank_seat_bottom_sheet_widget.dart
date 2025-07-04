import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/audio_room_page/controller/audio_room_controller.dart';
import 'package:tingle/page/audio_room_page/widget/audio_room_seat_invite_bottom_sheet_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class AudioRoomBlankSeatBottomSheetWidget {
  static Future<void> show(int position) async {
    final controller = Get.find<AudioRoomController>();
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: 310,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
                controller.onChangePosition(position: position);
              },
              child: Container(
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColor.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.black.withValues(alpha: 0.03),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  EnumLocal.txtSeatHere.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                AudioRoomSeatInviteBottomSheetWidget.show(liveHistoryId: controller.audioRoomModel?.liveHistoryId ?? "", position: position);
              },
              child: Container(
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColor.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.black.withValues(alpha: 0.03),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  EnumLocal.txtGiveTheMic.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.onToggleLockSeat(position),
              child: Container(
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColor.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.black.withValues(alpha: 0.03),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.audioRoomModel?.audioRoomSeats[position].lock == true ? EnumLocal.txtUnlock.name.tr : EnumLocal.txtLockTheMic.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (controller.audioRoomModel?.audioRoomSeats[position].mute == 3) {
                  controller.onSeatMutedSocket(position: position, mute: 0, userId: controller.audioRoomModel?.audioRoomSeats[position].userId ?? "");
                } else {
                  controller.onSeatMutedSocket(position: position, mute: 3, userId: controller.audioRoomModel?.audioRoomSeats[position].userId ?? "");
                }
                Get.back();
              },
              child: Container(
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColor.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.black.withValues(alpha: 0.03),
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.audioRoomModel?.audioRoomSeats[position].mute == 3 ? EnumLocal.txtUnmuteTheMic.name.tr : EnumLocal.txtMuteTheMic.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 16),
                ),
              ),
            ),
            Container(
              height: 8,
              width: Get.width,
              color: AppColor.secondary.withValues(alpha: 0.08),
            ),
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 60,
                width: Get.width,
                color: AppColor.transparent,
                alignment: Alignment.center,
                child: Text(
                  EnumLocal.txtCancel.name.tr,
                  style: AppFontStyle.styleW700(AppColor.red, 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
