import 'package:flutter/material.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class BioTextFieldWidget extends StatelessWidget {
  const BioTextFieldWidget({
    super.key,
    this.title,
    this.hintText,
    this.controller,
  });

  final String? title;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Column(
            children: [
              Text(
                title!,
                style: AppFontStyle.styleW500(AppColor.black, 14),
              ),
              5.height,
            ],
          ),
        TextFormField(
          keyboardType: TextInputType.text,
          controller: controller,
          maxLines: null,
          minLines: 3,
          cursorColor: AppColor.secondary,
          style: AppFontStyle.styleW500(AppColor.black, 15),
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.white,
            hintText: hintText,
            hintStyle: AppFontStyle.styleW500(const Color(0xFFD2D6DB), 15),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
