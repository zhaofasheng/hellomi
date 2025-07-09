import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/search_page/widget/search_app_bar_widget.dart';
import 'package:tingle/page/search_page/widget/search_history_widget.dart';
import 'package:tingle/page/search_page/widget/search_user_widget.dart';
import 'package:tingle/page/search_page/controller/search_controller.dart' as controller;
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/utils.dart';

import '../../../custom/widget/custom_light_background_widget.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          Column(
            children: [
              const SearchAppBarWidget(),
              Expanded(
                child: GetBuilder<controller.SearchController>(
                  id: AppConstant.onChangeSearchHistory,
                  builder: (controller) => controller.isShowSearchHistory
                      ? const SearchHistoryWidget()
                      : const SearchUserWidget(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}