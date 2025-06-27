// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/fake_steam_pk_page/controller/fake_stream_pk_controller.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FakeStreamPkView extends GetView<FakeStreamPkController> {
//   const FakeStreamPkView({super.key});
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
//           child: GetBuilder<FakeStreamPkController>(
//             id: AppConstant.onChangePkType,
//             builder: (controller) => PageView.builder(
//               itemCount: controller.FakepkTypePages.length,
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return controller.FakepkTypePages[controller.selectedPkType];
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
