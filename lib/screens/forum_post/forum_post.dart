import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_dropdown_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/post_item.dart';

class ForumPost extends StatelessWidget {
  final String forumId;
  final String forumName;
  ForumPost({this.forumId, this.forumName});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(forumId: forumId),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              childs: [
                Text(
                  "$forumName",
                  style: AppStyle.appBarTitle,
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: CustomDropdownList()),
                /*CustomButton(
                  onPress: () {},
                  iconColor: Colors.green,
                  icon: EvaIcons.funnel,
                  tooltip: "Filter",
                  height: 30,
                  childs: [Text("Newest")],
                )*/
              ],
              height: 50,
              onTapBack: () {
                Get.back();
              },
            ),
            body: Container(
              height: Get.height,
              width: Get.width,
              child: Center(
                child: Obx(
                  () => SmartRefresher(
                    controller: _.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () => _.refresh(),
                    onLoading: () => _.loadMorePost(),
                    child: ListView.separated(
                      cacheExtent: 100,
                      addAutomaticKeepAlives: true,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20),
                      itemCount: _.countPost,
                      itemBuilder: (context, index) {
                        var posts = _.postData;
                        return PostItem(
                          model: posts[index],
                          isLike: _.isLike,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
