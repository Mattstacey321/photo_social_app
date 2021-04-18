import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../controllers/profile_controller.dart';

class ProfileDesktop extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}