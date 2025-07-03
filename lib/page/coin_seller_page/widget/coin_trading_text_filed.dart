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
        if (title != null) ...[
          Text(
            title!,
            style: AppFontStyle.styleW500(AppColor.black, 14),
          ),
          5.height,
        ],
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
            fillColor: Colors.white, // ✅ 背景白色
            hintText: hintText,
            hintStyle: AppFontStyle.styleW500(AppColor.darkGray, 15), // ✅ 深灰色 hint
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20), // ✅ 圆角 20
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: suffixIcon,
            suffix: suffix,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
