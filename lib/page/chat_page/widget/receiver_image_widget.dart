import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/format_message_time.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';

class ReceiverImageWidget extends StatelessWidget {
  const ReceiverImageWidget({
    super.key,
    required this.image,
    required this.time,
    required this.isBanned,
    required this.receiverImage,
    required this.receiverImageIsBanned,
  });

  final String image;
  final String time;
  final bool isBanned;
  final String receiverImage;
  final bool receiverImageIsBanned;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 用户头像
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
                image: receiverImage,
                isBanned: receiverImageIsBanned,
              ),
            ),
          ),

          // 图片 + 时间
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // 可添加图片放大预览功能
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), // 左上角直角
                    topRight: Radius.circular(20),
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
        ],
      ),
    );
  }
}
