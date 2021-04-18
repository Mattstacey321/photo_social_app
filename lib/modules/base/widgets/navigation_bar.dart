import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../controllers/base_controller.dart';

class NavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BaseController>(
      assignId: true,
      builder: (controller) {
        var stack = controller.stack;
        var currentIndex = controller.currentPageIndex.value;
        var currentRouteName = Get.currentRoute.split('/').last;
        var routesLength = stack[currentIndex].routes.length;
        var isOnSamePage = stack[currentIndex].page == currentRouteName;
        //stack[currentIndex].page == currentRouteName

        return Row(
          children: <Widget>[
            //back button
            currentIndex == 0
                ? (isOnSamePage && routesLength > 1 && stack.length == 2
                    ? Row(
                        children: <Widget>[
                          CircleIcon(
                            onTap: () {
                              controller.popStackPage();
                            },
                            tooltip: 'Back',
                            icon: Icon(EvaIcons.chevronLeft),
                          ),
                          //Text(stack[1].page)
                        ],
                      )
                    : const SizedBox())
                : Row(
                    children: <Widget>[
                      CircleIcon(
                        onTap: () {
                          controller.popStackPage();
                        },
                        tooltip: 'Back',
                        icon: Icon(EvaIcons.chevronLeft),
                      ),
                      //Text(stack[1].page)
                    ],
                  )
            //title
          ],
        );
      },
    );
  }
}
