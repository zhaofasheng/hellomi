import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class CoinSellerShimmerWidget extends StatelessWidget {
  const CoinSellerShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 15.height,
            Container(
              height: 120,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            15.height,
            Container(
              height: 20,
              width: 150,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              height: 60,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            15.height,
            Container(
              height: 20,
              width: 150,
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              height: 60,
              width: Get.width,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Spacer(),
            Container(
              height: 60,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColor.black,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
