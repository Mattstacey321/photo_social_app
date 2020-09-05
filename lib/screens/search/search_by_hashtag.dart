import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_loading_post.dart';

class SearchByHashTag extends StatefulWidget {
  final String hashTag;
  final bool hideHashTag;
  SearchByHashTag({this.hashTag, this.hideHashTag});
  @override
  _SearchByHashTagState createState() => _SearchByHashTagState();
}

class _SearchByHashTagState extends State<SearchByHashTag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        childs: [
          Text(
            "# ${widget.hashTag}",
            style: AppStyle.appBarTitle,
          )
        ],
        onTapBack: () {
          Get.back();
        },
      ),
      body: GetBuilder<SearchController>(
        init: SearchController(hashtag: widget.hashTag),
        builder: (_) {
          return Container(
              height: Get.height,
              width: Get.width,
              child: Center(
                child: Obx(
                  () => _.listPost.isEmpty
                      ? SpinKitDoubleBounce(
                          color: Colors.black,
                          size: 35,
                        )
                      : _.listPost.isEmpty
                          ? Text("No match")
                          : CustomLoadPost(
                              controller: _.controller,
                              hideHashTag: true,
                              onLoadMore: () => _.loadMore(),
                              onRefresh: () => _.refresh(),
                              posts: _.listPost,
                              totalPost: _.totalPost),
                ),
              ));
        },
      ),
    );
  }
}
