import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/page/theme_outfit_page/controller/theme_outfit_contoller.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ThemeOutfitAppbarWidget extends StatelessWidget {
  const ThemeOutfitAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeOutfitController>(
      id: ApiParams.outfitUpdate,
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          decoration: const BoxDecoration(color: AppColor.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部标题栏
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.transparent,
                      ),
                      child: Image.asset(AppAssets.icArrowLeft, width: 10),
                    ),
                  ),
                  Text(
                    EnumLocal.txtMyOutfit.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 18),
                  ),
                  const SizedBox(height: 45, width: 45),
                ],
              ),
              4.height,
              // TabBar
              controller.isLoading.value
                  ? const SizedBox()
                  : Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: AppColor.lightGrayBg,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TabBar(
                      isScrollable: true,
                      controller: controller.outfitTabController,
                      indicator: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      unselectedLabelColor: AppColor.secondary,
                      labelColor: AppColor.white,
                      dividerColor: AppColor.transparent,
                      labelPadding: EdgeInsets.zero,
                      onTap: controller.onTabChange,
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        _buildTab(EnumLocal.txtAvtarFrame.name.tr),
                        _buildTab(EnumLocal.txtRides.name.tr),
                        _buildTab(EnumLocal.txtPartyTheme.name.tr),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appFontSemiBold,
          ),
        ),
      ),
    );
  }
}


class ThemeOutfitTabBarWidget extends StatelessWidget {
  const ThemeOutfitTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tabTitles = [
      EnumLocal.txtAvtarFrame.name.tr,
      EnumLocal.txtRides.name.tr,
      EnumLocal.txtPartyTheme.name.tr,
    ];

    return GetBuilder<ThemeOutfitController>(
      id: ApiParams.outfitUpdate,
      builder: (controller) {
        if (controller.isLoading.value) return const SizedBox();

        return SizedBox(
          height: 50,
          child: Row(
            children: List.generate(tabTitles.length, (index) {
              return Expanded(
                child: _OutfitTabItem(
                  title: tabTitles[index],
                  isSelected: controller.outfitTabController!.index == index,
                  onTap: () {
                    controller.outfitTabController!.animateTo(index); // ✅ 切换 tab
                    controller.update(); // ✅ 强制刷新
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _OutfitTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _OutfitTabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned.fill(
                child: CustomPaint(
                  painter: _TabBackgroundPainter(color: AppColor.white), // ✅ 背景色修正
                ),
              ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColor.black : HexColor('#86868F'),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppConstant.appFontSemiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBackgroundPainter extends CustomPainter {
  final Color color;

  _TabBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double arcHeight = 18.0;
    final double arcWidth = 14.0;
    final double topRadius = 30.0;

    final path = Path();

    path.moveTo(0, topRadius);
    path.quadraticBezierTo(0, 0, topRadius, 0);
    path.lineTo(size.width - topRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, topRadius);
    path.lineTo(size.width, size.height - arcHeight);
    path.quadraticBezierTo(
      size.width + arcWidth, size.height + arcHeight,
      size.width - arcWidth, size.height + arcHeight,
    );
    path.lineTo(arcWidth, size.height + arcHeight);
    path.quadraticBezierTo(
      -arcWidth, size.height + arcHeight,
      0, size.height - arcHeight,
    );
    path.lineTo(0, topRadius);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}