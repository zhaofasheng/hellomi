import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class CoinAndPointDetailsWidget extends GetView<ProfileController> {
  const CoinAndPointDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) => Container(
        color: AppColor.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            ItemWidget(
              title: EnumLocal.txtMyCoins.name.tr,
              count: (controller.fetchUserProfileModel?.user?.coin ?? 0).toInt(),
              image: AppAssets.icMyCoin,
              gradient: AppColor.orangeYellowGradient,
              callback: () => Get.toNamed(AppRoutes.coinHistoryPage)?.then((value) {
                Utils.onChangeStatusBar(brightness: Brightness.dark);
                controller.scrollController.jumpTo(0.0);
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.count,
    required this.image,
    required this.gradient,
    required this.callback,
  });

  final String title;
  final int count;
  final String image;
  final Gradient gradient;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: SizedBox(
          height: 72,
          child: Stack(
            children: [
              Assets.images.mineYbBack.image(height: 72),
              Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Assets.images.mineYb.image(width: 56),
                    15.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (count).toStringAsFixed(2),
                          style: AppFontStyle.styleW900(AppColor.white, 22),
                        ),

                        0.height,
                        Text(
                          EnumLocal.txtAvailableMyCoins.name.tr,
                          style: AppFontStyle.styleW600(AppColor.white.withValues(alpha: 0.8), 12),
                        ),

                      ],
                    ),
                    const Spacer(),
                    Assets.images.mineWhiteRight.image(width: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
