import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/app_screen.dart';
import 'package:photo_social/modules/theme/theme_controller.dart';

Future showComment({@required String postId}) async {
  Get.bottomSheet(
    CommentRoot(
      postId: postId,
    ),
    backgroundColor: ThemeController.to.colorScheme,
    elevation: 1,
    isDismissible: true,
    persistent: true,
    ignoreSafeArea: false,
    isScrollControlled: true,
    enterBottomSheetDuration: Duration(milliseconds: 200),
    exitBottomSheetDuration: Duration(milliseconds: 200),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
  );
}
