import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';
import 'package:tingle/page/search_page/controller/search_controller.dart' as search;

class SearchHistoryWidget extends GetView<search.SearchController> {
  const SearchHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.searchUserHistory.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          EnumLocal.txtSearchHistory.name.tr,
                          style: AppFontStyle.styleW700(AppColor.black, 16),
                        ),
                        GestureDetector(
                          onTap: controller.onClearSearchHistory,
                          child: Container(
                            height: 20,
                            width: 100,
                            alignment: Alignment.centerRight,
                            color: AppColor.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(AppAssets.icDeleteBorder, width: 15),
                                5.width,
                                Text(
                                  EnumLocal.txtClearUp.name.tr,
                                  style: AppFontStyle.styleW600(AppColor.red, 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    15.height,
                    SizedBox(
                      height: 30,
                      width: Get.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ListView.builder(
                          itemCount: controller.searchUserHistory.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final indexData = controller.searchUserHistory[index];
                            return GestureDetector(
                              onTap: () => controller.onClickSearchHistory(indexData),
                              child: Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                margin: EdgeInsets.only(right: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColor.lightGrayBg,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  indexData,
                                  style: AppFontStyle.styleW500(AppColor.grayText, 13),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    15.height,
                  ],
                )
              : Offstage(),

        ],
      ),
    );
  }
}
