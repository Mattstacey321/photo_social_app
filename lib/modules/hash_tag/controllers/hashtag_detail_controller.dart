import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/api/graphql.dart';
import '../../../data/models/post_model.dart';
import '../../../data/repositories/hashtag_repository.dart';
import '../../../src/enum/enum_loading.dart';

class HashTagDetailController extends GetxController {
  static HashTagDetailController get to => Get.find();
  final String _hashtag;
  HashTagDetailController({String hashtag}) : _hashtag = hashtag;
  HashTagRepository _hashTagRepository =
      HashTagRepository(client: Get.find<GraphQL>().selectClient);
  RefreshController controller = RefreshController();
  var scrollController = ScrollController();
  var posts = <PostModel>[].obs;
  var _currentPage = 1.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  @override
  void onInit() {
    initPostWithHashtag();
    super.onInit();
  }

  void initPostWithHashtag() async {
    try {
      final result = await _hashTagRepository.getPostByHashTag(hashTag: _hashtag, page: 1);
      if (result.isEmpty) {
        loadingStatus(LoadingStatus.empty);
      }
      posts.assignAll(result);
      loadingStatus(LoadingStatus.success);
    } catch (e) {
      loadingStatus(LoadingStatus.error);
    }
    update(["hash-tag-detail"]);
  }

  void loadMore() async {
    int nextPage = _currentPage.value + 1;

    final result = await _hashTagRepository.getPostByHashTag(hashTag: _hashtag, page: nextPage);
    if (result.isEmpty) {
      controller.loadNoData();
    } else {
      posts.addAll(result);
      _currentPage.value++;
      controller.loadComplete();
    }
    update(["hash-tag-detail"]);
  }

  void refresh() async {
    posts.clear();
    //change(null, status: RxStatus.loading());
    initPostWithHashtag();
    _currentPage.value = 1;
    controller.refreshCompleted();
  }
}
