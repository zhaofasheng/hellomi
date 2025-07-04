import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class CustomRankSliderWidget extends StatelessWidget {
  const CustomRankSliderWidget({super.key, required this.rank1, required this.rank2, required this.width, required this.height});

  final int rank1;
  final int rank2;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final int totalRank = rank1 + rank2;

    if (totalRank == 0) {
      return Stack(
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    height: height,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                      color: HexColor('#00E4A6'),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(100)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        3.width,
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(AppAssets.icCircleBlurStar, width: 17),
                        ),
                        3.width,
                        Text(
                          "0",
                          style: AppFontStyle.styleW700(AppColor.white, 11),
                        ),
                        5.width,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height,
                  width: 30,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: -2,
                        child: Container(height: height, width: 17, color: HexColor('#00E4A6')),
                      ),
                      Positioned(
                        right: -2,
                        child: Container(height: height, width: 17, color: HexColor('#FFD45B')),
                      ),
                      Assets.icons.pkFlashImg.image(width: 30),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedContainer(
                    height: height,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.linear,
                    decoration: BoxDecoration(
                      color: HexColor('#FFD45B'),
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(100)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        5.width,
                        Text(
                          "0",
                          style: AppFontStyle.styleW700(AppColor.white, 11),
                        ),
                        3.width,
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Image.asset(AppAssets.icCircleBlurStar, width: 17),
                        ),
                        3.width,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Assets.images.pkLineImg.image(width: width),
        ],
      );
    }

    final double user1WidthRatio = rank1 / totalRank;
    final double user2WidthRatio = rank2 / totalRank;

    // Minimum width for sliders
    const double minWidth = 100.0;

    final double user1Width = (width * user1WidthRatio).clamp(minWidth, width - minWidth);
    final double user2Width = (width * user2WidthRatio).clamp(minWidth, width - minWidth);

    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Row(
            children: [
              AnimatedContainer(
                height: height,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.linear,
                width: user1Width - 15,
                decoration: BoxDecoration(
                  color: AppColor.blue,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(100)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    3.width,
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Image.asset(AppAssets.icCircleBlurStar, width: 17),
                    ),
                    3.width,
                    Text(
                      rank1.toStringAsFixed(0),
                      style: AppFontStyle.styleW700(AppColor.white, 11),
                    ),
                    5.width,
                  ],
                ),
              ),
              SizedBox(
                height: height,
                width: 30,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: -2,
                      child: Container(height: height, width: 17, color: AppColor.blue),
                    ),
                    Positioned(
                      right: -2,
                      child: Container(height: height, width: 17, color: AppColor.pink),
                    ),
                    Assets.icons.pkFlashImg.image(width: 30),
                  ],
                ),
              ),
              AnimatedContainer(
                height: height,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.linear,
                width: user2Width - 15,
                decoration: BoxDecoration(
                  color: AppColor.pink,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(100)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    5.width,
                    Text(
                      rank2.toStringAsFixed(0),
                      style: AppFontStyle.styleW700(AppColor.white, 11),
                    ),
                    3.width,
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Image.asset(AppAssets.icCircleBlurStar, width: 17),
                    ),
                    3.width,
                  ],
                ),
              ),
            ],
          ),
        ),
        Assets.images.pkLineImg.image(width: width),
      ],
    );
  }
}

