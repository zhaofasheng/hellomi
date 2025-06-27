// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/go_live_page/controller/go_live_controller.dart';
// import 'package:tingle/page/preview_user_profile_page/controller/preview_user_profile_controller.dart';
// import 'package:tingle/routes/app_routes.dart';
// import 'package:tingle/utils/assets.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/database.dart';
// import 'package:tingle/utils/enums.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class CreateAudioRoomAppBarWidget extends GetView<GoLiveController> {
//   const CreateAudioRoomAppBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).viewPadding.top + 50,
//       padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top, left: 0, right: 15),
//       alignment: Alignment.center,
//       width: Get.width,
//       color: AppColor.transparent,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: Get.back,
//             child: Container(
//               height: 45,
//               width: 45,
//               alignment: Alignment.center,
//               decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColor.transparent),
//               child: Image.asset(
//                 AppAssets.icArrowLeft,
//                 color: AppColor.white,
//                 width: 10,
//               ),
//             ),
//           ),
//           35.width,
//           Expanded(
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Create Audio Room",
//                 maxLines: 1,
//                 textAlign: TextAlign.center,
//                 overflow: TextOverflow.ellipsis,
//                 style: AppFontStyle.styleW700(AppColor.white, 16),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: controller.onClickGoLive,
//             child: Container(
//               height: 35,
//               width: 80,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: AppColor.white,
//                 borderRadius: BorderRadius.circular(100),
//               ),
//               child: Text(
//                 EnumLocal.txtGoLive.name.tr,
//                 style: AppFontStyle.styleW700(AppColor.primary, 13),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
