import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    super.key,
    required this.height,
    required this.width,
    this.margin,
    this.color,
    this.gradient,
    required this.title,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    required this.callback,
  });

  final double height;
  final double width;

  final EdgeInsetsGeometry? margin;

  final Color? color;
  final Gradient? gradient;

  final String title;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: height,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
          gradient: gradient,
        ),
        margin: margin,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: fontColor ?? AppColor.white,
              fontFamily: AppConstant.appFontMedium,
              fontSize: fontSize ?? 18,
              letterSpacing: 0.3,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
