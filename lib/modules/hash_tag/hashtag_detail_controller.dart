import 'package:get/get.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/modules/hash_tag/hashtag_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HashTagDetailController extends GetxController {
  final String _hashtag;
  HashTagDetailController({String hashtag}) : _hashtag = hashtag;
  HashTagRepository _hashTagRepository = HashTagRepository();
  RxList<PostModel> listPost = RxList<PostModel>();
  RefreshController controller = RefreshController();
  RxInt _currentPage = 1.obs;

  @override
  void onInit() {
    initGetPostWithHashtag();
    super.onInit();
  }

  void initGetPostWithHashtag() async {
    try {
      final result =
          await _hashTagRepository.getPostByHashTag(hashTag: _hashtag, page: 1);
      listPost.assignAll(result);
    } catch (e) {}
  }

  void loadMore() async {
    int nextPage = _currentPage.value + 1;

    final result = await _hashTagRepository.getPostByHashTag(
        hashTag: _hashtag, page: nextPage);
    if (result.isEmpty) {
      controller.loadNoData();
    } else {
      listPost.addAllNonNull(result);
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
