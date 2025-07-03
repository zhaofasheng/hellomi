import 'package:flutter/material.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_fans_club_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_fans_ranking_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_gift_gallery_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_personal_info_widget.dart';
import 'package:tingle/page/preview_user_profile_page/widget/preview_profile_wealth_level_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class PreviewProfileDataTabWidget extends StatelessWidget {
  const PreviewProfileDataTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Column(
        children: [
          15.height,
          PreviewProfileWealthLevelWidget(),
          15.height,
          PreviewProfileGiftGalleryWidget(),
          // 15.height,
          // PreviewProfileFansClubWidget(),
          15.height,
          PreviewProfileFansRankingWidget(),
          5.height,
          PreviewProfilePersonalInfoWidget(),
        ],
      ),
    );
  }
}
