import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingle/page/create_reels_page/controller/create_reels_controller.dart';
import 'package:tingle/page/create_reels_page/widget/effect_camera_widget.dart';
import 'package:tingle/page/create_reels_page/widget/without_effect_camera_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class CreateReelsView extends GetView<CreateReelsController> {
  const CreateReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.light);
    return Scaffold(
      body: controller.isUseEffects ? EffectCameraWidget() : WithoutEffectCameraWidget(),
    );
  }
}
