import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RichTabBarWidget extends StatelessWidget {
  const RichTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeRichTabBar,
      builder: (controller) => Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.1), // 背景色
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabItemWidget(
              title: EnumLocal.txtDaily.name.tr,
              isSelected: controller.selectedRichTabIndex == 0,
              callback: () => controller.onChangeRichTabBar(0),
            ),
            10.width,
            _TabItemWidget(
              title: EnumLocal.txtWeekly.name.tr,
              isSelected: controller.selectedRichTabIndex == 1,
              callback: () => controller.onChangeRichTabBar(1),
            ),
            10.width,
            _TabItemWidget(
              title: EnumLocal.txtMonthly.name.tr,
              isSelected: controller.selectedRichTabIndex == 2,
              callback: () => controller.onChangeRichTabBar(2),
            ),
          ],
        ),
      ),
    );
  }
}

class GiftTabBarWidget extends StatelessWidget {
  const GiftTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeGiftTabBar,
      builder: (controller) => Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.1), // 背景色
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _TabItemWidget(
              title: EnumLocal.txtDaily.name.tr,
              isSelected: controller.selectedGiftTabIndex == 0,
              callback: () => controller.onChangeGiftTabBar(0),
            ),
            10.width,
            _TabItemWidget(
              title: EnumLocal.txtWeekly.name.tr,
              isSelected: controller.selectedGiftTabIndex == 1,
              callback: () => controller.onChangeGiftTabBar(1),
            ),
            10.width,
            _TabItemWidget(
              title: EnumLocal.txtMonthly.name.tr,
              isSelected: controller.selectedGiftTabIndex == 2,
              callback: () => controller.onChangeGiftTabBar(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  const _TabItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final bool isSelected;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.white : AppColor.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW500(
            isSelected ? AppColor.primary : HexColor('#A8A8AC'),
            13,
          ),
        ),
      ),
    );
  }
}

class GiftSubTabBarWidget extends StatelessWidget {
  const GiftSubTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeGiftTabBar,
      builder: (controller) => Container(
        height: 40,
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SubTabItemWidget(
              title: EnumLocal.txtTopSender.name.tr,
              isSelected: controller.selectedGiftSubTabIndex == 0,
              callback: () => controller.onChangeGiftSubTabBar(0),
            ),
            15.width,
            _SubTabItemWidget(
              title: EnumLocal.txtTopReceiver.name.tr,
              isSelected: controller.selectedGiftSubTabIndex == 1,
              callback: () => controller.onChangeGiftSubTabBar(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubTabItemWidget extends StatelessWidget {
  const _SubTabItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColor.white :  AppColor.white.withOpacity(0.4),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW500(isSelected ? AppColor.primary : HexColor('#A8A8AC'), 13),
        ),
      ),
    );
  }
}
