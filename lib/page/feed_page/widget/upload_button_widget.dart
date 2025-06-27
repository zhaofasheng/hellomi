// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/common/widget/loading_widget.dart';
// import 'package:tingle/custom/function/custom_thumbnail.dart';
// import 'package:tingle/custom/function/custom_video_picker.dart';
// import 'package:tingle/custom/function/custom_video_time.dart';
// import 'package:tingle/page/feed_page/controller/feed_controller.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/api_params.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/enums.dart';
// import 'package:tingle/utils/internet_connection.dart';
// import 'package:tingle/utils/utils.dart';
//
// class UploadButtonWidget extends StatelessWidget {
//   const UploadButtonWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FeedController>(
//       id: AppConstant.onToggleUploadButton,
//       builder: (controller) => Stack(
//         children: [
//           Visibility(
//             visible: controller.isShowUploadButton,
//             child: GestureDetector(
//               onTap: () => controller.isShowUploadButton ? controller.onToggleUploadButton() : null,
//               child: Container(
//                 height: Get.height,
//                 width: Get.width,
//                 color: AppColor.black.withValues(alpha: 0.4),
//               ),
//             ),
//           ),
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             right: controller.isShowUploadButton ? 70 : 0,
//             bottom: controller.isShowUploadButton ? 100 : 0,
//             curve: Curves.easeOut,
//             child: AnimatedOpacity(
//               opacity: controller.isShowUploadButton ? 1.0 : 0.0,
//               duration: Duration(milliseconds: 300),
//               child: GestureDetector(
//                 onTap: () async {
//                   controller.onToggleUploadButton();
//
//                   if (InternetConnection.isConnect.value) {
//                     Get.dialog(const LoadingWidget(), barrierDismissible: false); // Start Loading...
//
//                     final videoPath = await CustomVideoPicker.pickVideo(); // Pick Video...
//
//                     Utils.showLog("Picked Video Path => $videoPath");
//
//                     if (videoPath != null) {
//                       final videoTime = await CustomVideoTime.onGet(videoPath); // Pick Video Time...
//
//                       Utils.showLog("Picked Video Time => $videoTime");
//
//                       if (videoTime != null) {
//                         final String? videoImage = await CustomThumbnail.onGet(videoPath); // Pick Video Image...
//
//                         Get.back(); // Stop Loading...
//
//                         if (videoImage != null) {
//                           Utils.showLog("Video Path => $videoPath");
//                           Utils.showLog("Video Image => $videoImage");
//                           Utils.showLog("Video Time => $videoTime");
//
//                           Get.toNamed(
//                             AppRoutes.previewUploadVideoPage,
//                             arguments: {
//                               ApiParams.video: videoPath,
//                               ApiParams.image: videoImage,
//                               ApiParams.time: videoTime,
//                               ApiParams.songId: "",
//                             },
//                           );
//                         } else {
//                           Utils.showLog("Get Video Image Failed !!");
//                           Get.back(); // Stop Loading...
//                         }
//                       } else {
//                         Utils.showLog("Get Video Time Failed !!");
//                         Get.back(); // Stop Loading...
//                       }
//                     } else {
//                       Utils.showLog("Video Not Selected !!");
//                       Get.back(); // Stop Loading...
//                     }
//                   } else {
//                      Utils.showToast(text:EnumLocal.txtNoInternetConnection.name.tr);
//                     Utils.showLog("Internet Connection Lost !!");
//                   }
//                 },
//                 child: Container(
//                   height: 55,
//                   width: 55,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColor.white,
//                   ),
//                   child: Image.asset(AppAssets.icGradientPlay, width: 45),
//                 ),
//               ),
//             ),
//           ),
//           AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             right: controller.isShowUploadButton ? 120 : 0,
//             bottom: controller.isShowUploadButton ? 20 : 0,
//             curve: Curves.easeOut,
//             child: AnimatedOpacity(
//               opacity: controller.isShowUploadButton ? 1.0 : 0.0,
//               duration: Duration(milliseconds: 300),
//               child: GestureDetector(
//                 onTap: () {
//                   controller.onToggleUploadButton();
//                   Get.toNamed(AppRoutes.uploadFeedPage);
//                 },
//                 child: Container(
//                   height: 55,
//                   width: 55,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColor.white,
//                   ),
//                   child: Image.asset(AppAssets.icGradientCamera, width: 45),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
