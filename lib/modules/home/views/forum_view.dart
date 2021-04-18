import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/utils/nested_key.dart';
import '../../../global_widgets/demand_loading.dart';
import '../../../src/app_state/empty_forum.dart';
import '../../forum/controllers/forum_controller.dart';
import '../widgets/forum_banner.dart';

class ForumView extends GetView<ForumController>{

  @override
  Widget build(BuildContext context) {
    var forums = controller.forums;
    return DemandLoadingWidget(
        controller.forumStatus,
        child: SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () {
            controller.refresh();
          },
          onLoading: () {
            controller.loadMore();
          },
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                childAspectRatio: context.width / (context.height * 2)),
            itemCount: forums.length,
            itemBuilder: (_, index) {
              return ForumBanner(
                height: null,
                width: null,
                forum: forums[index],
                onTap: () {
                  Get.toNamed(
                  '/forum-detail',
                  id: NestedKey.home,
                  arguments: {"id": forums[index].id, "name": forums[index].name},
                );
                  //context.beamToNamed("/home/${forums[index].id}");
                },
              );
            },
          ),
        ),
        onEmpty: EmptyForum(),
        onError: Text("Has error"),
      );
    
  }
}
