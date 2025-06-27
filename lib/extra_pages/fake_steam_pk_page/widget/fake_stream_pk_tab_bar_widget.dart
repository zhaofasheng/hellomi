// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
// import 'package:tingle/page/fake_steam_pk_page/controller/fake_stream_pk_controller.dart';
// import 'package:tingle/utils/color.dart';
// import 'package:tingle/utils/constant.dart';
// import 'package:tingle/utils/enums.dart';
// import 'package:tingle/utils/font_style.dart';
// import 'package:tingle/utils/utils.dart';
//
// class FakeStreamPkTabBarWidget extends StatelessWidget {
//   const FakeStreamPkTabBarWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<FakeStreamPkController>(
//       id: AppConstant.onChangePkType,
//       builder: (controller) => Container(
//         height: 55,
//         width: Get.width,
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: AppColor.darkBlue,
//           borderRadius: BorderRadius.circular(100),
//         ),
//         child: Row(
//           children: [
//             ItemWidget(
//               title: EnumLocal.txt1V1PK.name.tr,
//               isSelected: controller.selectedPkType == 0,
//               callback: () => controller.onChangePkType(0),
//             ),
//             5.width,
//             ItemWidget(
//               title: EnumLocal.txtTeamPK.name.tr,
//               isSelected: controller.selectedPkType == 1,
//               callback: () => controller.onChangePkType(1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ItemWidget extends StatelessWidget {
//   const ItemWidget({super.key, required this.title, required this.isSelected, required this.callback});
//
//   final String title;
//   final bool isSelected;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: callback,
//         child: Container(
//           height: 55,
//           width: Get.width,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected ? AppColor.white : AppColor.transparent,
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Text(
//             title,
//             style: AppFontStyle.styleW700(isSelected ? AppColor.primary : AppColor.white, 14),
//           ),
//         ),
//       ),
//     );
//   }
// }
