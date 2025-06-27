import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/api/follow_unfollow_user_api.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class UserListTileWidget extends StatefulWidget {
  const UserListTileWidget({
    super.key,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.isVerified,
    required this.isProfileImageBanned,
    required this.isFollow,
    required this.isOnline,
    required this.wealthLevelImage,
    required this.coin,
    required this.uniqueId,
    required this.age,
    required this.callback,
    required this.avtarFrame,
    required this.avtarFrameType,
  });
  final String id;
  final String title;
  final String subTitle;
  final String leading;
  final String uniqueId;
  final String wealthLevelImage;
  final bool isVerified;
  final int coin;
  final int age;
  final bool isFollow;
  final bool isProfileImageBanned;
  final bool isOnline;
  final Callback callback;
  final String avtarFrame;
  final int avtarFrameType;

  @override
  State<UserListTileWidget> createState() => _UserListTileWidgetState();
}

class _UserListTileWidgetState extends State<UserListTileWidget> {
  RxBool isFollow = false.obs;

  @override
  void initState() {
    isFollow.value = widget.isFollow;
    super.initState();
  }

  void onClickFollow(ConnectionController controller) async {
    if (widget.id != Database.loginUserId) {
      isFollow.value = !isFollow.value;
      final token = await FirebaseAccessToken.onGet() ?? "";
      final uid = FirebaseUid.onGet() ?? "";
      await FollowUnfollowUserApi.callApi(token: token, uid: uid, toUserId: widget.id);
      await controller.onGetData();
      isFollow.value = widget.isFollow;
      controller.onTabChange(controller.tabController!.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onChangeFollowUpdate,
      builder: (controller) {
        return GestureDetector(
          onTap: widget.callback,
          child: Container(
            height: 90,
            width: Get.width,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColor.grayText.withValues(alpha: 0.2),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColor.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: PreviewProfileImageWithFrameWidget(
                        image: widget.leading,
                        isBanned: widget.isProfileImageBanned,
                        frame: widget.avtarFrame,
                        type: widget.avtarFrameType,
                        margin: EdgeInsets.all(10),
                      ),
                    ),
                    widget.isOnline
                        ? Positioned(
                            bottom: 3,
                            right: 3,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.white, width: 1.2),
                                shape: BoxShape.circle,
                                color: AppColor.green,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
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
                              widget.title,
                              maxLines: 1,
                              style: AppFontStyle.styleW700(AppColor.black, 13),
                            ),
                          ),
                          Visibility(
                            visible: widget.isVerified,
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
                            height: 18,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Image.asset(AppAssets.icFemale, width: 10),
                                3.width,
                                Text(
                                  "${widget.age}",
                                  style: AppFontStyle.styleW600(AppColor.white, 10),
                                ),
                              ],
                            ),
                          ),
                          5.width,
                          PreviewWealthLevelImage(
                            image: widget.wealthLevelImage,
                            height: 18,
                          ),
                          5.width,
                          Container(
                            height: 18,
                            padding: const EdgeInsets.only(left: 4, right: 8),
                            decoration: BoxDecoration(
                              color: AppColor.lightYellow.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                Image.asset(AppAssets.icCoinStar, width: 15),
                                3.width,
                                Text(
                                  CustomFormatNumber.onConvert(widget.coin),
                                  style: AppFontStyle.styleW600(AppColor.lightYellow, 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      5.height,
                      Text(
                        "${EnumLocal.txtID.name.tr} ${widget.uniqueId}",
                        maxLines: 1,
                        style: AppFontStyle.styleW600(AppColor.grayText, 10),
                      ),
                    ],
                  ),
                ),
                12.width,
                Obx(
                  () => GestureDetector(
                    onTap: () => onClickFollow(controller),
                    child: Container(
                      height: 92,
                      color: AppColor.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: isFollow.value ? AppColor.primary.withValues(alpha: 0.08) : AppColor.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          isFollow.value ? EnumLocal.txtFollowing.name.tr : EnumLocal.txtFollow.name.tr,
                          style: AppFontStyle.styleW600(isFollow.value ? AppColor.primary : AppColor.white, 12),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
