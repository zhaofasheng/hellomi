import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class RichTabBarWidget extends StatelessWidget {
  const RichTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeRichTabBar,
      builder: (controller) => Container(
        height: 40,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.1), // 背景半透明
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: List.generate(3, (index) {
            final titles = [
              EnumLocal.txtDaily.name.tr,
              EnumLocal.txtWeekly.name.tr,
              EnumLocal.txtMonthly.name.tr,
            ];
            return Expanded(
              child: _TabItemWidget(
                title: titles[index],
                isSelected: controller.selectedRichTabIndex == index,
                callback: () => controller.onChangeRichTabBar(index),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback callback;

  const _TabItemWidget({
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        height: 60,
        child: Stack(
          clipBehavior: Clip.none, // 允许撇出弧形
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
                style: TextStyle(
                  color: isSelected ? Colors.green : Colors.grey,
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

    final double arcHeight = 28.0;
    final double arcWidth = 64.0;
    final double topRadius = 16.0;

    final path = Path();

    // 左上圆角起点
    path.moveTo(0, topRadius);
    path.quadraticBezierTo(0, 0, topRadius, 0); // 左上角圆角

    // 顶部直线到右上角
    path.lineTo(size.width - topRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, topRadius); // 右上角圆角

    // 右边线到底部前
    path.lineTo(size.width, size.height - arcHeight);

    // 右底角向外撇（撇）
    path.quadraticBezierTo(
      size.width + arcWidth, size.height + arcHeight,
      size.width - arcWidth, size.height + arcHeight,
    );

    // 左底角向外撇（捺）
    path.lineTo(arcWidth, size.height + arcHeight);
    path.quadraticBezierTo(
      -arcWidth, size.height + arcHeight,
      0, size.height - arcHeight,
    );

    path.lineTo(0, topRadius); // 关闭路径
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GiftTabBarWidget extends StatelessWidget {
  const GiftTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeGiftTabBar,
      builder: (controller) => Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.1), // 背景色
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GiftTabItemWidget(
              title: EnumLocal.txtDaily.name.tr,
              isSelected: controller.selectedGiftTabIndex == 0,
              callback: () => controller.onChangeGiftTabBar(0),
            ),
            10.width,
            _GiftTabItemWidget(
              title: EnumLocal.txtWeekly.name.tr,
              isSelected: controller.selectedGiftTabIndex == 1,
              callback: () => controller.onChangeGiftTabBar(1),
            ),
            10.width,
            _GiftTabItemWidget(
              title: EnumLocal.txtMonthly.name.tr,
              isSelected: controller.selectedGiftTabIndex == 2,
              callback: () => controller.onChangeGiftTabBar(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _GiftTabItemWidget extends StatelessWidget {
  const _GiftTabItemWidget({
    super.key,
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
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.white : AppColor.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW500(
            isSelected ? AppColor.primary : HexColor('#A8A8AC'),
            13,
          ),
        ),
      ),
    );
  }
}

class GiftSubTabBarWidget extends StatelessWidget {
  const GiftSubTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RankingController>(
      id: AppConstant.onChangeGiftTabBar,
      builder: (controller) => Container(
        height: 40,
        width: Get.width,
        color: AppColor.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SubTabItemWidget(
              title: EnumLocal.txtTopSender.name.tr,
              isSelected: controller.selectedGiftSubTabIndex == 0,
              callback: () => controller.onChangeGiftSubTabBar(0),
            ),
            15.width,
            _SubTabItemWidget(
              title: EnumLocal.txtTopReceiver.name.tr,
              isSelected: controller.selectedGiftSubTabIndex == 1,
              callback: () => controller.onChangeGiftSubTabBar(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubTabItemWidget extends StatelessWidget {
  const _SubTabItemWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColor.white :  AppColor.white.withOpacity(0.4),
        ),
        child: Text(
          title,
          style: AppFontStyle.styleW500(isSelected ? AppColor.primary : HexColor('#A8A8AC'), 13),
        ),
      ),
    );
  }
}
