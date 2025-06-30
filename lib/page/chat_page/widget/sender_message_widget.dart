import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';

class SenderMessageWidget extends StatelessWidget {
  const SenderMessageWidget({
    super.key,
    required this.message,
    required this.time,
  });

  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    final user = Database.fetchLoginUserProfile()?.user;

    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 消息内容
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.6),
                padding: const EdgeInsets.only(left: 12, right: 38, top: 6, bottom: 15),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(0),         // 右上角直角
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  message,
                  style: AppFontStyle.styleW400(AppColor.white, 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 8),
                child: Text(
                  FormatMessageTime.onConvert(time),
                  style: AppFontStyle.styleW500(HexColor('#A8A8AC'), 10),
                ),
              ),
            ],
          ),
          // 头像
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(left: 5),
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


