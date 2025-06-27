import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/feed_page/controller/feed_controller.dart';
import 'package:tingle/page/feed_page/shimmer/video_shimmer_widget.dart';
import 'package:tingle/page/feed_page/widget/video_item_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class FeedVideoTabWidget extends GetView<FeedController> {
  const FeedVideoTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () => controller.onChangePage(0));

    Utils.onChangeStatusBar(brightness: Brightness.light);

    return Scaffold(
      backgroundColor: AppColor.black,
      body: GetBuilder<FeedController>(
        id: AppConstant.onGetVideo,
        builder: (controller) => controller.isLoading
            ? VideoShimmerWidget()
            : controller.videos.isEmpty
                ? RefreshIndicator(
                    color: AppColor.primary,
                    onRefresh: () async => await controller.onRefreshVideos(),
                    child: LayoutBuilder(builder: (context, box) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: box.maxHeight + 1,
                          child: NoDataFoundWidget(),
                        ),
                      );
                    }),
                  )
                : RefreshIndicator(
                    color: AppColor.primary,
                    onRefresh: () async => await controller.onRefreshVideos(),
                    child: PageView.builder(
                      itemCount: controller.videos.length,
                      scrollDirection: Axis.vertical,
                      onPageChanged: (value) {
                        controller.onPaginationVideo(value);
                        controller.onChangePage(value);
                      },
                      itemBuilder: (context, index) {
                        return GetBuilder<FeedController>(
                          id: AppConstant.onChangePage,
                          builder: (controller) => VideoItemWidget(
                            index: index,
                            currentIndex: controller.currentIndex,
                            videoData: controller.videos[index],
                            isInsertBottomBarSpace: true,
                          ),
                        );
                      },
                    ),
                  ),
      ),
      bottomNavigationBar: GetBuilder<FeedController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
