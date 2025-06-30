import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/page/fake_chat_page/controller/fake_chat_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class FakeChatTextFieldWidget extends GetView<FakeChatController> {
  const FakeChatTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppColor.white,
            child: SafeArea(
              bottom: controller.isShowMorePanel.value == true ? false : true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // More Button
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.isShowMorePanel.value = !controller.isShowMorePanel.value;
                      },
                      child: Container(
                        height: 50,
                        width: 40,
                        alignment: Alignment.center,
                        child: Center(child: Assets.images.chatMore.image(width: 32,height: 32),), // 你自定义的icon
                      ),
                    ),
                    10.width,
                    // 输入框
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: HexColor('#F8F8F8'),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.messageController,
                                cursorColor: HexColor('#00E4A6'),
                                onTap: () => controller.isShowMorePanel.value = false, // 输入时隐藏面板
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(bottom: 2),
                                  hintText: EnumLocal.txtSaySomething.name.tr,
                                  hintStyle: AppFontStyle.styleW500(HexColor('#A8A8AC'), 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.width,
                    // 发送按钮
                    GestureDetector(
                      onTap: controller.onClickSend,
                      child: Container(
                        height: 50,
                        width: 40,
                        padding: const EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          gradient: AppColor.primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SizedBox(width: 32,height: 32,child: Image.asset(AppAssets.icSend, color: AppColor.white),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 更多面板
          if (controller.isShowMorePanel.value)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: AppColor.white,
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 20,
                runSpacing: 15,
                children: [
                  MoreOption(icon: Assets.images.chatSendimg.image(width: 32,height: 32),  onTap: () {
                    controller.choiceImage();
                  }),
                  MoreOption(icon: Assets.images.chatCamram.image(width: 32,height: 32),  onTap: () {
                    controller.choiceCameraImage();
                  }),
                  //_MoreOption(icon: Assets.images.chatVideo.image(width: 32,height: 32),  onTap: () {/* TODO */}),
                ],
              ),
            ),
        ],
      );
    });
  }
}

// 可复用的功能按钮小组件
class MoreOption extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const MoreOption({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(top:false,child: GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor('#F8F8F8'),
            ),
            child: icon,
          ),
        ],
      ),
    ),);
  }
}