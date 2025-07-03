import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
class PreviewProfileTabBarWidget extends StatelessWidget {
  const PreviewProfileTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onChangeTab,
      builder: (controller) => Container(
        height: 40,
        decoration: BoxDecoration(
          color: HexColor('#F5F5F5'), // 半透明背景
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: List.generate(3, (index) {
            final titles = [
              EnumLocal.txtData.name.tr,
              EnumLocal.txtMoments.name.tr,
              EnumLocal.txtWonderfulMoments.name.tr,
            ];
            return Expanded(
              child: _TabItemWidget(
                title: titles[index],
                isSelected: controller.selectedTabIndex == index,
                callback: () => controller.onChangeTab(index),
              ),
            );
          }),
        ),
      ),
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
        height: 60,
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
                style: TextStyle(
                  color: isSelected ? HexColor('#00E4A6') : Colors.grey,
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
