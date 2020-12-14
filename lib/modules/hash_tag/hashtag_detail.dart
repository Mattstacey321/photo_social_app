import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/src/loading_indicator/loading_indicator.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/widgets/index.dart';

import 'hashtag_detail_controller.dart';

class HashTagDetail extends StatefulWidget {
  final String hashTag;
  final bool hideHashTag;
  HashTagDetail({this.hashTag, this.hideHashTag});
  @override
  _HashTagDetailState createState() => _HashTagDetailState();
}

class _HashTagDetailState extends State<HashTagDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [
          Text(
            "# ${widget.hashTag}",
            style: AppStyles.appBarTitle,
          )
        ],
        onTapBack: () {
          Get.back();
        },
      ),
      body: GetBuilder<HashTagDetailController>(
        init: HashTagDetailController(hashtag: widget.hashTag),
        builder: (_) {
          return Container(
              height: Get.height,
              width: Get.width,
              child: Center(
                child: Obx(
                  () => _.listPost.isEmpty
                      ? LoadingIndicator.listLoading()
                      : _.listPost.isEmpty
                          ? Text("No match")
                          : CustomLoadPost(
                              controller: _.controller,
                              hideHashTag: true,
                              onLoadMore: () => _.loadMore(),
                              onRefresh: () => _.refresh(),
                              posts: _.listPost,
                            ),
                ),
              ));
        },
      ),
    );
  }
}
