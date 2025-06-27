import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/live_page/api/fetch_available_live_user_for_pk_api.dart';
import 'package:tingle/page/live_page/controller/live_controller.dart';
import 'package:tingle/page/live_page/model/fetch_available_live_user_for_pk_model.dart';
import 'package:tingle/page/live_page/pk_battle_widget/sending_pk_request_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class InviteUserForPkBattleBottomSheet {
  static bool isOpenBottomSheet = false;
  static RxBool isLoading = false.obs;
  static FetchAvailableLiveUserForPkModel? fetchAvailableLiveUserForPkModel;
  static List<LiveUserList> liveUsers = [];

  static void onGetAvailableLiveUser() async {
    isLoading.value = true;
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    fetchAvailableLiveUserForPkModel = await FetchAvailableLiveUserForPkApi.callApi(token: token, uid: uid);
    liveUsers = fetchAvailableLiveUserForPkModel?.liveUserList ?? [];
    isLoading.value = false;
  }

  static Future<void> onShow() async {
    isOpenBottomSheet = true;
    onGetAvailableLiveUser();
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Obx(
        () => Container(
          height: Get.height / 2,
          width: Get.width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 65,
                color: AppColor.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    50.width,
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 35,
                          decoration: BoxDecoration(
                            color: AppColor.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        10.height,
                        Text(
                          "Invite for Pk Battle",
                          style: AppFontStyle.styleW700(AppColor.white, 17),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.white.withValues(alpha: 0.2),
                        ),
                        child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isLoading.value
                    ? LoadingWidget()
                    : liveUsers.isEmpty
                        ? NoDataFoundWidget()
                        : SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: liveUsers.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final indexData = liveUsers[index];
                                return _ItemWidget(
                                  title: indexData.name ?? "",
                                  subTitle: indexData.userName ?? "",
                                  leading: indexData.image ?? "",
                                  callback: () {
                                    final controller = Get.find<LiveController>();
                                    controller.onSendPkRequest(host2UserId: indexData.userId ?? "");
                                    Get.back();
                                    SendingPkRequestBottomSheet.onShow(
                                      context: context,
                                      h1Name: controller.liveModel?.host1Name ?? "",
                                      h1Image: controller.liveModel?.host1Image ?? "",
                                      isBannedH1Image: controller.liveModel?.host1ProfilePicIsBanned ?? false,
                                      h2Name: indexData.name ?? "",
                                      h2Image: indexData.image ?? "",
                                      isBannedH2Image: indexData.isProfilePicBanned ?? false,
                                      callback: () {
                                        Get.back();
                                        controller.onCancelPkRequest(host2UserId: indexData.userId ?? "");
                                      },
                                    );
                                  },
                                  isVerified: indexData.isVerified ?? false,
                                  isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() => isOpenBottomSheet = false);
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leading,
    required this.callback,
    required this.isVerified,
    required this.isProfileImageBanned,
  });

  final String title;
  final String subTitle;
  final String leading;
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
              decoration: BoxDecoration(color: AppColor.secondary, shape: BoxShape.circle),
              child: PreviewProfileImageWidget(image: leading, isBanned: isProfileImageBanned),
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
                          style: AppFontStyle.styleW700(AppColor.black, 15),
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
                  Text(
                    subTitle,
                    maxLines: 1,
                    style: AppFontStyle.styleW600(AppColor.lightGreyPurple, 12),
                  ),
                ],
              ),
            ),
            12.width,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                "Invite Now",
                style: AppFontStyle.styleW600(AppColor.primary, 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
