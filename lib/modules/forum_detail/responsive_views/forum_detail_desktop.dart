import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../global_widgets/demand_loading.dart';
import '../../../src/app_state/error_forum_post.dart';
import '../../../src/app_state/index.dart';
import '../controllers/post_controller.dart';
import '../widgets/index.dart';

class ForumDetaiLDesktop extends StatelessWidget {
  final String forumId;
  ForumDetaiLDesktop({@required this.forumId});
  @override
  Widget build(BuildContext context) {
    return GetX<PostController>(
      init: PostController(forumId: forumId),
      builder: (controller) {
        final posts = controller.posts;
        return Container(
          height: Get.height,
          width: Get.width,
          child: Center(
              child: DemandLoadingWidget(
            controller.postLoadingStatus,
            child: SmartRefresher(
              controller: controller.refreshController,
              enablePullUp : true,
              onRefresh: () => controller.refresh(),
              onLoading: () => controller.loadMorePost(),
              child: Scrollbar(
                controller: controller.scrollController,
                isAlwaysShown: true,
                child: GridView.builder(
                  controller: controller.scrollController,
                  cacheExtent: 200,
                  itemCount: controller.posts.length,
                  padding: EdgeInsets.only(right: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: GetPlatform.isMobile ? 2 : 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: (context.width / 2) / (context.height - kToolbarHeight - 24),
                  ),
                  itemBuilder: (context, index) {
                    final post = controller.posts[index];
                    return PostItem(
                      post: post,
                      hideHashTag: posts[index].isTagEmpty,
                    );
                  },
                ),
              ),
            ),
            onEmpty: EmptyPost(),
            onError: ErrorForumPost(
              onRetry: () => controller.refresh(),
            ),
          )),
        );
      },
    );
  }
}
