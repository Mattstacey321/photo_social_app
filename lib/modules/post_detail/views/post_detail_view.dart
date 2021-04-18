import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/post_model.dart';
import '../controllers/post_detail_controller.dart';
import '../widgets/post_image_galery.dart';
import 'comment_view.dart';

class PostDetailView extends StatelessWidget {
  final String postId;
  final int index;
  final List<Media> media;
  PostDetailView({@required this.postId, this.index = 0, this.media});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostDetailController(imageIndex: index, postId: postId));
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Container(
        width: context.width,
        height: context.height,
        child: Stack(
          children: [
            AnimatedPositioned(
              right: 0,
              child: CommentView(postId: postId),
              duration: 200.milliseconds,
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  //image view
                  Flexible(
                    child: PostImageGalery(media: media),
                  ),
                  //comment
                  ObxValue<RxBool>(
                    (res) {
                      return SizedBox(width: res.value ? 0 : context.width / 3.5);
                    },
                    controller.hideComment,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
