import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/utils/nested_key.dart';
import '../../../global_widgets/demand_loading.dart';
import '../../../src/app_state/error_comment.dart';
import '../../../src/app_state/index.dart';
import '../../comment/controllers/comment_controller.dart';
import '../../comment/widgets/index.dart';
import '../controllers/post_detail_controller.dart';

class CommentView extends GetView<PostDetailController> {
  final String postId;
  CommentView({@required this.postId});
  @override
  Widget build(BuildContext context) {
    var commentController = Get.put(CommentController(postId: postId));
    return Container(
      height: Get.height,
      width:  context.width / 3.5,
      child: ObxValue<RxBool>(
        (res) {
          return AnimatedOpacity(
            duration: 200.milliseconds,
            opacity: res.value ? 0 : 1,
            child: AnimatedContainer(
              duration: 150.milliseconds,
              alignment: Alignment.center,
              width:  context.width / 3.5,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                  left: BorderSide(
                    color: Colors.grey,
                    width: 0.3,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Flexible(
                    child: GetBuilder<CommentController>(
                      init: commentController,
                      assignId: true,
                      id: "comment",
                      builder: (controller) {
                        return DemandLoadingWidget(
                          controller.commentLoadingStatus,
                          child: SmartRefresher(
                            controller: controller.refreshController,
                            enablePullUp: !controller.isCommentEmpty,
                            onRefresh: () => controller.refresh(),
                            onLoading: () => controller.loadMoreComment(),
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              addAutomaticKeepAlives: true,
                              separatorBuilder: (context, index) => SizedBox(height: 20),
                              shrinkWrap: true,
                              itemCount: controller.comments.length,
                              itemBuilder: (context, index) {
                                final comment = controller.comments[index];
                                return CommentItem(
                                  comment: comment,
                                  onCommentSetting: () {},
                                  onLiked: () {},
                                  onReply: () {
                                    Get.toNamed("/detail", id: NestedKey.comment, arguments: comment);
                                  },
                                );
                              },
                            ),
                          ),
                          onEmpty: EmptyComment(),
                          onError: ErrorComment(),
                        );
                      },
                    ),
                  ),
                  CommentInput()
                ],
              ),
            ),
          );
        },
        controller.hideComment,
      ),
    );
  }
}
