// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tingle/page/stream_page/controller/stream_controller.dart';
// import 'package:tingle/page/stream_page/widget/stream_gridview_item_widget.dart';
// import 'package:tingle/utils/utils.dart';
//
// class StreamNearbyView extends GetView<StreamController> {
//   const StreamNearbyView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         5.height,
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.only(bottom: 15),
//             child: GridView.builder(
//               itemCount: 0,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 mainAxisExtent: 230,
//               ),
//               itemBuilder: (context, index) {
//                 final indexData = controller.liveUsers[index];
//                 return StreamGridviewItemWidget(
//                   name: indexData.name ?? "",
//                   userName: indexData.userName ?? "",
//                   isBanned: false,
//                   image: indexData.image ?? "",
//                   isVerify: indexData.isVerified ?? false,
//                   countryFlag: indexData.countryFlagImage ?? "",
//                   viewCount: indexData.view ?? 0,
//                   liveType: indexData.liveType ?? 0,
//                   callback: () {},
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
