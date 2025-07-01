import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/page/recharge_coin_page/controller/recharge_coin_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class PaymentGatewayWidget extends StatelessWidget {
  const PaymentGatewayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeCoinController>(
      id: AppConstant.onChangePayment,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.height,
          Text(
            EnumLocal.txtSelectPaymentGateway.name.tr,
            style: AppFontStyle.styleW700(AppColor.black, 16),
          ),
          15.height,
          Column(
            children: [
              _ListItemWidget(
                icon: Assets.images.payNewPay.image(width: 32,height: 32),
                title: 'newpay', // 替换成 EnumLocal.txtNewPay.tr 如有定义
                isSelected: controller.selectedPaymentIndex == 0,
                onTap: () => controller.onChangePayment(0),
                visible: true,
              ),
              _ListItemWidget(
                icon: Assets.images.payStripe.image(width: 32,height: 32),
                title: 'stripe',
                isSelected: controller.selectedPaymentIndex == 1,
                onTap: () => controller.onChangePayment(1),
                visible: Utils.isShowStripePaymentMethod,
              ),
              _ListItemWidget(
                icon: Assets.images.payApple.image(width: 32,height: 32),
                title: 'Appple pay', // 替换成 EnumLocal.txtApplePay.tr 如有定义
                isSelected: controller.selectedPaymentIndex == 2,
                onTap: () => controller.onChangePayment(2),
                visible: Utils.isShowInAppPurchasePaymentMethod,
              ),
            ],
          ),
          15.height,
        ],
      ),
    );
  }
}

class _ListItemWidget extends StatelessWidget {
  const _ListItemWidget({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.visible,
  });

  final Widget icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColor.primary : AppColor.colorBorder.withOpacity(0.3),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              icon,
              12.width,
              Expanded(
                child: Text(
                  title,
                  style: AppFontStyle.styleW500(AppColor.black, 14),
                ),
              ),
          isSelected ? Assets.images.payYes.image(width: 24,height: 24) : Assets.images.payNo.image(width: 24,height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.icon,
    required this.boxWidth,
    required this.iconSize,
    required this.isSelected,
    required this.callback,
    this.margin,
    required this.visible,
  });

  final String icon;
  final double boxWidth;
  final double iconSize;
  final bool isSelected;
  final EdgeInsetsGeometry? margin;
  final Callback callback;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: 40,
          width: boxWidth,
          alignment: Alignment.center,
          margin: margin,
          decoration: BoxDecoration(
            color: AppColor.colorBorder.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColor.orange : AppColor.transparent),
          ),
          child: Image.asset(icon, width: iconSize),
        ),
      ),
    );
  }
}
