import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/models/collection_model.dart';
import '../../../data/repositories/collection_repository.dart';
import '../../../global_widgets/index.dart';
import '../../../src/enum/index.dart';

class CollectionController extends GetxController {
  static CollectionController get to => Get.find();
  static const COLLECTION = "collection";
  final CollectionRepository _collectionRepository;
  CollectionController({@required CollectionRepository collectionRepository})
      : _collectionRepository = collectionRepository;
  RefreshController refreshController = RefreshController();
  LoadingButtonController deleteBookmarkCtrl = LoadingButtonController();
  var collections = <BookmarkCollectionModel>[].obs;

  var loadingResult = LoadingStatus.loading.obs;
  var selectedCollection = <BookmarkCollectionModel>[].obs;
  // deleted collection ...
  var deleteSelectedCollection = <BookmarkCollectionModel>[].obs;
  // multiple selected mode
  var multiSelected = false.obs;
  var totalDeletedCollection = 0.obs;
  var collectionSelected = <String>[].obs;
  var currentPage = 0.obs;
  var isCollectionNameValidated = false.obs;

  int get collectionLength => collections.length;
  //String get postId => _postId.value;
  //Widget get page => ProfileController.to.isGuest ? GuestBookmark() : CollectionsRoot();

  void loadSavedPost() async {
    try {
      var result = await _collectionRepository.getBookmarkCollection(page: 1);
      collections.assignAll(result);
      loadingResult(LoadingStatus.success);
      refreshController.refreshCompleted();
    } catch (e) {
      loadingResult(LoadingStatus.error);
      refreshController.refreshFailed();
    }
  }

  void refresh() async {
    try {
      final result =
          await _collectionRepository.getBookmarkCollection(page: 1);
      if (result.isEmpty) {
        refreshController.refreshCompleted();
      } else {
        collections.assignAll(result);
        refreshController.refreshCompleted();
      }
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  void loadMore() async {
    refreshController.loadNoData();
  }

  void selectCollection({String id}) {
    if (collectionSelected.where((value) => value == id).length > 0) {
      collectionSelected.removeWhere((value) => value == id);
    } else {
      collectionSelected.add(id);
    }
  }

  void selectItem(int index) {
    if (deleteSelectedCollection.any((item) => item.id == collections[index].id)) {
      collections[index].isSelected = !collections[index].isSelected;
      deleteSelectedCollection.removeWhere((value) => value.id == collections[index].id);
    } else {
      collections[index].isSelected = !collections[index].isSelected;
      deleteSelectedCollection.add(collections[index]);
    }

    totalDeletedCollection.value = deleteSelectedCollection.length;
    if (totalDeletedCollection.value == 0) multiSelected.value = false;
    update([COLLECTION]);
  }

  void multipleSelectedMode() {
    multiSelected.value = !multiSelected.value;
  }

  void cancelMultipleSelectedMode() {
    multiSelected.value = false;
    deleteSelectedCollection.clear();
    totalDeletedCollection.value = 0;
    deleteBookmarkCtrl.reset();
    for (var item in collections) {
      item.isSelected = false;
    }
    update([COLLECTION]);
  }

  void removeCollection() async {
    //TODO: remove collection
    for (var i in deleteSelectedCollection) {
      //print(i.name);
    }
    try {
      var result = await _collectionRepository.removeMultipleCollection(
          collectionIds: deleteSelectedCollection.map((item) => item.id).toList());
      if (result.success == true) {
        deleteBookmarkCtrl.success();
        multiSelected.value = false;
        updateData();
      }
    } catch (_) {
      deleteBookmarkCtrl.reset();
    }
  }

  Future addToNewCollection() async {
    /* try {
      bool result = await this.bookmarkPost(
        postId: postId,
        collectionName: collectionName,
      );
      if (result == true) {
        Future.delayed(Duration(seconds: 2), () => Get.back(result: true));
      } else {}
    } catch (e) {}*/
  }

  /*Future addToExistingCollection() async {
    for (var i = 0; i < collectionSelected.length; i++) {
      print(collectionSelected[i]);
    }
    try {
      var result = await _collectionRepository.bookmarkToExistingCollection(
          postId: postId, collectionIds: collectionSelected);
      if (result.success == true) {
        bookmarkCtrl.success();
        Future.delayed(Duration(seconds: 2), () => Get.back(result: true));
      } else {}
    } catch (e) {
      bookmarkCtrl.reset();
    }
  }*/

  void updateData() {
    // update local list
    collections.refresh();
    //refreshController.requestRefresh();
  }

  @override
  void onReady() {
    loadSavedPost();
    super.onReady();
  }
}
