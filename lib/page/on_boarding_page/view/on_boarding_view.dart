import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/on_boarding_page/controller/on_boarding_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primary.withValues(alpha: 0.05),
              AppColor.white.withValues(alpha: 0.5),
              AppColor.white,
            ],
          ),
        ),
        child: GetBuilder<OnBoardingController>(
          id: AppConstant.onChangePage,
          builder: (controller) => Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.pages.length,
                    onPageChanged: (value) => controller.onChangePage(value),
                    itemBuilder: (context, index) {
                      final indexData = controller.pages[controller.selectedIndex];
                      return indexData;
                    },
                  ),
                ),
              ),
              15.height,
              DotIndicatorUi(index: controller.selectedIndex),
              GestureDetector(
                onTap: controller.onClickNext,
                child: Container(
                  height: 60,
                  width: Get.width,
                  margin: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    EnumLocal.txtNext.name.tr,
                    style: AppFontStyle.styleW700(AppColor.white, 17),
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

class DotIndicatorUi extends StatelessWidget {
  const DotIndicatorUi({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: Get.width / 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 3; i++)
            AnimatedContainer(
              transformAlignment: Alignment.centerRight,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 300),
              height: 8,
              width: i == index ? 35 : 15,
              margin: EdgeInsets.only(left: 5),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: i == index ? AppColor.primary : AppColor.secondary.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
