import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';
import '../responsive_views/forum_detail_desktop.dart';
import '../responsive_views/forum_detail_mobile.dart';

class ForumDetailView extends GetResponsiveView<PostController> {
  final dynamic forumInfo;
  ForumDetailView({this.forumInfo}) : super(alwaysUseBuilder: false);
  @override
  Widget phone() {
    final String forumId = forumInfo["id"];
    final String forumName = forumInfo["name"];
    return ForumDetailMobile(forumId: forumId, forumName: forumName);
  }

  @override
  Widget desktop() {
    final String forumId = forumInfo["id"];
    return ForumDetaiLDesktop(forumId: forumId);
  }
}
