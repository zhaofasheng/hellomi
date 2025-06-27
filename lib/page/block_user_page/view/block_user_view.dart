import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/page/block_user_page/controller/block_user_controller.dart';
import 'package:tingle/page/block_user_page/widget/block_user_list_tile_widget.dart';
import 'package:tingle/page/privacy_policy_page/controller/privacy_policy_controller.dart';
import 'package:tingle/page/privacy_policy_page/widget/privacy_policy_app_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlockUserView extends GetView<BlockUserController> {
  const BlockUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarWidget.onShow(context: context, title: EnumLocal.txtBlockedUserList.name.tr),
      body: LayoutBuilder(
        builder: (context, box) => GetBuilder<BlockUserController>(
          id: AppConstant.onGetBlockUsers,
          builder: (controller) => controller.isLoading
              ? UserListShimmerWidget()
              : controller.blockUsers.isEmpty
                  ? RefreshIndicator(
                      onRefresh: controller.init,
                      color: AppColor.primary,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: Get.height + 1,
                          child: NoDataFoundWidget(),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: controller.init,
                      color: AppColor.primary,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: Get.height + 1,
                          child: RefreshIndicator(
                            onRefresh: controller.init,
                            color: AppColor.primary,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.zero,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.blockUsers.length,
                                itemBuilder: (context, index) {
                                  final indexData = controller.blockUsers[index];

                                  return BlockUserListTileWidget(blockedUsers: indexData);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
