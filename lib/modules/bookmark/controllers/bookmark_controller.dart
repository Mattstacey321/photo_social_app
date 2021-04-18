import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/collection_model.dart';
import '../../../data/repositories/bookmark_repository.dart';
import '../../../data/utils/check_token.dart';
import '../../../global_widgets/index.dart';
import '../../collection/controllers/collection_controller.dart';
class BookmarkController extends GetxController {
  static BookmarkController get to => Get.find();
  //String _namedRoute;
  BookmarkRepository _bookmarkRepository;
  BookmarkController({@required BookmarkRepository bookmarkRepository}) : _bookmarkRepository = bookmarkRepository;
  
  LoadingButtonController bookmarkCtrl = LoadingButtonController();
  TextEditingController collectionCtrl = TextEditingController();
  final receivePort = ReceivePort();
  Isolate _isolate;
  Isolate _isolateBookmark;

  var route = "".obs;

  var _postFirstImage = "".obs;

  var _postId = "".obs;

  var collectionSelected = <String>[].obs;

  var selectedItem = "".obs;

  var isCollectionNameValidated = false.obs;

  String get getPostFirstImage => _postFirstImage.value;
  String get postId => _postId.value;
  String get collectionName => collectionCtrl.text;
  // check for route redirect
  int get totalCollection => CollectionController.to.collectionLength;

  List<BookmarkCollectionModel> get collections =>
      CollectionController.to.collections;

  void selectCollection({String id}) {
    if (collectionSelected.where((value) => value == id).length > 0) {
      collectionSelected.removeWhere((value) => value == id);
    } else {
      collectionSelected.add(id);
    }
  }

  void setPostInfo({String id, String url}) {
    _postId.value = id;
    _postFirstImage.value = url;
  }

  Future bookmarkPost({String postId, @required String collectionName}) async {
    _isolateBookmark = await Isolate.spawn((message) async {
      var result = await _bookmarkRepository.bookmarkPost(
          postId: postId, collectionName: collectionName);
      if (result.status == 200) {
        bookmarkCtrl.success();
        return true;
      } else {
        bookmarkCtrl.error();
        return false;
      }
    }, receivePort);
    receivePort.listen((message) {
      print(message);
    });
  }

  Future unBookmarkPost({String postId}) async {
    _isolate = await Isolate.spawn((message) async {
      int status = (await _bookmarkRepository.bookmarkPost(
        postId: postId,
        collectionName: collectionName,
      ))
          .status;
      if (await isAuth() && status == 200) {
        return true;
      } else {
        return false;
      }
    }, receivePort);
    receivePort.listen((message) {
      print(message);
    });
  }

  Future addToNewCollection() async {
    try {
      bool result = await this.bookmarkPost(
        postId: postId,
        collectionName: collectionName,
      );
      if (result == true) {
        Future.delayed(Duration(seconds: 2), () => Get.back(result: true));
      } else {}
    } catch (e) {}
  }

  Future addToExistingCollection() async {
    try {
      var result = await _bookmarkRepository.bookmarkToExistingCollection(
          postId: postId, collectionIds: collectionSelected);
      if (result.success == true) {
        bookmarkCtrl.success();
        Future.delayed(Duration(seconds: 2), () => Get.back(result: true));
        requestRefresh();
      } else {}
    } catch (e) {
      print("bookmark error $e");
      bookmarkCtrl.reset();
    }
  }

  void validateCollectionName(String text) {
    if (text.isEmpty) {
      isCollectionNameValidated.value = false;
    } else
      isCollectionNameValidated.value = true;
  }

  void requestRefresh() {
    CollectionController.to.refreshController.requestRefresh();
  }

  void requestCollectionId() {
    collectionSelected
        .addAll(CollectionController.to.collections.map((e) => e.id));
  }

  /*void getNamedRoute() {
    route.value = _namedRoute;
  }*/

  @override
  void onReady() {
    // add already collection id
    requestCollectionId();
    //getNamedRoute();
    super.onReady();
  }
}
