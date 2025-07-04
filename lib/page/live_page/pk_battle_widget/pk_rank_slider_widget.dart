import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class PkRankSliderWidget extends StatelessWidget {
  const PkRankSliderWidget({
    super.key,
    required this.rank1,
    required this.rank2,
    required this.width,
    required this.height,
  });

  final int rank1;
  final int rank2;
  final double height;
  final double width;

  Widget _buildSlider({
    required double sliderWidth,
    required Color color,
    required String text,
    required bool isLeft,
  }) {
    return Container(
      height: height,
      width: sliderWidth,
      decoration: BoxDecoration(
        color: color,
      ),
      child: Row(
        mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: isLeft
            ? [
          3.width,
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Image.asset(AppAssets.icCircleBlurStar, width: 17),
          ),
          3.width,
          Text(
            text,
            style: AppFontStyle.styleW700(AppColor.white, 11),
          ),
          5.width,
        ]
            : [
          5.width,
          Text(
            text,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalRank = rank1 + rank2;

    // 👇 设置颜色（可替换为统一的AppColor.xxx）
    final Color leftColor = HexColor('#00E4A6');
    final Color rightColor = HexColor('#FFD45B');

    final String leftText = rank1.toString();
    final String rightText = rank2.toString();

    // 👇 中间部分宽度固定为30，两侧间距预留15
    const double middleBlockWidth = 30;
    const double minSliderWidth = 100.0;
    const double sidePadding = 15;

    // 👇 计算滑块宽度（总是加起来 = width - middleBlockWidth）
    final double totalSliderWidth = width - middleBlockWidth;

    final double leftRatio = totalRank == 0 ? 0.5 : rank1 / totalRank;
    final double rightRatio = totalRank == 0 ? 0.5 : rank2 / totalRank;

    final double leftWidth =
    (totalSliderWidth * leftRatio).clamp(minSliderWidth, totalSliderWidth - minSliderWidth);
    final double rightWidth =
    (totalSliderWidth * rightRatio).clamp(minSliderWidth, totalSliderWidth - minSliderWidth);

    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Row(
            children: [
              // 左侧滑块
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.linear,
                child: _buildSlider(
                  sliderWidth: leftWidth,
                  color: leftColor,
                  text: leftText,
                  isLeft: true,
                ),
              ),

              // 中间 PK 闪电图和两侧补色
              SizedBox(
                width: middleBlockWidth,
                height: height,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(left: -2, child: Container(width: 17, height: height, color: leftColor)),
                    Positioned(right: -2, child: Container(width: 17, height: height, color: rightColor)),
                    Assets.icons.pkFlashImg.image(width: middleBlockWidth),
                  ],
                ),
              ),

              // 右侧滑块
              AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.linear,
                child: _buildSlider(
                  sliderWidth: rightWidth,
                  color: rightColor,
                  text: rightText,
                  isLeft: false,
                ),
              ),
            ],
          ),
        ),

        // 底部的PK分隔线图片
        Assets.images.pkLineImg.image(width: width),
      ],
    );
  }
}