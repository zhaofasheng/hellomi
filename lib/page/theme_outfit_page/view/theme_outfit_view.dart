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

import '../../../custom/widget/custom_light_background_widget.dart';
import '../../../utils/enums.dart';
import '../../level_page/widget/level_app_bar_widget.dart';

class ThemeOutfitView extends GetView<ThemeOutfitView> {
  const ThemeOutfitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          Column(
            children: [
              const LevelAppBarWidget(title: 'My Outfit'),
              const ThemeOutfitTabBarWidget(),
              Expanded( // 👈 正确包裹 TabBarView
                child: GetBuilder<BackpackController>(
                  builder: (logic) => GetBuilder<ThemeOutfitController>(
                    builder: (controller) => controller.isLoading.value
                        ? ThemeOutfitShimmerWidget()
                        : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
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
            ],
          ),
        ],
      ),
    );
  }
}
