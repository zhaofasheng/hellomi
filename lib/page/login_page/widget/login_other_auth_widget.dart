import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(PhoneAuthenticationScreen());
                },
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // 圆角半径
                    border: Border.all(
                      color: HexColor('#EBEBEB'), // 边框颜色
                      width: 1,           // 边框宽度
                    ),
                  ),
                  child:Center(
                    child: Assets.icons.icMobile.image(width: 24,height: 24),
                  ),
                ),
              ),
              10.width,
              GestureDetector(
                onTap: (){
                  controller.onGoogleLogin();
                },
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // 圆角半径
                    border: Border.all(
                      color: HexColor('#EBEBEB'), // 边框颜色
                      width: 1,           // 边框宽度
                    ),
                  ),
                  child:Center(
                    child: Assets.images.googleLoginImg.image(width: 24,height: 24),
                  ),
                ),
              ),
              10.width,
              GestureDetector(
                onTap: (){
                  controller.onQuickLogin();
                },
                child: Container(
                  width: 75,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // 圆角半径
                    border: Border.all(
                      color: HexColor('#EBEBEB'), // 边框颜色
                      width: 1,           // 边框宽度
                    ),
                  ),
                  child:Center(
                    child: Assets.images.socketLoginImg.image(width: 24,height: 24),
                  ),
                ),
              ),
            ],
          ),
          10.height,
          GetBuilder<LoginController>(
            id: ApiParams.onChangeIsCheckedConditions,
            builder: (controller) => Center(child: GestureDetector(
              onTap: () => controller.onChangeIsCheckedConditions(),
              child: Container(
                height: 40,
                color: AppColor.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Flexible(
                      child: Text(
                        EnumLocal.txtIHaveAcceptAllTermsAndCondition.name.tr,
                        style: AppFontStyle.styleW500(AppColor.black, 14),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),),
          ),
          15.height,
        ],
      ),
    );
  }
}
