import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/forum_model.dart';
import '../../../data/models/hash_tag_model.dart';
import '../../../data/repositories/forum_repository.dart';
import '../../../src/enum/index.dart';

class ForumController extends GetxController {
  static ForumController get to => Get.find();
  final ForumRepository _forumRepository;
  ForumController({@required ForumRepository forumRepository}) : _forumRepository = forumRepository;
  
  var refreshController = RefreshController();
  var forums = <ForumModel>[].obs;
  var hashTags = <HashTagModel>[].obs;
  var _currentPage = 1.obs;
  var forumStatus = LoadingStatus.loading.obs;
  var hashTagStatus = LoadingStatus.loading.obs;

  int get countPostForum => hashTags.length;
  int get countForum => forums.length;
  int get countHashTag => hashTags.length;
  int get currentPage => _currentPage.value;

  @override
  void onReady() {
    initForum();
    super.onReady();
  }

  void initForum() async {
    try {
      final result = await _forumRepository.getForum(page: currentPage, limit: 10);
      if (result.isEmpty) {
        forumStatus(LoadingStatus.empty);
      } else {
        forums.addAll(result);
        forumStatus(LoadingStatus.success);
      }
    } catch (e) {
      forumStatus(LoadingStatus.error);
    }
  }

  void refresh() {
    forums.clear();
    initForum();
    _currentPage.value = 1;
    refreshController.refreshCompleted();
  }

  void loadMore() async {
    int nextPage = currentPage + 1;

    var result = await _forumRepository.getForum(limit: 10, page: nextPage);
    if (result.isEmpty) {
      refreshController.loadNoData();
    } else {
      forums.addAll(result);
      _currentPage.value++;
      refreshController.loadComplete();
    }
  }

  void sortList() {}
}
