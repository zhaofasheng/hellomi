import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
class ReceiverMessageWidget extends StatelessWidget {
  const ReceiverMessageWidget({
    super.key,
    required this.message,
    required this.time,
    required this.profileImage,
    required this.profileImageIsBanned,
  });

  final String message;
  final String time;
  final String profileImage;
  final bool profileImageIsBanned;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.secondary),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: PreviewProfileImageWidget(
                image: profileImage,
                isBanned: profileImageIsBanned,
              ),
            ),
          ),

          // 消息气泡 + 时间（用 Stack 包裹）
          Stack(
            children: [
              // 消息内容容器
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.6),
                padding: const EdgeInsets.only(left: 12, right: 38, top: 6, bottom: 15),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  message,
                  style: AppFontStyle.styleW400(AppColor.black, 16),
                ),
              ),

              // 时间戳
              Positioned(
                bottom: 3,
                right: 10,
                child: Text(
                  FormatMessageTime.onConvert(time),
                  style: AppFontStyle.styleW500(HexColor('#A8A8AC'), 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

