import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.iconSize,
  });

  final String image;
  final String title;
  final String subtitle;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top + 40),
        Container(
          width: Get.width,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 头像
              Container(
                height: iconSize,
                width: iconSize,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColor.transparent),
                child: Image.asset(
                  image,
                  width: iconSize,
                  height: iconSize,
                  cacheHeight: 120,
                  cacheWidth: 120,
                ),
              ),

              SizedBox(height: 10), // 间距

              // 标题
              Text(
                title,
                style: AppFontStyle.styleW900(AppColor.black, 30),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 0), // 间距
              // 副标题
              Text(
                subtitle,
                style: AppFontStyle.styleW500(HexColor('#86868F'), 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
