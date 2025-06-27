import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:readmore/readmore.dart';
import 'package:tingle/branch_io/branch_io_services.dart';
import 'package:tingle/common/api/delete_post_api.dart';
import 'package:tingle/common/function/common_share.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/widget/comment_bottom_sheet_widget.dart';
import 'package:tingle/common/widget/delete_dialog_widget.dart';
import 'package:tingle/common/widget/loading_widget.dart';
import 'package:tingle/common/widget/more_option_bottom_sheet.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/report_bottom_sheet_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/firebase/authentication/firebase_access_token.dart';
import 'package:tingle/firebase/authentication/firebase_uid.dart';
import 'package:tingle/page/bottom_bar_page/controller/bottom_bar_controller.dart';
import 'package:tingle/page/feed_page/api/like_post_api.dart';
import 'package:tingle/page/feed_page/api/share_post_api.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/page/other_user_profile_bottom_sheet/view/other_user_profile_bottom_sheet.dart';
import 'package:tingle/page/profile_feed_moment_page/wigdet/preview_profile_moment_post_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget({super.key, this.post});

  final Post? post;

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  RxBool isLike = false.obs;
  RxBool isFollow = false.obs;
  RxInt likeCount = 0.obs;
  RxInt commentCount = 0.obs;
  RxInt shareCount = 0.obs;

  @override
  void initState() {
    isLike.value = widget.post?.isLike ?? false;
    isFollow.value = widget.post?.isFollow ?? false;
    likeCount.value = (widget.post?.totalLikes ?? 0).toInt();
    commentCount.value = (widget.post?.totalComments ?? 0).toInt();
    shareCount.value = (widget.post?.shareCount ?? 0).toInt();
    super.initState();
  }

  void onToggleLike() async {
    isLike.value ? likeCount-- : likeCount++;
    isLike.value = !isLike.value;

    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";

    await LikePostApi.callApi(token: token, uid: uid, postId: widget.post?.id ?? "");
  }

  void onClickComment() async {
    commentCount.value = await CommentBottomSheetWidget.onShow(context: context, type: ApiParams.post, id: widget.post?.id ?? "", commentCount: commentCount.value);
  }

  void onClickShare() async {
    await CommonShare.onShare(
      id: widget.post?.id ?? "",
      title: widget.post?.caption ?? "",
      image: widget.post?.postImage?[0].url ?? "",
      userId: widget.post?.userId ?? "",
      pageRoutes: BranchIoServices.postKey,
    );
    final uid = FirebaseUid.onGet() ?? "";
    final token = await FirebaseAccessToken.onGet() ?? "";
    SharePostApi.callApi(token: token, uid: uid, postId: widget.post?.id ?? "");
    shareCount++;
  }

  void onClickProfile() {
    Utils.showLog("******* POST ID => ${widget.post?.userId}");
    OtherUserProfileBottomSheet.show(context: context, userID: widget.post?.userId ?? "");
  }

  void onClickMore() {
    widget.post?.userId == Database.loginUserId
        ? MoreOptionBottomSheet.show(
            context: context,
            reportCallBack: () {
              Get.back();
              ReportBottomSheetWidget.onShow(
                context: context,
                id: widget.post?.postId ?? "",
                type: ApiParams.post,
              );
            },
            deleteCallBack: () {
              Get.back();

              DeleteDialogWidget.onShow(
                height: 435,
                title: EnumLocal.txtDeletePost.name.tr,
                description: EnumLocal.txtDeletePostVideoContent.name.tr,
                callBack: () async {
                  Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...

                  final uid = FirebaseUid.onGet() ?? "";
                  final token = await FirebaseAccessToken.onGet() ?? "";

                  await DeletePostApi.callApi(token: token, uid: uid, postId: widget.post?.postId ?? "");

                  Utils.showToast(text: DeletePostApi.statusAndMessageModel?.message ?? "");
                  if (DeletePostApi.statusAndMessageModel?.status == true) Get.back(); // Close Dialog...

                  Get.back(); // Stop Loading...
                },
              );
            },
            editCallBack: () {
              Get.back();
              Get.toNamed(
                AppRoutes.editFeedPage,
                arguments: {
                  ApiParams.postId: widget.post?.postId ?? "",
                  ApiParams.postImage: widget.post?.postImage ?? "",
                  ApiParams.caption: widget.post?.caption ?? "",
                  ApiParams.hashTagId: widget.post?.hashTagId ?? "",
                },
              )?.then(
                (value) => Utils.onChangeStatusBar(brightness: Brightness.light),
              );
            },
          )
        : ReportBottomSheetWidget.onShow(
            context: context,
            id: widget.post?.id ?? "",
            type: ApiParams.post,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onClickProfile,
            child: Container(
              height: 70,
              width: Get.width,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: AppColor.colorBorder.withValues(alpha: 0.3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    padding: (widget.post?.avtarFrame?.trim().isEmpty ?? true) ? const EdgeInsets.all(2) : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: (widget.post?.avtarFrame?.trim().isEmpty ?? true) ? Border.all(color: AppColor.secondary) : null,
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: PreviewProfileImageWithFrameWidget(
                        image: widget.post?.userImage,
                        isBanned: widget.post?.isProfilePicBanned,
                        frame: widget.post?.avtarFrame,
                        type: widget.post?.avtarFrameType,
                        margin: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                widget.post?.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.styleW700(AppColor.black, 15),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: PreviewCountryFlagIcon(
                                  flag: widget.post?.countryFlagImage ?? "",
                                  networkFlagSize: 16,
                                  localFlagSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 18,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: AppColor.purple,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      widget.post?.gender?.toLowerCase() == ApiParams.male ? AppAssets.icMale : AppAssets.icFemale,
                                      width: 10,
                                    ),
                                    3.width,
                                    Text(
                                      (widget.post?.age ?? 0).toString(),
                                      style: AppFontStyle.styleW600(AppColor.white, 10),
                                    ),
                                  ],
                                ),
                              ),
                              // 10.width,
                              // Expanded(
                              //   child: SingleChildScrollView(
                              //     scrollDirection: Axis.horizontal,
                              //     child: SizedBox(
                              //       height: 25,
                              //       child: ListView.builder(
                              //         itemCount: 10,
                              //         shrinkWrap: true,
                              //         scrollDirection: Axis.horizontal,
                              //         itemBuilder: (context, index) {
                              //           return Container(
                              //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              //             margin: EdgeInsets.only(right: 10),
                              //             decoration: BoxDecoration(
                              //               color: AppColor.white,
                              //               borderRadius: BorderRadius.circular(100),
                              //               border: Border.all(color: AppColor.secondary.withValues(alpha: 0.2)),
                              //             ),
                              //             child: Text(
                              //               "@andrew_filder550",
                              //               style: AppFontStyle.styleW600(AppColor.primary, 9),
                              //             ),
                              //           );
                              //         },
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onClickMore,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(
                        AppAssets.icVerticalVert,
                        width: 3.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          15.height,
          SizedBox(
            height: Get.width / 2,
            child: ListView.builder(
              itemCount: widget.post?.postImage?.length ?? 0,
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(FullScreenPostPreview(posts: widget.post?.postImage ?? [], initialIndex: index));
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  height: 228,
                  width: Get.width / 2.4,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: AppColor.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PreviewPostImageWidget(
                    isBanned: widget.post?.postImage?[index].isBanned ?? false,
                    image: widget.post?.postImage?[index].url ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          15.height,
          Visibility(
            visible: widget.post?.caption?.trim().isNotEmpty ?? false,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ReadMoreText(
                      widget.post?.caption ?? "",
                      trimMode: TrimMode.Line,
                      trimLines: 3,
                      style: AppFontStyle.styleW500(AppColor.greyBlue, 15),
                      colorClickableText: AppColor.primary,
                      trimCollapsedText: EnumLocal.txtShowMore.name.tr,
                      trimExpandedText: EnumLocal.txtShowLess.name.tr,
                      moreStyle: AppFontStyle.styleW500(AppColor.primary, 15),
                    ),
                  ),
                  // 10.width,
                  // Image.asset(AppAssets.icTranslation, width: 15),
                  // 5.width,
                  // Text(
                  //   EnumLocal.txtTranslation.name.tr,
                  //   style: AppFontStyle.styleW500(AppColor.secondary, 12),
                  // ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.post?.hashTag?.isNotEmpty ?? false,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Column(
                children: [
                  8.height,
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, // gap between lines
                    children: <Widget>[
                      for (int index = 0; index < (widget.post?.hashTag?.length ?? 0); index++)
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                          margin: EdgeInsets.only(bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColor.secondary.withValues(alpha: 0.5), width: 1),
                          ),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.post?.hashTag?[index] ?? "",
                                  style: AppFontStyle.styleW500(AppColor.secondary, 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          10.height,
          Container(
            height: 60,
            color: AppColor.colorBorder.withValues(alpha: 0.3),
            width: Get.width,
            child: Row(
              children: [
                5.width,
                Obx(
                  () => IconButtonWidget(
                    icon: isLike.value ? AppAssets.icLikeFill : AppAssets.icLikeBorder,
                    count: likeCount.value,
                    iconSize: 25,
                    callback: onToggleLike,
                  ),
                ),
                Obx(
                  () => IconButtonWidget(
                    icon: AppAssets.icCommentBorder,
                    count: commentCount.value,
                    iconSize: 24,
                    callback: onClickComment,
                  ),
                ),
                Obx(
                  () => IconButtonWidget(
                    icon: AppAssets.icShareBorder,
                    count: shareCount.value,
                    iconSize: 22,
                    callback: onClickShare,
                  ),
                ),
                Spacer(),
                10.width,
                Text(
                  widget.post?.time ?? "",
                  style: AppFontStyle.styleW500(AppColor.secondary, 13),
                ),
                15.width,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.icon,
    required this.count,
    required this.iconSize,
    required this.callback,
  });

  final String icon;
  final int count;
  final double iconSize;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        color: AppColor.transparent,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon, width: iconSize),
            8.width,
            (count < 1000)
                ? AnimatedFlipCounter(
                    duration: Duration(milliseconds: 500),
                    value: count, // pass in a value like 2014
                    textStyle: AppFontStyle.styleW600(AppColor.secondary, 15),
                  )
                : Text(
                    CustomFormatNumber.onConvert(count),
                    style: AppFontStyle.styleW600(AppColor.secondary, 15),
                  ),
          ],
        ),
      ),
    );
  }
}

// void onToggleLike() async {
//   // UI को तुरंत अपडेट करें
//   isLike.value ? likeCount-- : likeCount++;
//   isLike.value = !isLike.value;
//
//   final uid = FirebaseUid.onGet() ?? "";
//   final token = await FirebaseAccessToken.onGet() ?? "";
//   final postId = widget.post?.id ?? "";
//
//   // ऑफ़लाइन केस के लिए Workmanager का उपयोग करें
//   await Workmanager().registerOneOffTask(
//     "like_${DateTime.now().microsecondsSinceEpoch}", // यूनिक टास्क आईडी
//     "likePostTask", // टास्क नाम (नीचे डिफाइन किया गया)
//     inputData: {
//       'token': token,
//       'uid': uid,
//       'postId': postId,
//     },
//     constraints: Constraints(
//       networkType: NetworkType.connected, // केवल इंटरनेट कनेक्ट होने पर चले
//     ),
//   );
//
//   // अगर इंटरनेट कनेक्टेड है तो तुरंत API कॉल करें
//   if (InternetConnection.isConnect.value) {
//     await LikePostApi.callApi(token: token, uid: uid, postId: postId);
//   }
// }

// void onToggleLike() async {
//   try {
//     // UI को तुरंत अपडेट करें
//     isLike.value ? likeCount-- : likeCount++;
//     isLike.value = !isLike.value;
//
//     final uid = FirebaseUid.onGet() ?? "";
//     final token = await FirebaseAccessToken.onGet() ?? "";
//     final postId = widget.post?.id ?? "";
//
//     // सीधे API कॉल करें (इंटरनेट कनेक्शन होने पर)
//     if (InternetConnection.isConnect.value) {
//       await LikePostApi.callApi(token: token, uid: uid, postId: postId);
//     } else {
//       // ऑफलाइन केस के लिए Workmanager का उपयोग करें
//       await Workmanager().registerOneOffTask(
//         "like_${DateTime.now().millisecondsSinceEpoch}", // यूनिक ID
//         "likePostTask",
//         inputData: {
//           'token': token,
//           'uid': uid,
//           'postId': postId,
//         },
//         constraints: Constraints(
//           networkType: NetworkType.connected,
//         ),
//         backoffPolicy: BackoffPolicy.linear,
//         backoffPolicyDelay: Duration(seconds: 10),
//       );
//     }
//   } catch (e) {
//     // एरर हैंडलिंग
//     print('Like Error: $e');
//     // UI को रोलबैक करें
//     isLike.value = !isLike.value;
//     isLike.value ? likeCount++ : likeCount--;
//   }
// }
