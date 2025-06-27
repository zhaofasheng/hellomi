import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_text_field_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/screen/forgot_password_screen.dart';
import 'package:tingle/page/login_page/screen/self_registration_screen.dart';
import 'package:tingle/page/login_page/widget/continue_button_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      id: ApiParams.password,
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomTextFieldWidget(
            title: EnumLocal.txtEnterYourEmailId.name.tr,
            hintText: EnumLocal.txtEnterYourEmailId.name.tr,
            hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
            keyboardType: TextInputType.text,
            controller: controller.emailController,
          ),
          15.height,
          GetBuilder<LoginController>(
            id: ApiParams.password,
            builder: (controller) => CustomTextFieldWidget(
              title: EnumLocal.txtEnterYourPassword.name.tr,
              hintText: EnumLocal.txtEnterYourPassword.name.tr,
              hintStyle: AppFontStyle.styleW500(AppColor.secondary, 15),
              keyboardType: TextInputType.name,
              controller: controller.passwordController,
              onChangeIsObscure: () => controller.onChangeObscure(),
              isPassword: true,
              isObscure: controller.isObscure.value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: controller.onClickForgotPasswordText,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  height: 50,
                  color: AppColor.transparent,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      EnumLocal.txtForgotPassword.name.tr,
                      style: AppFontStyle.customStyle(
                        color: AppColor.black,
                        decorationColor: AppColor.black,
                        fontSize: 12,
                        fontFamily: AppConstant.appFontMedium,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ContinueButtonWidget(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            textColor: AppColor.white,
            gradient: AppColor.primaryGradient,
            height: 55,
            title: EnumLocal.txtContinue.name.tr,
            callback: () => controller.onEmailPasswordLogin(),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: controller.onClickRegisterText,
                child: Container(
                  height: 50,
                  color: AppColor.transparent,
                  child: Row(
                    children: [
                      Text(
                        EnumLocal.txtIfYouHaveNewUser.name.tr,
                        style: AppFontStyle.styleW500(AppColor.black, 13),
                      ),
                      5.width,
                      Text(
                        EnumLocal.txtGetRegister.name.tr,
                        style: AppFontStyle.styleW600(AppColor.black, 13).copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: AppColor.grayText.withValues(alpha: 0.2),
            height: 1,
            thickness: 1,
          ),
          20.height,
        ],
      ),
    );
  }
}
