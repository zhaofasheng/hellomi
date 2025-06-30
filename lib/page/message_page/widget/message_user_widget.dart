import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class MessageUserWidget extends StatelessWidget {
  const MessageUserWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.messageCount,
    this.dateTime,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.avatarFrameImage,
    required this.avatarFrameType,
  });

  final String title;
  final String subTitle;
  final String leading;
  final int? messageCount;
  final String? dateTime;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;
  final String avatarFrameImage;
  final int avatarFrameType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 80,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(bottom: BorderSide(color: AppColor.white.withValues(alpha: 0.3))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 55,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: PreviewProfileImageWithFrameWidget(
                image: leading,
                isBanned: isProfileImageBanned,
                frame: avatarFrameImage,
                type: avatarFrameType,
                margin: EdgeInsets.all(10),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.styleW700(AppColor.black, 15),
                        ),
                      ),
                      Visibility(
                        visible: isVerified,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 16),
                        ),
                      ),
                      3.width,
                      Visibility(
                        visible: messageCount != null && messageCount != 0,
                        child: Container(
                          height: 18,
                          padding: const EdgeInsets.symmetric(horizontal: 4), // 文字左右间距
                          constraints: const BoxConstraints(
                            minWidth: 18, // 最小宽度为 20
                          ),
                          decoration: BoxDecoration(
                            color: HexColor('#00E4A6'),
                            borderRadius: BorderRadius.circular(9), // 胶囊形圆角
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            messageCount.toString(),
                            maxLines: 1,
                            style: AppFontStyle.styleW600(AppColor.white, 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Text(
                    subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.styleW500(HexColor('#A8A8AC'), 11),
                  ),
                ],
              ),
            ),
            10.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: dateTime != null,
                  child: Text(
                    dateTime!,
                    style: AppFontStyle.styleW600(HexColor('#A8A8AC'), 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
