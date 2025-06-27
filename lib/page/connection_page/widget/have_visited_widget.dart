import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/connection_widget.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/utils/constant.dart';

class HaveVisitedWidget extends StatelessWidget {
  const HaveVisitedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onGetSearchUser,
      builder: (controller) => controller.isLoading
          ? UserListShimmerWidget()
          : controller.visitedProfiles.isEmpty
              ? NoDataFoundWidget()
              : SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.visitedProfiles.length,
                    itemBuilder: (context, index) {
                      final indexData = controller.visitedProfiles[index];

                      return UserListTileWidget(
                        id: indexData.id ?? "",
                        title: indexData.name ?? "",
                        subTitle: indexData.userName ?? "",
                        leading: indexData.image ?? "",
                        isVerified: indexData.isVerified ?? false,
                        isFollow: indexData.isFollow ?? false,
                        uniqueId: indexData.uniqueId ?? "",
                        age: indexData.age ?? 18,
                        coin: indexData.coin ?? 0,
                        isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                        avtarFrame: indexData.avtarFrame ?? "",
                        avtarFrameType: indexData.avtarFrameType ?? 0,
                        callback: () {
                          OtherUserProfileBottomSheet.show(context: context, userID: indexData.id ?? "");
                        },
                        wealthLevelImage: indexData.wealthLevelImage ?? "",
                        isOnline: indexData.isOnline ?? false,
                      );
                    },
                  ),
                ),
    );
  }
}
