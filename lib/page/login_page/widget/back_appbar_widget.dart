import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';

class BackAppBarWidget extends StatelessWidget {
  const BackAppBarWidget({super.key, this.callback});

  final Callback? callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 50,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      alignment: Alignment.center,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
              // callback?.call();
            },
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
              child: Image.asset(
                AppAssets.icArrowLeft,
                width: 10,
              ),
            ),
          ),
        ],
      ),
    );

    //   Align(
    //   alignment: Alignment.topLeft,
    //   child: GestureDetector(
    //     onTap: () => Get.back(),
    //     child: Image.asset(AppAssets.icArrowLeft, height: 18, width: 18),
    //   ),
    // );
  }
}
