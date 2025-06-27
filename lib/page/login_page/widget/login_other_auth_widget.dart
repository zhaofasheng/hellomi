import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/screen/phone_authentication_screen.dart';
import 'package:tingle/page/login_page/widget/google_button_widget.dart';
import 'package:tingle/page/login_page/widget/login_button_widget.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LoginOtherAuthWidget extends StatelessWidget {
  const LoginOtherAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) => Column(
        children: [
          Row(
            children: [
              GoogleAndPhoneButtonWidget(
                image: AppAssets.icMobile,
                iconSize: 24,
                title: EnumLocal.txtMobile.name.tr,
                callback: () => Get.to(PhoneAuthenticationScreen()),
              ),
              10.width,
              GoogleAndPhoneButtonWidget(
                image: AppAssets.icGoogle,
                iconSize: 24,
                title: EnumLocal.txtGoogle.name.tr,
                callback: () => controller.onGoogleLogin(),
              ),
            ],
          ),
          15.height,
          LoginButtonWidget(
            image: AppAssets.icQuick,
            title: EnumLocal.txtQuickLogIn.name.tr,
            iconSize: 22,
            callback: () => controller.onQuickLogin(),
          ),
          10.height,
          GetBuilder<LoginController>(
            id: ApiParams.onChangeIsCheckedConditions,
            builder: (controller) => GestureDetector(
              onTap: () => controller.onChangeIsCheckedConditions(),
              child: Container(
                height: 40,
                color: AppColor.transparent,
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      padding: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.black),
                      ),
                      child: controller.isCheckedConditions
                          ? Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.black,
                              ),
                            )
                          : Offstage(),
                    ),
                    10.width,
                    Text(
                      EnumLocal.txtIHaveAcceptAllTermsAndCondition.name.tr,
                      style: AppFontStyle.styleW500(AppColor.black, 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          15.height,
        ],
      ),
    );
  }
}

// TODO => Privacy Policy Text

// RichText(
//   text: TextSpan(
//     text: EnumLocal.txtTermsAndCondition.name.tr,
//     style: const TextStyle(
//       color: AppColor.grayText,
//       fontSize: 15,
//       fontWeight: FontWeight.w600,
//       decoration: TextDecoration.underline,
//     ),
//     children: [
//       TextSpan(
//         text: " ${EnumLocal.txtAnd.name.tr} ",
//         style: const TextStyle(
//           color: AppColor.black,
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           decoration: TextDecoration.none,
//         ),
//       ),
//       TextSpan(
//         text: EnumLocal.txtPrivacyPolicy.name.tr,
//         style: const TextStyle(
//           color: AppColor.secondary,
//           fontSize: 15,
//           fontWeight: FontWeight.w600,
//           decoration: TextDecoration.underline,
//         ),
//       ),
//     ],
//   ),
// ),
// 30.height,
