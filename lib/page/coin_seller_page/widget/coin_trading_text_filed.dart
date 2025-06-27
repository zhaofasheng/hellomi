import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CoinTradingTextFiled extends StatelessWidget {
  const CoinTradingTextFiled({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.suffix,
    this.prefixIcon,
    this.onChange,
    this.inputFormatters,
    this.color,
    this.readOnly = false,
    this.onTap,
    this.onEditingComplete,
  });

  final String? title;
  final Color? color;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Function()? onTap;
  final Callback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Text(
                    title!,
                    style: AppFontStyle.styleW500(AppColor.grayText, 14),
                  ),
                  5.height,
                ],
              )
            : const Offstage(),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChange,
          maxLines: 1,
          onTap: onTap,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          cursorColor: color ?? AppColor.secondary,
          style: AppFontStyle.styleW600(AppColor.black, 15),
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.textFiledBgColor,
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: suffixIcon,
            suffix: suffix,
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.transparent),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primary.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
          ),
        ),
      ],
    );
  }
}
