import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../global_widgets/demand_loading.dart';
import '../../forum_detail/widgets/index.dart';
import '../controllers/hashtag_detail_controller.dart';

class HashTagDetail extends StatelessWidget {
  final Key key;
  final String hashTag;
  final bool hideHashTag;
  HashTagDetail({this.key, this.hashTag, this.hideHashTag = true})
      : super(key: key); //: super(key: key);
  @override
  Widget build(BuildContext context) {
    final _ = Get.find<HashTagDetailController>(tag: hashTag);
    int crossAxisCount = GetPlatform.isMobile ? 2 : 4;
    double childAspectRatio = context.width / (context.height * 2);
    //(context.width / 2) / (context.height - kToolbarHeight - 24);
    return Scaffold(
      body: GetBuilder<HashTagDetailController>(
        init: _,
        assignId: true,
        id: "hash-tag-detail",
        builder: (controller) {
          return Container(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  //Positioned(child: Scrollbar()),
                  DemandLoadingWidget(
                    controller.loadingStatus,
                    child: Scrollbar(
                      controller: controller.scrollController,
                      isAlwaysShown: true,
                      child: SmartRefresher(
                        controller: controller.controller,
                        enablePullUp: true,
                        onRefresh: () => controller.refresh(),
                        onLoading: () => controller.loadMore(),
                        child: GridView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.posts.length,
                          padding: EdgeInsets.only(right: 10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemBuilder: (context, index) {
                            final post = controller.posts[index];
                            return PostItem(post: post);
                          },
                        ),
                      ),
                    ),
                    onEmpty: Text("No Post"),
                    onError: Icon(EvaIcons.close),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
