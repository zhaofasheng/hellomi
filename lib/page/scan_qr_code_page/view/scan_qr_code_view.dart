import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/scan_qr_code_page/controller/scan_qr_code_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ScanQrCodeView extends GetView<ScanQrCodeController> {
  const ScanQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SimpleAppBarWidget.onShow(
          context: context,
          title: EnumLocal.txtScanQRCode.name.tr,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.height,
            GradiantBorderContainer(
              height: 265,
              radius: 22,
              child: Container(
                height: 265,
                width: 265,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MobileScanner(
                  controller: controller.mobileScannerController,
                  onDetect: (barcodes) async => controller.onDetect(context: context, barcodes: barcodes),
                ),
              ),
            ),
            20.height,
            Text(
              EnumLocal.txtScanQRCodeText.name.tr,
              maxLines: 1,
              style: AppFontStyle.styleW400(AppColor.grayText, 17),
            ),
            10.height,
            Image.asset(
              AppAssets.imgScanImage,
              height: 230,
            ),
          ],
        ),
      ),
    );
  }
}

class GradiantBorderContainer extends StatelessWidget {
  const GradiantBorderContainer({super.key, required this.height, this.width, required this.radius, this.child});

  final double height;
  final double? width;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: DottedBorder(
        dashPattern: const [3, 6],
        borderType: BorderType.RRect,
        color: AppColor.colorScaffold,
        radius: Radius.circular(radius),
        padding: const EdgeInsets.all(1.5),
        strokeWidth: 5,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColor.colorScaffold,
            borderRadius: BorderRadius.circular(radius - 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
