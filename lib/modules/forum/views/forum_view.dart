import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../routes/routes.dart';
import '../../home/widgets/forum_banner.dart';
import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  @override
  Widget build(BuildContext context) {
    final forums = controller.forums;
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Center(
        child: SmartRefresher(
          controller: controller.refreshController,
          enablePullDown: true,
          onRefresh: () => controller.refresh(),
          onLoading: () => controller.loadMore(),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemCount: forums.length,
            itemBuilder: (context, index) {
              //final forums = controller.forums;
              return forums.isEmpty
                  ? Text("No forums now")
                  : ForumBanner(
                      height: 130,
                      width: Get.width,
                      forum: forums[index],
                      onTap: () {
                        Get.toNamed(
                          Routes.FORUMPOST,
                          arguments: {"id": forums[index].id, "name": forums[index].name},
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
