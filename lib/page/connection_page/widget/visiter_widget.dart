import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/have_visited_widget.dart';
import 'package:tingle/page/connection_page/widget/myvisitor_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class VisitorsWidget extends StatelessWidget {
  const VisitorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectionController>(
      id: AppConstant.onChangeFollowUpdate,
      builder: (controller) => SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            5.height,
            Center(
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColor.lightGrayBg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: TabBar(
                    isScrollable: true,
                    controller: controller.visitTabController,
                    indicator: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    unselectedLabelColor: AppColor.secondary,
                    labelColor: AppColor.black,
                    dividerColor: Colors.transparent,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    overlayColor: WidgetStatePropertyAll(AppColor.transparent),
                    onTap: (value) {},
                    tabAlignment: TabAlignment.center,
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            EnumLocal.txtMyVisitors.name.tr,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            EnumLocal.txtWhoIHaveVisited.name.tr,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.visitTabController,
                children: const [
                  MyVisitorWidget(),
                  HaveVisitedWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
