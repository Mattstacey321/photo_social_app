import 'package:get/get.dart';
import 'package:photo_social/models/forum_model.dart';
import 'package:photo_social/models/hash_tag_model.dart';
import 'package:photo_social/modules/forum/forum_repository.dart';
import 'package:photo_social/src/enum/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumController extends GetxController {
  static ForumController get to => Get.find();
  ForumRepository _forumRepository = ForumRepository();
  RefreshController refreshController = RefreshController();

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
    initHashTag();
    super.onReady();
  }

  void initHashTag() async {
    try {
      var result = await _forumRepository.getHashTagStats();
      if (hashTags.isEmpty) {
        refreshController.refreshToIdle();
      }
      hashTags.addAllNonNull(result);
      refreshController.refreshCompleted();
      hashTagStatus(LoadingStatus.success);
    } catch (e) {
      refreshController.refreshFailed();
      hashTagStatus(LoadingStatus.error);
    }
  }

  void initForum() async {
    try {
      var result =
          await _forumRepository.getForum(page: currentPage, limit: 10);
      if (result.isEmpty) {
        forumStatus(LoadingStatus.success);
      } else {
        forums.addAllNonNull(result);
        forumStatus(LoadingStatus.success);
      }
    } catch (e) {
      print(e);
      forumStatus(LoadingStatus.error);
    }
  }

  void refresh({RefreshController controllers}) async {
    forums.clear();
    initForum();
    _currentPage.value = 1;
    controllers.refreshCompleted();
  }

  void loadMore() async {
    int nextPage = currentPage + 1;

    var result = await _forumRepository.getForum(limit: 10, page: nextPage);
    if (result.isEmpty) {
      refreshController.loadNoData();
    } else {
      forums.addAllNonNull(result);
      _currentPage.value++;
      refreshController.loadComplete();
    }
  }

  void sortList() {}
}
