import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/gender_icon.dart';
import 'package:tingle/common/widget/main_button_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/live_summary_page/controller/live_summary_controller.dart';
import 'package:tingle/page/live_summary_page/shimmer/live_summary_shimmer_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class LiveSummaryView extends StatelessWidget {
  const LiveSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light, delay: 200);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(gradient: AppColor.audioRoomGradient),
          ),
          GetBuilder<LiveSummaryController>(
            id: AppConstant.onGetLiveSummary,
            builder: (controller) => SizedBox(
              height: Get.height,
              width: Get.width,
              child: controller.isLoading
                  ? LiveSummaryShimmerWidget()
                  : Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 110,
                                  width: 110,
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: (controller.fetchLiveSummaryModel?.data?.user?.avtarFrame?.image?.trim().isEmpty ?? true) ? Border.all(color: AppColor.white, width: 2) : null,
                                  ),
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      color: AppColor.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: PreviewProfileImageWithFrameWidget(
                                      image: controller.fetchLiveSummaryModel?.data?.user?.image ?? "",
                                      isBanned: controller.fetchLiveSummaryModel?.data?.user?.isProfilePicBanned ?? false,
                                      frame: controller.fetchLiveSummaryModel?.data?.user?.avtarFrame?.image ?? "",
                                      type: controller.fetchLiveSummaryModel?.data?.user?.avtarFrame?.type ?? 0,
                                      fit: BoxFit.cover,
                                      margin: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                10.height,
                                SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(
                                          maxLines: 1,
                                          controller.fetchLiveSummaryModel?.data?.user?.name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.styleW700(AppColor.white, 15),
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.fetchLiveSummaryModel?.data?.user?.isVerified ?? false,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5, top: 6),
                                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                10.height,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 18,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: AppColor.primary,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(GenderIcon.onShow(controller.fetchLiveSummaryModel?.data?.user?.gender ?? ""), width: 10),
                                          3.width,
                                          Text(
                                            (controller.fetchLiveSummaryModel?.data?.user?.age ?? 0).toString(),
                                            style: AppFontStyle.styleW600(AppColor.white, 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    5.width,
                                    PreviewWealthLevelImage(
                                      image: controller.fetchLiveSummaryModel?.data?.user?.wealthLevel?.levelImage ?? "",
                                      height: 18,
                                      width: 40,
                                    ),
                                    5.width,
                                    Container(
                                      height: 18,
                                      padding: const EdgeInsets.only(left: 5, right: 8),
                                      decoration: BoxDecoration(
                                        color: AppColor.lightYellow.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(AppAssets.icCoinStar, width: 12),
                                          3.width,
                                          Text(
                                            CustomFormatNumber.onConvert(controller.fetchLiveSummaryModel?.data?.user?.coin ?? 0),
                                            style: AppFontStyle.styleW600(AppColor.lightYellow, 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                10.height,
                                Text(
                                  "${EnumLocal.txtID.name.tr} ${controller.fetchLiveSummaryModel?.data?.user?.uniqueId ?? ""}",
                                  maxLines: 1,
                                  style: AppFontStyle.styleW600(AppColor.white, 10),
                                ),
                                20.height,
                                Container(
                                  height: 200,
                                  width: Get.width,
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: AppColor.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SummaryItemWidget(
                                              title: CustomFormatNumber.onConvert(controller.fetchLiveSummaryModel?.data?.joinedUsers ?? 0),
                                              subTitle: EnumLocal.txtJoinedUsers.name.tr,
                                            ),
                                            DividerWidget(),
                                            SummaryItemWidget(
                                              title: controller.fetchLiveSummaryModel?.data?.duration ?? "",
                                              subTitle: EnumLocal.txtLiveDuration.name.tr,
                                            ),
                                            DividerWidget(),
                                            SummaryItemWidget(
                                              title: CustomFormatNumber.onConvert(controller.fetchLiveSummaryModel?.data?.receivedGifts ?? 0),
                                              subTitle: EnumLocal.txtReceivedGift.name.tr,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SummaryItemWidget(
                                              title: CustomFormatNumber.onConvert(controller.fetchLiveSummaryModel?.data?.publicComments ?? 0),
                                              subTitle: EnumLocal.txtPublicComments.name.tr,
                                            ),
                                            DividerWidget(),
                                            SummaryItemWidget(
                                              title: CustomFormatNumber.onConvert(controller.fetchLiveSummaryModel?.data?.increasedFans ?? 0),
                                              subTitle: EnumLocal.txtIncreasedFans.name.tr,
                                            ),
                                            DividerWidget(),
                                            SummaryItemWidget(
                                              title: CustomFormatNumber.onConvert(controller.fetchLiveSummaryModel?.data?.coinsCollected ?? 0),
                                              subTitle: EnumLocal.txtCoinsCollection.name.tr,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        MainButtonWidget(
                          height: 56,
                          width: Get.width,
                          margin: EdgeInsets.all(15),
                          gradient: AppColor.lightDarkPinkGradient,
                          title: EnumLocal.txtBackToHome.name.tr,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          callback: () => Get.back(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryItemWidget extends StatelessWidget {
  const SummaryItemWidget({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: AppColor.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppFontStyle.styleW700(AppColor.white, 15),
            ),
            5.height,
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.styleW500(AppColor.white.withValues(alpha: 0.8), 10),
            ),
          ],
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      indent: 15,
      endIndent: 15,
      color: AppColor.white.withValues(alpha: 0.2),
    );
  }
}
