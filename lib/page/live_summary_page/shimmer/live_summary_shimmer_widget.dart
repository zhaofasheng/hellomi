import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class LiveSummaryShimmerWidget extends StatelessWidget {
  const LiveSummaryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(color: AppColor.black.withValues(alpha: 0.5), shape: BoxShape.circle),
                ),
                15.height,
                Container(
                  height: 22,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 5, right: 15),
                  decoration: BoxDecoration(color: AppColor.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(100)),
                ),
                5.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 22,
                      width: 80,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(color: AppColor.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20)),
                    ),
                    5.width,
                    Container(
                      height: 22,
                      width: 80,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(color: AppColor.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20)),
                    ),
                    5.width,
                    Container(
                      height: 22,
                      width: 80,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(color: AppColor.black.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(20)),
                    ),
                  ],
                ),
                5.height,
                Container(
                  height: 22,
                  width: 150,
                  margin: const EdgeInsets.only(bottom: 5, right: 15),
                  decoration: BoxDecoration(
                    color: AppColor.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                30.height,
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColor.black.withValues(alpha: 0.2),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          8.width,
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          8.width,
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.height,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          8.width,
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          8.width,
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.black.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                15.height,
              ],
            ),
          ),
          Container(
            height: 56,
            width: Get.width,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: AppColor.white.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(100)),
          ),
        ],
      ),
    );
  }
}
