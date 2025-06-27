import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String icon;
  final String title;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 65,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: const Border(bottom: BorderSide(color: AppColor.colorBorder)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        // margin: const EdgeInsets.only(bottom: 2),
        child: Row(
          children: [
            Image.asset(icon, width: 34),
            15.width,
            Expanded(
              child: Text(
                title,
                style: AppFontStyle.styleW600(AppColor.black, 15),
              ),
            ),
            RadioItem(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  const RadioItem({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: AppColor.transparent,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? null : AppColor.transparent,
              gradient: isSelected ? AppColor.primaryGradient : null,
            ),
            child: Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColor.white : AppColor.primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
