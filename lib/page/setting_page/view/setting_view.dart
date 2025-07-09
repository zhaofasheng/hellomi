import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
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

import '../../../custom/widget/custom_light_background_widget.dart';
import '../../level_page/widget/level_app_bar_widget.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 200);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 60,left: 15,right: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          height: 60,
                          width: Get.width,
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
                      _ItemWidget(
                        name: EnumLocal.txtLanguages.name.tr,
                        isShowRightArrow: true,
                        callback: () => Get.toNamed(AppRoutes.languagePage),
                      ),

                      _ItemWidget(
                        name: EnumLocal.txtPrivacyPolicy.name.tr,
                        isShowRightArrow: true,
                        callback: () => Get.toNamed(AppRoutes.privacyPolicyPage,),
                      ),

                      _ItemWidget(
                        name: EnumLocal.txtTermsOfUse.name.tr,
                        isShowRightArrow: true,
                        callback: () => Get.toNamed(AppRoutes.termsOfUsePage),
                      ),
                      _ItemWidget(
                        name: EnumLocal.txtLiveAgreement.name.tr,
                        isShowRightArrow: true,
                        callback: () => Get.toNamed(AppRoutes.privacyPolicyPage, arguments: {
                          'title': EnumLocal.txtLiveAgreement.name.tr,
                          'url': Utils.liveBroadcastAgreementPolicyLink,
                        },),
                      ),
                      _ItemWidget(
                        name: EnumLocal.txtRechargeAgreement.name.tr,
                        isShowRightArrow: true,
                        callback: () => Get.toNamed(AppRoutes.privacyPolicyPage,arguments: {
                          'title': EnumLocal.txtRechargeAgreement.name.tr,
                          'url': Utils.userRechargeAgreementPolicyLink,
                        },),
                      ),
                      _ItemWidget(
                        name: EnumLocal.txtChildProtectionPolicy.name.tr,
                        isShowRightArrow: true,
                        callback: () => Get.toNamed(AppRoutes.privacyPolicyPage,arguments: {
                          'title': EnumLocal.txtChildProtectionPolicy.name.tr,
                          'url': Utils.noChildHarmPolicyLink,
                        },),
                      ),
                    ],
                  ),
                ),
                15.height,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _ItemWidget(
                        name: EnumLocal.txtLogOut.name.tr,
                        isShowRightArrow: false,
                        style: AppFontStyle.styleW600(AppColor.black, 14),
                        callback: () => LogOutDialogWidget.onShow(),
                      ),
                      _ItemWidget(
                        name: EnumLocal.txtDeleteAccount.name.tr,
                        isShowRightArrow: false,
                        style: AppFontStyle.styleW600(AppColor.black, 14),
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
              ],
            ),
          ),
          LevelAppBarWidget(title: EnumLocal.txtSettings.name.tr),
        ],
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
        color: Colors.transparent,
        height: 60,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
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
                color: HexColor('#86868F'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

