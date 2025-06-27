import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/block_user_page/api/block_unblock_user_api.dart';
import 'package:tingle/page/block_user_page/model/fetch_block_user_model.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class BlockUserListTileWidget extends StatefulWidget {
  const BlockUserListTileWidget({super.key, required this.blockedUsers});

  final BlockedUsers blockedUsers;

  @override
  State<BlockUserListTileWidget> createState() => _BlockUserListTileWidgetState();
}

class _BlockUserListTileWidgetState extends State<BlockUserListTileWidget> {
  RxBool isBlock = false.obs;

  @override
  void initState() {
    isBlock.value = true;
    super.initState();
  }

  void onClickBlockUnblock() async {
    isBlock.value = !isBlock.value;
    final token = await FirebaseAccessToken.onGet() ?? "";
    final uid = FirebaseUid.onGet() ?? "";

    await BlockUnblockUserApi.callApi(
      token: token,
      uid: uid,
      toUserId: widget.blockedUsers.toUserId?.id ?? "",
    );

    if (BlockUnblockUserApi.blockUnblockUserModel?.status == true) {
      Utils.showToast(text: BlockUnblockUserApi.blockUnblockUserModel?.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 80,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColor.transparent,
          border: Border(
            bottom: BorderSide(color: AppColor.secondary.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: AppColor.transparent, shape: BoxShape.circle),
              child: PreviewProfileImageWithFrameWidget(
                image: widget.blockedUsers.toUserId?.image,
                isBanned: widget.blockedUsers.toUserId?.isProfilePicBanned,
                frame: widget.blockedUsers.toUserId?.activeAvtarFrame?.image,
                type: widget.blockedUsers.toUserId?.activeAvtarFrame?.type,
                margin: EdgeInsets.all(10),
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
                          widget.blockedUsers.toUserId?.name ?? "",
                          maxLines: 1,
                          style: AppFontStyle.styleW700(AppColor.black, 13),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Image.asset(AppAssets.icAuthoriseIcon, width: 18),
                        ),
                      ),
                    ],
                  ),
                  3.height,
                  Text(
                    widget.blockedUsers.toUserId?.userName ?? "",
                    maxLines: 1,
                    style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 10),
                  ),
                ],
              ),
            ),
            12.width,
            GestureDetector(
              onTap: onClickBlockUnblock,
              child: Obx(
                () => Container(
                  height: 80,
                  color: AppColor.transparent,
                  alignment: Alignment.center,
                  child: Container(
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: isBlock.value ? AppColor.transparent : AppColor.primary,
                      border: Border.all(color: isBlock.value ? AppColor.primary : AppColor.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Image.asset(isBlock.value ? AppAssets.icUnlockUser : AppAssets.icBlockUser, width: 18, color: isBlock.value ? AppColor.primary : AppColor.white),
                        5.width,
                        Text(
                          isBlock.value ? EnumLocal.txtUnblock.name.tr : EnumLocal.txtBlock.name.tr,
                          style: AppFontStyle.styleW600(isBlock.value ? AppColor.primary : AppColor.white, 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
