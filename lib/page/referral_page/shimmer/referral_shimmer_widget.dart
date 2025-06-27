import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class ReferralShimmerWidget extends StatelessWidget {
  const ReferralShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            15.height,
            Container(
              height: 25,
              width: 150,
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
            ),
            15.height,
            Container(
              height: 55,
              width: Get.width,
              decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(100)),
            ),
            15.height,
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.black,
              ),
            ),
            15.height,
            Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.black,
              ),
            ),
            15.height,
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.black,
              ),
            ),
            15.height,
          ],
        ),
      ),
    );
  }
}
