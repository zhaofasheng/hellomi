import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/custom/widget/custom_text_field_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/back_appbar_widget.dart';
import 'package:tingle/page/login_page/widget/continue_button_widget.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ForgotPasswordScreen extends GetView<LoginController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          30.height,
                          Text(
                            EnumLocal.txtForgotYourPassword.name.tr,
                            style: AppFontStyle.styleW900(AppColor.black, 30),
                          ),
                          Text(
                            EnumLocal.txtDotWorryItHappens.name.tr,
                            style: AppFontStyle.styleW400(AppColor.black, 14),
                          ),
                          30.height,
                          CustomTextFieldWidget(
                            title: EnumLocal.txtEnterEmail.name.tr,
                            hintText: EnumLocal.txtEnterEmail.name.tr,
                            controller: controller.forgotPasswordEmailController,
                            keyboardType: TextInputType.text,
                            suffixIcon: const Offstage(),
                          ),
                          20.height
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
        gradient: AppColor.primaryGradient,
        title: EnumLocal.txtVerify.name.tr,
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        callback: () => controller.onForgotPassword(),
      ),
    );
  }
}
