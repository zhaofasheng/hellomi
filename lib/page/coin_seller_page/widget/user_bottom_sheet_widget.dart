import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/widget/custom_text_field_widget.dart';
import 'package:tingle/page/coin_seller_page/controller/coin_seller_controller.dart';
import 'package:tingle/page/coin_seller_page/model/filter_user_model.dart';
import 'package:tingle/page/language_page/widget/language_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class UserBottomSheetWidget {
  static RxBool isLoading = false.obs;
  static RxBool isOpenBottomSheet = false.obs;
  static Future<void> show({required BuildContext context}) async {
    isLoading.value = true;

    Future.delayed(Duration(milliseconds: 300), () => isLoading.value = false);

    isOpenBottomSheet.value = true;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: Get.height,
      enableDrag: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SizedBox(
        height: Get.height / 1.1,
        width: Get.width,
        child: GetBuilder<CoinSellerController>(
          id: AppConstant.onGetUserList,
          builder: (controller) => Column(
            children: [
              Container(
                height: 65,
                color: AppColor.secondary.withValues(alpha: 0.1),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    30.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 4,
                            width: 35,
                            decoration: BoxDecoration(
                              color: AppColor.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          10.height,
                          Text(
                            EnumLocal.txtSelectUser.name.tr,
                            style: AppFontStyle.styleW700(AppColor.black, 17),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColor.secondary),
                        child: Center(
                          child: Image.asset(
                            width: 18,
                            AppAssets.icClose,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.height,
              Container(
                height: 60,
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomTextFieldWidget(
                  controller: controller.searchController,
                  hintText: EnumLocal.txtSearchHintText.name.tr,
                  fillColor: AppColor.colorBorder.withValues(alpha: 0.3),
                  textColor: AppColor.grayText,
                  onChange: (value) => controller.onGetUserList(search: value.trim()),
                ),
              ),
              10.height,
              Obx(
                () => isLoading.value
                    ? Expanded(child: UserListShimmerWidget())
                    : Expanded(
                        child: controller.isSearchUser
                            ? UserListShimmerWidget()
                            : controller.userList.isEmpty
                                ? NoDataFoundWidget()
                                : SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.userList.length,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final userData = controller.userList[index];
                                        return UserItemWidget(
                                          user: userData,
                                          onSelect: () => controller.onClickUser(userData),
                                        );
                                      },
                                    ),
                                  ),
                      ),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() => isOpenBottomSheet.value = false);
  }
}

class UserItemWidget extends GetView<CoinSellerController> {
  const UserItemWidget({super.key, this.user, required this.onSelect});

  final UserData? user;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onSelect,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.transparent,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: PreviewProfileImageWithFrameWidget(
                      image: user?.image ?? '',
                      isBanned: user?.isProfilePicBanned,
                      frame: user?.avtarFrame,
                      type: user?.avtarFrameType,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                  8.width,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? '',
                          style: AppFontStyle.styleW700(AppColor.black, 13),
                        ),
                        2.height,
                        Text(
                          user?.uniqueId ?? '',
                          style: AppFontStyle.styleW500(AppColor.lightGreyPurple, 12),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  RadioItem(isSelected: controller.selectedUserId == user?.uniqueId),
                ],
              ),
              Divider(color: AppColor.colorBorder),
            ],
          ),
        ));
  }
}
