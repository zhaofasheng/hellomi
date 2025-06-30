import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';

class CustomLightBackgroundWidget extends StatelessWidget {
  const CustomLightBackgroundWidget({super.key, this.isLogin = false, this.isMine = false});

  final bool isLogin;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Assets.images.backgroundImg.image(width: Get.width,height: Get.height,fit: BoxFit.cover),
          if(isLogin) Assets.images.loginBackImg.image(width: Get.width,fit: BoxFit.cover),

          if(isMine) Assets.images.mineBackImg.image(width: Get.width,fit: BoxFit.cover),
        ],
      )
    );
  }
}
