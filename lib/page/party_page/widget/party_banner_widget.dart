import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/function/banner_services.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

class PartyBannerWidget extends StatelessWidget {
  const PartyBannerWidget({super.key, required this.isShow, required this.margin});

  final bool isShow;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return BannerServices.homeBannerList.isNotEmpty && isShow
        ? Container(
            height: 100,
            width: Get.width,
            margin: margin,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColor.black,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColor.grayText.withValues(alpha: 0.3),
                  blurRadius: 2,
                ),
              ],
            ),
            child: GetBuilder<PartyController>(
              id: AppConstant.onChangeBanner,
              builder: (controller) => Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: controller.bannerPageController,
                    itemCount: BannerServices.homeBannerList.length,
                    onPageChanged: (value) => controller.onChangeBannerIndex(value: value),
                    itemBuilder: (context, index) => PreviewPostImageWidget(
                      image: BannerServices.homeBannerList[index].imageUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                        gradient: LinearGradient(
                          colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.6)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: DotIndicatorUi(
                      index: controller.currentBannerIndex,
                      length: BannerServices.homeBannerList.length,
                    ),
                  ),
                ],
              ),
            ))
        : Offstage();
  }
}
