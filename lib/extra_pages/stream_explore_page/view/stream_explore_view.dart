import 'dart:math';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/page/audio_room_page/model/audio_room_model.dart';
import 'package:tingle/page/audio_room_page/widget/private_audio_room_bottom_sheet_widget.dart';
import 'package:tingle/page/fake_live_page/model/fake_live_model.dart';
import 'package:tingle/page/live_page/model/live_model.dart';
import 'package:tingle/page/stream_page/widget/stream_country_tab_bar_widget.dart';
import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
import 'package:tingle/page/stream_page/shimmer/stream_gridview_shimmer_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_gridview_item_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

// class StreamExploreView extends GetView<StreamExploreController> {
//   const StreamExploreView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     controller.init();
//     return Column(
//       children: [
//         5.height,
//         const StreamExploreTabBarWidget(),
//         // 15.height,
//         // Row(
//         //   children: [
//         //     15.width,
//         //     ButtonItemWidget(
//         //       backgroundImage: AppAssets.imgRankingBg,
//         //       icon: AppAssets.icRanking,
//         //       title: EnumLocal.txtAllRanking.name.tr,
//         //     ),
//         //     10.width,
//         //     ButtonItemWidget(
//         //       backgroundImage: AppAssets.imgActivityBg,
//         //       icon: AppAssets.icActivityStar,
//         //       title: EnumLocal.txtActivityCenter.name.tr,
//         //     ),
//         //     15.width,
//         //   ],
//         // ),
//         15.height,
//         GetBuilder<StreamExploreController>(
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
//
//                                         return StreamGridviewItemWidget(
//                                           name: indexData.name ?? "",
//                                           userName: indexData.userName ?? "",
//                                           isBanned: false,
//                                           image: indexData.liveType == 3 ? (indexData.pkThumbnails?[0] ?? "") : indexData.image ?? "",
//                                           isVerify: indexData.isVerified ?? false,
//                                           countryFlag: indexData.countryFlagImage ?? "",
//                                           viewCount: indexData.view ?? 0,
//                                           liveType: indexData.liveType ?? 0,
//                                           callback: () => (indexData.isFake ?? true)
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

// class ButtonItemWidget extends StatelessWidget {
//   const ButtonItemWidget({
//     super.key,
//     required this.title,
//     required this.backgroundImage,
//     required this.icon,
//   });
//
//   final String title;
//   final String backgroundImage;
//   final String icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 60,
//         clipBehavior: Clip.antiAlias,
//         padding: const EdgeInsets.only(left: 15, right: 8),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(backgroundImage),
//             fit: BoxFit.cover,
//           ),
//           borderRadius: BorderRadius.circular(50),
//           border: Border.all(color: AppColor.white),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 style: AppFontStyle.styleW700(AppColor.white, 14),
//               ),
//             ),
//             Image.asset(icon, width: 45),
//           ],
//         ),
//       ),
//     );
//   }
// }
