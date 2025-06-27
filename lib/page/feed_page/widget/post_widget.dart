// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:readmore/readmore.dart';
// import 'package:tingle/common/api/follow_unfollow_user_api.dart';
// import 'package:tingle/common/function/common_share.dart';
// import 'package:tingle/common/widget/comment_bottom_sheet_widget.dart';
// import 'package:tingle/common/widget/loading_widget.dart';
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
// import 'package:tingle/utils/database.dart';
// import 'package:tingle/utils/enums.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class PostView extends StatefulWidget {
//   const PostView({
//     super.key,
//     required this.id,
//     required this.userId,
//     required this.profileImage,
//     required this.postImages,
//     required this.title,
//     required this.subTitle,
//     required this.time,
//     required this.description,
//     required this.hastTag,
//     required this.isLike,
//     required this.isFollow,
//     required this.isVerified,
//     required this.likes,
//     required this.comments,
//     required this.isFakeUser,
//     required this.shareCount,
//   });
//
//   final String id;
//   final String userId;
//   final String profileImage;
//   final List<PostImage> postImages;
//   final String title;
//   final String subTitle;
//   final String time;
//   final String description;
//
//   final List hastTag;
//
//   final bool isLike;
//   final bool isVerified;
//   final bool isFollow;
//   final bool isFakeUser;
//
//   final int likes;
//   final int comments;
//   final int shareCount;
//
//   @override
//   State<PostView> createState() => _PostViewState();
// }
//
// class _PostViewState extends State<PostView> {
//   RxBool isLike = false.obs;
//   RxBool isFollow = false.obs;
//
//   RxInt likeCount = 0.obs;
//   RxInt commentCount = 0.obs;
//   RxInt shareCount = 0.obs;
//
//   RxBool isShowLikeIconAnimation = false.obs;
//
//   @override
//   void initState() {
//     isLike.value = widget.isLike;
//     isFollow.value = widget.isFollow;
//
//     likeCount.value = widget.likes;
//     commentCount.value = widget.comments;
//     super.initState();
//   }
//
//   Future<void> onClickLike() async {
//     if (isLike.value) {
//       isLike.value = false;
//       likeCount--;
//     } else {
//       isLike.value = true;
//       likeCount++;
//     }
//
//     isShowLikeIconAnimation.value = true;
//     await 500.milliseconds.delay();
//     isShowLikeIconAnimation.value = false;
//
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//     await LikePostApi.callApi(token: token, uid: uid, postId: widget.id);
//   }
//
//   void onClickFollow() async {
//     if (Database.loginUserId != widget.userId) {
//       isFollow.value = !isFollow.value;
//
//       final uid = FirebaseUid.onGet() ?? "";
//       final token = await FirebaseAccessToken.onGet() ?? "";
//
//       await FollowUnfollowUserApi.callApi(token: token, uid: uid, toUserId: widget.id);
//     }
//   }
//
//   void onClickComment() async {
//     commentCount.value = await CommentBottomSheetWidget.onShow(
//       context: context,
//       type: ApiParams.post,
//       id: widget.id,
//       commentCount: commentCount.value,
//     );
//   }
//
//   void onClickShare() async {
//     await CommonShare.onShare(id: widget.id, title: widget.title, filePath: widget.postImages[0].url);
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//     SharePostApi.callApi(token: token, uid: uid, postId: widget.id);
//     shareCount++;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(bottom: 10),
//       margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: AppColor.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               color: AppColor.lightGrey.withValues(alpha: 0.08),
//               width: Get.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     clipBehavior: Clip.antiAlias,
//                     height: 42,
//                     width: 42,
//                     decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.secondary),
//                     child: PreviewProfileImageWidget(),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: Get.width / 2.5,
//                           child: Row(
//                             children: [
//                               Flexible(
//                                 fit: FlexFit.loose,
//                                 child: Text(
//                                   widget.title,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: AppFontStyle.styleW700(AppColor.black, 14),
//                                 ),
//                               ),
//                               Visibility(
//                                 visible: widget.isVerified,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 2),
//                                   child: Image.asset(AppAssets.icAuthoriseIcon, width: 20),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: Get.width / 2.5,
//                           child: Text(
//                             maxLines: 1,
//                             widget.subTitle,
//                             style: AppFontStyle.styleW500(AppColor.secondary, 11),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const Spacer(),
//                   // Visibility(
//                   //   visible: (widget.userId != Database.loginUserId),
//                   //   child: GestureDetector(
//                   //     onTap: onClickFollow,
//                   //     child: Obx(
//                   //       () => Container(
//                   //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//                   //         decoration: BoxDecoration(
//                   //           color: isFollow.value ? AppColor.primary : AppColor.transparent,
//                   //           borderRadius: BorderRadius.circular(20),
//                   //           border: Border.all(color: isFollow.value ? AppColor.transparent : AppColor.primary, width: 1),
//                   //         ),
//                   //         child: Row(
//                   //           mainAxisAlignment: MainAxisAlignment.center,
//                   //           children: [
//                   //             Image.asset(isFollow.value ? AppAssets.icFollowing : AppAssets.icFollow, color: isFollow.value ? AppColor.white : AppColor.primary, width: 18),
//                   //             5.width,
//                   //             Text(
//                   //               isFollow.value ? EnumLocal.txtFollowing.name.tr : EnumLocal.txtFollow.name.tr,
//                   //               style: AppFontStyle.styleW500(isFollow.value ? AppColor.white : AppColor.primary, 14),
//                   //             ),
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//
//                   GestureDetector(
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
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 15.height,
//                 SizedBox(
//                   height: Get.width / 2,
//                   child: ListView.builder(
//                     itemCount: widget.postImages.length,
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     scrollDirection: Axis.horizontal,
//                     // physics: (),
//
//                     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     //   crossAxisCount: 2,
//                     //   crossAxisSpacing: 12,
//                     //   mainAxisSpacing: 12,
//                     //   childAspectRatio: 0.88,
//                     // ),
//                     itemBuilder: (context, index) => GestureDetector(
//                       // onTap: () => Get.to(
//                       // PreviewImageUi(
//                       //   name: widget.title,
//                       //   userName: widget.subTitle,
//                       //   userImage: widget.profileImage,
//                       //   images: widget.postImages,
//                       //   selectedIndex: index,
//                       // ),
//                       // ),
//                       child: Container(
//                         clipBehavior: Clip.antiAlias,
//                         height: Get.width / 2,
//                         width: Get.width / 2.4,
//                         margin: EdgeInsets.only(right: 10),
//                         decoration: BoxDecoration(color: AppColor.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
//                         child: PreviewPostImageWidget(
//                           isBanned: widget.postImages[index].isBanned ?? false,
//                           image: widget.postImages[index].url ?? "",
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 widget.description.trim().isEmpty
//                     ? Offstage()
//                     : Column(
//                         children: [
//                           10.height,
//                           ReadMoreText(
//                             widget.description,
//                             trimMode: TrimMode.Line,
//                             trimLines: 3,
//                             style: AppFontStyle.styleW500(AppColor.black, 15),
//                             colorClickableText: AppColor.primary,
//                              trimCollapsedText: EnumLocal.txtShowMore.name.tr,
//                             trimExpandedText: EnumLocal.txtShowLess.name.tr,
//                             moreStyle: AppFontStyle.styleW500(AppColor.primary, 15),
//                           ),
//                         ],
//                       ),
//                 widget.hastTag.isEmpty
//                     ? Offstage()
//                     : Column(
//                         children: [
//                           8.height,
//                           Wrap(
//                             spacing: 8.0, // gap between adjacent chips
//                             runSpacing: 4.0, // gap between lines
//                             children: <Widget>[
//                               for (int index = 0; index < widget.hastTag.length; index++)
//                                 Container(
//                                   padding: const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
//                                   margin: EdgeInsets.only(bottom: 3),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(color: AppColor.secondary, width: 1),
//                                   ),
//                                   child: Text.rich(
//                                     TextSpan(
//                                       children: [
//                                         TextSpan(
//                                           text: widget.hastTag[index],
//                                           style: AppFontStyle.styleW500(AppColor.secondary, 12),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ],
//                       ),
//                 5.height,
//                 Text(
//                   widget.time,
//                   style: AppFontStyle.styleW500(AppColor.secondary.withOpacity(0.8), 12),
//                 ),
//                 8.height,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: onClickLike,
//                       child: Obx(
//                         () => Container(
//                           height: 30,
//                           color: AppColor.transparent,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               AnimatedContainer(
//                                 duration: Duration(milliseconds: 300),
//                                 height: isShowLikeIconAnimation.value ? 12 : 30,
//                                 alignment: Alignment.center,
//                                 child: Image.asset(
//                                   AppAssets.icLikeFill,
//                                   color: isLike.value ? AppColor.red : AppColor.secondary,
//                                   width: 24,
//                                 ),
//                               ),
//                               8.width,
//                               Text(
//                                 CustomFormatNumber.convert(likeCount.value),
//                                 style: AppFontStyle.styleW700(AppColor.black, 15),
//                               ),
//                               5.width
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     8.width,
//                     GestureDetector(
//                       onTap: onClickComment,
//                       child: Obx(
//                         () => Container(
//                           height: 30,
//                           color: AppColor.transparent,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 AppAssets.icCommentFill,
//                                 color: AppColor.secondary,
//                                 width: 24,
//                               ),
//                               8.width,
//                               Text(
//                                 CustomFormatNumber.convert(commentCount.value),
//                                 style: AppFontStyle.styleW700(AppColor.black, 15),
//                               ),
//                               8.width
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     5.width,
//                     GestureDetector(
//                       onTap: onClickShare,
//                       child: Container(
//                         height: 30,
//                         color: AppColor.transparent,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image.asset(AppAssets.icShareBorder, color: AppColor.secondary, width: 20),
//                             8.width,
//                             Text(
//                               CustomFormatNumber.convert(commentCount.value),
//                               style: AppFontStyle.styleW700(AppColor.black, 15),
//                             ),
//                             8.width
//                           ],
//                         ),
//                       ),
//                     ),
//                     8.width,
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         height: 30,
//                         width: 50,
//                         color: AppColor.transparent,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               AppAssets.icHorizontalVert,
//                               color: AppColor.secondary,
//                               width: 24,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // const Spacer(),
//                     // Visibility(
//                     //   visible: (widget.userId != Database.loginUserId),
//                     //   child: GestureDetector(
//                     //     onTap: () {},
//                     //     child: Container(
//                     //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//                     //       decoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.circular(24),
//                     //         gradient: AppColor.primaryGradient,
//                     //       ),
//                     //       child: Row(
//                     //         mainAxisAlignment: MainAxisAlignment.center,
//                     //         children: [
//                     //           // Image.asset(AppAssets.icSayHey, width: 20),
//                     //           // Text(
//                     //           //   ' ${EnumLocal.txtSayHi.name.tr}',
//                     //           //   style: TextStyle(
//                     //           //     fontStyle: FontStyle.italic,
//                     //           //     color: AppColor.white,
//                     //           //     fontFamily: AppConstant.appFontBold,
//                     //           //     fontSize: 14,
//                     //           //     fontWeight: FontWeight.w800,
//                     //           //   ),
//                     //           // ),
//                     //         ],
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Widget iconView({
//   String? countText,
//   required String image,
//   Color? color,
// }) {
//   return Row(
//     children: [
//       Image.asset(image, color: color ?? AppColor.secondary, width: 24),
//       5.width,
//       countText != null
//           ? Text(
//               countText,
//               style: AppFontStyle.styleW700(AppColor.black, 15),
//             )
//           : const Offstage(),
//     ],
//   );
// }
