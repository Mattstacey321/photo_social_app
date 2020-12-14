import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/widgets/index.dart';

import '../comment_controller.dart';

class CommentInput extends GetView<CommentController> {
  @override
  Widget build(BuildContext context) {
    CommentController _ = controller;
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
              controller: _.commentCtrl,
              decoration: InputDecoration.collapsed(
                hintText: "What do you think ?",
              ),
            ),
          ),
          CircleIcon(
              onTap: () {
                _.addComment().then(
                      (value) => BotToast.showText(
                        text: "Comment Success",
                      ),
                      onError: (err) =>
                          BotToast.showText(text: "Comment fail. Try again"),
                    );
              },
              child: Icon(EvaIcons.cornerDownLeft))
        ],
      ),
    );
  }
}
