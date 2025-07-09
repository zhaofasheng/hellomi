import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/common/widget/gradient_text_widget.dart';
import 'package:tingle/common/widget/simple_app_bar_widget.dart';
import 'package:tingle/custom/widget/custom_text_field_widget.dart';
import 'package:tingle/page/host_request_page/controller/host_request_controller.dart';
import 'package:tingle/page/preview_created_reels_page/widget/preview_created_reels_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../level_page/widget/level_app_bar_widget.dart';

class HostRequestView extends GetView<HostRequestController> {
  const HostRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      color: HexColor('#F5F5F5'),
                    ),
                    SizedBox(
                      height: 328,
                      width: Get.width,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Assets.images.hostDaili.image(
                          height: 328,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        children: [
                          265.height,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: BlurryContainer(
                              color: HexColor('#00E4A6'),
                              padding: EdgeInsets.zero,
                              height: 390,
                              borderRadius: BorderRadius.circular(30),
                              child: Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    child: Text(
                                      EnumLocal.txtRequestToJoinHostAgency.name.tr,
                                      style: AppFontStyle.styleW600(AppColor.white, 16).copyWith(),
                                    ),
                                  ),
                                  Container(
                                    height: 350,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: GetBuilder<HostRequestController>(
                                      builder: (controller) => Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                EnumLocal.txtJoinAgency.name.tr,
                                                style: AppFontStyle.styleW500(HexColor('#00E4A6'), 25),
                                              ),
                                            ),
                                            20.height,
                                            Row(
                                              children: [
                                                Assets.images.hostId.image(width: 16),
                                                3.width,
                                                Text(
                                                  EnumLocal.txtUniqueId.name.tr,
                                                  style: AppFontStyle.styleW600(AppColor.black, 14),
                                                ),
                                              ],
                                            ),
                                            5.height,
                                            CustomTextFieldWidget(
                                              backgroundColor: HexColor('F5F5F5'),
                                              borderRadius: 999,
                                              controller: controller.uniqueIdController,
                                              fillColor: AppColor.colorBorder.withValues(alpha: 0.3),
                                              borderColor: AppColor.primary.withValues(alpha: 0.6),
                                              hintText: EnumLocal.txtEnterUniqueId.name.tr,
                                              hintStyle: AppFontStyle.styleW400(AppColor.secondary, 15),
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [],
                                            ),
                                            15.height,
                                            Row(
                                              children: [
                                                Assets.images.hostCode.image(width: 16),
                                                3.width,
                                                Text(
                                                  EnumLocal.txtAgencyCode.name.tr,
                                                  style: AppFontStyle.styleW600(AppColor.black, 14),
                                                ),
                                              ],
                                            ),

                                            5.height,
                                            CustomTextFieldWidget(
                                              backgroundColor: HexColor('F5F5F5'),
                                              borderRadius: 999,
                                              hintText: EnumLocal.txtEnterAgencyCode.name.tr,
                                              keyboardType: TextInputType.emailAddress,
                                              controller: controller.agencyCodeController,
                                              fillColor: AppColor.colorBorder.withValues(alpha: 0.3),
                                              borderColor: AppColor.primary.withValues(alpha: 0.6),
                                              hintStyle: AppFontStyle.styleW400(HexColor('#86868F'), 15),
                                              // onChange: (p0) => controller.onChangeAgencyId(),
                                              onEditingComplete: () => controller.onChangeAgencyId(),
                                              suffixIcon: SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Obx(
                                                      () => Center(
                                                    child: controller.isCheckingAgency.value
                                                        ? Padding(
                                                      padding: const EdgeInsets.all(15),
                                                      child: CircularProgressIndicator(color: AppColor.primary, strokeWidth: 3),
                                                    )
                                                        : controller.isValidAgency == null
                                                        ? Offstage()
                                                        : controller.isValidAgency == true
                                                        ? Icon(
                                                      Icons.done_all,
                                                      color: AppColor.green,
                                                    )
                                                        : Image.asset(AppAssets.icClose, color: Colors.red, height: 20, width: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            20.height,
                                            AppButtonUi(
                                              fontSize: 16,
                                              gradient: AppColor.primaryGradient,
                                              fontWeight: FontWeight.bold,
                                              title: EnumLocal.txtSendRequest.name.tr,
                                              callback: controller.onClickSendRequest,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LevelAppBarWidget(title: EnumLocal.txtHostRequest.name.tr),
          ],
        ),
      ),
    );
  }
}
