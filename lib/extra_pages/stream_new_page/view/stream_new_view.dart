// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/widget/no_data_found_widget.dart';
// import 'package:tingle/page/stream_explore_page/view/stream_explore_view.dart';
// import 'package:tingle/page/stream_new_page/controller/stream_new_controller.dart';
// import 'package:tingle/page/stream_page/controller/stream_controller.dart';
// import 'package:tingle/page/stream_page/shimmer/stream_gridview_shimmer_widget.dart';
// import 'package:tingle/page/stream_page/widget/stream_gridview_item_widget.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/utils.dart';
//
// class StreamNewView extends GetView<StreamNewController> {
//   const StreamNewView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     controller.init();
//     return Column(
//       children: [
//         5.height,
//         GetBuilder<StreamNewController>(
//           id: AppConstant.onGetLiveUser,
//           builder: (controller) => Expanded(
//             child: LayoutBuilder(
//               builder: (context, box) {
//                 return RefreshIndicator(
//                   color: AppColor.primary,
//                   onRefresh: () => controller.onRefresh(),
//                   child: SingleChildScrollView(
//                     child: Container(
//                       height: box.minHeight + 1,
//                       color: Colors.transparent,
//                       child: RefreshIndicator(
//                         color: AppColor.primary,
//                         onRefresh: () => controller.onRefresh(),
//                         child: SingleChildScrollView(
//                           padding: const EdgeInsets.only(bottom: 15),
//                           child: controller.isLoading
//                               ? StreamGridviewShimmerWidget()
//                               : controller.liveUsers.isEmpty
//                                   ? SizedBox(
//                                       height: box.minHeight + 1,
//                                       child: Center(child: NoDataFoundWidget()),
//                                     )
//                                   : GridView.builder(
//                                       itemCount: controller.liveUsers.length,
//                                       shrinkWrap: true,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 2,
//                                         crossAxisSpacing: 12,
//                                         mainAxisSpacing: 12,
//                                         mainAxisExtent: 230,
//                                       ),
//                                       itemBuilder: (context, index) {
//                                         final indexData = controller.liveUsers[index];
//                                         return StreamGridviewItemWidget(
//                                           name: indexData.name ?? "",
//                                           userName: indexData.userName ?? "",
//                                           isBanned: false,
//                                           image: indexData.liveType == 3 ? (indexData.pkThumbnails?[0] ?? "") : indexData.image ?? "",
//                                           isVerify: indexData.isVerified ?? false,
//                                           countryFlag: indexData.countryFlagImage ?? "",
//                                           viewCount: indexData.view ?? 0,
//                                           liveType: indexData.liveType ?? 0,
//                                           callback: () => indexData.isFake ?? true
//                                               ? indexData.liveType == 2
//                                                   ? onClickFakeAudioRoom(
//                                                       indexData: indexData,
//                                                       callback: () => controller.onRefresh(),
//                                                     )
//                                                   : onClickFakeLive(
//                                                       indexData: indexData,
//                                                       callback: () => controller.onRefresh(),
//                                                     )
//                                               : indexData.liveType == 2
//                                                   ? onClickAudioRoom(
//                                                       indexData: indexData,
//                                                       callback: () => controller.onRefresh(),
//                                                     )
//                                                   : onClickLive(
//                                                       indexData: indexData,
//                                                       callback: () => controller.onRefresh(),
//                                                     ),
//                                         );
//                                       },
//                                     ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
