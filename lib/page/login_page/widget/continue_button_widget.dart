import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({
    super.key,
    required this.title,
    required this.callback,
    this.borderRadius,
    this.buttonColor,
    this.textColor,
    this.height,
    this.gradient,
    this.margin,
    this.padding,
  });

  final String title;
  final BorderRadius? borderRadius;
  final Callback callback;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final Color? buttonColor;
  final Color? textColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: height ?? 50,
        width: Get.width,
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: buttonColor ?? AppColor.primary,
          gradient: gradient,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW700(textColor ?? AppColor.white, 15),
        ),
      ),
    );
  }
}
