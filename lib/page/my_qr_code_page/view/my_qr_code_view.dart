import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tingle/assets/assets.gen.dart';
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

import '../../../custom/widget/custom_light_background_widget.dart';

class MyQrCodeView extends GetView<MyQrCodeController> {
  const MyQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          Column(
            children: [
              _CustomTopBar(),
              Expanded(child:SizedBox(
                height: Get.height,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      40.height,
                      Screenshot(
                        controller: controller.screenshotController,
                        child: Stack(
                          children: [
                            Assets.images.codeBackground.image(width: 335,height: 374),
                            Container(
                              width: 355,
                              height: 374,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  44.height,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IntrinsicWidth( // 👈 让内容宽度包裹真实宽度
                                        child: Row(
                                          children: [
                                            // 头像
                                            Container(
                                              height: 60,
                                              width: 60,
                                              padding: EdgeInsets.all(1.5),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: AppColor.white, width: 1),
                                              ),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                child: PreviewProfileImageWidget(
                                                  image: Database.fetchLoginUserProfile()?.user?.image,
                                                  isBanned: Database.fetchLoginUserProfile()?.user?.isProfilePicBanned,
                                                ),
                                              ),
                                            ),
                                            10.width,
                                            // 昵称和用户名
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      (Database.fetchLoginUserProfile()?.user?.name ?? ""),
                                                      style: AppFontStyle.styleW700(AppColor.black, 16),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    if (Database.fetchLoginUserProfile()?.user?.isVerified ?? false)
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 3),
                                                        child: Image.asset(AppAssets.icAuthoriseIcon, width: 20),
                                                      ),
                                                  ],
                                                ),
                                                Text(
                                                  (Database.fetchLoginUserProfile()?.user?.userName ?? ""),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: AppFontStyle.styleW400(HexColor('#86868F'), 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  64.height,
                                  QrImageView(
                                    data: "${Database.loginUserId},${false}",
                                    version: QrVersions.auto,
                                    size: 140.0,
                                    eyeStyle: QrEyeStyle(
                                      color: AppColor.black, // ✅ 改为黑色
                                      eyeShape: QrEyeShape.square,
                                    ),
                                    dataModuleStyle: QrDataModuleStyle(
                                      color: AppColor.black,
                                      dataModuleShape: QrDataModuleShape.square,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      30.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          QrCodeItemUi(
                            imageWidget: Assets.images.codeDownload.image(width: 24,height: 24),
                            icon: AppAssets.icDownload,
                            callback: () async => controller.onClickDownload(),
                          ),
                          QrCodeItemUi(
                            imageWidget: Assets.images.codeDh.image(width: 24,height: 24),
                            icon: AppAssets.icWhatsapp,
                            callback: () async => controller.onClickWhatsapp(),
                          ),
                          QrCodeItemUi(
                            imageWidget: Assets.images.codeUnn.image(width: 24,height: 24),
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
                          style: AppFontStyle.styleW700(AppColor.black, 16),
                        ),
                      ),
                      10.height,
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          EnumLocal.txtMyQRCodeText.name.tr,
                          style: AppFontStyle.styleW400(HexColor('#999999'), 12),
                        ),
                      ),
                      50.height,
                    ],
                  ),
                ),
              ),),
            ],
          )

        ],
      ),
    );
  }
}

class _CustomTopBar extends StatelessWidget {
  const _CustomTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 左侧返回按钮
          Positioned(
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back_ios, color: AppColor.black, size: 20),
            ),
          ),
          // 居中标题
          Center(
            child: Text(
              EnumLocal.txtMyQRCode.name.tr,
              style: AppFontStyle.styleW700(AppColor.black, 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 右侧图标按钮
          Positioned(
            right: 20,
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.scanQrCodePage),
              child: Image.asset(AppAssets.icScanQr, width: 22, height: 22),
            ),
          ),
        ],
      ),
    );
  }
}

