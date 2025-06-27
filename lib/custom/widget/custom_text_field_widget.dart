import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.hintStyle,
    this.suffixIcon,
    this.onChange,
    this.validator,
    this.onChangeIsObscure,
    this.inputFormatters,
    this.isPassword = false,
    this.isObscure = false,
    this.fillColor,
    this.borderColor,
    this.enabled,
    this.textColor,
    this.onEditingComplete,
  });

  final String? title;
  final String? hintText;
  final bool isPassword;
  final bool isObscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final Callback? onChangeIsObscure;
  final Callback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text(
                      title!,
                      style: AppFontStyle.styleW500(AppColor.grayText, 12),
                    ),
                  ),
                  5.height,
                ],
              )
            : const Offstage(),
        TextFormField(
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChange,
          maxLines: 1,
          onEditingComplete: onEditingComplete,
          inputFormatters: inputFormatters,
          cursorColor: AppColor.secondary,
          obscureText: isPassword ? isObscure : false,
          validator: validator,
          style: AppFontStyle.styleW600(textColor ?? AppColor.black, 15),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? AppColor.white,
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: isPassword
                ? GestureDetector(
                    onTap: onChangeIsObscure,
                    child: Container(
                      color: AppColor.transparent,
                      alignment: Alignment.center,
                      width: 50,
                      margin: EdgeInsets.only(right: 5),
                      child: Image.asset(
                        isObscure ? AppAssets.icHide : AppAssets.icPwdShow,
                        width: 24,
                        height: 24,
                        color: AppColor.grayText.withValues(alpha: 0.5),
                      ),
                    ),
                  )
                : suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColor.secondary.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColor.secondary.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? AppColor.primary.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.red.withValues(alpha: 0.5)),
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: hintStyle ?? AppFontStyle.styleW500(AppColor.secondary, 15),
          ),
        )
      ],
    );
  }
}
