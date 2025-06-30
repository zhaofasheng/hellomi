import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart' show ReadMoreText, TrimMode;
import 'package:tingle/common/function/gender_icon.dart';
import 'package:tingle/common/widget/preview_network_image_widget.dart';
import 'package:tingle/common/widget/user_role_widget.dart';
import 'package:tingle/page/profile_page/controller/profile_controller.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/assets.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/database.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/font_style.dart';
import 'package:tingle/utils/utils.dart';

import '../../../assets/assets.gen.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      id: AppConstant.onGetProfile,
      builder: (controller) {
        final user = controller.fetchUserProfileModel?.user;
        return GestureDetector(
          onTap: () => Get.toNamed(
            AppRoutes.previewUserProfilePage,
            arguments: user?.id ?? "",
          )?.then((value) {
            Utils.onChangeStatusBar(brightness: Brightness.dark);
            controller.scrollController.jumpTo(0.0);
          }),
          child: Container(
            alignment: Alignment.center,
            color: AppColor.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, // 所有居中对齐
              children: [
                // 🟡 头像居中
                // 替换原来的头像 Container，改成 Stack 包裹
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 68,
                      width: 68,
                      padding: const EdgeInsets.all(1), // 内边距用于模拟边框宽度
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.primary, width: 1), // ✅ 固定边框
                      ),
                      child: ClipOval(
                        child: PreviewProfileImageWithFrameWidget(
                          image: user?.image,
                          isBanned: user?.isProfilePicBanned ?? false,
                          fit: BoxFit.cover,
                          frame: user?.activeAvtarFrame?.image ?? "",
                          type: user?.activeAvtarFrame?.type ?? 1,
                          margin: const EdgeInsets.all(10), // 内部圆形内容间距
                        ),
                      ),
                    ),
                    // 🔽 右下角进入按钮
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.previewUserProfilePage, arguments: user?.id ?? "");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Assets.images.mineEdit.image(width: 20,height: 20),
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 10),

                // 🟢 Row: 昵称 + 认证 + 角色标签 + 性别 + 年龄 + 财富等级
                Wrap(
                  spacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      user?.name ?? "",
                      style: AppFontStyle.styleW700(AppColor.black, 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (user?.isVerified ?? false)
                      Image.asset(AppAssets.icAuthoriseIcon, width: 15),
                    UserRoleWidget(
                      roles: user?.role ?? [],
                    ),
                    Container(
                      height: 18,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            GenderIcon.onShow(user?.gender ?? ""),
                            width: 10,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            (user?.age ?? 0).toString(),
                            style: AppFontStyle.styleW600(AppColor.white, 10),
                          ),
                        ],
                      ),
                    ),
                    PreviewWealthLevelImage(
                      image: user?.wealthLevel?.levelImage,
                      height: 18,
                      width: 40,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔵 ID
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: (user?.uniqueId).toString()));
                    Utils.showToast(text: EnumLocal.txtCopiedOnClipboard.name.tr);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${EnumLocal.txtID.name.tr} ${user?.uniqueId ?? 0}",
                        style: AppFontStyle.styleW400(HexColor('#86868F'), 13),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

