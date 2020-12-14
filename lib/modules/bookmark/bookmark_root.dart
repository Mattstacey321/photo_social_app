import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';

class BookmarkRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionController>(
      init: CollectionController(),
      autoRemove: false,
      assignId: true,
      id: "collection",
      builder: (controller) {
        return Scaffold(
          body: controller.page,
        );
      },
    );
  }
}
