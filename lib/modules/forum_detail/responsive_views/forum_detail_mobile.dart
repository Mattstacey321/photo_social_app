import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/themes/index.dart';
import '../../../global_widgets/demand_loading.dart';
import '../../../global_widgets/index.dart';
import '../../../src/app_state/error_forum_post.dart';
import '../../../src/app_state/index.dart';
import '../controllers/post_controller.dart';
import '../widgets/index.dart';

class ForumDetailMobile extends StatelessWidget {
  final String forumId;
  final String forumName;
  ForumDetailMobile({@required this.forumId, @required this.forumName});
  @override
  Widget build(BuildContext context) {
    return GetX<PostController>(
      init: PostController(forumId: forumId),
      autoRemove: false,
      builder: (controller) {
        final posts = controller.posts;
        return Scaffold(
          appBar: CustomAppBar(
            childs: [
              GestureDetector(
                onTap: () {
                  controller.scrollToTop();
                },
                child: Text(
                  forumName ?? "",
                  style: AppStyles.appBarTitle,
                ),
              ),
              Spacer(),
              /*Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: CustomDropdownList(),
             ),*/
            ],
            height: 50,
            onTapBack: () {
              Get.back();
            },
          ),
          body: Container(
            height: Get.height,
            width: Get.width,
            child: Center(
              child: DemandLoadingWidget(
                controller.postLoadingStatus,
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  onRefresh: () => controller.refresh(),
                  onLoading: () => controller.loadMorePost(),
                  child: ListView.separated(
                    controller: controller.scrollController,
                    cacheExtent: 200,
                    addAutomaticKeepAlives: true,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostItem(
                        post: posts[index],
                        hideHashTag: posts[index].tags.isEmpty,
                      );
                    },
                  ),
                ),
                onEmpty: EmptyPost(),
                onError: ErrorForumPost(
                  onRetry: () {
                    controller.refresh();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
