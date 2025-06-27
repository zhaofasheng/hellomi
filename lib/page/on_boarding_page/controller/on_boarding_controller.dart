import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/on_boarding_page/widget/on_boarding_screen_one_widget.dart';
import 'package:tingle/page/on_boarding_page/widget/on_boarding_screen_three_widget.dart';
import 'package:tingle/page/on_boarding_page/widget/on_boarding_screen_two_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/constant.dart';

class OnBoardingController extends GetxController {
  int selectedIndex = 0;

  final List<Widget> pages = [
    OnBoardingScreenOneWidget(),
    OnBoardingScreenTwoWidget(),
    OnBoardingScreenThreeWidget(),
  ];

  void onChangePage(int value) {
    selectedIndex = value;
    update([AppConstant.onChangePage]);
  }

  void onClickNext() {
    if (selectedIndex == 0) {
      selectedIndex = 1;
    } else if (selectedIndex == 1) {
      selectedIndex = 2;
    } else if (selectedIndex == 2) {
      Get.toNamed(AppRoutes.loginPage);
    }
    update([AppConstant.onChangePage]);
  }
}
