import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class GoogleAndPhoneButtonWidget extends StatelessWidget {
  const GoogleAndPhoneButtonWidget({
    super.key,
    required this.image,
    required this.title,
    required this.iconSize,
    required this.callback,
  });

  final String image;
  final String title;
  final double iconSize;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 60,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColor.colorBorder),
          ),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColor.lightGray,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(image, width: iconSize),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: AppFontStyle.styleW700(AppColor.black, 14),
                  ),
                ),
              ),
              20.width,
            ],
          ),
        ),
      ),
    );
  }
}
