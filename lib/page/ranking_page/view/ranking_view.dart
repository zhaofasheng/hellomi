import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/ranking_page/controller/ranking_controller.dart';
import 'package:tingle/page/ranking_page/tabs/ranking_gift_tab_widget.dart';
import 'package:tingle/page/ranking_page/tabs/ranking_rich_tab_widget.dart';
import 'package:tingle/page/ranking_page/widget/rank_app_bar_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

import '../../../custom/widget/custom_light_background_widget.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      backgroundColor: AppColor.transparent,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CustomLightBackgroundWidget(),

            // 内容区
            GetBuilder<RankingController>(
              builder: (controller) => Column(
                children: [
                  RankAppBarWidget(),
                  Expanded(
                    child: Padding(
                      // ✅ 给 TabBarView 增加底部间距，防止内容被导航栏遮挡
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom,
                      ),
                      child: TabBarView(
                        controller: controller.tabController,
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          RankingRichTabWidget(),
                          RankingGiftTabWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ✅ 底部白色背景，仅在 iOS 绘制
            if (Platform.isIOS)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).padding.bottom,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
