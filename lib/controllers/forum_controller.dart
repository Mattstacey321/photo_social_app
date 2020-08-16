import 'package:get/get.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/forum_repository.dart';

class ForumController extends GetxController {
  static ForumController get to => Get.find();
  String forumId;
  ForumController({this.forumId});
  Rx<List<ForumModel>> forumsData = Rx<List<ForumModel>>();

  var _countForumPost = 0.obs;
  int get countPostForum => _countForumPost.value;
  int get countForum => forumsData.value.length;
  List<ForumModel> get forums => forumsData.value;

  @override
  void onReady() {
    intForum();
  }

  Future intForum() async {
    try {
      forumsData.value = (await ForumRepository.getForums());
      _countForumPost.value = await ForumRepository.countForumPost(forumId: forumId);
    } catch (e) {
      forumsData.value = [];
    }
  }

  Future loadMore() async {}
  Future refresh() async{}
}
