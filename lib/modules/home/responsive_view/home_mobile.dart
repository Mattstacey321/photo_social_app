import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../data/themes/index.dart';
import '../../../global_widgets/index.dart';

import '../../forum/views/forum_view.dart';
import '../controllers/home_controller.dart';

class HomeMobile extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
      (isCollapsed) {
        return Scaffold(
          appBar: CustomAppBar(
            homeIcon: Icon(EvaIcons.menu2),
            onTapBack: () {
              //TODO: open hashtag dialog
              //openTagDialog()
            },
            childs: [
              Text(
                isCollapsed.value ? "Tag" : "Home",
                style: AppStyles.appBarTitle,
              ),
            ],
          ),
          body: ForumView(),
        );
      },
      controller.isCollapsed,
    );
  }
}
