import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.only(bottom: Get.height * 0.35),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.imgReferralBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    EnumLocal.txtJoinMemberGetCoin.name.tr,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppConstant.appFontExtraBold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [AppColor.yellow, AppColor.yellow],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(const Rect.fromLTWH(10, 0, 0, 10)),
                      shadows: [
                        Shadow(
                          offset: Offset(3, 3),
                          blurRadius: 3,
                          color: Colors.black.withValues(alpha: 0.6),
                        ),
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 0,
                          color: Colors.black.withValues(alpha: 0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                15.height,
                Center(
                  child: Text(
                    EnumLocal.txtTheMoreYouInviteTheMoreRewardsYouWillGet.name.tr,
                    textAlign: TextAlign.center,
                    style: AppFontStyle.styleW600(AppColor.white, 14),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Get.height,
            width: Get.width,
            color: AppColor.transparent,
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Column(
              children: [
                Expanded(flex: 10, child: Offstage()),
                Expanded(
                  flex: 15,
                  child: GetBuilder<ReferralController>(
                    id: AppConstant.onGetReferralSystem,
                    builder: (controller) => controller.isLoading
                        ? ReferralShimmerWidget()
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${EnumLocal.txtMyReferralCode.name.tr} :-",
                                  textAlign: TextAlign.center,
                                  style: AppFontStyle.styleW700(AppColor.black, 14),
                                ),
                                15.height,
                                Container(
                                  height: 55,
                                  width: Get.width,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColor.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.grey.withValues(alpha: 0.1),
                                        blurRadius: 0,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColor.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          AppAssets.icReferralCode,
                                          width: 26,
                                        ),
                                      ),
                                      15.width,
                                      Expanded(
                                        child: Text(
                                          FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.referralCode ?? "",
                                          textAlign: TextAlign.center,
                                          style: AppFontStyle.styleW700(AppColor.primary, 15),
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
                                        child: Container(
                                          height: 50,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColor.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                AppAssets.icShareText,
                                                width: 22,
                                                color: AppColor.grayText,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => CustomCopyText.onCopy(text: FetchLoginUserProfileApi.fetchLoginUserProfileModel?.user?.referralCode ?? ""),
                                        child: Container(
                                          height: 50,
                                          width: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.transparent,
                                          ),
                                          child: Image.asset(
                                            AppAssets.icCopy,
                                            width: 20,
                                            color: AppColor.grayText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                15.height,
                                controller.referralSystem.isEmpty
                                    ? SizedBox(
                                        height: 250,
                                        child: NoDataFoundWidget(),
                                      )
                                    : ListView.builder(
                                        itemCount: controller.referralSystem.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final indexData = controller.referralSystem[index];
                                          return _ItemWidget(
                                            index,
                                            indexData.rewardCoins ?? 0,
                                            indexData.targetReferrals ?? 0,
                                          );
                                        },
                                      ),
                                15.height,
                                Container(
                                  width: Get.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${EnumLocal.txtReferralRules.name.tr} :-",
                                        textAlign: TextAlign.center,
                                        style: AppFontStyle.styleW700(AppColor.black, 15),
                                      ),
                                      10.height,
                                      Text(
                                        "You cannot refer yourself using multiple accounts. Any attempt to do so will lead to disqualification from the referral program.Referrals are valid only if your friend is a new user and completes the signup process using your referral code.",
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
              ],
            ),
          ),
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
                Image.asset(
                  AppAssets.icMyCoin,
                  width: 24,
                ),
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
