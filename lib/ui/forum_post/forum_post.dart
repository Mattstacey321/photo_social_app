import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/postModel.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/ui/forum_post/widgets/post_item.dart';
import 'package:photo_social/widgets/custom_appBar.dart';

class ForumPost extends StatelessWidget {
  final String forumId;
  final String forumName;
  ForumPost({this.forumId, this.forumName});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForumController>(
        init: ForumController(forumId: forumId),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
              childs: [
                Text(
                  "$forumName",
                  style: AppStyle.appBarTitle,
                )
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
                  child: Obx(
                    () => _.postData() == null
                        ? SpinKitCubeGrid(
                            color: Colors.black,
                            size: 15,
                          )
                        : _.countPost == 0
                            ? Text("No data")
                            : ListView.separated(
                                separatorBuilder: (context, index) => SizedBox(height: 20),
                                itemCount: _.countPost,
                                itemBuilder: (context, index) {
                                  List<PostModel> posts = _.postData.value;
                                  return PostItem(
                                    model: posts[index],
                                    onTap: () {
                                      //view image in large view  
                                    },
                                    isLike: false,
                                  );
                                },
                              ),
                  ),
                )),
          );
        });
  }
}
