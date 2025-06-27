import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/delete_dialog_widget.dart';
import 'package:tingle/common/widget/log_out_dialog_widget.dart';
import 'package:tingle/page/setting_page/controller/setting_controller.dart';
import 'package:tingle/page/setting_page/widget/setting_app_bar_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 200);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: SettingAppBarWidget.onShow(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 60,
                width: Get.width,
                color: AppColor.white,
                child: Row(
                  children: [
                    15.width,
                    Expanded(
                      child: Text(
                        EnumLocal.txtNotifyMe.name.tr,
                        style: AppFontStyle.styleW500(AppColor.black, 14),
                      ),
                    ),
                    GetBuilder<SettingController>(
                      id: AppConstant.onSwitchNotification,
                      builder: (controller) => GestureDetector(
                        onTap: () => controller.onSwitchNotification(),
                        child: Container(
                          height: 65,
                          width: 70,
                          color: AppColor.transparent,
                          alignment: Alignment.centerRight,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: controller.isShowNotification,
                              activeTrackColor: AppColor.primary,
                              onChanged: (value) => controller.onSwitchNotification(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _ItemWidget(
              name: EnumLocal.txtBlockedUserList.name.tr,
              isShowRightArrow: true,
              callback: () => Get.toNamed(AppRoutes.blockUserPage),
            ),
            _DividerWidget(),
            _ItemWidget(
              name: EnumLocal.txtLanguages.name.tr,
              isShowRightArrow: true,
              callback: () => Get.toNamed(AppRoutes.languagePage),
            ),
            _DividerWidget(),
            _ItemWidget(
              name: EnumLocal.txtPrivacyPolicy.name.tr,
              isShowRightArrow: true,
              callback: () => Get.toNamed(AppRoutes.privacyPolicyPage),
            ),
            _DividerWidget(),
            _ItemWidget(
              name: EnumLocal.txtTermsOfUse.name.tr,
              isShowRightArrow: true,
              callback: () => Get.toNamed(AppRoutes.termsOfUsePage),
            ),
            15.height,
            _ItemWidget(
              name: EnumLocal.txtLogOut.name.tr,
              isShowRightArrow: false,
              style: AppFontStyle.styleW600(AppColor.red, 14),
              callback: () => LogOutDialogWidget.onShow(),
            ),
            _DividerWidget(),
            _ItemWidget(
              name: EnumLocal.txtDeleteAccount.name.tr,
              isShowRightArrow: false,
              style: AppFontStyle.styleW600(AppColor.red, 14),
              callback: () {
                DeleteDialogWidget.onShow(
                  height: 420,
                  title: EnumLocal.txtDeleteAccount.name.tr,
                  description: EnumLocal.txtDeleteAccountText.name.tr,
                  callBack: () => Database.onDeleteAccount(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({required this.name, required this.isShowRightArrow, this.style, required this.callback});

  final String name;
  final bool isShowRightArrow;
  final TextStyle? style;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 60,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(color: AppColor.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: style ?? AppFontStyle.styleW500(AppColor.black, 14),
            ),
            Visibility(
              visible: isShowRightArrow,
              child: Image.asset(
                AppAssets.icArrowRight,
                width: 8,
                color: AppColor.secondary.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DividerWidget extends StatelessWidget {
  const _DividerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 2,
        color: AppColor.backgroundColor,
      ),
    );
  }
}
