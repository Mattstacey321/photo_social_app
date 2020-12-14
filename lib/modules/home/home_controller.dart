import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/account/account_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RefreshController refreshController = RefreshController();
  var isCollapsed = false.obs;

  /*int get countPostForum => ForumController.to.countPostForum;
  int get countForum => ForumController.to.countForum;
  int get countHashTag => ForumController.to.countHashTag;*/

  /*get curentVersion async => await UpdateRepository.getAppVersion();
  get latestVersion async => await UpdateRepository.getUpdateFromServer()
    ..version;*/

  @override
  void onReady() {
    notifyUserLogin();
    super.onReady();
  }

  void notifyUserLogin() {
    bool hasLogin = AccountController.to.hasSession;
    !hasLogin
        ? BotToast.showText(
            text: "You are now sign in as guest",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            borderRadius: BorderRadius.circular(10),
            align: Alignment(0, 0.9),
            duration: Duration(seconds: 2),
          )
        : BotToast.showText(
            text: "Wellcome back, ${AccountController.to.userName}",
            borderRadius: BorderRadius.circular(10),
            align: Alignment(0, 0.9),
            duration: Duration(seconds: 2),
          );
  }

  void openSideBar() {
    isCollapsed.value = !isCollapsed.value;
  }
}
