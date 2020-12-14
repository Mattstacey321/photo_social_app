import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/src/app_state/error_forum_post.dart';
import 'package:photo_social/src/app_state/index.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'post_controller.dart';
import 'widgets/post_item.dart';

class ForumPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String forumId = Get.arguments["id"];
    final String forumName = Get.arguments["name"];
    return GetBuilder<PostController>(
        init: PostController(forumId: forumId),
        builder: (_) => Scaffold(
              appBar: CustomAppBar(
                childs: [
                  GestureDetector(
                    onTap: () {
                      _.scrollToTop();
                    },
                    child: Text(
                      forumName ?? "",
                      style: AppStyles.appBarTitle,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: CustomDropdownList(),
                  ),
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
                  child: ObxValue(
                    (res) {
                      switch (res.value) {
                        case LoadingStatus.loading:
                          return LoadingIndicator.listLoading();
                        case LoadingStatus.error:
                          return ErrorForumPost(
                            onRetry: () {},
                          );
                        default:
                          return SmartRefresher(
                            controller: _.refreshController,
                            enablePullDown: true,
                            enablePullUp: true,
                            footer: SRLoadingState.loadMore,
                            onRefresh: () => _.refresh(),
                            onLoading: () => _.loadMorePost(),
                            child: ListView.separated(
                              controller: _.scrollController,
                              cacheExtent: 200,
                              addAutomaticKeepAlives: true,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20),
                              itemCount: _.countPost,
                              itemBuilder: (context, index) {
                                final posts = _.postData;
                                return posts.isEmpty
                                    ? EmptyPost()
                                    : Post(
                                        model: posts[index],
                                        hideHashTag: posts[index].tags.isEmpty,
                                      );
                              },
                            ),
                          );
                      }
                    },
                    _.loadingResult,
                  ),
                ),
              ),
            ));
  }
}
