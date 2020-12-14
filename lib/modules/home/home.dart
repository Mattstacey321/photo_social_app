import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/home/widgets/index.dart';
import 'package:photo_social/themes/app_styles.dart';
import 'package:photo_social/widgets/index.dart';

import 'home_controller.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      autoRemove: false,
      init: HomeController(),
      builder: (_) {
        return ObxValue(
          (isColappsed) {
            return Scaffold(
              appBar: CustomAppBar(
                  homeIcon: Icon(EvaIcons.menu2),
                  onTapBack: () => openTagDialog(),
                  childs: [
                    Text(
                      _.isCollapsed.value ? "Tag" : "Home",
                      style: AppStyles.appBarTitle,
                    ),
                  ],
                  height: 50),
              body: ForumDashboard(),
            );
          },
          _.isCollapsed,
        );
      },
    );
  }
}
