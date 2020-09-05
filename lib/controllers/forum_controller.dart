import 'package:get/get.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/forum_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumController extends GetxController {
  String forumId = "";
  ForumController({this.forumId});

  static ForumController get to => Get.find();

  var _forumsData = List<ForumModel>().obs;
  var _currentPage = 1.obs;
  var _countForumPost = 0.obs;

  int get countPostForum => _countForumPost.value;
  int get countForum => _forumsData.length;
  List<ForumModel> get forums => _forumsData;
  int get currentPage => _currentPage.value;

  @override
  void onReady() {
    initForum();
  }

  void initForum() async {
    try {
      _forumsData.value =
          await ForumRepository.getForums(page: currentPage, limit: 10);
      _countForumPost.value =
          await ForumRepository.countForumPost(forumId: forumId);
    } catch (e) {
      print(e);
      _forumsData.value = [];
    }
  }

  Future refresh(RefreshController controller) async {
    _forumsData.clear();
    initForum();
    _currentPage.value = 1;
    controller.refreshCompleted();
  }

  Future loadMore(RefreshController controller) async {
    int nextPage = currentPage + 1;
    RxList<ForumModel> newData = List<ForumModel>().obs;

    newData.value = await ForumRepository.getForums(limit: 10, page: nextPage);
    if (newData.isEmpty) {
      controller.loadNoData();
    } else {
      _forumsData.addAllIf(newData.isNotEmpty, newData);
      _currentPage.value++;
      controller.loadComplete();
    }
  }

  void sortList() {}
}
