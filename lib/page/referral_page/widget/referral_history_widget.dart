import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/referral_page/controller/referral_controller.dart';
import 'package:tingle/page/referral_page/widget/referral_history_app_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ReferralHistoryWidget extends StatelessWidget {
  const ReferralHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 200);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: ReferralHistoryAppBarWidget.onShow(context),
      body: GetBuilder<ReferralController>(
        id: AppConstant.onGetReferralUserHistory,
        builder: (controller) => controller.isLoadingHistory
            ? UserListShimmerWidget()
            : controller.referralHistory.isEmpty
                ? NoDataFoundWidget()
                : SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 0),
                      itemCount: controller.referralHistory.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final indexData = controller.referralHistory[index];
                        return MessageUserWidget(
                          index: index,
                          title: indexData.userId?.name ?? "",
                          subTitle: indexData.userId?.userName ?? "",
                          leading: indexData.userId?.image ?? "",
                          isVerified: false,
                          isProfileImageBanned: indexData.userId?.isProfilePicBanned ?? false,
                          dateTime: indexData.date ?? "",
                          callback: () {},
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

class MessageUserWidget extends StatelessWidget {
  const MessageUserWidget({
    super.key,
    required this.index,
    required this.title,
    required this.subTitle,
    required this.leading,
    this.dateTime,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
  });

  final int index;
  final String title;
  final String subTitle;
  final String leading;
  final String? dateTime;
  final Callback callback;
  final bool isVerified;
  final bool isProfileImageBanned;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 80,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(bottom: BorderSide(color: AppColor.colorBorder.withValues(alpha: 0.5))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 55,
              width: 55,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: PreviewProfileImageWidget(image: leading, isBanned: isProfileImageBanned),
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
                    ],
                  ),
                  3.height,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 11),
                        ),
                      ),
                      10.width,
                      Visibility(
                        visible: dateTime != null,
                        child: Text(
                          dateTime ?? "",
                          style: AppFontStyle.styleW600(AppColor.grayText, 8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
