import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/fetch_user_coin.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class CoinBoxWidget extends StatelessWidget {
  const CoinBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: LayoutBuilder(
        builder: (context, box) {
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Assets.images.jinbiBack.image(fit: BoxFit.cover),
              Positioned(
                top: 15,
                child: SizedBox(
                  height: box.maxHeight,
                  width: box.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 120,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.white.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    EnumLocal.txtRemainingCoins.name.tr,
                                    style: AppFontStyle.styleW500(AppColor.white, 12),
                                  ),
                                ),
                                10.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Assets.images.tuijianGold.image(width: 45),
                                    10.width,
                                    Obx(
                                      () => Text(
                                        CustomFormatNumber.onConvert(FetchUserCoin.coin.value),
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: AppColor.white,
                                          fontFamily: AppConstant.appFontBold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                final profileController = Get.find<ProfileController>();
                                if (Utils.isDemoApp || profileController.fetchUserProfileModel?.user?.wealthLevel?.permissions?.redeemCashout == true) {
                                  Get.toNamed(AppRoutes.withdrawPage);
                                } else {
                                  Utils.showToast(text: EnumLocal.txtTopUpYourBalanceToReachTheNext.name.tr);
                                }
                              },
                              child: IntrinsicWidth(
                                child: Container(
                                  height: 32,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Assets.images.getJinbi.image(width: 24, height: 24),
                                      5.width,
                                      Text(
                                        EnumLocal.txtWithdraw.name.tr,
                                        style: AppFontStyle.styleW700(AppColor.orange, 13),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
