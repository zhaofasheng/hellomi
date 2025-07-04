import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/connection_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/constant.dart';

class FollowsWidget extends StatelessWidget {
  const FollowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onChangeFollowUpdate,
      builder: (controller) => controller.isLoading
          ? UserListShimmerWidget()
          : controller.following.isEmpty
              ? NoDataFoundWidget()
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.following.length,
                    itemBuilder: (context, index) {
                      final indexData = controller.following[index];
                      return UserListTileWidget(
                        id: indexData.id ?? "",
                        title: indexData.name ?? "",
                        subTitle: indexData.userName ?? "",
                        leading: indexData.image ?? "",
                        isVerified: indexData.isVerified ?? false,
                        isFollow: indexData.isFollow ?? false,
                        isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                        avtarFrame: indexData.avtarFrame ?? "",
                        avtarFrameType: indexData.avtarFrameType ?? 0,
                        callback: () {
                          log("User ID: ${indexData.id}");
                          OtherUserProfileBottomSheet.show(context: context, userID: indexData.id ?? "");
                        },
                        age: indexData.age ?? 18,
                        coin: indexData.coin ?? 0,
                        uniqueId: indexData.uniqueId ?? "",
                        wealthLevelImage: indexData.wealthLevelImage ?? "",
                        isOnline: indexData.isOnline ?? false,
                      );
                    },
                  ),
                ),
    );
  }
}
