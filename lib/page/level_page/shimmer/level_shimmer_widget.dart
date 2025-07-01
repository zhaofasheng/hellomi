import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class LevelShimmerWidget extends StatelessWidget {
  const LevelShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.white,
      highlightColor: HexColor('##00E4A6'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          90.height,
          Container(
            height: 115,
            width: 115,
            decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
          ),
          15.height,
          Container(
            height: 8,
            width: Get.width,
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(10)),
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 15,
                width: 100,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
              ),
              Container(
                height: 15,
                width: 150,
                margin: const EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
              ),
            ],
          ),
          15.height,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.black,
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
          15.height,
        ],
      ),
    );
  }
}
