import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/login_other_auth_widget.dart';
import 'package:tingle/page/login_page/widget/login_text_field_widget.dart';
import 'package:tingle/page/login_page/widget/login_title_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      body: SafeArea(top: false,child: Stack(
        alignment: Alignment.center,
        children: [
          const CustomLightBackgroundWidget(isLogin: true,),
          GetBuilder<LoginController>(
            builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        image: AppAssets.icLogo,
                        title: Utils.appName,
                        subtitle: EnumLocal.txtLoveBeginsHereLogInToConnect.name.tr,
                        iconSize: 65,
                      ),
                      40.height,
                      LoginTextFieldWidget(),
                      LoginOtherAuthWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),),
    );
  }
}
