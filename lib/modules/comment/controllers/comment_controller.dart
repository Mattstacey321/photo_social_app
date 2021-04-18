import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/comment_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../src/enum/enum_loading.dart';
import '../../profile/controllers/profile_controller.dart';

class CommentController extends GetxController {
  static CommentController get to => Get.find();
  final String _postId;
  CommentController({@required String postId}) : _postId = postId;
  CommentRepository _commentRepository = Get.find<CommentRepository>();
  var refreshController = RefreshController();
  var commentCtrl = TextEditingController();
  var commentsData = RxList<CommentModel>();
  var commentLoadingStatus = LoadingStatus.loading.obs;
  var _currentPage = 1.obs;

  int get commentLength => commentsData.length;
  List<CommentModel> get comments => commentsData;
  bool get isCommentEmpty => commentsData.isEmpty;
  UserModel get user => ProfileController.to.getUser;

  @override
  void onInit() {
    loadComment();
    ever(commentsData, (List<CommentModel> res) {
      if (res.isNotEmpty) {
        commentLoadingStatus(LoadingStatus.success);
      }
    });
    super.onInit();
  }

  void loadComment() async {
    try {
      final result = await _commentRepository.getPostComment(postId: _postId, page: 1);
      if (result.isEmpty) {
        commentLoadingStatus(LoadingStatus.empty);
      } else {
        commentsData.addAll(result);
        commentLoadingStatus(LoadingStatus.success);
      }
    } catch (e) {
      commentLoadingStatus(LoadingStatus.error);
    }
  }

  void addComment() async {
    try {
      commentsData.add(
        CommentModel(
          comment: commentCtrl.text,
          commentId: "",
          createdTime: DateTime.now(),
          user: UserCommentInfo(
            id: user.userId,
            avatar: user.avatar,
            name: user.name,
          ),
        ),
      );
      commentCtrl.clear();
      BotToast.showText(
        text: "Comment Success",
      );
      update(["comment"]);
    } catch (e) {
      BotToast.showText(text: "Comment fail. Try again");
    }
  }

  void refresh() async {
    commentsData.clear();
    loadComment();
    refreshController.refreshCompleted();
    _currentPage.value = 1;
  }

  void loadMoreComment() async {
    int nextPage = _currentPage.value + 1;
    try {
      var result =
          await _commentRepository.getPostComment(postId: _postId, limit: 10, page: nextPage);
      if (result.isEmpty) {
        refreshController.loadNoData();
      } else {
        commentsData.addAll(result);
        _currentPage.value++;
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
    }
  }
}
