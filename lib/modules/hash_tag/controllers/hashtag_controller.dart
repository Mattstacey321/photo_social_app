import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/hash_tag_model.dart';
import '../../../data/repositories/hashtag_repository.dart';
import '../../../src/enum/enum_loading.dart';
import '../../base/controllers/base_controller.dart';

class HashTagController extends GetxController {
  static HashTagController get to => Get.find();
  final HashTagRepository _hashTagRepository;
  HashTagController({@required HashTagRepository hashTagRepository})
      : _hashTagRepository = hashTagRepository;
  var controller = RefreshController();

  var loadingStatus = LoadingStatus.loading.obs;
  var hashTags = <HashTagModel>[].obs;
  var selectHashTag = <HashTagModel>[].obs;
  var oldSelected = <HashTagModel>[].obs;

  void initHashTag() async {
    try {
      final result = await _hashTagRepository.getHashTag();
      hashTags.addAll(result);
      loadingStatus(LoadingStatus.success);
    } catch (e) {
      loadingStatus(LoadingStatus.error);
    }
  }

  void deselectedHashTag() {
    selectHashTag.clear();
    oldSelected.clear();
  }

  void selectedHashTag(int index) {
    oldSelected.assignAll(selectHashTag);
    selectHashTag.assign(hashTags[index]);

    BaseController.to.addHashTagPage(
      hashTag: hashTags[index].hashtag,
      oldHashTag: oldSelected.isEmpty ? "" : oldSelected.first.hashtag,
      hideHashTag: true,
    );
  }

  @override
  void onInit() {
    initHashTag();
    super.onInit();
  }
}
