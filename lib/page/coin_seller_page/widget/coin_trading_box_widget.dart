import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/coin_seller_page/controller/coin_seller_controller.dart';
import 'package:tingle/page/coin_seller_page/widget/coin_seller_history_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class CoinTradingBoxWidget extends GetView<CoinSellerController> {
  const CoinTradingBoxWidget({super.key});

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
                            Container(
                              height: 30,
                              width: 110,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                EnumLocal.txtCoinTrading.name.tr,
                                style: AppFontStyle.styleW500(AppColor.white, 12),
                              ),
                            ),
                            Spacer(),
                            // Image.asset(
                            //   AppAssets.icCoinTradingDetailIcon,
                            //   height: 20,
                            //   fit: BoxFit.cover,
                            // ),
                            // 4.width,

                            Text(
                              EnumLocal.txtCoinTradingDetails.name.tr,
                              style: AppFontStyle.styleW600(AppColor.white, 12),
                            ),
                          ],
                        ),
                        10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.tuijianGold.image(width: 45,),
                            10.width,
                            GetBuilder<CoinSellerController>(
                              id: ApiParams.onGetCoinSellerHistory,
                              builder: (controller) => Text(
                                Utils.isDemoApp ? CustomFormatNumber.onConvert(5000) : CustomFormatNumber.onConvert(controller.fetchCoinSellerModel?.data?.coin ?? 0),
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: AppColor.white,
                                  fontFamily: AppConstant.appFontBold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 2,
                                      color: Colors.black.withValues(alpha: 0.3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                controller.onRefreshHistory();
                                Get.to(() => CoinSellerHistoryWidget());
                              },
                              child: Container(
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Assets.images.ybjioayiHistory.image(width: 20),
                                    4.width,
                                    Text(
                                      EnumLocal.txtHistory.name.tr,
                                      style: AppFontStyle.styleW500(AppColor.orange, 14),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 10),
                              ),
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
