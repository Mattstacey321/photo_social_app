import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/startup_controller.dart';

class StartUpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<StartUpController>(
      init: StartUpController(),
      builder: (_) => Container(
        height: Get.height,
        width: Get.width,
      ),
    ));
  }
}
