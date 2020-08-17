import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/ui/forum_post/forum_post.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_netword_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
              homeIcon: Icon(FeatherIcons.hash),
              onTap: () {},
              childs: [
                Text(
                  "Available Forum",
                  style: AppStyle.appBarTitle,
                ),
                Spacer(),
                CustomButton(
                  onPress: () {
                    //Get.dialog(SkipLoginDialog(onBack: () {}, onSkip: () {}));
                  },
                  tooltip: "Request forum",
                  iconColor: Colors.red,
                  icon: FeatherIcons.zap,
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 10),
                CustomAvatar(
                  url: _.getAvatar(),
                  onTap: () {},
                  toolTip: "Profile",
                  size: 40,
                )
              ],
              height: 50),
          body: Container(
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Obx(
                () => _.forumsData.isEmpty
                    ? SpinKitDoubleBounce(color: Colors.black, size: 25)
                    : _.forumsData.isEmpty
                        ? Text("No forums now")
                        : SmartRefresher(
                            controller: _.refreshController,
                            enablePullUp: true,
                            enablePullDown: true,
                            onRefresh: () => _.refreshForum(),
                            onLoading: () => _.loadMoreForum(),
                            child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(height: 15),
                              itemCount: _.countForum,
                              itemBuilder: (context, index) {
                                List<ForumModel> forum = _.forumsData;
                                return CustomNetworkImage(
                                  onTap: () {
                                    Get.to(ForumPost(
                                      forumId: forum[index].id,
                                      forumName: forum[index].name,
                                    ));
                                  },
                                  id: forum[index].id,
                                  url: forum[index].banner,
                                  title: forum[index].name,
                                  imageHeight: 130,
                                  imageWidth: Get.width,
                                );
                              },
                            ),
                          ),
              ),
            ),
          ),
        );
      },
    );
  }
}
