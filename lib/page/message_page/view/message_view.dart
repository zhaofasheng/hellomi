import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/common/shimmer/user_list_shimmer_widget.dart';
import 'package:tingle/common/widget/no_data_found_widget.dart';
import 'package:tingle/custom/function/custom_message_time_format.dart';
import 'package:tingle/custom/widget/custom_light_background_widget.dart';
import 'package:tingle/page/message_page/controller/message_controller.dart';
import 'package:tingle/page/message_page/widget/message_app_bar_widget.dart';
import 'package:tingle/page/message_page/widget/message_user_widget.dart';
import 'package:tingle/routes/app_routes.dart';
import 'package:tingle/utils/api_params.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';
import 'package:tingle/utils/enums.dart';
import 'package:tingle/utils/utils.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.onChangeStatusBar(brightness: Brightness.dark);
    Utils.onChangeExtendBody(false);

    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const MessageAppBarWidget(),
                Expanded(
                  child: LayoutBuilder(builder: (context, box) {
                    return RefreshIndicator(
                      color: AppColor.primary,
                      onRefresh: () async => await controller.onRefresh(millisecondsDelay: 0),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: box.maxHeight + 1, // USE TO ACTIVE REFRESH INDICATOR...
                          child: RefreshIndicator(
                            color: AppColor.primary,
                            onRefresh: () async => await controller.onRefresh(millisecondsDelay: 0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // AlertMessageWidget(
                                  //   title: "Official Announcement",
                                  //   subTitle: "Official Announcement- Beware of Scams",
                                  //   image: AppAssets.icAnnouncement,
                                  //   imageSize: 26,
                                  //   color: AppColor.primary,`
                                  //   dateTime: "09:20",
                                  //   messageCount: 8,
                                  //   gradient: AppColor.announcementGradient,
                                  //   callback: () {},
                                  // ),
                                  // AlertMessageWidget(
                                  //   title: "Account Security Center",
                                  //   subTitle: "The system has detected that your account...",
                                  //   color: AppColor.red,
                                  //   image: AppAssets.icSecurity,

                                  //   imageSize: 24,
                                  //   dateTime: "09:20",
                                  //   messageCount: 8,
                                  //   gradient: AppColor.securityGradient,
                                  //   callback: () {},
                                  // ),
                                  GetBuilder<MessageController>(
                                    id: AppConstant.onFetchMessageUser,
                                    builder: (controller) => controller.isLoading
                                        ? UserListShimmerWidget()
                                        : controller.messageUsers.isEmpty
                                            ? SizedBox(
                                                height: Get.height / 1.5,
                                                child: NoDataFoundWidget(title: EnumLocal.txtNoChatsYetStartAConversation.name.tr),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: controller.messageUsers.length,
                                                padding: EdgeInsets.zero,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  final indexData = controller.messageUsers[index];
                                                  return GetBuilder<MessageController>(
                                                    id: AppConstant.onChangeAnimation,
                                                    builder: (controller) => AnimatedContainer(
                                                      width: Get.width,
                                                      curve: Curves.easeInOut,
                                                      transform: Matrix4.translationValues(controller.isStartAnimation ? 0 : Get.width, 0, 0),
                                                      duration: Duration(milliseconds: 150 + (index * 100)),
                                                      child: MessageUserWidget(
                                                        title: indexData.name ?? "",
                                                        subTitle: indexData.message ?? "",
                                                        leading: indexData.image ?? "",
                                                        dateTime: (indexData.time?.trim().isEmpty ?? true) ? (CustomMessageTimeFormat.convert(Random().nextInt(1000).toDouble())) : indexData.time,
                                                        messageCount: indexData.unreadCount ?? 0,
                                                        isVerified: indexData.isVerified ?? false,
                                                        isProfileImageBanned: indexData.isProfilePicBanned ?? false,
                                                        avatarFrameImage: indexData.avatarFrameImage ?? "",
                                                        avatarFrameType: indexData.avatarFrameType ?? 0,
                                                        callback: () => indexData.isFake ?? true
                                                            ? Get.toNamed(
                                                                AppRoutes.fakeChatPage,
                                                                arguments: {
                                                                  ApiParams.roomId: indexData.id ?? "",
                                                                  ApiParams.receiverUserId: indexData.userId ?? "",
                                                                  ApiParams.name: indexData.name ?? "",
                                                                  ApiParams.image: indexData.image ?? "",
                                                                  ApiParams.isBanned: indexData.isProfilePicBanned ?? false,
                                                                  ApiParams.isVerify: indexData.isVerified ?? false,
                                                                },
                                                              )?.then((value) => controller.onRefresh(millisecondsDelay: 1000))
                                                            : Get.toNamed(
                                                                AppRoutes.chatPage,
                                                                arguments: {
                                                                  ApiParams.roomId: indexData.id ?? "",
                                                                  ApiParams.receiverUserId: indexData.userId ?? "",
                                                                  ApiParams.name: indexData.name ?? "",
                                                                  ApiParams.image: indexData.image ?? "",
                                                                  ApiParams.isBanned: indexData.isProfilePicBanned ?? false,
                                                                  ApiParams.isVerify: indexData.isVerified ?? false,
                                                                },
                                                              )?.then((value) => controller.onRefresh(millisecondsDelay: 1000)),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
