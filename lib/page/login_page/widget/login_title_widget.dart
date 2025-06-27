import 'package:flutter/material.dart';
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
        (MediaQuery.of(context).viewPadding.top + 30).height,
        Container(
          width: Get.width,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 65,
                width: 65,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: AppColor.transparent),
                child: Image.asset(
                  image,
                  width: iconSize,
                  cacheHeight: 120,
                  cacheWidth: 120,
                ),
              ),
              20.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.styleW900(AppColor.black, 30),
                    ),
                    Text(
                      subtitle,
                      style: AppFontStyle.styleW500(AppColor.black, 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
