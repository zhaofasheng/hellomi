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
      body: SafeArea(top:false,child: Stack(
        fit: StackFit.expand,
        children: [
          const CustomLightBackgroundWidget(),
          GetBuilder<RankingController>(
            builder: (controller) => Column(
              children: [
                RankAppBarWidget(),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      RankingRichTabWidget(),
                      RankingGiftTabWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
