import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomPhoneTextFieldWidget extends StatelessWidget {
  CustomPhoneTextFieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.onChange,
    this.onCountryChanged,
    this.validator,
    this.onChangeIsObscure,
    this.inputFormatters,
    this.isPassword = false,
    this.isObscure = false,
  });

  final String? title;
  final String? hintText;
  final bool isPassword;
  final bool isObscure;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Function(PhoneNumber)? onChange;
  final Function(Country)? onCountryChanged;
  final String? Function(String?)? validator;
  final Callback? onChangeIsObscure;
  final List<TextInputFormatter>? inputFormatters;

  RxBool isobsure = false.obs;

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
        IntlPhoneField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            counterText: "",
            hintText: hintText,
            hintStyle: AppFontStyle.styleW500(const Color(0xFF86868F), 15),
          ),
          initialCountryCode: "IN",
          onChanged: onChange,
          onCountryChanged: onCountryChanged,
        ),

      ],
    );
  }
}
