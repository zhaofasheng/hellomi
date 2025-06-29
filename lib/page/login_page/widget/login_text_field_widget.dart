import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
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

import '../../../assets/assets.gen.dart';
import '../../../utils/common_input_field.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      id: ApiParams.password,
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CommonInputField(
            controller: controller.emailController,
            hintText: EnumLocal.txtEnterYourEmailId.name.tr,
            iconWidget: Assets.images.loginEmailImg.image(width: 24,height: 24),
            keyboardType: TextInputType.text,
            hintTextColor: HexColor('#D2D6DB'),
          ),

          10.height,
          GetBuilder<LoginController>(
            id: ApiParams.password,
            builder: (controller) => CommonInputField(
              controller: controller.passwordController,
              hintText: EnumLocal.txtEnterYourPassword.name.tr,
              iconWidget: Assets.images.loginPasswdImg.image(width: 24,height: 24),
              keyboardType: TextInputType.name,
              hintTextColor: HexColor('#D2D6DB'),
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
            height: 50,
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
          Row(
            children: [
              Expanded(child: Container(height: 1,color: HexColor('#EBEBEB'),)),
              15.width,
              Text(
                'Or',
                style: AppFontStyle.styleW500(HexColor('#D2D6DB'), 14),
                textAlign: TextAlign.center,
              ),
              15.width,
              Expanded(child: Container(height: 1,color: HexColor('#EBEBEB'),)),

            ],
          ),
          20.height,
        ],
      ),
    );
  }
}
