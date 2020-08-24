import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/repository/post_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostController extends GetxController {
  String forumId = "";
  PostController({this.forumId});
  RefreshController refreshController = RefreshController();
  ScrollController pageIndexController = ScrollController();
  RxList<PostModel> postData = List<PostModel>().obs;
  var _currentPage = 1.obs;
  var _currentIndicatorIndex = 0.obs;

  @override
  void onReady() {
    initPost();
  }

  @override
  void onInit() {}
  int get currentPage => _currentPage.value;
  int get currentIndicatorIndex => _currentIndicatorIndex.value;

  void initPost() async {
    refreshController.requestRefresh();
    postData.value =
        await PostRepository.getForumPost(forumId: forumId, page: currentPage, limit: 10);
    if (postData.isEmpty) {
      refreshController.loadNoData();
    }
    refreshController.refreshCompleted();
  }

  int get countPost => postData.value.length;

  void setIndicatorIndex(int index) {
    _currentIndicatorIndex.value = index;
  }

  void likePost({String postId}) async {}

  void refresh() async {
    postData.clear();
    initPost();
    _currentPage.value = 1;
  }

  void loadMorePost() async {
    int nextPage = currentPage + 1;
    RxList<PostModel> newData = List<PostModel>().obs;

    newData.value = await PostRepository.getForumPost(forumId: forumId, limit: 10, page: nextPage);
    if (newData.value.isEmpty) {
      refreshController.loadNoData();
    } else {
      postData.addAllIf(newData.value.isNotEmpty, newData.value);
      _currentPage.value++;
      refreshController.loadComplete();
    }
  }

  void getImageInfo() {}
}
