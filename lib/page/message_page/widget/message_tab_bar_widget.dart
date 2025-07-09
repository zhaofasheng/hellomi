import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';

class MessageTabBarWidget extends StatelessWidget {
  const MessageTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final messageTypes = [
      EnumLocal.txtAll.name.tr,
      EnumLocal.txtOnline.name.tr,
      EnumLocal.txtUnread.name.tr,
    ];

    return GetBuilder<MessageController>(
      id: AppConstant.onChangeMessageType,
      builder: (controller) => SizedBox(
        height: 40,
        child: Row(
          children: List.generate(messageTypes.length, (index) {
            return Expanded(
              child: _TabItemWidget(
                title: messageTypes[index],
                isSelected: controller.selectedMessageType == index,
                callback: () => controller.onChangeMessageType(index),
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
