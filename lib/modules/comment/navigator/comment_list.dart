import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/comment/widgets/index.dart';
import 'package:photo_social/src/app_state/empty_comment.dart';
import 'package:photo_social/src/app_state/error_comment.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:photo_social/utils/nested_key.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../comment_controller.dart';

class CommentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommentController>();
    return Scaffold(
        appBar: CustomAppBar(
          onTapBack: () {
            Get.back();
          },
          childs: [Text("Comment")],
        ),
        body: ObxValue<Rx<LoadingStatus>>((res) {
          switch (res.value) {
            case LoadingStatus.loading:
              return LoadingIndicator.listLoading();
            case LoadingStatus.error:
              return ErrorComment();
            default:
              return Center(
                child: controller.isCommentEmpty
                    ? EmptyComment()
                    : SmartRefresher(
                        controller: controller.refreshController,
                        enablePullDown: true,
                        enablePullUp: !controller.isCommentEmpty,
                        footer: SRLoadingState.loadMore,
                        onRefresh: () => controller.refresh(),
                        onLoading: () => controller.loadMoreComment(),
                        child: ListView.separated(
                          addAutomaticKeepAlives: true,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 20),
                          shrinkWrap: true,
                          itemCount: controller.commentLength,
                          itemBuilder: (context, index) {
                            final comments = controller.comments;
                            return CommentItem(
                              comment: comments[index],
                              onCommentSetting: () {},
                              onLiked: () {},
                              onReply: () {
                                Get.toNamed(
                                  "/detail",
                                  id: NestedKey.comment,
                                  arguments: comments[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
              );
          }
        }, controller.commentLoadingStatus));
  }
}
