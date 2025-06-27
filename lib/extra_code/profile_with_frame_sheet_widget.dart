// import 'dart:developer';
//
// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/api/follow_unfollow_user_api.dart';
// import 'package:tingle/common/function/fetch_user_coin.dart';
// import 'package:tingle/common/shimmer/profile_bottom_sheet_shimmer.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/common/widget/preview_profile_with_frame_widget.dart';
// import 'package:tingle/custom/widget/custom_check_box.dart';
// import 'package:tingle/custom/widget/custom_coinday_txt_widget.dart';
// import 'package:tingle/custom/widget/custum_frame_image.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/preview_theme_page/view/preview_them_view.dart';
// import 'package:tingle/page/profile_page/api/fetch_user_profile_api.dart';
// import 'package:tingle/page/profile_page/model/fetch_user_profile_model.dart';
// import 'package:tingle/page/store_page/api/all_frame_api.dart';
// import 'package:tingle/page/store_page/api/purchase_theme_dart.dart';
// import 'package:tingle/page/store_page/controller/store_controller.dart';
// import 'package:tingle/page/store_page/model/top_frame_model.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/api.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/database.dart';
// import 'package:tingle/utils/enums.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PreviewProfileBottomSheetUi {
//   static FetchUserProfileModel? fetchUserProfileModel;
//   static RxBool isLoadingProfile = false.obs;
//   static RxBool isWearDirectly = false.obs;
//   static RxBool isFollow = false.obs;
//
//   static Future<void> onGetProfile(String userId) async {
//     isLoadingProfile.value = true;
//     final token = await FirebaseAccessToken.onGet() ?? "";
//     final uid = FirebaseUid.onGet() ?? "";
//     fetchUserProfileModel = await FetchUserProfileApi.callApi(token: token, uid: uid);
//     if (fetchUserProfileModel?.user?.name != null) {
//       // isFollow.value = fetchUserProfileModel?.user?.isFollow ?? false;
//       isLoadingProfile.value = false;
//     }
//   }
//
//   static Future<void> onClickFollow(String userId) async {
//     if (userId != Database.loginUserId) {
//       isFollow.value = !isFollow.value;
//       final token = await FirebaseAccessToken.onGet() ?? "";
//       final uid = FirebaseUid.onGet() ?? "";
//       await FollowUnfollowUserApi.callApi(token: token, uid: uid, toUserId: userId ?? "");
//     } else {
//       Utils.showToast(text: EnumLocal.txtYouCantFollowYourOwnAccount.name.tr);
//     }
//   }
//
//   static void show({required String userId, required BuildContext context, String? itemType, dynamic frameData}) {
//     onGetProfile(userId);
//     FetchUserCoin.init();
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       backgroundColor: AppColor.transparent,
//       builder: (context) => Container(
//         height: 428,
//         width: Get.width,
//         clipBehavior: Clip.antiAlias,
//         decoration: const BoxDecoration(
//           color: AppColor.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//         ),
//         child: Column(
//           children: [
//             Obx(
//               () => Container(
//                 height: 65,
//                 color: isLoadingProfile.value ? AppColor.white : AppColor.colorBorder,
//                 alignment: Alignment.topRight,
//                 child: GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     margin: const EdgeInsets.only(right: 20, top: 20),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColor.transparent,
//                       border: Border.all(color: AppColor.black),
//                     ),
//                     child: Center(
//                       child: Image.asset(
//                         width: 18,
//                         AppAssets.icClose,
//                         color: AppColor.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Obx(
//                 () => isLoadingProfile.value
//                     ? PreviewProfileBottomSheetShimmerUi()
//                     : SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Container(
//                               color: AppColor.colorBorder,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
//                                 child: Column(
//                                   children: [
//                                     Container(
//                                         height: 100,
//                                         width: 100,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           // gradient: AppColor.rankingGradient,
//                                         ),
//                                         child: PreviewProfileWithFrameWidget(
//                                           height: 100,
//                                           width: 100,
//                                           isBanned: fetchUserProfileModel?.user?.isProfilePicBanned,
//                                           image: fetchUserProfileModel?.user?.image,
//                                           fit: BoxFit.cover,
//                                           frame: frameData,
//                                           itemType: itemType,
//                                         )),
//                                     10.height,
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           frameData!.name ?? "",
//                                           style: AppFontStyle.styleW700(AppColor.black, 18),
//                                         ),
//                                       ],
//                                     ),
//                                     5.height,
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.dialog(
//                                           PreviewThemView(
//                                             type: frameData.type ?? 1,
//                                             imagePath: frameData.image ?? "",
//                                             itemType: itemType ?? "",
//                                             framePath: frameData.svgaImage ?? "",
//                                           ),
//                                           barrierDismissible: true,
//                                           barrierColor: AppColor.transparent,
//                                         );
//                                       },
//                                       child: Container(
//                                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                         decoration: BoxDecoration(
//                                           color: AppColor.grayText,
//                                           borderRadius: BorderRadius.circular(50),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: AppColor.extraLightGray,
//                                               blurRadius: 10,
//                                               offset: const Offset(0, 5),
//                                             ),
//                                           ],
//                                         ),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Image.asset(
//                                               AppAssets.icShow,
//                                               height: 24,
//                                               width: 24,
//                                             ),
//                                             8.width,
//                                             Text(
//                                               EnumLocal.txtPreview.name.tr,
//                                               style: AppFontStyle.styleW600(AppColor.white, 14),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             10.height,
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: Container(
//                                 width: 100,
//                                 height: 80,
//                                 margin: EdgeInsets.only(left: 15),
//                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.colorBorder, border: Border.all(color: AppColor.mediumYellow)),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // Text(
//                                     //   ,
//                                     //   style: AppFontStyle.styleW600(AppColor.black, 14),
//                                     // ),
//                                     TimeValidityText(
//                                       validityType: frameData!.validityType,
//                                       validity: frameData.validity,
//                                       textColor: AppColor.black,
//                                     ),
//                                     5.height,
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 8.0),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Image.asset(
//                                             AppAssets.icCoinStar,
//                                             height: 22,
//                                             width: 22,
//                                           ),
//                                           5.width,
//                                           Text(
//                                             frameData!.coin.toString(),
//                                             style: AppFontStyle.styleW600(AppColor.mediumYellow, 14),
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             7.height,
//                             frameData.isPurchased == true
//                                 ? Container(
//                                     height: 0,
//                                   )
//                                 : Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           10.width,
//                                           CustomCircleCheckbox(
//                                             onChanged: (value) {
//                                               isWearDirectly.value = !isWearDirectly.value;
//                                             },
//                                             isChecked: isWearDirectly.value,
//                                             size: 20,
//                                             activeColor: AppColor.primary,
//                                             borderColor: AppColor.primary,
//                                           ),
//                                           5.width,
//                                           Text(
//                                             EnumLocal.txtWearDirectly.name.tr,
//                                             style: AppFontStyle.styleW500(AppColor.colorLightBlue, 14),
//                                           )
//                                         ],
//                                       ),
//                                       GetBuilder<StoreController>(builder: (logic) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             if (FetchUserCoin.coin >= frameData!.coin) {
//                                               PurchaseThemeApi.callApi(token: logic.token, itemType: itemType ?? "", itemId: frameData.id, userId: logic.uid, directWear: isWearDirectly.value);
//                                             } else {
//                                               Get.toNamed(AppRoutes.rechargeCoinPage);
//                                             }
//                                           },
//                                           child: Container(
//                                             // width: 100,
//                                             // height: 70,
//                                             margin: EdgeInsets.only(right: 8),
//                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: AppColor.primary),
//                                             child: Padding(
//                                               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
//                                               child: Column(
//                                                 mainAxisAlignment: MainAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                     EnumLocal.txtPayTheCoins.name.tr,
//                                                     style: AppFontStyle.styleW600(AppColor.white, 14),
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Image.asset(
//                                                         AppAssets.icCoinStar,
//                                                         height: 22,
//                                                         width: 22,
//                                                       ),
//                                                       5.width,
//                                                       CoinText(
//                                                         coin: frameData!.coin.toString(),
//                                                       )
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       })
//                                     ],
//                                   )
//                           ],
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CoinText extends StatelessWidget {
//   final String? coin;
//
//   const CoinText({super.key, this.coin});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       "${coin ?? "0"}/coin",
//       style: AppFontStyle.styleW700(AppColor.white, 12),
//     );
//   }
// }
