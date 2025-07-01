import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RankAppBarWidget extends GetView<RankingController> {
  const RankAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;

    return Container(
      margin: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        height: 40,
        width: Get.width,
        child: Row(
          children: [
            GestureDetector(
              onTap: Get.back,
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.transparent,
                ),
                child: Image.asset(
                  AppAssets.icArrowLeft,
                  width: 10,
                  color: AppColor.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 36,
                margin: const EdgeInsets.only(right: 45),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.4), // 外层灰/白背景
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TabBar(
                  controller: controller.tabController,
                  indicator: BoxDecoration(
                    color: AppColor.white, // 选中项的背景色
                    borderRadius: BorderRadius.circular(30),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColor.black, // 选中项的文字颜色
                  unselectedLabelColor: HexColor('#A8A8AC'), // 未选中文字颜色
                  labelStyle: AppFontStyle.styleW600(AppColor.black, 15),
                  unselectedLabelStyle: AppFontStyle.styleW500(AppColor.white.withOpacity(0.6), 15),
                  dividerColor: AppColor.transparent,
                  tabs: [
                    Tab(text: EnumLocal.txtRich.name.tr),
                    Tab(text: EnumLocal.txtGift.name.tr),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
