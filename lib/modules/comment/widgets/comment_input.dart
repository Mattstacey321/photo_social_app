import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../controllers/comment_controller.dart';

class CommentInput extends GetView<CommentController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.commentCtrl,
              decoration: InputDecoration.collapsed(
                hintText: "What do you think ?",
              ),
            ),
          ),
          CircleIcon(
              onTap: () {
                controller.addComment();
              },
              tooltip: "Comment",
              icon: Icon(EvaIcons.cornerDownLeft))
        ],
      ),
    );
  }
}
