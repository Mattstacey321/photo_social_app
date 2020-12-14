import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/widgets/animations/slide_transition.dart';
import 'package:photo_social/widgets/index.dart';

import 'hashtag_controller.dart';
import 'widgets/hashtag_item.dart';

class HashTagDashboard extends StatefulWidget {
  @override
  _HashTagDashboardState createState() => _HashTagDashboardState();
}

class _HashTagDashboardState extends State<HashTagDashboard> {
  @override
  Widget build(BuildContext context) {
    HashTagController _ = HashTagController.to;
    return Obx(
      () => Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(height: 10),
            itemCount: _.countHashTag,
            itemBuilder: (context, index) {
              final tags = _.hashTags;
              return tags.isEmpty
                  ? Text("No hashtag found now")
                  : CustomTranstion.slideDown(
                      delayed: 150,
                      child: HashTagItem(
                        hashtag: tags[index].hashtag,
                        total: tags[index].total,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

Future openTagDialog() async {
  return Get.generalDialog(
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
                CurvedAnimation(
                    parent: animation,
                    curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
            child: Scaffold(
              appBar: CustomAppBar(childs: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close),
                ),
                SizedBox(width: 10),
                Text(
                  "Available Tag",
                  style: AppStyles.appBarTitle,
                )
              ]),
              body: HashTagDashboard(),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Opacity(opacity: animation.value, child: child);
      },
      transitionDuration: Duration(milliseconds: 200));
}
