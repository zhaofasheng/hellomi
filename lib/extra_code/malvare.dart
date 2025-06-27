import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/login_page/controller/login_controller.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isLoggedIn = Get.find<LoginController>().loginModel!.user != null;
    if (!isLoggedIn) {
      return RouteSettings(name: '/login');
    }
    return null;
  }
}
