import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController with SingleGetTickerProviderMixin {
  static AuthController get to => Get.find();
  TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void goToRegister() {
    tabController.animateTo(1);
  }
}
