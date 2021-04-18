import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/themes/app_styles.dart';
import '../../../global_widgets/index.dart';
import '../controllers/hashtag_controller.dart';
import '../views/hashtag_root.dart';
import '../widgets/hashtag_item.dart';

class HashTagDashboard extends StatefulWidget {
  @override
  _HashTagDashboardState createState() => _HashTagDashboardState();
}

class _HashTagDashboardState extends State<HashTagDashboard> {
  @override
  Widget build(BuildContext context) {
    HashTagController _ = HashTagController.to;
    return Scaffold(
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
      body: Obx(
        () => Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(height: 10),
              itemCount: _.hashTags.length,
              itemBuilder: (context, index) {
                final tags = _.hashTags;
                return tags.isEmpty
                    ? Text("No hashtag found now")
                    : CustomTranstion.slideDown(
                        delayed: 150,
                        child: HashTagItem(
                          hashTag: tags[index],
                          onTap: () {},
                        ),
                      );
              },
            ),
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
            position: Tween(begin: Offset(-1, 0), end: Offset(0, 0)).animate(CurvedAnimation(
                parent: animation, curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn))),
            child: HashTagRoot(),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Opacity(opacity: animation.value, child: child);
      },
      barrierDismissible: true,
      barrierLabel: "Close Tag",
      transitionDuration: Duration(milliseconds: 200));
}
