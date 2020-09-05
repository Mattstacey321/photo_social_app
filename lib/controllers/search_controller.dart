import 'package:get/get.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/repository/post_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchController extends GetxController {
  String hashtag = "";
  SearchController({this.hashtag});
  var listPost = List<PostModel>().obs;
  var controller = RefreshController();
  var _currentPage = 1.obs;
  @override
  void onInit() {
    initGetPostWithHashtag();
  }

  int get totalPost => listPost.length;

  void initGetPostWithHashtag() async {
    try {
      listPost.value = await PostRepository.getPostByHashTag(
          hashTag: this.hashtag, page: 1, limit: 10);
      print(listPost);
    } catch (e) {
      listPost.value = [];
    }
  }

  void loadMore() async {
    int nextPage = _currentPage.value + 1;
    RxList<PostModel> newData = RxList<PostModel>();

    newData.value =
        await PostRepository.getPostByHashTag(limit: 10, page: nextPage);
    if (newData.isEmpty) {
      controller.loadNoData();
    } else {
      listPost.addAllIf(newData.isNotEmpty, newData);
      _currentPage.value++;
      controller.loadComplete();
    }
  }

  void refresh() async {
    listPost.clear();
    initGetPostWithHashtag();
    _currentPage.value = 1;
    controller.refreshCompleted();
  }
}
