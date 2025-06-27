import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FakeTeamPkWidget extends StatelessWidget {
  const FakeTeamPkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return const ItemWidget();
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssets.imgPkTeam, width: 100),
          const Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserItemWidget(),
                UserItemWidget(),
                UserItemWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserItemWidget extends StatelessWidget {
  const UserItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55,
            width: 55,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: AppColor.transparent,
              shape: BoxShape.circle,
            ),
            child: const PreviewProfileImageWidget(),
          ),
          5.height,
          Text(
            "👸👸Priya👸👸",
            style: AppFontStyle.styleW600(AppColor.black, 12),
          ),
          5.height,
          Text(
            "🇮🇳",
            style: AppFontStyle.styleW900(AppColor.pink, 14),
          ),
        ],
      ),
    );
  }
}
