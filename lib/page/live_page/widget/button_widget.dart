import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/icon_button_widget.dart';
import 'package:tingle/common/widget/stop_live_dialog_widget.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/page/live_page/pk_battle_widget/invite_user_for_pk_battle_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class ButtonWidget extends GetView<LiveController> {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: Get.height / 2,
        color: AppColor.transparent,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              75.height,
              GetBuilder<LiveController>(
                id: AppConstant.onSwitchMic,
                builder: (controller) => IconButtonWidget(
                  icon: controller.liveModel?.isMute == true ? AppAssets.icMicOff : AppAssets.icMicOn,
                  iconColor: AppColor.white,
                  iconSize: 20,
                  circleColor: AppColor.white.withValues(alpha: 0.2),
                  circleBorderColor: AppColor.white.withValues(alpha: 0.3),
                  visible: controller.liveModel?.isHost == true,
                  callback: controller.onSwitchMic,
                ),
              ),
              15.height,
              IconButtonWidget(
                icon: AppAssets.icCameraRotate,
                iconColor: AppColor.white,
                iconSize: 20,
                circleColor: AppColor.white.withValues(alpha: 0.2),
                circleBorderColor: AppColor.white.withValues(alpha: 0.3),
                visible: controller.liveModel?.isHost == true,
                callback: controller.onSwitchCamera,
              ),
              15.height,
              GetBuilder<LiveController>(
                id: AppConstant.onEventHandler,
                builder: (controller) => Visibility(
                  visible: controller.liveModel?.isChannelMediaRelay == false,
                  child: IconButtonWidget(
                    icon: AppAssets.icPkUsers,
                    iconColor: AppColor.white,
                    iconSize: 18,
                    margin: EdgeInsets.only(bottom: 15),
                    circleColor: AppColor.white.withValues(alpha: 0.2),
                    circleBorderColor: AppColor.white.withValues(alpha: 0.3),
                    visible: controller.liveModel?.isHost == true,
                    callback: () => InviteUserForPkBattleBottomSheet.onShow(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
