import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/comment_model.dart';
import 'package:photo_social/modules/account/account_controller.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'comment_repository.dart';

class CommentController extends GetxController {
  static CommentController get to => Get.find();
  final String _postId;
  CommentController({@required String postId}) : _postId = postId;
  CommentRepository _commentRepository = CommentRepository();
  RefreshController refreshController = RefreshController();
  TextEditingController commentCtrl = TextEditingController();
  var commentsData = RxList<CommentModel>();
  var commentLoadingStatus = LoadingStatus.loading.obs;
  var _currentPage = 1.obs;

  int get commentLength => commentsData.length;
  List<CommentModel> get comments => commentsData;
  bool get isCommentEmpty => commentsData.isEmpty;

  @override
  void onInit() {
    super.onInit();
    loadComment();
  }

  void loadComment() async {
    try {
      var result =
          await _commentRepository.getPostComment(postId: _postId, page: 1);
      commentLoadingStatus(LoadingStatus.success);
      commentsData.addAll(result);
    } catch (e) {
      commentLoadingStatus(LoadingStatus.error);
    }
  }

  Future<bool> addComment() async {
    final currentUser = AccountController.to.getUser;
    try {
      commentsData.add(
        CommentModel(
          comment: commentCtrl.text,
          commentId: "",
          createdTime: DateTime.now(),
          user: UserCommentInfo(
            id: currentUser.userId,
            avatar: currentUser.avatar,
            name: currentUser.name,
          ),
        ),
      );
      commentCtrl.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  void refresh() async {
    commentsData.clear();
    loadComment();
    _currentPage.value = 1;
  }

  void loadMoreComment() async {
    int nextPage = _currentPage.value + 1;
    try {
      var result = await _commentRepository.getPostComment(
          postId: _postId, limit: 10, page: nextPage);
      if (result.isEmpty) {
        refreshController.loadNoData();
      } else {
        commentsData.addAllNonNull(result);
        _currentPage.value++;
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
    }
  }
}
