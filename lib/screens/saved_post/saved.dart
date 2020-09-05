import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/save_post.dart';
import 'package:photo_social/widgets/custom_appBar.dart';

class SavedPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          childs: [Text("Saved Post")],
          onTapBack: () {
            Get.back();
          }),
      body: GetBuilder<SavedPostController>(
        init: SavedPostController(),
        builder: (_) {
          return Container(
            height: Get.height,
            width: Get.width,
            child: Column(children: []),
          );
        },
      ),
    );
  }
}
