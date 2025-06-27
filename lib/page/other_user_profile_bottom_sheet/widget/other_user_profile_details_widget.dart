import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:readmore/readmore.dart';
import 'package:tingle/common/function/gender_icon.dart';
import 'package:tingle/common/model/fetch_other_user_profile_model.dart';
import 'package:tingle/common/widget/block_user_dialog_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/report_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/user_role_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/custom/widget/custom_user_more_option_bottom_sheet_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/block_user_page/api/block_unblock_user_api.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

//ignore: must_be_immutable
class OtherUserProfileDetailsWidget extends StatelessWidget {
  const OtherUserProfileDetailsWidget({
    super.key,
    // required this.fetchOtherUserProfileModel,
    // required this.fetchUserProfileModel,
  });
  // OtherUserProfileModel? fetchOtherUserProfileModel;
  // FetchUserProfileModel? fetchUserProfileModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 350,
              width: Get.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                child: PreviewProfileImageWidget(
                  image: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.image ?? "",
                  isBanned: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.isProfilePicBanned ?? false,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColor.white, shape: BoxShape.circle),
                  margin: EdgeInsets.all(5),
                  child: Image.asset(AppAssets.icClose, color: AppColor.black, width: 18),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 55,
              child: Visibility(
                visible: Database.loginUserId != OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.id,
                child: GestureDetector(
                  onTap: () {
                    CustomUserMoreOptionBottomSheetWidget.show(
                      context: context,
                      onClickReport: () {
                        ReportBottomSheetWidget.onShow(
                          context: context,
                          id: OtherUserProfileBottomSheet.userId.value,
                          type: ApiParams.user,
                        );
                      },
                      onClickBlock: () {
                        BlockUserDialogWidget.onShow(
                          callBack: () async {
                            Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

                            final uid = FirebaseUid.onGet() ?? "";
                            final token = await FirebaseAccessToken.onGet() ?? "";

                            await BlockUnblockUserApi.callApi(token: token, uid: uid, toUserId: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.id ?? "");

                            Get.back(); // Stop Loading...

                            if (BlockUnblockUserApi.blockUnblockUserModel?.status == true) {
                              Get.back();
                              Utils.showToast(text: BlockUnblockUserApi.blockUnblockUserModel?.message ?? "");
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColor.transparent, shape: BoxShape.circle),
                    margin: EdgeInsets.all(5),
                    child: Image.asset(AppAssets.icCircleVert, color: AppColor.white, width: 30),
                  ),
                ),
              ),
            ),
          ],
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
                        Container(
                          height: 80,
                          width: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.transparent,
                            border: (OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.activeAvtarFrame?.image?.trim().isEmpty ?? true) ? Border.all(color: AppColor.white, width: 2) : null,
                          ),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                            child: PreviewProfileImageWithFrameWidget(
                              image: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.image ?? "",
                              isBanned: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.isProfilePicBanned ?? false,
                              frame: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.activeAvtarFrame?.image ?? "",
                              type: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.activeAvtarFrame?.type ?? 0,
                              margin: EdgeInsets.all(10),
                            ),
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
                                count: (OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.totalFriends ?? 0).toInt(),
                                callback: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.otherUserConnectionPage, arguments: {ApiParams.tabIndex: 0, ApiParams.userId: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.id})?.then((value) {
                                    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 0);
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
                                title: EnumLocal.txtFollow.name.tr,
                                count: (OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.totalFollowing ?? 0).toInt(),
                                callback: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.otherUserConnectionPage, arguments: {ApiParams.tabIndex: 1, ApiParams.userId: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.id})?.then((value) {
                                    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 0);
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
                                count: (OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.totalFollowers ?? 0).toInt(),
                                callback: () {
                                  Get.back();
                                  Get.toNamed(AppRoutes.otherUserConnectionPage, arguments: {ApiParams.tabIndex: 2, ApiParams.userId: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.id})?.then((value) {
                                    Utils.onChangeStatusBar(brightness: Brightness.dark, delay: 0);
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
                        OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                      ),
                    ),
                    Visibility(
                      visible: OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.isVerified ?? false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 6),
                        child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                      ),
                    ),
                    UserRoleWidget(
                      margin: EdgeInsets.only(left: 5),
                      roles: OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.role ?? [],
                    ),
                  ],
                ),
              ),
              3.height,
              Row(
                children: [
                  PreviewCountryFlagIcon(
                    flag: OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.countryFlagImage,
                    networkFlagSize: 22,
                  ),
                  5.width,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Image.asset(GenderIcon.onShow(OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.gender ?? ""), width: 10),
                        3.width,
                        Text(
                          CustomFormatNumber.onConvert((OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.age ?? 0).toInt()),
                          style: AppFontStyle.styleW600(AppColor.white, 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              5.height,
              Row(
                children: [
                  Text(
                    "${EnumLocal.txtID.name.tr}: ${OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.uniqueId ?? 0}",
                    style: AppFontStyle.styleW400(AppColor.secondary, 13),
                  ),
                  5.width,
                  Image.asset(AppAssets.icCopyId, width: 15),
                ],
              ),
              Visibility(
                visible: (OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.bio?.trim().isNotEmpty ?? false),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.height,
                    ReadMoreText(
                      OtherUserProfileBottomSheet.fetchUserProfileModel?.user?.bio ?? "",
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
    );
    //   Obx(
    //   () =>
    //
    // );
  }
}

//ignore: must_be_immutable
class FakeOtherUserProfileDetailsWidget extends StatelessWidget {
  FakeOtherUserProfileDetailsWidget({
    super.key,
    required this.fetchOtherUserProfileModel,
  });
  FetchOtherUserProfileModel? fetchOtherUserProfileModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 350,
              width: Get.width,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                child: PreviewPostImageWidget(
                  image: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.image ?? "",
                  isBanned: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.isProfilePicBanned ?? false,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(color: AppColor.white, shape: BoxShape.circle),
                  margin: EdgeInsets.all(5),
                  child: Center(child: Icon(Icons.close, color: AppColor.black)),
                ),
              ),
            ),
          ],
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
                        Container(
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
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
                            child: PreviewProfileImageWidget(
                              image: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.image ?? "",
                              isBanned: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.isProfilePicBanned ?? false,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 80,
                          width: 230,
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
                                title: EnumLocal.txtFollow.name.tr,
                                count: (OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.totalFollowing ?? 0).toInt(),
                                callback: () {
                                  Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 1})?.then((value) {
                                    Utils.onChangeStatusBar(brightness: Brightness.dark);
                                  });
                                },
                              ),
                              VerticalDivider(
                                color: AppColor.secondary.withValues(alpha: 0.3),
                                indent: 15,
                                endIndent: 15,
                              ),
                              ItemWidget(
                                title: EnumLocal.txtFollowers.name.tr,
                                count: (OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.totalFollowers ?? 0).toInt(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        maxLines: 1,
                        OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.name ?? "",
                        style: AppFontStyle.styleW700(AppColor.black, 18),
                      ),
                    ),
                    Visibility(
                      visible: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.isVerified ?? false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 6),
                        child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                      ),
                    ),
                  ],
                ),
              ),
              3.height,
              Row(
                children: [
                  PreviewCountryFlagIcon(
                    flag: OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.countryFlagImage,
                    networkFlagSize: 22,
                  ),
                  // Text(
                  //   CountryFlagIcon.onShow(fetchOtherUserProfileModel?.user?.countryFlagImage ?? ""),
                  //   style: AppFontStyle.styleW700(AppColor.black, 18),
                  // ),
                  5.width,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Image.asset(GenderIcon.onShow(OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.gender ?? ""), width: 10),
                        3.width,
                        Text(
                          CustomFormatNumber.onConvert((OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.age ?? 0).toInt()),
                          style: AppFontStyle.styleW600(AppColor.white, 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              5.height,
              Row(
                children: [
                  Text(
                    "${EnumLocal.txtID.name.tr}: ${OtherUserProfileBottomSheet.fetchOtherUserProfileModel?.user?.uniqueId ?? 0}",
                    style: AppFontStyle.styleW400(AppColor.secondary, 13),
                  ),
                  5.width,
                  Image.asset(AppAssets.icCopyId, width: 15),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    //   Obx(
    //   () =>
    //
    // );
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
          height: Get.height,
          width: Get.width,
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
