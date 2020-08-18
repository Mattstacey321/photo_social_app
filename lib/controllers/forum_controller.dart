import 'package:get/get.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/forum_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ForumController extends GetxController {
  String forumId;
  ForumController({this.forumId});

  static ForumController get to => Get.find();

  RxList<ForumModel> forumsData = List<ForumModel>().obs;
  var _currentPage = 1.obs;
  var _countForumPost = 0.obs;

  int get countPostForum => _countForumPost.value;
  int get countForum => forumsData.value.length;
  List<ForumModel> get forums => forumsData.value;
  int get currentPage => _currentPage.value;

  @override
  void onReady() {
    intForum();
  }

  void intForum() async {
    try {
      forumsData.value = (await ForumRepository.getForums(page: currentPage, limit: 10));
      _countForumPost.value = await ForumRepository.countForumPost(forumId: forumId);
    } catch (e) {
      forumsData.value = [];
    }
  }

  Future refresh(RefreshController controller) async {
    forumsData.clear();
    intForum();
    _currentPage.value = 1;
    controller.refreshCompleted();
  }

  Future loadMore(RefreshController controller) async {
    int nextPage = currentPage + 1;
    RxList<ForumModel> newData = List<ForumModel>().obs;

    newData.value = await ForumRepository.getForums(limit: 10, page: nextPage);
    if (newData.value.isEmpty) {
      controller.loadNoData();
    } else {
      forumsData.addAllIf(newData.value.isNotEmpty, newData.value);
      _currentPage.value++;
      controller.loadComplete();
    }
  }
}
