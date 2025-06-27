import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/backpack_page/controller/backpack_controller.dart';
import 'package:tingle/page/theme_outfit_page/controller/theme_outfit_contoller.dart';
import 'package:tingle/page/theme_outfit_page/shimmer/theme_outfit_shimmer.dart';
import 'package:tingle/page/theme_outfit_page/widget/avtar_theme_outfit_widget.dart';
import 'package:tingle/page/theme_outfit_page/widget/party_theme_widget_outfit.dart';
import 'package:tingle/page/theme_outfit_page/widget/rides_theme_outfit_widget.dart';
import 'package:tingle/page/theme_outfit_page/widget/theme_outfit_appbar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class ThemeOutfitView extends GetView<ThemeOutfitView> {
  const ThemeOutfitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: ThemeOutfitAppbarWidget.onShow(
        context,
      ),
      body: GetBuilder<BackpackController>(
        builder: (logic) => GetBuilder<ThemeOutfitController>(
          builder: (controller) => controller.isLoading.value
              ? ThemeOutfitShimmerWidget()
              : SizedBox(
                  height: Get.height * 0.83, // Ensures full height for scrolling
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.outfitTabController,
                    children: [
                      AvtarThemeOutfitWidget(),
                      RidesThemeOutfitWidget(),
                      PartyThemeWidgetOutfit(),
                    ],
                  ),
                ),
        ),
      ),
      // bottomSheet: GetBuilder<BackpackController>(
      //   builder: (logic) => Container(
      //     height: 70,
      //     width: Get.width,
      //     alignment: Alignment.center,
      //     decoration: BoxDecoration(
      //       color: AppColor.white,
      //       borderRadius: BorderRadius.circular(0),
      //       boxShadow: [],
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           GetBuilder<ThemeOutfitController>(
      //             builder: (controller) => logic.isActiveTheme != -1 && controller.outfitTabController!.index == 2 ||
      //                     logic.isActiveFrame != -1 && controller.outfitTabController!.index == 0 ||
      //                     logic.isActiveRide != -1 && controller.outfitTabController!.index == 1
      //                 ? GestureDetector(
      //                     onTap: () {
      //                       log("ACTIVE ON TAP");
      //                       if (logic.isActiveFrame != -1 && controller.outfitTabController!.index == 0) {
      //                         SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.avatarFrames!.active![logic.isActiveFrame].itemId!,
      //                           itemType: 2,
      //                           action: ApiParams.takeoff,
      //                         ).then((value) {
      //                           if (value != null) {
      //                             // logic.fetchPurchasedFrameModel = value;
      //                             logic.update([ApiParams.backpack]);
      //                           }
      //                         });
      //                       } else if (logic.isActiveTheme != -1 && controller.outfitTabController!.index == 0) {
      //                         SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.themes!.active![logic.isActiveTheme].itemId!,
      //                           itemType: 1,
      //                           action: ApiParams.takeoff,
      //                         ).then((value) {
      //                           if (value != null) {
      //                             // logic.fetchPurchasedFrameModel = value;
      //                             logic.update([ApiParams.backpack]);
      //                           }
      //                         });
      //                       } else if (logic.isActiveRide != -1 && controller.outfitTabController!.index == 0) {
      //                         SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.rides!.active![logic.isActiveRide].itemId!,
      //                           itemType: 3,
      //                           action: ApiParams.takeoff,
      //                         ).then((value) {
      //                           if (value != null) {
      //                             // logic.fetchPurchasedFrameModel = value;
      //                             logic.update([ApiParams.backpack]);
      //                           }
      //                         });
      //                       } else {
      //                         Utils.showToast(text: "Not Selected item");
      //                       }
      //                     },
      //                     child: Container(
      //                       height: 50,
      //                       width: Get.width / 2 - 20,
      //                       decoration: BoxDecoration(
      //                         color: AppColor.lightGrayBg,
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: Center(
      //                         child: Text(
      //                           EnumLocal.txtActivateAndWear.name.tr,
      //                           style: AppFontStyle.styleW600(AppColor.black, 16),
      //                         ),
      //                       ),
      //                     ),
      //                   )
      //                 : GestureDetector(
      //                     onTap: () {
      //                       log("ACTIVE ON TAP");
      //                       if (logic.isActiveFrame != -1 && controller.outfitTabController!.index == 0) {
      //                         SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.avatarFrames!.active![logic.isActiveFrame].itemId!,
      //                           itemType: 2,
      //                           action: ApiParams.takeoff,
      //                         ).then((value) {
      //                           if (value != null) {
      //                             // logic.fetchPurchasedFrameModel = value;
      //                             logic.update([ApiParams.backpack]);
      //                           }
      //                         });
      //                       } else if (logic.isActiveTheme != -1 && controller.outfitTabController!.index == 0) {
      //                         SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.themes!.active![logic.isActiveTheme].itemId!,
      //                           itemType: 1,
      //                           action: ApiParams.takeoff,
      //                         ).then((value) {
      //                           if (value != null) {
      //                             // logic.fetchPurchasedFrameModel = value;
      //                             logic.update([ApiParams.backpack]);
      //                           }
      //                         });
      //                       } else if (logic.isActiveRide != -1 && controller.outfitTabController!.index == 0) {
      //                         SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.rides!.active![logic.isActiveRide].itemId!,
      //                           itemType: 3,
      //                           action: ApiParams.takeoff,
      //                         ).then((value) {
      //                           if (value != null) {
      //                             // logic.fetchPurchasedFrameModel = value;
      //                             logic.update([ApiParams.backpack]);
      //                           }
      //                         });
      //                       } else {
      //                         Utils.showToast(text: "Not Selected item");
      //                       }
      //                     },
      //                     child: Container(
      //                       height: 50,
      //                       width: Get.width / 2 - 20,
      //                       decoration: BoxDecoration(
      //                         color: AppColor.lightGrayBg,
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                       child: Center(
      //                         child: Text(
      //                           EnumLocal.txtTakeOff.name.tr,
      //                           style: AppFontStyle.styleW600(AppColor.black, 16),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //           ),
      //           GetBuilder<ThemeOutfitController>(
      //             builder: (controller) => InkWell(
      //               onTap: () {
      //                 log("ACTIVE ON TAP");
      //                 if (logic.isActiveFrame != -1 && controller.outfitTabController!.index == 0) {
      //                   SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.avatarFrames!.active![logic.isActiveFrame].itemId!,
      //                           action: ApiParams.takeoff,
      //                           itemType: 2)
      //                       .then((value) {
      //                     if (value != null) {
      //                       // logic.fetchPurchasedFrameModel = value;
      //                       logic.update([ApiParams.backpack]);
      //                     }
      //                   });
      //                 } else if (logic.isActiveTheme != -1 && controller.outfitTabController!.index == 0) {
      //                   SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.themes!.active![logic.isActiveTheme].itemId!,
      //                           action: ApiParams.takeoff,
      //                           itemType: 1)
      //                       .then((value) {
      //                     if (value != null) {
      //                       // logic.fetchPurchasedFrameModel = value;
      //                       logic.update([ApiParams.backpack]);
      //                     }
      //                   });
      //                 } else if (logic.isActiveRide != -1 && controller.outfitTabController!.index == 0) {
      //                   SelectThemeApi.callApi(
      //                           uid: logic.uid,
      //                           token: logic.token,
      //                           itemId: logic.fetchPurchasedFrameModel!.data!.rides!.active![logic.isActiveRide].itemId!,
      //                           action: ApiParams.takeoff,
      //                           itemType: 3)
      //                       .then((value) {
      //                     if (value != null) {
      //                       // logic.fetchPurchasedFrameModel = value;
      //                       logic.update([ApiParams.backpack]);
      //                     }
      //                   });
      //                 } else {
      //                   Utils.showToast(text: "Not Selected item");
      //                 }
      //               },
      //               child: Container(
      //                 height: 50,
      //                 width: Get.width / 2 - 20,
      //                 decoration: BoxDecoration(
      //                   color: AppColor.primary,
      //                   borderRadius: BorderRadius.circular(15),
      //                 ),
      //                 child: Center(
      //                   child: Text(
      //                     EnumLocal.txtRenew.name.tr,
      //                     style: AppFontStyle.styleW600(AppColor.white, 16),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: GetBuilder<ThemeOutfitController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
