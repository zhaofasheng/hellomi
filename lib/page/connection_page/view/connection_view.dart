import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/connection_page/controller/connection_controller.dart';
import 'package:tingle/page/connection_page/widget/Following_widget.dart';
import 'package:tingle/page/connection_page/widget/connection_appbar_widget.dart';
import 'package:tingle/page/connection_page/widget/follower_widget.dart';
import 'package:tingle/page/connection_page/widget/friend_widget.dart';
import 'package:tingle/page/connection_page/widget/visiter_widget.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/constant.dart';

import '../../../custom/widget/custom_light_background_widget.dart';

class ConnectionView extends StatelessWidget {
  const ConnectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomLightBackgroundWidget(),
          Column(
            children: [
              const ConnectionAppBarWidget(),
              Expanded(
                child: Container(
                  color: AppColor.white,
                  child: GetBuilder<ConnectionController>(
                    builder: (controller) => RefreshIndicator(
                      onRefresh: () async {
                        await controller.onGetData();
                      },
                      child: TabBarView(
                        physics: const ClampingScrollPhysics(),
                        controller: controller.tabController,
                        children: const [
                          FriendsWidget(),
                          FollowsWidget(),
                          FollowersWidget(),
                          VisitorsWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<ConnectionController>(
        id: AppConstant.onPagination,
        builder: (controller) => Visibility(
          visible: controller.isLoadingConnectionPagination,
          child: LinearProgressIndicator(color: AppColor.primary),
        ),
      ),
    );
  }
}
