import 'package:flutter/material.dart';
import 'package:tingle/utils/color.dart';
import 'constant.dart';

abstract class AppFontStyle {
  static styleW300(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      fontFamily: AppConstant.appFontLight,
    );
  }

  static styleW400(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstant.appFontRegular,
    );
  }

  static styleW500(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstant.appFontMedium,
    );
  }

  static styleW600(Color color, double fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstant.appFontSemiBold,
    );
  }

  static styleW700(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      fontFamily: AppConstant.appFontBold,
    );
  }

  static styleW800(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
      fontFamily: AppConstant.appFontBold,
    );
  }

  static styleW900(Color? color, double? fontSize) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      fontFamily: AppConstant.appFontExtraBold,
    );
  }

  static appBarStyle() {
    return const TextStyle(
      fontSize: 21,
      letterSpacing: 0.4,
      fontFamily: AppConstant.appFontBold,
      fontWeight: FontWeight.bold,
    );
  }

  static customStyle({Color? color, double? fontSize, FontWeight? fontWeight, String? fontFamily, Color? decorationColor}) {
    return TextStyle(
      color: color ?? AppColor.white,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.w900,
      fontFamily: fontFamily ?? AppConstant.appFontExtraBold,
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.underline,
      decorationColor: decorationColor ?? AppColor.black,
      decorationStyle: TextDecorationStyle.solid,
    );
  }
}
