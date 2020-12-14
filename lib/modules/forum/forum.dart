import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/routes/routes.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:photo_social/src/enum/index.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/widgets/index.dart';
import 'forum_controller.dart';

class ForumDashboard extends GetView<ForumController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.forumStatus.value == LoadingStatus.loading
          ? LoadingIndicator.listLoading()
          : Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh: () => controller.refresh(),
                  onLoading: () => controller.loadMore(),
                  footer: SRLoadingState.loadMore,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 15),
                    itemCount: controller.countForum,
                    itemBuilder: (context, index) {
                      final forums = controller.forums;
                      return forums.isEmpty
                          ? Text("No forums now")
                          : ForumBanner(
                              height: 130,
                              width: Get.width,
                              forum: forums[index],
                              onTap: () {
                                Get.toNamed(
                                  Routes.FORUMPOST,
                                  arguments: {
                                    "id": forums[index].id,
                                    "name": forums[index].name
                                  },
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
