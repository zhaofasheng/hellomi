import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';

class ConnectionAppBarWidget extends StatelessWidget {
  const ConnectionAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;

    return GetBuilder<ConnectionController>(
      id: AppConstant.onTabBarTap,
      builder: (controller) {
        final tabTitles = [
          EnumLocal.txtFriends.name.tr,
          EnumLocal.txtFollow.name.tr,
          EnumLocal.txtFollowers.name.tr,
          EnumLocal.txtVisitors.name.tr,
        ];

        return Container(
          width: Get.width,
          padding: EdgeInsets.only(top: statusBarHeight),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部导航栏 Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: const SizedBox(
                        height: 60,
                        width: 45,
                        child: Center(
                          child: Image(
                            image: AssetImage(AppAssets.icArrowLeft),
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.selectedCount.value == 0
                            ? controller.mainTitle.value
                            : "${controller.mainTitle.value}(${controller.selectedCount})",
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.onSearchData();
                        Get.toNamed(AppRoutes.searchConnectionPage);
                      },
                      child: const SizedBox(
                        height: 45,
                        width: 45,
                        child: Center(
                          child: Image(
                            image: AssetImage(AppAssets.icSearch),
                            width: 25,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // TabBar 样式
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SizedBox(
                  height: 40,
                  child: Row(
                    children: List.generate(tabTitles.length, (index) {
                      return Expanded(
                        child: _TabItemWidget(
                          title: tabTitles[index],
                          isSelected: controller.tabController?.index == index,
                          callback: () {
                            controller.tabController?.animateTo(index);
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  const _TabItemWidget({
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final bool isSelected;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: 40,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomPaint(
                  size: const Size(double.infinity, 60),
                  painter: _TabBackgroundPainter(color: Colors.white),
                ),
              ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? AppColor.black : Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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

    const double arcHeight = 28.0;
    const double arcWidth = 64.0;
    const double topRadius = 16.0;

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
