import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      id: AppConstant.onChangeBottomBar,
      builder: (logic) {
        return Obx(
          () => Container(
            height: AppConstant.bottomBarSize.toDouble(),
            color: Utils.isExtendBody.value ? AppColor.transparent : AppColor.white,
            width: Get.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ItemWidget(
                  icon: logic.selectedTabIndex == 0 ? Assets.images.icLiveChoice.image(width: 30,height: 30) : Assets.images.icLiveNomer.image(width: 30,height: 30),
                  callback: () => logic.onChangeBottomBar(0),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 1 ? Assets.images.partyChoice.image(width: 30,height: 30) : Assets.images.partyNomer.image(width: 30,height: 30),
                  callback: () => logic.onChangeBottomBar(1),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 2 ? Assets.images.dongtaiNomer.image(width: 30,height: 30) : Assets.images.dongtaiChoice.image(width: 30,height: 30),
                  callback: () => logic.onChangeBottomBar(2),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 3 ? Assets.images.messageChoice.image(width: 30,height: 30) : Assets.images.messageNomer.image(width: 30,height: 30),
                  callback: () => logic.onChangeBottomBar(3),
                ),
                ItemWidget(
                  icon: logic.selectedTabIndex == 4 ? Assets.images.mineChoice.image(width: 30,height: 30) : Assets.images.mineNomer.image(width: 30,height: 30),
                  callback: () => logic.onChangeBottomBar(4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.icon, required this.callback});

  final Widget icon;

  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 15),
          child: icon,
        ),
      ),
    );
  }
}
