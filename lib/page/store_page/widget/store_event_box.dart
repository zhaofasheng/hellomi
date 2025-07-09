import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class StoreEventBoxWidget extends StatelessWidget {
  const StoreEventBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              ItemWidget(
                imageWidget: Assets.images.avaterImg.image(width: 30),
                title: EnumLocal.txtAvtarTheme.name.tr,
                image: AppAssets.icAvtarFrame,
                callback: () {
                  Get.toNamed(AppRoutes.avtarFramePage);
                },
              ),
              ItemWidget(
                imageWidget: Assets.images.shopParty.image(width: 30),
                title: EnumLocal.txtPartyTheme.name.tr,
                image: AppAssets.icTheme,
                callback: () {
                  Get.toNamed(AppRoutes.partyFramePage);
                },
              ),
              ItemWidget(
                imageWidget: Assets.images.shopGame.image(width: 30),
                title: EnumLocal.txtRides.name.tr,
                image: AppAssets.icRide,
                callback: () {
                  Get.toNamed(AppRoutes.rideFramePage);
                },
              ),
            ],
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
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: callback,
          child: Column(
            children: [
              Container(
                height: 54,
                width: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 2, color: AppColor.white),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.secondary.withValues(alpha: 0.05),
                      spreadRadius: 2,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: imageWidget ?? Image.asset(
                  image,
                  width: 30,
                ),
              ),
              4.height,
              Text(
                title,
                style: AppFontStyle.styleW500(HexColor('#86868F'), 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
