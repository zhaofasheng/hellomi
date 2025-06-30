import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/message_page/widget/message_tab_bar_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MessageAppBarWidget extends StatelessWidget {
  const MessageAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).viewPadding.top + 105,
      padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 15, right: 15),
      alignment: Alignment.center,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.transparent,
        border: Border(
          bottom: BorderSide(
            color: AppColor.white.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            color: AppColor.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    EnumLocal.txtMessage.name.tr,
                    style: AppFontStyle.styleW700(AppColor.black, 20),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.searchMessageUserPage),
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.transparent,
                      ),
                      child: Image.asset(
                        AppAssets.icSearch,
                        width: 28,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const MessageTabBarWidget(),
        ],
      ),
    );
  }
}
