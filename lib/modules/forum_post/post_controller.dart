import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/utils/check_token.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'post_repository.dart';

class PostController extends GetxController {
  static PostController get to => Get.find();
  String _forumId;
  PostController({String forumId}) : _forumId = forumId;
  PostRepository _postRepository = PostRepository();
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();

  var postData = RxList<PostModel>();
  var _currentPage = 1.obs;
  var _currentIndicatorIndex = 0.obs;
  var loadingResult = LoadingStatus.loading.obs;

  @override
  void onInit() {
    initPost();
    super.onInit();
  }

  int get currentPage => _currentPage.value;
  int get currentIndicatorIndex => _currentIndicatorIndex.value;
  int get countPost => postData.length;

  void initPost() async {
    await _postRepository.getForumPost(forumId: _forumId, page: 1).then(
        (value) {
      postData.addAll(value);
      loadingResult(LoadingStatus.success);
    }, onError: (error) {
      print(error);
      loadingResult(LoadingStatus.error);
    });
  }

  void setIndicatorIndex(int index) {
    _currentIndicatorIndex.value = index;
  }

  Future<bool> likePost({String forumId, String postId, bool isLiked}) async {
    if (await isAuth()) {
      /*bool result =
          await PostRepository.likePost(forumId: forumId, postId: postId);*/
      //  update();
      //Get.defaultDialog(title: "Thanks");
      return !isLiked;
    } else {
      //once(_, callback)
      return isLiked;
    }
    //_isLike.value = await PostRepository.likePost(forumId: forumId, postId: postId);
  }

  void refresh() async {
    final result =
        await _postRepository.getForumPost(forumId: _forumId, page: 1);
    if (result.isEmpty) {
      refreshController.refreshCompleted();
    } else {
      postData.clear();
      postData.addAll(result);
      refreshController.refreshCompleted();
    }
  }

  void loadMorePost() async {
    final newData = await _postRepository.getForumPost(
        forumId: _forumId, limit: 10, page: currentPage + 1);
    if (newData.isEmpty) {
      refreshController.loadNoData();
    } else {
      postData.addAllIf(newData.isNotEmpty, newData);
      _currentPage.value++;
      refreshController.loadComplete();
    }
  }

  void scrollToTop() {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 350), curve: Curves.easeIn);
  }
}
