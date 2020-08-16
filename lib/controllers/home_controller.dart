import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/forum_controller.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/forum_repository.dart';
import 'package:photo_social/repository/user_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RefreshController refreshController = RefreshController();
  //Rx<PhotoModel> data = Rx<PhotoModel>();
  RxBool _isSkipLogin = false.obs;

  bool get loginAsGuest => _isSkipLogin.value;

  int get countPostForum => ForumController.to.countPostForum;
  int get countForum => ForumController.to.countForum;
  List<ForumModel> get forumsData => ForumController.to.forums;

  @override
  void onReady() {
    //ForumController.to.intForum();
    bool isSkipLogin = Get.find<SharedPreferences>().getBool("isSkipLogin");
    _isSkipLogin.value = isSkipLogin;
    isSkipLogin
        ? BotToast.showText(
            text: "You are now sign in as guest",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            borderRadius: BorderRadius.circular(10),
            align: Alignment.bottomCenter,
            duration: Duration(seconds: 2),
          )
        : BotToast.showText(
            text: "Wellcome back, ABCDEF",
            borderRadius: BorderRadius.circular(10),
            align: Alignment.bottomCenter,
            duration: Duration(seconds: 1),
          );
  }

  String getAvatar() {
    if (loginAsGuest) {
      return UserRepository.signInAsGuest();
    } else {
      return UserRepository.signInAsGuest();
    }
  }
}
