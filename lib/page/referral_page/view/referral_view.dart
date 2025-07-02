import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/function/custom_copy_text.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/login_page/api/fetch_login_user_profile_api.dart';
import 'package:tingle/page/referral_page/controller/referral_controller.dart';
import 'package:tingle/page/referral_page/shimmer/referral_shimmer_widget.dart';
import 'package:tingle/page/referral_page/widget/referral_app_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class ReferralView extends GetView<ReferralController> {
  const ReferralView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light, delay: 300);

    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          // 🔼 背景图 + 标题文字
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  // 背景图
                  Assets.images.tuijianBack.image(
                    width: Get.width,
                    height: Get.width * 274 / 375,
                    fit: BoxFit.cover,
                  ),
                  // 左上角文案
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 2 / 3+10,  // 限制最大宽度为屏幕的2/3
                          ),
                          child: Text(
                            EnumLocal.txtJoinMemberGetCoin.name.tr,
                            style: AppFontStyle.styleW700(AppColor.white, 24),
                            softWrap: true,  // 自动换行，默认true，可以省略
                          ),
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Get.width * 2 / 3+10,
                          ),
                          child: Text(
                            EnumLocal.txtTheMoreYouInviteTheMoreRewardsYouWillGet.name.tr,
                            style: AppFontStyle.styleW500(AppColor.white, 14),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),

          // 🔽 内容区域，覆盖背景图下方 20px
          Column(
            children: [
              SizedBox(height: Get.width * 274 / 375 - 20), // 留出顶部背景图高度减20
              Expanded(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: GetBuilder<ReferralController>(
                    id: AppConstant.onGetReferralSystem,
                    builder: (controller) => controller.isLoading
                        ? ReferralShimmerWidget()
                        : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.height,
                          Text(
                            "${EnumLocal.txtMyReferralCode.name.tr} :",
                            style: AppFontStyle.styleW700(AppColor.black, 14),
                          ),
                          15.height,
                          // 推荐码组件
                          Container(
                            height: 55,
                            width: Get.width,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: HexColor('#F5F5F5'),
                            ),
                            child: Row(
                              children: [
                                Assets.images.tuijianCode.image(width: 24,height: 24),
                                15.width,
                                Expanded(
                                  child: Text(
                                    FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.referralCode ?? "",
                                    textAlign: TextAlign.center,
                                    style: AppFontStyle.styleW700(AppColor.black, 15),
                                  ),
                                ),
                                15.width,
                                GestureDetector(
                                  onTap: () => CommonShare.onShare(
                                    id: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.referralCode ?? "",
                                    userId: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.id ?? "",
                                    title: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.name ?? "",
                                    image: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.image ?? "",
                                    pageRoutes: BranchIoServices.referralKey,
                                    referralCode: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.referralCode ?? "",
                                  ),
                                  child: Assets.images.tuijianShare.image(width: 24,height: 24),
                                ),
                                10.width,
                                GestureDetector(
                                  onTap: () => CustomCopyText.onCopy(
                                    text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.referralCode ?? "",
                                  ),
                                  child: Assets.images.tuijianCopy.image(width: 24,height: 24),
                                ),
                              ],
                            ),
                          ),
                          controller.referralSystem.isEmpty
                              ? const SizedBox(height: 250, child: NoDataFoundWidget())
                              : ListView.builder(
                            itemCount: controller.referralSystem.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final data = controller.referralSystem[index];
                              return _ItemWidget(
                                index,
                                data.rewardCoins ?? 0,
                                data.targetReferrals ?? 0,
                              );
                            },
                          ),
                          15.height,
                          Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${EnumLocal.txtReferralRules.name.tr} :-",
                                  style: AppFontStyle.styleW700(AppColor.black, 15),
                                ),
                                10.height,
                                Text(
                                  "You cannot refer yourself using multiple accounts. Any attempt to do so will lead to disqualification from the referral program. Referrals are valid only if your friend is a new user and completes the signup process using your referral code.",
                                  style: AppFontStyle.styleW500(AppColor.grayText, 10),
                                ),
                              ],
                            ),
                          ),
                          15.height,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 🔝 固定的 AppBar 组件（浮在最上方）
          ReferralAppBarWidget(),
        ],
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.index, this.coin, this.member);

  final int index;
  final int coin;
  final int member;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: Get.width,
      padding: EdgeInsets.only(left: 20, right: 15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        gradient: index % 2 == 0 ? AppColor.orangeYellowGradient : AppColor.pinkPurpleGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${EnumLocal.txtJoin.name.tr} $member ${EnumLocal.txtMemberGetCoin.name.tr}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppFontStyle.styleW700(AppColor.white, 15),
              ),
            ),
          ),
          15.width,
          Container(
            height: 42,
            width: 105,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.black.withValues(alpha: 0.3),
                  offset: Offset(1, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.tuijianGold.image(width: 20,height: 20),
                5.width,
                Text(
                  "${CustomFormatNumber.onConvert(coin)}/${EnumLocal.txtCoins.name.tr}",
                  textAlign: TextAlign.center,
                  style: AppFontStyle.styleW700(AppColor.orange, 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
