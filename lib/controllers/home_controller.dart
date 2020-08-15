import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/repository/forum_repository.dart';
import 'package:photo_social/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  //Rx<PhotoModel> data = Rx<PhotoModel>();
  Rx<List<ForumModel>> _forumsData = Rx<List<ForumModel>>();
  RxBool _isSkipLogin = false.obs;

  bool get loginAsGuest => _isSkipLogin.value;
  int get countForum => _forumsData.value.length;
  List<ForumModel> get forumsData => _forumsData.value;

  @override
  void onReady() {
    intForum();
    bool isSkipLogin = Get.find<SharedPreferences>().getBool("isSkipLogin");
    _isSkipLogin.value = isSkipLogin;
    isSkipLogin
        ? BotToast.showText(
            text: "You are now sign in as guest",
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            align: Alignment.bottomCenter,
            duration: Duration(seconds: 2),
          )
        : BotToast.showText(
            text: "Wellcome back, ABCDEF",
            align: Alignment.bottomCenter,
            duration: Duration(seconds: 1),
          );
  }

  Future intForum() async {
    _forumsData.value = (await ForumRepository.getForums());
  }

  String getAvatar() {
    if (loginAsGuest) {
      return UserRepository.signInAsGuest();
    } else {
      return UserRepository.signInAsGuest();
    }
  }
}
