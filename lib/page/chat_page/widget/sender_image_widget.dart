import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';

class SenderImageWidget extends StatelessWidget {
  const SenderImageWidget({
    super.key,
    required this.image,
    required this.time,
    required this.isBanned,
  });

  final String image;
  final String time;
  final bool isBanned;

  @override
  Widget build(BuildContext context) {
    final user = Database.fetchLoginUserProfile()?.user;

    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 图片 + 时间
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // 可选：图片预览操作
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20), // 右上角直角
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    width: Get.width / 2.5,
                    height: 200,
                    color: AppColor.white,
                    child: PreviewPostImageWidget(
                      image: image,
                      fit: BoxFit.cover,
                      isBanned: isBanned,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                FormatMessageTime.onConvert(time),
                style: AppFontStyle.styleW500(AppColor.white, 10),
              ),
            ],
          ),

          const SizedBox(width: 5),

          // 用户头像
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.secondary),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: PreviewProfileImageWidget(
                image: user?.image ?? "",
                isBanned: user?.isProfilePicBanned ?? false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
