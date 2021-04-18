import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/api/graphql.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/post_repository.dart';
import '../../../data/utils/check_token.dart';
import '../../../src/enum/index.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();
  String _forumId;
  PostController({String forumId}) : _forumId = forumId;
  PostRepository _postRepository = PostRepository(client: Get.find<GraphQL>().selectClient);
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  var posts = <PostModel>[].obs;
  var _currentPage = 1.obs;
  var _currentIndicatorIndex = 0.obs;
  var postLoadingStatus = LoadingStatus.loading.obs;

  @override
  void onReady() {
    initPost();
    super.onReady();
  }

  int get currentPage => _currentPage.value;
  int get currentIndicatorIndex => _currentIndicatorIndex.value;
  int get countPost => posts.length;

  void initPost() async {
    try {
      final response = await _postRepository.getForumPost(forumId: _forumId, page: 1);
      if (response.isEmpty) {
        //change([], status: RxStatus.empty());
        postLoadingStatus(LoadingStatus.empty);
      } else {
        postLoadingStatus(LoadingStatus.success);
        posts.addAll(response);
        //change(response, status: RxStatus.success());
      }
    } catch (e) {
      print(e);
      postLoadingStatus(LoadingStatus.error);
      //change(null, status: RxStatus.error());
    }
  }

  void setIndicatorIndex(int index) {
    _currentIndicatorIndex.value = index;
  }

  Future<bool> likePost({String forumId, String postId, bool isLiked}) async {
    if (await isAuth()) {
      //success
      final result = await _postRepository.reactionPost(forumId: forumId, postId: postId);
      if (result.status == 200) {
        return !isLiked;
      } else
        return isLiked;
    } else {
      //fail
      return isLiked;
    }
  }

  void refresh() async {
    final result = await _postRepository.getForumPost(forumId: _forumId, page: 1);
    if (result.isEmpty) {
      refreshController.refreshCompleted();
    } else {
      posts.clear();
      posts.addAll(result);
      refreshController.refreshCompleted();
    }
  }

  void loadMorePost() async {
    final newData =
        await _postRepository.getForumPost(forumId: _forumId, limit: 10, page: currentPage + 1);
    if (newData.isEmpty) {
      refreshController.loadNoData();
    } else {
      posts.addAllIf(newData.isNotEmpty, newData);
      _currentPage.value++;
      refreshController.loadComplete();
    }
  }

  void scrollToTop() {
    scrollController.animateTo(0, duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  }
}
