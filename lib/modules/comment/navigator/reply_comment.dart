import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/comment_model.dart';
import 'package:photo_social/widgets/app_bar/custom_appBar.dart';

import '../widgets/comment_item.dart';

class ReplyComment extends StatelessWidget {
  final CommentModel comment;
  ReplyComment({this.comment});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [Text("Reply")],
        onTapBack: () {
          Get.back(id: 2);
        },
      ),
      body: Center(
        child: comment == null
            ? CircularProgressIndicator()
            : Container(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: <Widget>[
                    CommentItem(
                      comment: comment,
                      onCommentSetting: () {},
                      onLiked: () {},
                      onReply: () {
                        //tag system
                      },
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
