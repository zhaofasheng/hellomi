import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/back_appbar_widget.dart';
import 'package:tingle/page/login_page/widget/continue_button_widget.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PhoneOtpVerificationScreen extends GetView<LoginController> {
  const PhoneOtpVerificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) => PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            controller.otpCountTime = 30;
            controller.update([ApiParams.onCountTime]);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              const CustomLightBackgroundWidget(),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackAppBarWidget(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            30.height,
                            Text(
                              EnumLocal.txtOTPVerification.name.tr,
                              textAlign: TextAlign.start,
                              style: AppFontStyle.styleW900(AppColor.black, 36),
                            ),
                            5.height,
                            Text(
                              EnumLocal.txtCompleteTheVerificationByEntering.name.tr,
                              textAlign: TextAlign.start,
                              style: AppFontStyle.styleW400(AppColor.black, 14),
                            ),
                            35.height,
                            OtpTextField(
                              numberOfFields: 6,
                              fillColor: AppColor.transparent,
                              borderRadius: BorderRadius.circular(8),
                              fieldWidth: 45,
                              cursorColor: AppColor.primary,
                              disabledBorderColor: AppColor.primary,
                              borderColor: AppColor.primary,
                              borderWidth: 1.2,
                              enabledBorderColor: AppColor.primary,
                              // focusedBorderColor: AppColor.primary,
                              showFieldAsBox: true,
                              onSubmit: (String otpCode) => controller.otpController.text = otpCode,
                            ),
                            20.height,
                            GetBuilder<LoginController>(
                              id: ApiParams.onCountTime,
                              builder: (controller) => GestureDetector(
                                onTap: () => controller.otpCountTime == 30 ? controller.onPhoneSendOtp() : null,
                                child: Text(
                                  controller.otpCountTime == 30 ? EnumLocal.txtResendCode.name.tr : "00:${controller.otpCountTime}",
                                  textAlign: TextAlign.start,
                                  style: controller.otpCountTime == 30
                                      ? TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.red,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColor.red,
                                          fontFamily: AppConstant.appFontMedium,
                                        )
                                      : TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.black,
                                          decorationColor: AppColor.red,
                                          fontFamily: AppConstant.appFontMedium,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppButtonUi(
                      title: EnumLocal.txtVerify.name.tr,
                      gradient: AppColor.primaryGradient,
                      margin: const EdgeInsets.all(15),
                      callback: () => controller.onVerifyOtp(otp: controller.otpController.text),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
