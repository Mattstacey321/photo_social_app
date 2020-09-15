import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/repository/post_repository.dart';
import 'package:photo_social/utils/check_token.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class PostController extends GetxController {
  String forumId = "";
  PostController({this.forumId});
  RefreshController refreshController = RefreshController();
  ScrollController pageIndexController = ScrollController();
  RxList<PostModel> postData = List<PostModel>().obs;
  var _currentPage = 1.obs;
  var _currentIndicatorIndex = 0.obs;
  var _isLike = false.obs;

  @override
  void onReady() {
    initPost();
  }

  @override
  void onInit() {}
  int get currentPage => _currentPage.value;
  int get currentIndicatorIndex => _currentIndicatorIndex.value;
  bool get isLike => _isLike.value;

  void initPost() async {
    refreshController.requestRefresh();
    postData.value = await PostRepository.getForumPost(
        forumId: forumId, page: currentPage, limit: 10);
    if (postData.isEmpty) {
      refreshController.loadNoData();
    }
    refreshController.refreshCompleted();
  }

  int get countPost => postData.length;

  void setIndicatorIndex(int index) {
    _currentIndicatorIndex.value = index;
  }

  Future<bool> likePost({String forumId, String postId, bool isLiked}) async {
    if (await isAuth()) {
      // _isLike.value =
      //     await PostRepository.likePost(forumId: forumId, postId: postId);
      //  update();
      //Get.defaultDialog(title: "Thanks");
      return !isLiked;
    } else {
      //once(_, callback)
      return !isLiked;
    }
    //_isLike.value = await PostRepository.likePost(forumId: forumId, postId: postId);
  }

  void refresh() async {
    postData.clear();
    initPost();
    _currentPage.value = 1;
  }

  void loadMorePost() async {
    int nextPage = currentPage + 1;
    RxList<PostModel> newData = List<PostModel>().obs;

    newData.value = await PostRepository.getForumPost(
        forumId: forumId, limit: 10, page: nextPage);
    if (newData.isEmpty) {
      refreshController.loadNoData();
    } else {
      postData.addAllIf(newData.isNotEmpty, newData);
      _currentPage.value++;
      refreshController.loadComplete();
    }
  }

  void getImageInfo() {}

  void _launchApp([String url, String fallbackUrl = ""]) async {
    try {
      bool launched =
          await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      //BotToast.showText(text: "Can not open url");
    }
  }

  void openInFacebook({String id = ""}) async {
    String url = "https://www.facebook.com/$id";
    String fallbackUrl = "fb://profile/$id";
    _launchApp(url, fallbackUrl);
  }

  void openInInstagram({String id = ""}) async {
    String url = "https://www.instagram.com/$id";
    _launchApp(url);
  }

  void openInTwitter({String id = ""}) async {
    String url = "https://twitter.com/$id";
    _launchApp(url);
  }
}
