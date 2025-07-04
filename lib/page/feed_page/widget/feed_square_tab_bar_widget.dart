import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class FeedSquareTabBarWidget extends StatelessWidget {
  const FeedSquareTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List squareTabs = [EnumLocal.txtMoments.name.tr, EnumLocal.txtTopics.name.tr];
    return GetBuilder<FeedController>(
      id: AppConstant.onChangeSquareTab,
      builder: (controller) => Container(
        color: AppColor.transparent,
        height: 30,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: squareTabs.length,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => controller.onChangeSquareTab(index),
                child: Container(
                  height: 30,
                  margin: const EdgeInsets.only(right: 15),
                  alignment: Alignment.center,
                  color: AppColor.transparent,
                  child: Container(
                    height: 24,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: controller.selectedSquareTab == index
                          ? HexColor('#B300E4A6')
                          : Colors.transparent, // ❌ 未选中透明
                      borderRadius: BorderRadius.circular(12), // 圆角
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        squareTabs[index],
                        style: controller.selectedSquareTab == index
                            ? AppFontStyle.styleW400(AppColor.white, 14)
                            : AppFontStyle.styleW400(
                          AppColor.black, // 写法优化
                          14,
                        ),
                      ),
                    ),
                  )

                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
