import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/custom/widget/custom_phone_text_field_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/continue_button_widget.dart';
import 'package:tingle/page/login_page/widget/back_appbar_widget.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PhoneAuthenticationScreen extends GetView<LoginController> {
  const PhoneAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) => controller.phoneNumberController.clear(),
      child: Scaffold(
        body: Stack(
          children: [
            const CustomLightBackgroundWidget(),
            GetBuilder<LoginController>(
              builder: (controller) => SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackAppBarWidget(),
                    30.height,
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              EnumLocal.txtLogInWithMobileNumber.name.tr,
                              style: AppFontStyle.styleW900(AppColor.black, 30),
                            ),
                            Text(
                              EnumLocal.txtLetsGetStartedEnter.name.tr,
                              style: AppFontStyle.styleW400(AppColor.black, 14),
                            ),
                            30.height,
                            GetBuilder<LoginController>(
                              id: ApiParams.onPhoneNumber,
                              builder: (controller) => CustomPhoneTextFieldWidget(
                                title: EnumLocal.txtPhoneNumber.name.tr,
                                hintText: EnumLocal.txtEnterYourPhoneNumber.name.tr,
                                controller: controller.phoneNumberController,
                                keyboardType: TextInputType.phone,
                                suffixIcon: const Offstage(),
                                onCountryChanged: (value) => controller.onGetPhoneNumber(
                                  // phoneNumber: controller.phoneNumberController.text,
                                  code: value,
                                ),
                                onChange: (p0) {
                                  controller.update([ApiParams.onPhoneNumber]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppColor.white,
        bottomNavigationBar: AppButtonUi(
          title: EnumLocal.txtSubmit.name.tr,
          gradient: AppColor.primaryGradient,
          margin: const EdgeInsets.all(15),
          callback: () => controller.onPhoneSendOtp(),
        ),
      ),
    );
  }
}
