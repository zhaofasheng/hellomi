import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PurchaseCoinWidget extends StatelessWidget {
  const PurchaseCoinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeCoinController>(
      id: AppConstant.onGetCoinPlan,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtPurchaseCoins.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          15.height,
          GridView.builder(
            itemCount: controller.coinPlans.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 100,
            ),
              itemBuilder: (BuildContext context, int index) {
                final indexData = controller.coinPlans[index];
                return _ItemWidget(
                  callback: () => controller.onChoiceProduct(index: index, context: context),
                  amount: (indexData.amount ?? 0).toDouble(),
                  coin: (indexData.coin ?? 0).toInt(),
                  isPopular: indexData.isPopular ?? false,
                  isSelected: controller.selectedProductIndex == index,
                );
              }
          ),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.coin,
    required this.amount,
    required this.isPopular,
    required this.isSelected,
    required this.callback,
  });

  final int coin;
  final double amount;
  final bool isPopular;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? HexColor('#09E6AA') : AppColor.white;
    final textColor = isSelected ? AppColor.white : AppColor.black;
    final subTextColor = isSelected ? AppColor.white : HexColor('#A8A8AC');

    return SizedBox(
      child: Stack(
        children: [
          GestureDetector(
            onTap: callback,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Column(
                children: [
                  25.height,
                  Text(
                    "${CustomFormatNumber.onConvert(coin)} ${EnumLocal.txtCoin.name.tr}",
                    style: AppFontStyle.styleW800(textColor, 11),
                  ),
                  8.height,
                  Text(
                    "${Utils.currencySymbol} ${CustomFormatNumber.onConvert(amount.toInt())}",
                    style: AppFontStyle.styleW500(subTextColor, 12),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isPopular,
            child: Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 20,
                width: 100,
                decoration: BoxDecoration(
                  color: HexColor('#09E6AA'),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Text(
                      EnumLocal.txtMostPopularPlan.name.tr,
                      style: AppFontStyle.styleW700(AppColor.white, 8),
                      overflow: TextOverflow.visible,
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
