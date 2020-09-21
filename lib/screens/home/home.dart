import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/forumModel.dart';
import 'package:photo_social/screens/home/widgets/hashtag_dashboard.dart';
import 'package:photo_social/screens/index.dart';
import 'package:photo_social/screens/request_feature/widgets/request_feature.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_footer_loading.dart';
import 'package:photo_social/widgets/custom_forum_banner.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Duration duration = const Duration(milliseconds: 250);

  Widget sidebar() {
    return HashTagDashboard();
  }

  Widget dashboard(HomeController _) {
    bool isCollapsed = !_.isCollapsed.value;

    return AnimatedPositioned(
      duration: duration,
      curve: Curves.fastOutSlowIn,
      top: isCollapsed ? 0 : 0.0 * Get.height,
      bottom: isCollapsed ? 0 : 0.0 * Get.width,
      left: isCollapsed ? 0 : 0.6 * Get.width,
      right: isCollapsed ? 0 : -0.4 * Get.width,
      child: Container(
        height: Get.height,
        width: Get.width,
        color: PreferencesController.colorTheme,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Obx(
            () => _.forumsData.isEmpty
                ? AppStyle.defaultLoading()
                : _.countForum == 0
                    ? Text("No forums now")
                    : SmartRefresher(
                        controller: _.refreshController,
                        enablePullUp: true,
                        enablePullDown: true,
                        onRefresh: () => _.refreshForum(),
                        onLoading: () => _.loadMoreForum(),
                        footer: LoadingState.loadMore,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 15),
                          itemCount: _.countForum,
                          itemBuilder: (context, index) {
                            List<ForumModel> forum = _.forumsData;
                            return CustomForumBanner(
                              onTap: () {
                                Get.to(
                                  ForumPost(
                                    forumId: forum[index].id,
                                    forumName: forum[index].name,
                                  ),
                                );
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
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return ObxValue((isColappsed) {
          return Scaffold(
            appBar: CustomAppBar(
                homeIcon: Icon(EvaIcons.hash),
                onTapBack: () {
                  _.openSideBar();
                },
                childs: [
                  ObxValue((data) {
                    return Text(
                      data.value ? "Tag" : "Home",
                      style: AppStyle.appBarTitle,
                    );
                  }, _.isCollapsed),
                  Spacer(),
                  CustomButton(
                    onPress: () {
                      Get.to(RequestFeature());
                      //Get.dialog(SkipLoginDialog(onBack: () {}, onSkip: () {}));
                    },
                    tooltip: "Request Feature",
                    iconColor: Colors.red,
                    icon: EvaIcons.paperPlane,
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  CustomAvatar(
                    url: _.getAvatar(),
                    onTap: () {
                      Get.toNamed('/profile');
                    },
                    toolTip: "Profile",
                    size: 40,
                  )
                ],
                height: 50),
            body: GestureDetector(
              onHorizontalDragEnd: (details) {
                _.openSideBar();
              },
              behavior: HitTestBehavior.translucent,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  sidebar(),
                  dashboard(_),
                ],
              ),
            ),
          );
        }, _.isCollapsed);
      },
    );
  }
}
