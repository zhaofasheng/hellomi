import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/icon_button_widget.dart';
import 'package:tingle/page/audio_room_page/widget/game_bottom_sheet_widget.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class CommentTextFieldWidget extends GetView<LiveController> {
  const CommentTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 15, right: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColor.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.images.liveMsg.image(width: 22),
                  5.width,
                  VerticalDivider(
                    indent: 12,
                    endIndent: 12,
                    color: HexColor('#B9BCC1'),
                  ),
                  5.width,
                  Expanded(
                    child: TextFormField(
                      controller: controller.liveModel?.commentController,
                      cursorColor: AppColor.white,
                      maxLines: 1,
                      onChanged: (value) => controller.update([AppConstant.onChanged]),
                      style: AppFontStyle.styleW500(AppColor.white, 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(bottom: 8),
                        hintText: EnumLocal.txtTypeComment.name.tr,
                        hintStyle: AppFontStyle.styleW400(HexColor('#B9BCC1'), 11),
                      ),
                    ),
                  ),
                  5.width,
                  GetBuilder<LiveController>(
                    id: AppConstant.onChanged,
                    builder: (controller) => Visibility(
                      visible: controller.liveModel?.commentController.text.trim().isNotEmpty ?? false,
                      child: GestureDetector(
                        onTap: controller.onSendComment,
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.only(bottom: 3),
                          color: AppColor.transparent,
                          child: Center(
                            child: Image.asset(width: 22, AppAssets.icSend,color: HexColor('#B9BCC1'),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 15.width,
          // IconButtonWidget(
          //   icon: AppAssets.icMicOn,
          //   iconColor: AppColor.white,
          //   circleSize: 42,
          //   iconSize: 20,
          //   circleColor: AppColor.white.withValues(alpha: 0.2),
          //   visible: false,
          // ),

          10.width,
          GestureDetector(
            onTap: () => GameBottomSheetWidget.onShow(),
            child: Assets.images.liveGame.image(width: 40),
          ),

          10.width,
          GestureDetector(
            onTap:() => controller.onClickGift(context),
            child: Assets.images.liveGift.image(width: 40),
          ),

        ],
      ),
    );
  }
}
