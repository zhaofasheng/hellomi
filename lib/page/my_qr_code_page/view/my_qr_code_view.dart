import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/my_qr_code_page/controller/my_qr_code_controller.dart';
import 'package:tingle/page/my_qr_code_page/widget/my_qr_code_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MyQrCodeView extends GetView<MyQrCodeController> {
  const MyQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: SimpleAppBarWidget.onShow(
        context: context,
        title: EnumLocal.txtMyQRCode.name.tr,
        icon: AppAssets.icScanQr,
        callBack: () => Get.toNamed(AppRoutes.scanQrCodePage),
      ),
      body: SizedBox(
        height: Get.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.height,
              Screenshot(
                controller: controller.screenshotController,
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: Get.width / 11),
                  decoration: BoxDecoration(
                    gradient: AppColor.primaryGradient,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Column(
                    children: [
                      40.height,
                      QrImageView(
                        data: "${Database.loginUserId},${false}",
                        version: QrVersions.auto,
                        size: 140.0,
                        eyeStyle: QrEyeStyle(color: AppColor.white, eyeShape: QrEyeShape.square),
                        dataModuleStyle: QrDataModuleStyle(color: AppColor.white, dataModuleShape: QrDataModuleShape.square),
                      ),
                      12.height,
                      Divider(
                        indent: 30,
                        endIndent: 30,
                        thickness: 0.5,
                        color: AppColor.white.withValues(alpha: 0.5),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        padding: EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.white, width: 1),
                        ),
                        child: Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: PreviewProfileImageWidget(
                            image: Database.fetchLoginUserProfile()?.user?.image,
                            isBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned,
                          ),
                        ),
                      ),
                      5.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                (Database.fetchLoginUserProfile()?.user?.name ?? ""),
                                style: AppFontStyle.styleW700(AppColor.white, 18),
                              ),
                            ),
                            Visibility(
                              visible: Database.fetchLoginUserProfile()?.user?.isVerified ?? false,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Image.asset(AppAssets.icAuthoriseIcon, width: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          (Database.fetchLoginUserProfile()?.user?.userName ?? ""),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.styleW400(AppColor.white, 13),
                        ),
                      ),
                      20.height,
                    ],
                  ),
                ),
              ),
              30.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QrCodeItemUi(
                    icon: AppAssets.icDownload,
                    callback: () async => controller.onClickDownload(),
                  ),
                  QrCodeItemUi(
                    icon: AppAssets.icWhatsapp,
                    callback: () async => controller.onClickWhatsapp(),
                  ),
                  QrCodeItemUi(
                    icon: AppAssets.icCopy,
                    callback: () async => controller.onClickCopy(),
                  ),
                  QrCodeItemUi(
                    icon: AppAssets.icMore,
                    callback: () async => controller.onClickShare(),
                  ),
                ],
              ),
              30.height,
              Center(
                child: Text(
                  EnumLocal.txtScanQRCode.name.tr,
                  style: AppFontStyle.styleW700(AppColor.black, 22),
                ),
              ),
              10.height,
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  EnumLocal.txtMyQRCodeText.name.tr,
                  style: AppFontStyle.styleW400(AppColor.grayText, 12),
                ),
              ),
              50.height,
            ],
          ),
        ),
      ),
    );
  }
}
