import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:tingle/utils/color.dart';

class PreviewShortsVideoShimmerWidget extends StatelessWidget {
  const PreviewShortsVideoShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.baseColor,
      highlightColor: AppColor.highlightColor,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            right: 20,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 50,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(top: 40),
                    decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                  ),
                  Spacer(),
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(left: 15, bottom: 5),
                      decoration: const BoxDecoration(color: AppColor.black, shape: BoxShape.circle),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 20,
                          width: 150,
                          margin: const EdgeInsets.only(left: 12, bottom: 5),
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                        ),
                        Container(
                          height: 20,
                          width: 150,
                          margin: const EdgeInsets.only(left: 12, bottom: 5),
                          decoration: BoxDecoration(color: AppColor.black, borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < 3; i++)
                  Container(
                    height: 25,
                    width: 250,
                    margin: const EdgeInsets.only(left: 20, bottom: 5),
                    decoration: BoxDecoration(
                      color: AppColor.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
