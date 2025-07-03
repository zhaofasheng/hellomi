import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/coin_seller_page/widget/coin_trading_text_filed.dart';
import 'package:tingle/page/coin_seller_page/controller/coin_seller_controller.dart';
import 'package:tingle/page/coin_seller_page/widget/user_bottom_sheet_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class TransferWidget extends GetView<CoinSellerController> {
  const TransferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.height,
        CoinTradingTextFiled(
          readOnly: false,
          title: " ${EnumLocal.txtTransferTo.name.tr}",
          controller: controller.uniqueIdController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onEditingComplete: () => controller.onChangeUserName(isSelectedParticularUser: false),
          onChange: (p0) => controller.onChangeUniqueId(),
          hintText: EnumLocal.txtEnterUniqueId.name.tr,
          suffixIcon: SizedBox(
            width: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GetBuilder<CoinSellerController>(
                  id: AppConstant.onChangeUserName,
                  builder: (controller) => Visibility(
                    visible: controller.uniqueIdController.text.trim().isNotEmpty,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Obx(
                        () => Center(
                          child: controller.isCheckingUserName.value
                              ? Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CircularProgressIndicator(color: AppColor.primary, strokeWidth: 2),
                                )
                              : controller.isValidUserName == true
                                  ? Icon(Icons.done_all, color: AppColor.green)
                                  : Image.asset(AppAssets.icClose, color: Colors.red, height: 20, width: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    UserBottomSheetWidget.show(context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      AppAssets.icInviteUserIcon,
                      color: AppColor.primary,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GetBuilder<CoinSellerController>(
          id: AppConstant.onGetUserList,
          builder: (controller) => Visibility(
            visible: controller.selectedUserData != null,
            child: Container(
              height: 30,
              margin: EdgeInsets.only(top: 10),
              width: Get.width,
              color: AppColor.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: PreviewProfileImageWidget(image: controller.selectedUserData?.image ?? '', isBanned: controller.selectedUserData?.isProfilePicBanned),
                  ),
                  8.width,
                  Expanded(
                    child: Text(
                      (controller.selectedUserData?.name ?? ''),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.styleW700(AppColor.black, 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        24.height,
        CoinTradingTextFiled(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          title: " ${EnumLocal.txtTransferCoin.name.tr}",
          controller: controller.amountController,
          hintText: EnumLocal.txtPleaseEnterCoins.name.tr,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Assets.images.tuijianGold.image(width: 24,)
          ),
        ),
      ],
    );
  }
}
