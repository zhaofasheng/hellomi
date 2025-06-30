import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tingle/common/function/country_flag_icon.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/custom/function/custom_format_number.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

class StreamGridviewItemWidget extends StatelessWidget {
  const StreamGridviewItemWidget({
    super.key,
    required this.name,
    required this.userName,
    required this.image,
    required this.isBanned,
    required this.isVerify,
    required this.countryFlag,
    required this.viewCount,
    required this.callback,
    required this.liveType,
  });

  final String name;
  final String userName;
  final String image;
  final bool isBanned;
  final bool isVerify;
  final String countryFlag;
  final int viewCount;
  final Callback callback;
  final int liveType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 226,
      child: GestureDetector(
        onTap: callback,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.white),
            borderRadius: BorderRadius.circular(20),
          ),
          child: LayoutBuilder(builder: (context, box) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: PreviewPostImageWidget(
                    image: image,
                    isBanned: isBanned,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          HexColor('#00E4A6'), // 起始颜色
                          HexColor('#00C2FF'), // 结束颜色，可替换为你想要的颜色
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.icLiveWave,
                          width: 12,
                          color: AppColor.white,
                        ),
                        5.width,
                        Text(
                          CustomFormatNumber.onConvert(viewCount),
                          style: AppFontStyle.styleW600(AppColor.white, 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(vertical: 0,horizontal: 4),
                    decoration: BoxDecoration(
                      color: AppColor.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          liveType == 1
                              ? AppAssets.icLiveIcon
                              : liveType == 2
                              ? AppAssets.icAudioRoomIcon
                              : AppAssets.icPkIcon,
                          width: 15,
                          color: liveType == 3 ? null : Colors.black,
                        ),

                        3.width,
                        Text(
                          liveType == 1
                              ? EnumLocal.txtLive.name.tr
                              : liveType == 2
                              ? EnumLocal.txtAudioLive.name.tr
                              : liveType == 3
                              ? EnumLocal.txtPkBattle.name.tr
                              : "",
                          style: AppFontStyle.styleW500(AppColor.black, 10),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 100,
                    width: box.maxWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColor.transparent, AppColor.black.withValues(alpha: 0.8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 2,
                  child: Container(
                    height: 50,
                    width: box.maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColor.white),
                          ),
                          child: Container(
                            height: 32,
                            width: 32,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: PreviewProfileImageWidget(image: image, isBanned: isBanned),
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.styleW700(AppColor.white, 11),
                                    ),
                                  ),
                                  3.width,
                                  PreviewCountryFlagIcon(flag: countryFlag),
                                  Visibility(
                                    visible: isVerify,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: Image.asset(AppAssets.icAuthoriseIcon, width: 16),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  userName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.styleW500(AppColor.white, 9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.width,

                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
