import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  PageController pageController = PageController();
  int pageIndex = 0;
  PostDetailController({this.pageIndex});
  @override
  void onReady() {
    pageController.animateToPage(this.pageIndex,
        curve: Curves.fastLinearToSlowEaseIn, duration: Duration(milliseconds: 200));
  }
}
