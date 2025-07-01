import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_text_field_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/continue_button_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class RegisterTextFieldWidget extends StatelessWidget {
  const RegisterTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      id: ApiParams.password,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            EnumLocal.txtSelfRegistration.name.tr,
            style: AppFontStyle.styleW900(AppColor.black, 32),
          ),
          10.height,
          Text(
            EnumLocal.txtRegisterYourSelfToUnlock.name.tr,
            style: AppFontStyle.styleW400(AppColor.wine, 12),
          ),
          40.height,
          CustomTextFieldWidget(
            leftImage: Assets.images.loginName.image(width: 24,height: 24),
            hintText: EnumLocal.txtEnterYourName.name.tr,
            keyboardType: TextInputType.text,
            controller: controller.registrationNameController,
          ),
          20.height,
          CustomTextFieldWidget(
            leftImage: Assets.images.loginSubName.image(width: 24,height: 24),
            hintText: EnumLocal.txtEnterEmail.name.tr,
            keyboardType: TextInputType.text,
            controller: controller.registrationEmailController,
          ),
          20.height,
          GetBuilder<LoginController>(
            id: ApiParams.password,
            builder: (controller) => CustomTextFieldWidget(
              leftImage: Assets.images.loginRock.image(width: 24,height: 24),
              hintText: EnumLocal.txtEnterPassword.name.tr,
              keyboardType: TextInputType.name,
              controller: controller.registrationPasswordController,
              isPassword: true,
              isObscure: controller.isObscure.value,
              onChangeIsObscure: () => controller.onChangeObscure(),
            ),
          ),
          20.height,
          GetBuilder<LoginController>(
            id: ApiParams.password,
            builder: (controller) => CustomTextFieldWidget(
              leftImage: Assets.images.loginRock.image(width: 24,height: 24),
              hintText: EnumLocal.txtConfirmPassword.name.tr,
              keyboardType: TextInputType.name,
              controller: controller.registrationConfirmPasswordController,
              isPassword: true,
              isObscure: controller.confirmIsObscure.value,
              onChangeIsObscure: () => controller.onChangeConfirmObscure(),
            ),
          ),
          // Spacer(),

          20.height,
        ],
      ),
    );
  }
}
