import 'package:flutter/material.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/modules/forum_post/widgets/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomLoadPost extends StatelessWidget {
  final RefreshController controller;
  final bool hideHashTag;
  final Function onRefresh;
  final Function onLoadMore;
  final List<PostModel> posts;
  CustomLoadPost(
      {@required this.controller,
      this.hideHashTag = false,
      @required this.onRefresh,
      @required this.onLoadMore,
      @required this.posts});
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () => onRefresh(),
      onLoading: () => onLoadMore(),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var postsData = posts;
          return Post(
            model: postsData[index],
            hideHashTag: hideHashTag,
          );
        },
      ),
    );
  }
}
