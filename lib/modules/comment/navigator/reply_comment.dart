import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/comment_model.dart';
import '../../../global_widgets/index.dart';
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
