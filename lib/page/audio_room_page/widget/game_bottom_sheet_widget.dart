import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/common/widget/play_game_bottom_sheet_widget.dart';
import 'package:tingle/page/party_page/tabs/party_games_tab_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class GameBottomSheetWidget {
  static Future<void> onShow() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      backgroundColor: AppColor.transparent,
      builder: (context) => Container(
        height: Get.height / 1.5,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 55,
              color: AppColor.secondary.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.width,
                  Expanded(
                    child: Center(
                      child: Text(
                        EnumLocal.txtGames.name.tr,
                        style: AppFontStyle.styleW700(AppColor.greyBlue, 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.secondary.withValues(alpha: 0.6),
                      ),
                      child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            15.height,
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Utils.games.isEmpty
                  ? NoDataFoundWidget()
                  : SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: Utils.games.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final indexData = Utils.games[index];
                          return indexData.isActive == true
                              ? GameItemWidget(
                                  title: indexData.name ?? "",
                                  image: indexData.image ?? "",
                                  callback: () {
                                    Get.back();
                                    PlayGameBottomSheetWidget.onShow(
                                      name: indexData.name ?? "",
                                      height: ((indexData.link ?? "").contains("teenpatti"))
                                          ? 370
                                          : ((indexData.link ?? "").contains("ferrywheelgame"))
                                              ? 550
                                              : 580,
                                      link: (indexData.link?.trim().isNotEmpty ?? false) ? ("${indexData.link}?id=${Database.loginUserId}") : "",
                                    );
                                  },
                                )
                              : Offstage();
                        },
                      ),
                    ),
            )),
          ],
        ),
      ),
    );
  }
}

//   static Future<void> onShowWebView({
//     required String name,
//     required double height,
//     required String link,
//   }) async {
//     Get.back();
//     onInitializeWebView(link: link);
//     await showModalBottomSheet(
//       isScrollControlled: true,
//       context: Get.context!,
//       backgroundColor: AppColor.transparent,
//       builder: (context) => Container(
//         height: height,
//         width: Get.width,
//         decoration: BoxDecoration(
//           color: AppColor.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               height: 50,
//               color: AppColor.secondary.withValues(alpha: 0.08),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   50.width,
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         name,
//                         style: AppFontStyle.styleW700(AppColor.greyBlue, 17),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => Get.back(),
//                     child: Container(
//                       height: 28,
//                       width: 28,
//                       margin: const EdgeInsets.only(right: 20),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColor.secondary.withValues(alpha: 0.6),
//                       ),
//                       child: Image.asset(width: 18, AppAssets.icClose, color: AppColor.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Obx(
//                 () => Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     LoadingWidget(),
//                     isLoading.value == false && webViewController != null ? WebViewWidget(controller: webViewController!) : Offstage(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _GameItemWidget extends StatelessWidget {
//   const _GameItemWidget({required this.icon, required this.name, required this.callback});
//
//   final String icon;
//   final String name;
//   final Callback callback;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         onTap: callback,
//         child: Container(
//           color: AppColor.transparent,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 icon,
//                 width: 55,
//               ),
//               5.height,
//               Text(
//                 name,
//                 style: AppFontStyle.styleW600(AppColor.black, 12),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20),
//   child: Row(
//     children: [
//       _GameItemWidget(
//         icon: AppAssets.icCasinoGame,
//         name: EnumLocal.txtCasino.name.tr,
//         callback: () => onShowWebView(
//           height: 580,
//           link: "https://roulettecasinogame.codderlab.com/?id=680b486a63652ed618fe0ff0",
//           name: EnumLocal.txtCasino.name.tr,
//         ),
//       ),
//       _GameItemWidget(
//         icon: AppAssets.icFerryGame,
//         name: EnumLocal.txtFerryWheel.name.tr,
//         callback: () => onShowWebView(
//           height: 550,
//           link: "https://ferrywheelgame.codderlab.com/?id=680b486a63652ed618fe0ff0",
//           name: EnumLocal.txtFerryWheel.name.tr,
//         ),
//       ),
//       _GameItemWidget(
//         icon: AppAssets.icPattiGame,
//         name: EnumLocal.txtTeenPatti.name.tr,
//         callback: () => onShowWebView(
//           height: 370,
//           link: "https://teenpatti.codderlab.com/?id=680b486a63652ed618fe0ff0",
//           name: EnumLocal.txtTeenPatti.name.tr,
//         ),
//       ),
//     ],
//   ),
// ),
