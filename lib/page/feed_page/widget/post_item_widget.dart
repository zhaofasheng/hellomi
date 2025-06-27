// import 'package:animated_flip_counter/animated_flip_counter.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:readmore/readmore.dart';
// import 'package:tingle/common/function/common_share.dart';
// import 'package:tingle/common/widget/comment_bottom_sheet_widget.dart';
// import 'package:tingle/custom/function/custom_format_number.dart';
// import 'package:tingle/common/widget/preview_network_image_widget.dart';
// import 'package:tingle/firebase/authentication/firebase_access_token.dart';
// import 'package:tingle/firebase/authentication/firebase_uid.dart';
// import 'package:tingle/page/feed_page/api/like_post_api.dart';
// import 'package:tingle/page/feed_page/api/share_post_api.dart';
// import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PostItemWidget extends StatefulWidget {
//   const PostItemWidget({super.key, this.post});
//
//   final Post? post;
//
//   @override
//   State<PostItemWidget> createState() => _PostItemWidgetState();
// }
//
// class _PostItemWidgetState extends State<PostItemWidget> {
//   RxBool isLike = false.obs;
//   RxBool isFollow = false.obs;
//
//   RxInt likeCount = 0.obs;
//   RxInt commentCount = 0.obs;
//   RxInt shareCount = 0.obs;
//
//   @override
//   void initState() {
//     isLike.value = widget.post?.isLike ?? false;
//     isFollow.value = widget.post?.isFollow ?? false;
//     likeCount.value = (widget.post?.totalLikes ?? 0).toInt();
//     commentCount.value = (widget.post?.totalComments ?? 0).toInt();
//     shareCount.value = (widget.post?.shareCount ?? 0).toInt();
//     super.initState();
//   }
//
//   void onToggleLike() async {
//     isLike.value ? likeCount-- : likeCount++;
//     isLike.value = !isLike.value;
//
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//
//     await LikePostApi.callApi(token: token, uid: uid, postId: widget.post?.id ?? "");
//   }
//
//   void onClickComment() async {
//     commentCount.value = await CommentBottomSheetWidget.onShow(context: context, type: ApiParams.post, id: widget.post?.id ?? "", commentCount: commentCount.value);
//   }
//
//   void onClickShare() async {
//     await CommonShare.onShare(id: widget.post?.id ?? "", title: widget.post?.name ?? "", filePath: widget.post?.postImage?[0].url ?? "");
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//     SharePostApi.callApi(token: token, uid: uid, postId: widget.post?.id ?? "");
//     shareCount++;
//   }
//
//   void onClickProfile() {
//     Utils.showLog("******* POST ID => ${widget.post?.id ?? ""}");
//   }
//
//   void onClickMore() {}
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: Get.width,
//       margin: const EdgeInsets.only(bottom: 15),
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(32),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: onClickProfile,
//             child: Container(
//               height: 75,
//               width: Get.width,
//               color: AppColor.transparent,
//               padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 47,
//                     width: 47,
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: AppColor.secondary),
//                     ),
//                     child: Container(
//                       clipBehavior: Clip.antiAlias,
//                       decoration: const BoxDecoration(shape: BoxShape.circle),
//                       child: const PreviewProfileImageWidget(),
//                     ),
//                   ),
//                   12.width,
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Flexible(
//                               fit: FlexFit.loose,
//                               child: Text(
//                                 widget.post?.name ?? "",
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: AppFontStyle.styleW700(AppColor.black, 16),
//                               ),
//                             ),
//                             Visibility(
//                               visible: true,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text(
//                                   widget.post?.countryFlagImage ?? "",
//                                   style: AppFontStyle.styleW700(AppColor.white, 16),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         3.height,
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                               decoration: BoxDecoration(
//                                 color: AppColor.purple,
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Image.asset(AppAssets.icFemale, width: 10),
//                                   3.width,
//                                   Text(
//                                     (widget.post?.age ?? 0).toString(),
//                                     style: AppFontStyle.styleW600(AppColor.white, 10),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: onClickMore,
//                     child: Container(
//                       height: 40,
//                       width: 40,
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(shape: BoxShape.circle),
//                       child: Image.asset(
//                         AppAssets.icVerticalVert,
//                         width: 4,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 335,
//             width: Get.width,
//             child: PageView.builder(
//               itemCount: widget.post?.postImage?.length ?? 0,
//               itemBuilder: (context, index) {
//                 final indexData = widget.post?.postImage?[index];
//                 return PreviewPostImageWidget(
//                   fit: BoxFit.cover,
//                   image: indexData?.url ?? "",
//                   isBanned: indexData?.isBanned ?? false,
//                 );
//               },
//             ),
//           ),
//           Container(
//             height: 50,
//             color: AppColor.transparent,
//             width: Get.width,
//             child: Row(
//               children: [
//                 5.width,
//                 Obx(
//                   () => IconButtonWidget(
//                     icon: isLike.value ? AppAssets.icLikeFill : AppAssets.icLikeBorder,
//                     count: likeCount.value,
//                     iconSize: 25,
//                     callback: onToggleLike,
//                   ),
//                 ),
//                 Obx(
//                   () => IconButtonWidget(
//                     icon: AppAssets.icCommentBorder,
//                     count: commentCount.value,
//                     iconSize: 24,
//                     callback: onClickComment,
//                   ),
//                 ),
//                 Obx(
//                   () => IconButtonWidget(
//                     icon: AppAssets.icShareBorder,
//                     count: shareCount.value,
//                     iconSize: 22,
//                     callback: onClickShare,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: widget.post?.caption?.trim().isNotEmpty ?? false,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ReadMoreText(
//                       widget.post?.caption ?? "",
//                       trimMode: TrimMode.Line,
//                       trimLines: 3,
//                       style: AppFontStyle.styleW500(AppColor.greyBlue, 12),
//                       colorClickableText: AppColor.primary,
//                        trimCollapsedText: EnumLocal.txtShowMore.name.tr,
//                       trimExpandedText: EnumLocal.txtShowLess.name.tr,
//                       moreStyle: AppFontStyle.styleW500(AppColor.primary, 13),
//                     ),
//                   ),
//                   // 10.width,
//                   // Image.asset(AppAssets.icTranslation, width: 15),
//                   // 5.width,
//                   // Text(
//                   //   EnumLocal.txtTranslation.name.tr,
//                   //   style: AppFontStyle.styleW500(AppColor.secondary, 12),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           Visibility(
//             visible: widget.post?.hashTag?.isNotEmpty ?? false,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.post?.hashTag?.join(",") ?? "",
//                     style: AppFontStyle.styleW500(AppColor.primary, 12),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Text(
//               widget.post?.time ?? "",
//               style: AppFontStyle.styleW500(AppColor.secondary, 13),
//             ),
//           ),
//           15.height,
//         ],
//       ),
//     );
//   }
// }
//
// class IconButtonWidget extends StatelessWidget {
//   const IconButtonWidget({
//     super.key,
//     required this.icon,
//     required this.count,
//     required this.iconSize,
//     required this.callback,
//   });
//
//   final String icon;
//   final int count;
//   final double iconSize;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: callback,
//       child: Container(
//         color: AppColor.transparent,
//         height: 50,
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(icon, width: iconSize),
//             8.width,
//             (count < 1000)
//                 ? AnimatedFlipCounter(
//                     duration: Duration(milliseconds: 500),
//                     value: count, // pass in a value like 2014
//                     textStyle: AppFontStyle.styleW600(AppColor.secondary, 15),
//                   )
//                 : Text(
//                     CustomFormatNumber.onConvert(count),
//                     style: AppFontStyle.styleW600(AppColor.secondary, 15),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
