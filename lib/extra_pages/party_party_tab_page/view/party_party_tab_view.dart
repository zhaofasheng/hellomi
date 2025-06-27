// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/widget/loading_widget.dart';
// import 'package:tingle/common/widget/no_data_found_widget.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/custom/function/custom_format_number.dart';
// import 'package:tingle/custom/function/custom_random_light_color.dart';
// import 'package:tingle/page/party_follow_tab_page/widget/party_follow_tab_bar_widget.dart';
// import 'package:tingle/page/party_party_tab_page/controller/party_party_tab_controller.dart';
// import 'package:tingle/page/party_page/widget/party_country_tab_bar_widget.dart';
// import 'package:tingle/page/stream_page/model/fetch_live_user_model.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PartyPartyTabView extends GetView<PartyPartyTabController> {
//   const PartyPartyTabView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     controller.onRefresh();
//     return Column(
//       children: [
//         5.height,
//         const PartyCountryTabBarWidget(),
//         15.height,
//         Expanded(
//           child: LayoutBuilder(builder: (context, box) {
//             return GetBuilder<PartyPartyTabController>(
//               id: AppConstant.onGetLiveUser,
//               builder: (controller) => controller.isLoading
//                   ? LoadingWidget()
//                   : RefreshIndicator(
//                       color: AppColor.primary,
//                       onRefresh: () async => await controller.onRefresh(),
//                       child: controller.liveUsers.isEmpty
//                           ? Center(
//                               child: SingleChildScrollView(
//                                 child: SizedBox(
//                                   height: box.maxHeight + 1,
//                                   child: NoDataFoundWidget(),
//                                 ),
//                               ),
//                             )
//                           : SingleChildScrollView(
//                               child: SizedBox(
//                                 height: box.maxHeight + 1,
//                                 child: SingleChildScrollView(
//                                   child: ListView.builder(
//                                     itemCount: controller.liveUsers.length,
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                                     itemBuilder: (context, index) {
//                                       final indexData = controller.liveUsers[index];
//                                       return GestureDetector(
//                                         onTap: () => controller.onClickItem(indexData),
//                                         child: ItemWidget(liveUser: indexData),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
//
// class ItemWidget extends StatelessWidget {
//   const ItemWidget({super.key, required this.liveUser});
//
//   final LiveUserList liveUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 110,
//       width: Get.width,
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.white),
//         color: CustomRandomLightColor.onGet().withValues(alpha: 0.5),
//         borderRadius: BorderRadius.circular(23),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 110,
//             width: 110,
//             child: Container(
//               height: 110,
//               width: 110,
//               margin: const EdgeInsets.all(8),
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(
//                 color: AppColor.transparent,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: PreviewPostImageWidget(
//                 image: liveUser.roomImage,
//                 fit: BoxFit.cover,
//                 size: 50,
//               ),
//             ),
//           ),
//           5.width,
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   fit: FlexFit.loose,
//                   child: Text(
//                     liveUser.name ?? "",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: AppFontStyle.styleW700(AppColor.black, 16),
//                   ),
//                 ),
//                 5.height,
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                   decoration: BoxDecoration(
//                     color: AppColor.primary.withValues(alpha: 0.15),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Text(
//                     liveUser.roomName ?? "",
//                     style: AppFontStyle.styleW600(AppColor.primary, 12),
//                   ),
//                 ),
//                 8.height,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 30,
//                         color: AppColor.transparent,
//                         child: Stack(
//                           children: [
//                             for (int i = 0; i < (liveUser.viewers?.length ?? 0); i++)
//                               Positioned(
//                                 left: i == 0 ? 0 : i * 25,
//                                 child: Container(
//                                   height: 30,
//                                   width: 30,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppColor.primary,
//                                     border: Border.all(color: AppColor.white),
//                                   ),
//                                   child: Container(
//                                     height: 30,
//                                     width: 30,
//                                     clipBehavior: Clip.antiAlias,
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       color: AppColor.primary,
//                                     ),
//                                     child: PreviewProfileImageWidget(
//                                       image: liveUser.viewers?[i].image,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     5.width,
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: AppColor.black.withValues(alpha: 0.15),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             AppAssets.icLiveWave,
//                             width: 12,
//                             color: AppColor.white,
//                           ),
//                           5.width,
//                           Text(
//                             CustomFormatNumber.onConvert(liveUser.view ?? 0),
//                             style: AppFontStyle.styleW600(AppColor.white, 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           15.width,
//         ],
//       ),
//     );
//   }
// }
