// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:tingle/common/widget/no_data_found_widget.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/common/widget/rendom_name_setter_widget.dart';
// import 'package:tingle/custom/function/custom_format_number.dart';
// import 'package:tingle/custom/widget/custom_rank_slider_widget.dart';
// import 'package:tingle/page/fake_steam_pk_page/controller/fake_stream_pk_controller.dart';
// import 'package:tingle/page/stream_explore_page/view/stream_explore_view.dart';
// import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
// import 'package:tingle/page/stream_page/shimmer/pk_item_shimmer_widget.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FakeOneVsOnePkWidget extends GetView<FakeStreamPkController> {
//   const FakeOneVsOnePkWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FakeStreamPkController>(
//       id: AppConstant.onGetLiveUser,
//       builder: (controller) => LayoutBuilder(
//         builder: (context, box) {
//           return RefreshIndicator(
//             color: AppColor.primary,
//             onRefresh: () => controller.onRefresh(),
//             child: SingleChildScrollView(
//               child: Container(
//                 height: box.minHeight + 1,
//                 color: Colors.transparent,
//                 child: RefreshIndicator(
//                   color: AppColor.primary,
//                   onRefresh: () => controller.onRefresh(),
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.only(bottom: 15),
//                     child: controller.isLoading
//                         ? PkItemShimmerWidget()
//                         : controller.liveUsers.isEmpty
//                             ? SizedBox(
//                                 height: box.minHeight + 1,
//                                 child: Center(child: NoDataFoundWidget()),
//                               )
//                             : ListView.builder(
//                                 itemCount: controller.liveUsers.length,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                                 itemBuilder: (context, index) {
//                                   final indexData = controller.liveUsers[index];
//                                   return ItemWidget(
//                                     indexData: indexData,
//                                     callback: () => indexData.isFake ?? true
//                                         ? indexData.liveType == 2
//                                             ? onClickFakeAudioRoom(
//                                                 indexData: indexData,
//                                                 callback: () => controller.onRefresh(),
//                                               )
//                                             : onClickFakeLive(
//                                                 indexData: indexData,
//                                                 callback: () => controller.onRefresh(),
//                                               )
//                                         : indexData.liveType == 2
//                                             ? onClickAudioRoom(
//                                                 indexData: indexData,
//                                                 callback: () => controller.onRefresh(),
//                                               )
//                                             : onClickLive(
//                                                 indexData: indexData,
//                                                 callback: () => controller.onRefresh(),
//                                               ),
//                                   );
//                                 },
//                               ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class ItemWidget extends StatelessWidget {
//   const ItemWidget({super.key, required this.indexData, required this.callback});
//
//   final LiveUserList indexData;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: callback,
//       child: Container(
//         height: 160,
//         width: Get.width,
//         margin: const EdgeInsets.only(bottom: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           color: AppColor.white,
//           borderRadius: BorderRadius.circular(23),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 55,
//                           width: 55,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(
//                             color: AppColor.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: PreviewProfileImageWidget(
//                             image: indexData.image ?? "",
//                           ),
//                         ),
//                         5.height,
//                         Text(
//                           indexData.name ?? "",
//                           style: AppFontStyle.styleW600(AppColor.black, 12),
//                         ),
//                         5.height,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(AppAssets.icYellowWin, width: 35),
//                             Text(
//                               "x${CustomFormatNumber.onConvert(indexData.localGiftCount ?? 0)}",
//                               style: AppFontStyle.styleW900(AppColor.pink, 14),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     width: 100,
//                     alignment: Alignment.center,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Image.asset(AppAssets.imgRandomPk, width: 100),
//                         Image.asset(AppAssets.icYellowVs, width: 100),
//                         const Offstage(),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 55,
//                           width: 55,
//                           clipBehavior: Clip.antiAlias,
//                           decoration: const BoxDecoration(
//                             color: AppColor.transparent,
//                             shape: BoxShape.circle,
//                           ),
//                           child: PreviewProfileImageWidget(image: indexData.host2Image),
//                         ),
//                         5.height,
//                         Text(
//                           RandomNameSetter.getName(
//                             indexData.host2Name ?? "",
//                           ),
//                           style: AppFontStyle.styleW600(AppColor.black, 12),
//                         ),
//                         5.height,
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(AppAssets.icYellowWin, width: 35),
//                             Text(
//                               "x${CustomFormatNumber.onConvert(indexData.remoteGiftCount ?? 0)}",
//                               style: AppFontStyle.styleW900(AppColor.pink, 14),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CustomRankSliderWidget(
//               rank1: indexData.localRank ?? 0,
//               rank2: indexData.remoteRank ?? 0,
//               width: (Get.width - 54),
//               height: 20,
//             ),
//             12.height,
//           ],
//         ),
//       ),
//     );
//   }
// }
