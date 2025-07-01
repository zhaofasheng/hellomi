import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class RankingUserListTileWidget extends StatelessWidget {
  const RankingUserListTileWidget({
    super.key,
    required this.index,
    required this.title,
    required this.coin,
    required this.image,
    required this.gender,
    required this.age,
    required this.wealthLevelImage,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.frame,
    required this.frameType,
  });

  final int index;
  final String title;
  final int coin;
  final String image;
  final String gender;
  final String frame;
  final int age;
  final int frameType;
  final String wealthLevelImage;
  final bool isProfileImageBanned;
  final bool isVerified;
  final Callback callback;

  Widget _buildTopRankImage(int rank) {
    switch (rank) {
      case 1:
        return Assets.images.rich1.image(width: 25, height: 25);
      case 2:
        return Assets.images.rich2.image(width: 25, height: 25);
      case 3:
        return Assets.images.rice3.image(width: 25, height: 25);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 100,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: HexColor('#00E4A6').withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: (index + 1) <= 3
                  ? _buildTopRankImage(index + 1)
                  : Center(
                child: Text(
                  (index + 1).toString(),
                  style: AppFontStyle.styleW700(AppColor.black, 15),
                ),
              ),
            ),
            15.width,
            Container(
              height: 50,
              width: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: AppColor.transparent, shape: BoxShape.circle),
              child: PreviewProfileImageWithFrameWidget(
                image: image,
                isBanned: isProfileImageBanned,
                frame: frame,
                type: frameType,
                fit: BoxFit.cover,
                margin: EdgeInsets.all(5),
              ),
            ),
            12.width,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          title,
                          maxLines: 1,
                          style: AppFontStyle.styleW700(AppColor.black, 13),
                        ),
                      ),
                      Visibility(
                        visible: isVerified,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 18),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              gender == ApiParams.male ? AppAssets.icFemale : AppAssets.icFemale,
                              color: AppColor.white,
                              width: 10,
                            ),
                            3.width,
                            Text(
                              CustomFormatNumber.onConvert(age),
                              style: AppFontStyle.styleW600(AppColor.white, 10),
                            ),
                          ],
                        ),
                      ),
                      5.width,
                      SizedBox(
                        width: 40,
                        height: 20,
                        child: PreviewLevelImageWidget(
                          image: wealthLevelImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
           Container(
             padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
             decoration: BoxDecoration(
               color: HexColor('#FFB200').withOpacity(0.2),
               borderRadius: BorderRadius.circular(999), // ✅ 完全圆角
             ),
             child: Row(
               children: [
                 Image.asset(AppAssets.icCoinStar, width: 18),
                 3.width,
                 Text(
                   CustomFormatNumber.onConvert(coin),
                   style: AppFontStyle.styleW700(AppColor.lightYellow, 12),
                 ),
                 5.width,
               ],
             ),
           ),
          ],
        ),
      ),
    );
  }
}
