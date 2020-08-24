import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  CarouselController buttonCarouselController = CarouselController();
  int pageIndex = 0;
  PostDetailController({this.pageIndex});
  @override
  void onReady() {
    buttonCarouselController.animateToPage(this.pageIndex,curve: Curves.fastLinearToSlowEaseIn,duration: Duration(milliseconds: 200));
  }
}
