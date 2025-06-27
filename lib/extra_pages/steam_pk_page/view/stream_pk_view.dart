// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/steam_pk_page/controller/stream_pk_controller.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/utils.dart';
//
// class StreamPkView extends GetView<StreamPkController> {
//   const StreamPkView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     controller.init();
//     return Column(
//       children: [
//         5.height,
//         // const StreamPkTabBarWidget(),
//         // 15.height,
//         Expanded(
//           child: GetBuilder<StreamPkController>(
//             id: AppConstant.onChangePkType,
//             builder: (controller) => PageView.builder(
//               itemCount: controller.pkTypePages.length,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return controller.pkTypePages[controller.selectedPkType];
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
