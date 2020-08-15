import 'package:get/get.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/repository/post_repository.dart';

class ForumController extends GetxController {
  String forumId;
  ForumController({this.forumId});
  Rx<List<PostModel>> postData = Rx<List<PostModel>>();
  @override
  void onReady() {
    loadPost();
  }

  int get countPost => postData.value.length ;

  void loadPost() async {
    postData.value = await PostRepository.getForumPost(forumId: forumId, page: 1, limit: 10);
  }

  void loadMore() async {}

  
}
