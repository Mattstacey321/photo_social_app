import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/controllers/forum_controller.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/update_repository.dart';
import 'package:photo_social/repository/user_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RefreshController refreshController = RefreshController();
  RxBool _isSkipLogin = false.obs;
  RxBool isCollapsed = false.obs;
  bool get loginAsGuest => _isSkipLogin.value;

  int get countPostForum => ForumController.to.countPostForum;
  int get countForum => ForumController.to.countForum;
  List<ForumModel> get forumsData => ForumController.to.forums;

  refreshForum() => ForumController.to.refresh(refreshController);
  loadMoreForum() => ForumController.to.loadMore(refreshController);

  get curentVersion async => await UpdateRepository.getAppVersion();
  get latestVersion async => await UpdateRepository.getUpdateFromServer()
    ..version;

  @override
  void onReady() {
    bool isSkipLogin = PreferencesController.getPrefs.getBool("isSkipLogin");
    _isSkipLogin.value = isSkipLogin;
    isSkipLogin
        ? BotToast.showText(
            text: "You are now sign in as guest",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            borderRadius: BorderRadius.circular(10),
            align: Alignment(0, 0.9),
            duration: Duration(seconds: 2),
          )
        : BotToast.showText(
            text: "Wellcome back, ABCDEF",
            borderRadius: BorderRadius.circular(10),
            align: Alignment(0, 0.9),
            duration: Duration(seconds: 2),
          );
  }

  void openSideBar() {
    isCollapsed.value = !isCollapsed.value;
  }

  String getAvatar() {
    if (loginAsGuest) {
      return UserRepository.signInAsGuest();
    } else {
      return UserRepository.signInAsGuest();
    }
  }

  void skipUpdate() {
    PreferencesController.getPrefs.setBool("installLater", true);
    Get.back();
  }
}
