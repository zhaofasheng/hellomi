// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/api.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/utils.dart';
// import 'package:video_player/video_player.dart';
//
// class ReelsMasterView extends StatefulWidget {
//   const ReelsMasterView({super.key});
//
//   @override
//   State<ReelsMasterView> createState() => _ReelsMasterViewState();
// }
//
// class _ReelsMasterViewState extends State<ReelsMasterView> {
//   ChewieController? chewieController;
//   VideoPlayerController? videoPlayerController;
//
//   RxInt currentIndex = 0.obs;
//
//   List reels = [
//     'https://codderlab.blr1.digitaloceanspaces.com/loopbox/Lag%20Ja%20Gale%20Episode%201%2018%20Web%20Series%20ULLU.mp4',
//     'https://cdn.bmaal.com/ULLU/Mere%20Angane%20Mein-D1/Mere%20Angane%20Mein%20Episode%207.mp4',
//     'https://cdn.bmaal.com/ULLU/Mere%20Angane%20Mein-D1/Mere%20Angane%20Mein%20Episode%206.mp4',
//     'https://cdn.bmaal.com/ULLU/Mere%20Angane%20Mein-D1/Mere%20Angane%20Mein%20Episode%205.mp4',
//     'https://cdn.bmaal.com/ULLU/Mere%20Angane%20Mein-D1/Mere%20Angane%20Mein%20Episode%204.mp4',
//   ];
//
//   List videoController = [];
//
//   void onInit(String url) async {
//     chewieController = null;
//     videoPlayerController = null;
//
//     videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
//
//     await videoPlayerController?.initialize();
//
//     if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
//       chewieController = ChewieController(
//         videoPlayerController: videoPlayerController!,
//         looping: true,
//         allowedScreenSleep: false,
//         allowMuting: false,
//         showControlsOnInitialize: false,
//         showControls: false,
//         maxScale: 1,
//       );
//
//       videoController.add({"chewie": chewieController, "video": videoController});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         scrollDirection: Axis.vertical,
//         itemCount: reels.length,
//         onPageChanged: (value) => currentIndex.value = value,
//         itemBuilder: (context, index) {
//           return Obx(
//             () => VideoMasterView(
//               index: index,
//               currentIndex: currentIndex.value,
//               videoUrl: reels[index],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class VideoMasterView extends StatefulWidget {
//   const VideoMasterView({
//     super.key,
//     required this.index,
//     required this.currentIndex,
//     required this.videoUrl,
//   });
//
//   final int index;
//   final int currentIndex;
//   final String videoUrl;
//
//   @override
//   State<VideoMasterView> createState() => _VideoMasterViewState();
// }
//
// class _VideoMasterViewState extends State<VideoMasterView> with SingleTickerProviderStateMixin {
//   ChewieController? chewieController;
//   VideoPlayerController? videoPlayerController;
//
//   RxBool isBuffering = false.obs;
//   RxBool isVideoLoading = true.obs;
//   RxBool isPlaying = false.obs;
//   RxBool isVideoPage = true.obs;
//
//   @override
//   void initState() {
//     isVideoPage.value = true;
//     initializeVideoPlayer();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     isVideoPage.value = false;
//     onDisposeVideoPlayer();
//     super.dispose();
//   }
//
//   Future<void> initializeVideoPlayer() async {
//     try {
//       String videoPath = (widget.videoUrl);
//
//       videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoPath));
//
//       await videoPlayerController?.initialize();
//
//       if (videoPlayerController != null && (videoPlayerController?.value.isInitialized ?? false)) {
//         chewieController = ChewieController(
//           videoPlayerController: videoPlayerController!,
//           looping: true,
//           allowedScreenSleep: false,
//           allowMuting: false,
//           showControlsOnInitialize: false,
//           showControls: false,
//           maxScale: 1,
//         );
//
//         if (chewieController != null) {
//           isVideoLoading.value = false;
//           (widget.index == widget.currentIndex && isVideoPage.value) ? onPlayVideo() : null; // Use => First Time Video Playing...
//         } else {
//           isVideoLoading.value = true;
//         }
//
//         videoPlayerController?.addListener(
//           () {
//             // Use => If Video Buffering then show loading....
//             (videoPlayerController?.value.isBuffering ?? false) ? isBuffering.value = true : isBuffering.value = false;
//
//             if (isVideoPage.value == true || Get.currentRoute == AppRoutes.bottomBarPage || Get.currentRoute == AppRoutes.previewUserProfilePage) {
//               onPlayVideo();
//             } else {
//               onStopVideo(); // Use => On Change Routes...
//             }
//           },
//         );
//       }
//
//       Utils.showLog(">>>> Reels Video Initialization Success => ${widget.index}");
//     } catch (e) {
//       onDisposeVideoPlayer();
//       Utils.showLog("Reels Video Initialization Failed !!! ${widget.index} => $e");
//     }
//   }
//
//   void onStopVideo() {
//     isPlaying.value = false;
//     videoPlayerController?.pause();
//   }
//
//   void onPlayVideo() {
//     isPlaying.value = true;
//     videoPlayerController?.play();
//   }
//
//   void onClickPlayPause() async {
//     videoPlayerController!.value.isPlaying ? onStopVideo() : onPlayVideo();
//     if (isVideoPage.value == false) {
//       isVideoPage.value = true; // Use => On Back Reels Page...
//     }
//   }
//
//   void onDisposeVideoPlayer() {
//     try {
//       onStopVideo();
//       videoPlayerController?.dispose();
//       chewieController?.dispose();
//       chewieController = null;
//       videoPlayerController = null;
//       isVideoLoading.value = true;
//     } catch (e) {
//       Utils.showLog(">>>> On Dispose VideoPlayer Error => $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.index == widget.currentIndex) {
//       // Use => Play Current Video On Scrolling...
//
//       (isVideoLoading.value == false && isVideoPage.value) ? onPlayVideo() : null;
//     } else {
//       // Restart Previous Video On Scrolling...
//       isVideoLoading.value == false ? videoPlayerController?.seekTo(Duration.zero) : null;
//       onStopVideo(); // Stop Previous Video On Scrolling...
//     }
//
//     return Container(
//       height: Get.height,
//       width: Get.width,
//       color: AppColor.black,
//       child: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {},
//             child: Container(
//               height: Get.height,
//               width: Get.width,
//               color: AppColor.transparent,
//               child: Obx(
//                 () => isVideoLoading.value
//                     ? Align(alignment: Alignment.bottomCenter, child: LinearProgressIndicator(color: AppColor.primary))
//                     : GestureDetector(
//                         child: SizedBox.expand(
//                           child: FittedBox(
//                             fit: BoxFit.cover,
//                             child: SizedBox(
//                               width: videoPlayerController?.value.size.width ?? 0,
//                               height: videoPlayerController?.value.size.height ?? 0,
//                               child: Chewie(controller: chewieController!),
//                             ),
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
