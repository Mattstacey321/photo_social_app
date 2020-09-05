import 'package:flutter/material.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/screens/forum_post/widgets/post_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomLoadPost extends StatelessWidget {
  final RefreshController controller;
  final bool hideHashTag;
  final int totalPost;
  final Function onRefresh;
  final Function onLoadMore;
  final List<PostModel> posts;
  CustomLoadPost(
      {@required this.controller,
      @required this.totalPost,
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
        itemCount: totalPost,
        itemBuilder: (context, index) {
          var postsData = posts;
          return PostItem(
            model: postsData[index],
            hideHashTag: hideHashTag,
            isLike: false,
          );
        },
      ),
    );
  }
}
