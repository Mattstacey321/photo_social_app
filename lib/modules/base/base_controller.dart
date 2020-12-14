import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/account/account_root.dart';
import 'package:photo_social/modules/app_screen.dart';

class BaseController extends GetxController {
  PageController pageController = PageController();
  static BaseController get to => Get.find();
  var currentIndex = 0.obs;
  List<Widget> pages;

  @override
  void onInit() {
    pages = [
      Home(),
      BookmarkRoot(),
      ProfileRoot(),
    ];
    super.onInit();
  }

  void changePage(int index) {
    currentIndex.value = index;
  }
}
