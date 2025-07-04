import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/function/country_services.dart';
import 'package:tingle/common/widget/scroll_fade_effect_widget.dart';
import 'package:tingle/page/party_page/controller/party_controller.dart';
import 'package:tingle/page/party_page/widget/party_apply_filter_bottom_sheet.dart';
import 'package:tingle/page/stream_page/shimmer/country_tab_shimmer_widget.dart';
import 'package:tingle/page/stream_page/widget/stream_country_tab_bar_widget.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class PartyCountryTabBarWidget extends StatelessWidget {
  const PartyCountryTabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PartyController>(
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
                    scrollDirection: Axis.horizontal,
                    controller: CountryService.scrollController,
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
                                callback: () => controller.onChangeCountry(value: (indexData.name ?? "").toLowerCase()),
                              );
                            },
                          ),
                  ),
                ),
              ),
              Visibility(
                visible: CountryService.isLoading.value == false,
                child: GestureDetector(
                  onTap: () => PartyApplyFilterBottomSheet.show(context: context),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.transparent,
                    ),
                    child: Assets.images.mainChoiceMoreImg.image(width: 25),
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

class ItemWidget extends StatelessWidget {
  const ItemWidget({
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
        padding: const EdgeInsets.only(left: 18, right: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(100),
          border: isSelected ? Border.all(color: AppColor.white) : Border.all(color: AppColor.transparent),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              flag,
              style: AppFontStyle.styleW500(AppColor.white, 14),
            ),
            8.width,
            Text(
              title,
              style: isSelected ? AppFontStyle.styleW600(AppColor.white, 14) : AppFontStyle.styleW500(AppColor.white, 14),
            ),
            8.width,
          ],
        ),
      ),
    );
  }
}
