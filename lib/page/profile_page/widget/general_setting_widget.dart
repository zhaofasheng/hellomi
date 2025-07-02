import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class GeneralSettingWidget extends GetView<ProfileController> {
  const GeneralSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> role = controller.fetchUserProfileModel?.user?.role ?? [];

    return Container(
      width: Get.width,
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.only(bottom: 8, left: 15, right: 15, top: 8),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 5,
          mainAxisExtent: 100,
        ),
        children: [
          if (role.contains(1) && !role.contains(3) && !role.contains(2)) // If User && Not Agency && Not Host
            ItemWidget(
              title: EnumLocal.txtHostRequest.name.tr,
              image: AppAssets.icHostRequest,
              imageWidget: Assets.images.mineMainRequest.image(width: 26),
              callback: () => Get.toNamed(AppRoutes.hostRequestPage),
            ),

          // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Demo App Icon <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
          if (Utils.isDemoApp)
            ItemWidget(
              title: "Demo Agency",
              // title: EnumLocal.txtMyAgency.name.tr,
              image: AppAssets.icMyAgencyIcon,
              callback: () => Get.toNamed(
                AppRoutes.agencyPage,
                arguments: Utils.demoAgencyId,
              ),
            ),
          if (Utils.isDemoApp)
            ItemWidget(
              title: "Demo Host",
              // title: EnumLocal.txtHostCenter.name.tr,
              image: AppAssets.icHostCenter,
              callback: () => Get.toNamed(
                AppRoutes.hostCenterPage,
                arguments: Utils.demoHostCenterId,
              ),
            ),
          if (Utils.isDemoApp)
            ItemWidget(
              title: EnumLocal.txtCoinTrading.name.tr,
              image: AppAssets.icCoinTradingIcon,
              callback: () => Get.toNamed(AppRoutes.coinSellerPage),
            ),

          // >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Demo App Icon <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

          if (!Utils.isDemoApp && role.contains(2)) // If Host
            ItemWidget(
              title: EnumLocal.txtHostCenter.name.tr,
              image: AppAssets.icHostCenter,
              callback: () => Get.toNamed(
                AppRoutes.hostCenterPage,
                arguments: Database.loginUserId,
              ),
            ),
          if (!Utils.isDemoApp && role.contains(3)) // If Agency
            ItemWidget(
              title: EnumLocal.txtMyAgency.name.tr,
              image: AppAssets.icMyAgencyIcon,
              callback: () => Get.toNamed(
                AppRoutes.agencyPage,
                arguments: controller.fetchUserProfileModel?.user?.agencyOwnerId ?? "",
              ),
            ),
          if (!Utils.isDemoApp && role.contains(4)) // If CoinSeller
            ItemWidget(
              title: EnumLocal.txtCoinTrading.name.tr,
              image: AppAssets.icCoinTradingIcon,
              imageWidget: Assets.images.yiongbiJy.image(width: 26),
              callback: () => Get.toNamed(AppRoutes.coinSellerPage),
            ),
          ItemWidget(
            title: EnumLocal.txtLevel.name.tr,
            image: AppAssets.icLevelIcon,
            imageWidget: Assets.images.mineLevle.image(width: 26),
            callback: () => Get.toNamed(AppRoutes.levelPage),
          ),
          ItemWidget(
            title: EnumLocal.txtMyQRCode.name.tr,
            image: AppAssets.icMyQr,
            imageWidget: Assets.images.mineQrCode.image(width: 26),
            callback: () {
              Get.toNamed(AppRoutes.myQrCodePage)?.then((value) {
                Utils.onChangeStatusBar(brightness: Brightness.dark);
                controller.scrollController.jumpTo(0.0);
              });
            },
          ),
          ItemWidget(
            title: EnumLocal.txtHelp.name.tr,
            image: AppAssets.icHelpIcon,
            imageWidget: Assets.images.mineHelp.image(width: 26),
            callback: () => Get.toNamed(AppRoutes.helpPage)?.then((value) {
              Utils.onChangeStatusBar(brightness: Brightness.dark);
              controller.scrollController.jumpTo(0.0);
            }),
          ),
          if (!Utils.isDemoApp)
            ItemWidget(
              title: EnumLocal.txtAboutUs.name.tr,
              imageWidget: Assets.images.mineAbout.image(width: 26),
              image: AppAssets.icAboutUsIcon,
              callback: () => Get.toNamed(AppRoutes.aboutUsPage),
            ),
          ItemWidget(
            title: EnumLocal.txtSettings.name.tr,
            imageWidget: Assets.images.mineSet.image(width: 26),
            image: AppAssets.icSettingIcon,
            callback: () => Get.toNamed(AppRoutes.settingPage),
          ),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.callback, this.imageWidget,
  });

  final String title;
  final String image;
  final Widget? imageWidget;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.transparent,
      child: GestureDetector(
        onTap: callback,
        child: Column(
          children: [
            Container(
              height: 54,
              width: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: HexColor('#F8F8F8'),
                borderRadius: BorderRadius.circular(15),
              ),
              child: imageWidget ?? Image.asset(
                image,
                width: 26,
              ),
            ),
            5.height,
            SizedBox(
              width: 54,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppFontStyle.styleW500(AppColor.black, 11),
              ),
            )
          ],
        ),
      ),
    );
  }
}
