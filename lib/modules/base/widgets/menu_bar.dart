import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../../../src/buttons/profile_button.dart';
import '../controllers/base_controller.dart';
import 'navigation_bar.dart';
import 'search_bar.dart';

class MenuBar extends GetView<BaseController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          NavigationBar(),
          Spacer(),
          SearchBar(),
          const SizedBox(width: 10),
          CircleIcon(
            onTap: () {},
            icon: Icon(EvaIcons.bellOutline),
            tooltip: "Notification",
            showToolTip: true,
          ),
          const SizedBox(width: 10),
          ProfileButton(
            onTap: () {
              controller.addProfilePage();
            },
          )
        ],
      ),
    );
  }
}
