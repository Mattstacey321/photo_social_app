import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/ui/forum_post/widgets/post_item.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
               
              ],
              height: 50,
              onTap: () {
                Get.back();
              },
              homeIcon: Icon(FeatherIcons.arrow_left),
            ),
            body: Container(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: Obx(() => SmartRefresher(
                        controller: _.refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh: () => _.refresh(),
                        onLoading: () => _.loadMorePost(),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: 20),
                          itemCount: _.countPost,
                          itemBuilder: (context, index) {
                            var posts = _.postData.value;
                            return PostItem(
                              model: posts[index],
                              isLike: false,
                            );
                          },
                        ),
                      )),
                )),
          );
        });
  }
}
/*_.postData.isEmpty
                      ? SpinKitCubeGrid(
                          color: Colors.black,
                          size: 15,
                        )
                      : _.countPost == 0
                          ? Text("No data")
                          :*/
