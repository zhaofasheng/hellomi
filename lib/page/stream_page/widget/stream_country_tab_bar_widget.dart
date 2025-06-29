import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/assets/assets.gen.dart';
import 'package:tingle/common/function/country_services.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/stream_page/controller/stream_controller.dart';
import 'package:tingle/page/stream_page/shimmer/country_tab_shimmer_widget.dart';
import 'package:tingle/page/stream_page/widget/apply_filter_bottom_sheet.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class StreamCountryTabBarWidget extends StatelessWidget {
  const StreamCountryTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreamController>(
      id: AppConstant.onChangeCountry,
      builder: (controller) => Container(
        height: 35,
        width: Get.width,
        color: AppColor.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(
          () => Row(
            children: [
              Expanded(
                child: ScrollFadeEffectWidget(
                  axis: Axis.horizontal,
                  child: SingleChildScrollView(
                    controller: CountryService.scrollController,
                    scrollDirection: Axis.horizontal,
                    child: CountryService.isLoading.value
                        ? CountryTabShimmerWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: CountryService.countries.length,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final indexData = CountryService.countries[index];
                              return CountyItemWidget(
                                title: indexData.name ?? "",
                                flag: indexData.emoji ?? "",
                                isSelected: controller.selectedCountry == (indexData.name)?.toLowerCase(),
                                callback: () => controller.onChangeCountry((indexData.name ?? "").toLowerCase()),
                              );
                            },
                          ),
                  ),
                ),
              ),
              Visibility(
                visible: CountryService.isLoading.value == false,
                child: GestureDetector(
                  onTap: () => ApplyFilterBottomSheet.show(context: context),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.transparent,
                    ),
                    child: Assets.images.mainChoiceMoreImg.image(width: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountyItemWidget extends StatelessWidget {
  const CountyItemWidget({
    super.key,
    required this.title,
    required this.flag,
    required this.isSelected,
    required this.callback,
  });

  final String title;
  final String flag;
  final bool isSelected;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.only(left: 15, right: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.white : AppColor.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColor.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              flag,
              style: AppFontStyle.styleW500(AppColor.black, 14),
            ),
            8.width,
            Text(
              title,
              style: isSelected ? AppFontStyle.styleW600(AppColor.black, 13) : AppFontStyle.styleW500(AppColor.black, 12),
            ),
            8.width,
          ],
        ),
      ),
    );
  }
}
