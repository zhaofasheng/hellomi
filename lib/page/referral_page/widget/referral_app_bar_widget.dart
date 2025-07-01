import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/referral_page/controller/referral_controller.dart';
import 'package:tingle/page/referral_page/widget/referral_history_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class ReferralAppBarWidget extends GetView<ReferralController> {
  const ReferralAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 60,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      alignment: Alignment.center,
      width: Get.width,
      color: AppColor.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
              child: Image.asset(
                AppAssets.icArrowLeft,
                color: AppColor.white,
                width: 10,
              ),
            ),
          ),
          Text(
            EnumLocal.txtReferral.name.tr,
            style: AppFontStyle.styleW700(AppColor.white, 18),
          ),
          GestureDetector(
            onTap: () {
              controller.onGetReferralUserHistory();
              Get.to(ReferralHistoryWidget())?.then(
                (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
              );
            },
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 5),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
              child: Assets.images.tuijianHistory.image(width: 24,height: 24),
            ),
          ),
        ],
      ),
    );
  }
}
