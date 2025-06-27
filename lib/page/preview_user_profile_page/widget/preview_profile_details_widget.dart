import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:readmore/readmore.dart';
import 'package:tingle/common/function/gender_icon.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/user_role_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileDetailsWidget extends StatelessWidget {
  const PreviewProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreviewUserProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) => Column(
        children: [
          Container(
            height: 350,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.imgCreateLiveRoomBg),
                fit: BoxFit.cover,
              ),
            ),
            child: PreviewPostImageWidget(
              image: controller.fetchUserProfileModel?.user?.image ?? "",
              isBanned: controller.fetchUserProfileModel?.user?.isProfilePicBanned ?? false,
              fit: BoxFit.cover,
              isShowPlaceHolder: false,
            ),
          ),
          Container(
            color: AppColor.transparent,
            height: 50,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -40,
                    child: SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          controller.fetchUserProfileModel?.user?.activeAvtarFrame?.image == null
                              ? Container(
                                  height: 80,
                                  width: 80,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.transparent,
                                    border: Border.all(color: AppColor.white, width: 2),
                                  ),
                                  child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.transparent,
                                    ),
                                    child: PreviewProfileImageWidget(
                                      image: controller.fetchUserProfileModel?.user?.image ?? "",
                                      isBanned: controller.fetchUserProfileModel?.user?.isProfilePicBanned ?? false,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  clipBehavior: Clip.none,
                                  decoration: const BoxDecoration(
                                    color: AppColor.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: PreviewProfileImageWithFrameWidget(
                                    image: controller.fetchUserProfileModel?.user?.image,
                                    isBanned: controller.fetchUserProfileModel?.user?.isProfilePicBanned ?? false,
                                    fit: BoxFit.cover,
                                    frame: controller.fetchUserProfileModel?.user?.activeAvtarFrame?.image ?? "",
                                    type: controller.fetchUserProfileModel?.user?.activeAvtarFrame?.type ?? 1,
                                    margin: EdgeInsets.all(5),
                                  ),
                                ),
                          Spacer(),
                          Container(
                            height: 80,
                            width: 280,
                            clipBehavior: Clip.antiAlias,
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: AppColor.white,
                              border: Border(
                                top: BorderSide(color: AppColor.lightGray),
                                left: BorderSide(color: AppColor.lightGray),
                                bottom: BorderSide(color: AppColor.lightGray),
                              ),
                            ),
                            child: Row(
                              children: [
                                ItemWidget(
                                  title: EnumLocal.txtFriends.name.tr,
                                  count: (controller.fetchUserProfileModel?.user?.totalFriends ?? 0).toInt(),
                                  callback: () {
                                    Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 0})?.then((value) {
                                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                                    });
                                  },
                                ),
                                VerticalDivider(
                                  color: AppColor.secondary.withValues(alpha: 0.3),
                                  width: 0,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ItemWidget(
                                  title: EnumLocal.txtFollowing.name.tr,
                                  count: (controller.fetchUserProfileModel?.user?.totalFollowing ?? 0).toInt(),
                                  callback: () {
                                    Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 1})?.then((value) {
                                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                                    });
                                  },
                                ),
                                VerticalDivider(
                                  color: AppColor.secondary.withValues(alpha: 0.3),
                                  width: 0,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ItemWidget(
                                  title: EnumLocal.txtFollowers.name.tr,
                                  count: (controller.fetchUserProfileModel?.user?.totalFollowers ?? 0).toInt(),
                                  callback: () {
                                    Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 2})?.then((value) {
                                      Utils.onChangeStatusBar(brightness: Brightness.dark);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          maxLines: 1,
                          controller.fetchUserProfileModel?.user?.name ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.styleW700(AppColor.black, 18),
                        ),
                      ),
                      Visibility(
                        visible: controller.fetchUserProfileModel?.user?.isVerified ?? false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 6),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                        ),
                      ),
                      UserRoleWidget(
                        roles: controller.fetchUserProfileModel?.user?.role ?? [],
                        margin: EdgeInsets.only(left: 5),
                      ),
                    ],
                  ),
                ),
                3.height,
                Row(
                  children: [
                    PreviewCountryFlagIcon(flag: controller.fetchUserProfileModel?.user?.countryFlagImage ?? "", networkFlagSize: 18),
                    5.width,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Image.asset(GenderIcon.onShow(controller.fetchUserProfileModel?.user?.gender ?? ""), width: 10),
                          3.width,
                          Text(
                            CustomFormatNumber.onConvert((controller.fetchUserProfileModel?.user?.age ?? 0).toInt()),
                            style: AppFontStyle.styleW600(AppColor.white, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                5.height,
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: (controller.fetchUserProfileModel?.user?.uniqueId).toString()));
                    Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                  },
                  child: Container(
                    color: AppColor.transparent,
                    child: Row(
                      children: [
                        Text(
                          "ID: ${controller.fetchUserProfileModel?.user?.uniqueId ?? 0}",
                          style: AppFontStyle.styleW600(AppColor.grayText, 12),
                        ),
                        5.width,
                        Image.asset(AppAssets.icCopyId, width: 15),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.fetchUserProfileModel?.user?.bio?.trim().isNotEmpty ?? false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.height,
                      ReadMoreText(
                        controller.fetchUserProfileModel?.user?.bio ?? "",
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        style: AppFontStyle.styleW400(AppColor.black, 12),
                        colorClickableText: AppColor.primary,
                        trimCollapsedText: EnumLocal.txtShowMore.name.tr,
                        trimExpandedText: EnumLocal.txtShowLess.name.tr,
                        moreStyle: AppFontStyle.styleW600(AppColor.primary, 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.title, required this.count, required this.callback});

  final String title;
  final int count;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          color: AppColor.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CustomFormatNumber.onConvert(count),
                style: AppFontStyle.styleW700(AppColor.primary, 18),
              ),
              3.height,
              Text(
                title,
                style: AppFontStyle.styleW500(AppColor.secondary, 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
