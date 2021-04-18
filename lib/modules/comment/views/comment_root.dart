import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/utils/nested_key.dart';

import '../controllers/comment_controller.dart';
import '../navigator/list_comment.dart';
import '../navigator/reply_comment.dart';
import '../widgets/comment_input.dart';

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
                  key: Get.nestedKey(NestedKey.comment),
                  initialRoute: "/comment",
                  onPopPage: (route, result) {
                    print(route);
                    if (!route.didPop(result)) return false;
                    return true;
                  },
                  onGenerateRoute: (settings) {
                    if (settings.name == "/comment") {
                      return GetPageRoute(
                        routeName: "comment",
                        page: () => CommentList(),
                      );
                    } else if (settings.name == "/reply")
                      return GetPageRoute(
                        routeName: "reply",
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
