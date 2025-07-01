import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/login_page/widget/continue_button_widget.dart';
import 'package:tingle/page/login_page/widget/register_text_field_widget.dart';
import 'package:tingle/page/login_page/widget/back_appbar_widget.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class SelfRegistrationScreen extends GetView<LoginController> {
  const SelfRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);

    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) => Stack(
          children: [
            const CustomLightBackgroundWidget(),
            SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    BackAppBarWidget(),
                    30.height,
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: RegisterTextFieldWidget(),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      backgroundColor: AppColor.white,
      bottomNavigationBar: SafeArea(top: false,child: AppButtonUi(
        title: EnumLocal.txtSubmit.name.tr,
        gradient: AppColor.primaryGradient,
        margin: const EdgeInsets.all(15),
        callback: () => controller.onRegisterUser(),
      ),)

    );
  }
}
