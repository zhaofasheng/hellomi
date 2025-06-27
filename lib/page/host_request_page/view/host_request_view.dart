import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class HostRequestView extends GetView<HostRequestController> {
  const HostRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBarWidget.onShow(context: context, title: EnumLocal.txtHostRequest.name.tr),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff4962E0),
                      Color(0xff4962E0),
                      Color(0xffE59AFF),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 280,
                width: Get.width,
                child: Image.asset(
                  AppAssets.imgHostRequest,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    240.height,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: BlurryContainer(
                        color: AppColor.white.withValues(alpha: 0.2),
                        padding: EdgeInsets.zero,
                        blur: 15,
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
                                style: AppFontStyle.styleW800(AppColor.white, 16).copyWith(
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 4.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
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
                                        child: GradientTextWidget(
                                          EnumLocal.txtJoinAgency.name.tr,
                                          gradient: AppColor.textGradient,
                                          style: AppFontStyle.styleW900(AppColor.black, 25),
                                        ),
                                      ),
                                      20.height,
                                      Text(
                                        EnumLocal.txtUniqueId.name.tr,
                                        style: AppFontStyle.styleW600(AppColor.black, 14),
                                      ),
                                      5.height,
                                      CustomTextFieldWidget(
                                        controller: controller.uniqueIdController,
                                        fillColor: AppColor.colorBorder.withValues(alpha: 0.3),
                                        borderColor: AppColor.primary.withValues(alpha: 0.6),
                                        hintText: EnumLocal.txtEnterUniqueId.name.tr,
                                        hintStyle: AppFontStyle.styleW400(AppColor.secondary, 15),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [],
                                      ),
                                      15.height,
                                      Text(
                                        EnumLocal.txtAgencyCode.name.tr,
                                        style: AppFontStyle.styleW600(AppColor.black, 14),
                                      ),
                                      5.height,
                                      CustomTextFieldWidget(
                                        hintText: EnumLocal.txtEnterAgencyCode.name.tr,
                                        keyboardType: TextInputType.emailAddress,
                                        controller: controller.agencyCodeController,
                                        fillColor: AppColor.colorBorder.withValues(alpha: 0.3),
                                        borderColor: AppColor.primary.withValues(alpha: 0.6),
                                        hintStyle: AppFontStyle.styleW400(AppColor.secondary, 15),
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
                                        gradient: AppColor.textGradient,
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
    );
  }
}
