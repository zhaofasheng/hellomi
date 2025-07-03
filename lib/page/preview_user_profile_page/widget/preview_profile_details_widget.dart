import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
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

import '../../../assets/assets.gen.dart';

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
          Transform.translate(
            offset: Offset(0, -20),
            child:Container(
              color: AppColor.transparent,
              width: Get.width,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F5F5F5'),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    20.height,
                    Row(
                      children: [
                        15.width,
                        ///头像
                        controller.fetchUserProfileModel?.user?.activeAvtarFrame?.image == null
                            ? Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.transparent,
                            border: Border.all(color: HexColor('##00E4A6'), width: 2),
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
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.none,
                          decoration: BoxDecoration(
                            color: AppColor.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(color: HexColor('##00E4A6'), width: 2),
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

                        5.width,
                        ///昵称等信息
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  controller.fetchUserProfileModel?.user?.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW700(AppColor.black, 18),
                                ),
                                3.width,
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
                                    Assets.images.copIdImg.image(width: 15),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: controller.fetchUserProfileModel?.user?.isVerified ?? true,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5, top: 6),
                                    child: Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                                  ),
                                ),
                                UserRoleWidget(
                                  roles: controller.fetchUserProfileModel?.user?.role ?? [],
                                  margin: EdgeInsets.only(left: 5),
                                ),
                                PreviewCountryFlagIcon(flag: controller.fetchUserProfileModel?.user?.countryFlagImage ?? "", networkFlagSize: 18),
                                5.width,
                              ],
                            ),

                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 78),
                      child: Visibility(
                        visible: controller.fetchUserProfileModel?.user?.bio?.trim().isNotEmpty ?? false,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ReadMoreText(
                            controller.fetchUserProfileModel?.user?.bio ?? "",
                            trimMode: TrimMode.Line,
                            trimLines: 3,
                            style: AppFontStyle.styleW400(AppColor.black, 12),
                            colorClickableText: AppColor.primary,
                            trimCollapsedText: EnumLocal.txtShowMore.name.tr,
                            trimExpandedText: EnumLocal.txtShowLess.name.tr,
                            moreStyle: AppFontStyle.styleW600(AppColor.primary, 12),
                          ),
                        ),
                      ),
                    ),
                    15.height,
                    Container(
                    height: 60,
                    width: 280, // 容器固定宽度
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: ItemWidget(
                            title: EnumLocal.txtFriends.name.tr,
                            count: (controller.fetchUserProfileModel?.user?.totalFriends ?? 0).toInt(),
                            callback: () {
                              Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 0})?.then((value) {
                                Utils.onChangeStatusBar(brightness: Brightness.dark);
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: ItemWidget(
                            title: EnumLocal.txtFollowing.name.tr,
                            count: (controller.fetchUserProfileModel?.user?.totalFollowing ?? 0).toInt(),
                            callback: () {
                              Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 1})?.then((value) {
                                Utils.onChangeStatusBar(brightness: Brightness.dark);
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: ItemWidget(
                            title: EnumLocal.txtFollowers.name.tr,
                            count: (controller.fetchUserProfileModel?.user?.totalFollowers ?? 0).toInt(),
                            callback: () {
                              Get.toNamed(AppRoutes.connectionPage, arguments: {ApiParams.tabIndex: 2})?.then((value) {
                                Utils.onChangeStatusBar(brightness: Brightness.dark);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.title,
    required this.count,
    required this.callback,
  });

  final String title;
  final int count;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              CustomFormatNumber.onConvert(count),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF86868F),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: null, // 允许换行
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
