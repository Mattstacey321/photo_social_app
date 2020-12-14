import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:photo_social/utils/nested_key.dart';

import 'comment_controller.dart';
import 'navigator/comment_list.dart';
import 'navigator/reply_comment.dart';
import 'widgets/comment_input.dart';

class CommentRoot extends StatefulWidget {
  final String postId;
  CommentRoot({@required this.postId});
  @override
  CommentRootState createState() => CommentRootState();
}

class CommentRootState extends State<CommentRoot> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      init: CommentController(postId: widget.postId),
      builder: (controller) {
        return Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: <Widget>[
              Flexible(
                child: Navigator(
                  initialRoute: "/",
                  key: Get.nestedKey(NestedKey.comment),
                  /*pages: [
                    MaterialPage(child: CommentList()),
                    MaterialPage(child: ReplyComment())
                  ],*/
                  onPopPage: (route, result) {
                    print(route);
                    if (!route.didPop(result)) return false;
                    return true;
                  },
                  onGenerateRoute: (settings) {
                    if (settings.name == "/") {
                      return GetPageRoute(page: () => CommentList());
                    } else if (settings.name == "/detail")
                      return GetPageRoute(
                        page: () => ReplyComment(
                          comment: settings.arguments,
                        ),
                      );
                    throw Exception('Invalid route: ${settings.name}');
                  },
                ),
              ),
              CommentInput()
            ],
          ),
        );
      },
    );
  }
}
