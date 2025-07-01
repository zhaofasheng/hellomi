import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../assets/assets.gen.dart';

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
    this.leftImage,
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
  final VoidCallback? onChangeIsObscure;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final Widget? leftImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Column(
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
          ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              if (leftImage != null)
                Padding(
                  padding: const EdgeInsets.only(left: 10,),
                  child: leftImage!,
                ),
              Expanded(
                child: TextFormField(
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
                    filled: false, // 关闭内置填充，避免覆盖外层背景
                    fillColor: null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    hintText: hintText,
                    hintStyle: hintStyle ??
                        AppFontStyle.styleW500(
                          const Color(0xFFD2D6DB),
                          15,
                        ),
                    suffixIcon: isPassword
                        ? GestureDetector(
                      onTap: onChangeIsObscure,
                      child: Container(
                        color: AppColor.transparent,
                        alignment: Alignment.center,
                        width: 50,
                        margin: EdgeInsets.only(right: 5),
                        child: isObscure?Assets.images.loginNoShow.image(width: 24,height: 25):Assets.images.loginShow.image(width: 24,height: 25),
                      ),
                    )
                        : suffixIcon,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
