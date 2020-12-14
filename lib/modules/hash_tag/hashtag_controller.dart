import 'package:get/get.dart';
import 'package:photo_social/models/hash_tag_model.dart';
import 'package:photo_social/modules/hash_tag/hashtag_repository.dart';
import 'package:photo_social/src/enum/enum_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HashTagController extends GetxController {
  static HashTagController get to => Get.find();
  HashTagRepository _hashTagRepository = HashTagRepository();
  RefreshController controller = RefreshController();

  var loadingStatus = LoadingStatus.loading.obs;
  var hashTags = RxList<HashTagModel>();

  int get countHashTag => hashTags.length;

  void initHashTag() async {
    try {
      final result = await _hashTagRepository.getHashTag();
      hashTags.addAllNonNull(result);
      loadingStatus(LoadingStatus.success);
    } catch (e) {
      loadingStatus(LoadingStatus.error);
    }
  }

  @override
  void onInit() {
    initHashTag();
    super.onInit();
  }
}
