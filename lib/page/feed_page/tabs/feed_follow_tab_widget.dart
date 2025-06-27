import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/widget/custom_dark_background_widget.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/page/feed_page/shimmer/feed_shimmer_widget.dart';
import 'package:tingle/page/feed_page/widget/feed_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FeedFollowTabWidget extends GetView<FeedController> {
  const FeedFollowTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomDarkBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).viewPadding.top + 50),
                10.height,
                Expanded(
                  child: GetBuilder<FeedController>(
                    id: AppConstant.onGetFollowPost,
                    builder: (controller) => LayoutBuilder(
                      builder: (context, box) {
                        return RefreshIndicator(
                          color: AppColor.primary,
                          onRefresh: () => controller.onRefreshFollowPost(),
                          child: controller.isLoadingFollow
                              ? FeedShimmerWidget()
                              : controller.followPost.isEmpty
                                  ? SingleChildScrollView(
                                      child: SizedBox(
                                        height: box.maxHeight + 1, // USE TO ACTIVE REFRESH INDICATOR
                                        child: NoDataFoundWidget(),
                                      ),
                                    )
                                  : LayoutBuilder(builder: (context, box) {
                                      return RefreshIndicator(
                                        color: AppColor.primary,
                                        onRefresh: () => controller.onRefreshFollowPost(),
                                        child: SingleChildScrollView(
                                          child: SizedBox(
                                            height: box.maxHeight + 1,
                                            child: RefreshIndicator(
                                              color: AppColor.primary,
                                              onRefresh: () => controller.onRefreshFollowPost(),
                                              child: SingleChildScrollView(
                                                controller: controller.followScrollController,
                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: controller.followPost.length,
                                                      padding: const EdgeInsets.only(left: 15, right: 15),
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        final indexData = controller.followPost[index];
                                                        return FeedItemWidget(post: indexData);
                                                      },
                                                    ),
                                                    controller.followPost.length == 1 ? (Get.width / 2).height : Offstage(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<FeedController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isPaginationFollow,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
