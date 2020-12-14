import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/modules/collection/collection_repository.dart';
import 'package:photo_social/src/enum/index.dart';
import 'package:photo_social/widgets/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectionDetailController extends GetxController {
  static const String COLLECTIONDETAIL = "collection-detail";
  String _collectionId;
  CollectionDetailController({String collectionId})
      : _collectionId = collectionId;
  RefreshController refreshController = RefreshController();
  CollectionRepository _collectionRepository = CollectionRepository();
  LoadingButtonController deleteBookmarkCtrl = LoadingButtonController();
  var postList = <PostModel>[].obs;
  var deleteSelectedPost = <PostModel>[].obs;
  var totaldeleteSelectedPost = 0.obs;
  var loadingResult = LoadingStatus.loading.obs;
  var pageIndex = 1.obs;
  var multiSelected = false.obs;

  int get page => pageIndex.value;

  @override
  void onReady() {
    super.onReady();
    initPost();
  }

  void initPost() async {
    try {
      List<PostModel> result = await _collectionRepository.getCollectionDetail(
          collectionId: _collectionId, page: 1);
      postList.addAllNonNull(result);
      loadingResult(LoadingStatus.success);
    } catch (e) {
      loadingResult(LoadingStatus.error);
    }
  }

  void refresh() {
    postList.clear();
    initPost();
    refreshController.refreshCompleted();
  }

  void loadMore() async {
    try {
      List<PostModel> result = await _collectionRepository.getCollectionDetail(
          collectionId: _collectionId, page: page);
      if (result.isEmpty) {
        refreshController.loadNoData();
      } else {
        postList.addAllNonNull(result);
        pageIndex.value++;
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
    }
  }

  void multipleSelectedMode() {
    multiSelected.value = !multiSelected.value;
  }

  void selectItem(int index) {
    if (deleteSelectedPost
        .any((item) => item.postId == postList[index].postId)) {
      postList[index].isSelected = !postList[index].isSelected;
      deleteSelectedPost
          .removeWhere((value) => value.postId == postList[index].postId);
    } else {
      postList[index].isSelected = !postList[index].isSelected;
      deleteSelectedPost.add(postList[index]);
    }
    update([COLLECTIONDETAIL]);
    totaldeleteSelectedPost.value = deleteSelectedPost.length;
    if (totaldeleteSelectedPost.value == 0) multiSelected.value = false;
  }

  void cancelMultipleSelectedMode() {
    multiSelected.value = false;
    deleteSelectedPost.clear();
    totaldeleteSelectedPost.value = 0;

    for (var item in postList) {
      item.isSelected = false;
    }

    deleteBookmarkCtrl.idle();

    update([COLLECTIONDETAIL]);
  }

  void removePost() async {
    deleteBookmarkCtrl.start();
    final result = await _collectionRepository.removeCollectionItem(
      postIds: deleteSelectedPost.map((e) => e.postId).toList(),
      collectionId: _collectionId,
    );
    if (result.success) {
      // remove local
      //postList.removeWhere((e) => deleteSelectedPost.contains(e.postId));
      deleteBookmarkCtrl.success();
      cancelMultipleSelectedMode();
      updateData();
      // notify update successful
      BotToast.showText(text: "Deleted post success");
    } else {
      deleteBookmarkCtrl.error();
      BotToast.showText(text: "Deleted post fail. Try again");
    }
  }

  void updateData() {
    // update data when remove item, local only
    // update list
    postList.refresh();
    CollectionController.to.collections.refresh();
  }
}
