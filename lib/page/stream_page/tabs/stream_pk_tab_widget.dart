import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/shimmer/pk_item_shimmer_widget.dart';
import 'package:tingle/page/stream_page/widget/banner_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_tab_item_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

class StreamPkTabWidget extends GetView<StreamController> {
  const StreamPkTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamController>(
      id: AppConstant.onGetPkLiveUser,
      builder: (controller) => LayoutBuilder(
        builder: (context, box) {
          return RefreshIndicator(
            color: AppColor.primary,
            onRefresh: () => controller.onRefresh(),
            child: SingleChildScrollView(
              child: Container(
                height: box.minHeight + 1,
                color: Colors.transparent,
                child: RefreshIndicator(
                  color: AppColor.primary,
                  onRefresh: () => controller.onRefresh(),
                  child: SingleChildScrollView(
                    controller: controller.exploreScrollController,
                    padding: const EdgeInsets.only(bottom: 15),
                    child: controller.isLoadingPk
                        ? PkItemShimmerWidget()
                        : controller.pkLiveUsers.isEmpty
                            ? SizedBox(
                                height: box.minHeight + 1,
                                child: Center(child: NoDataFoundWidget()),
                              )
                            : ListView.separated(
                                itemCount: controller.pkLiveUsers.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                itemBuilder: (context, index) {
                                  final indexData = controller.pkLiveUsers[index];
                                  return StreamTabItemWidget(indexData: indexData);
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return (index + 1) == Utils.bannerShowIndex
                                      ? BannerWidget(
                                          isShow: (controller.pkLiveUsers.length > Utils.bannerShowIndex),
                                          margin: EdgeInsets.only(bottom: 10),
                                        )
                                      : Offstage();
                                },
                              ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
