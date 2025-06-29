import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/rendom_name_setter_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/widget/custom_rank_slider_widget.dart';
import 'package:tingle/database/fake_data/user_fake_data.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class StreamPkItemWidget extends StatelessWidget {
  const StreamPkItemWidget({super.key, required this.indexData, required this.callback});

  final LiveUserList indexData;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 160,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          padding: const EdgeInsets.all(2), // 边框宽度
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor('#00E4A6'), // 边框颜色
                          ),
                          child: ClipOval(
                            child: PreviewProfileImageWidget(
                              image: (indexData.isFake ?? true)
                                  ? (indexData.pkThumbnails?.isEmpty ?? true)
                                  ? ""
                                  : indexData.pkThumbnails?.first
                                  : indexData.image ?? "",
                            ),
                          ),
                        ),
                        5.height,
                        Text(
                          indexData.name ?? "",
                          style: AppFontStyle.styleW600(AppColor.black, 12),
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.pkWinImg.image(width: 35),
                            Text(
                              "x${CustomFormatNumber.onConvert(indexData.localGiftCount ?? 0)}",
                              style: AppFontStyle.styleW900(HexColor('#00E4A6'), 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Assets.images.pkTitleImg.image(width: 100),
                        Assets.images.pkVsImg.image(width: 100),
                        const Offstage(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          padding: const EdgeInsets.all(2), // 控制边框宽度
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor('#FFD45B'), // 边框颜色
                          ),
                          child: ClipOval(
                            child: PreviewProfileImageWidget(
                              image: (indexData.isFake ?? true)
                                  ? (indexData.pkThumbnails?.isEmpty ?? true)
                                  ? ""
                                  : indexData.pkThumbnails?.last
                                  : indexData.host2Image,
                            ),
                          ),
                        ),

                        5.height,
                        Text(
                          // indexData.host2Name ?? "",
                          FakeProfilesSet.getName(
                            indexData.host2Name ?? "",
                          ),
                          style: AppFontStyle.styleW600(AppColor.black, 12),
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.pkWinImg.image(width: 35),
                            Text(
                              "x${CustomFormatNumber.onConvert(indexData.remoteGiftCount ?? 0)}",
                              style: AppFontStyle.styleW900(HexColor('#00E4A6'), 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomRankSliderWidget(
              rank1: indexData.localRank ?? 0,
              rank2: indexData.remoteRank ?? 0,
              width: (Get.width - 54),
              height: 20,
            ),
            12.height,
          ],
        ),
      ),
    );
  }
}
