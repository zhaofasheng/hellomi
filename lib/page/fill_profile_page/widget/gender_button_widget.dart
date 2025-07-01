import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/custom/widget/custom_radio_button_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class GenderButtonWidget extends StatelessWidget {
  const GenderButtonWidget({super.key, required this.title, required this.image, required this.isSelected, required this.callback, this.imageWidget});

  final String title;
  final String image;
  final Widget? imageWidget;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              imageWidget ?? Image.asset(image, width: 35),
              10.width,
              Text(
                title,
                style: AppFontStyle.styleW500(AppColor.black, 15),
              ),
              const Spacer(),
              CustomRadioButtonWidget(
                isSelected: isSelected,
                size: 20,
                borderColor: AppColor.primary,
                activeColor: AppColor.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
