import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../controllers/base_controller.dart';
import '../widgets/menu_bar.dart';
import '../widgets/side_bar.dart';
import 'global_comment.dart';

class BaseScreen extends GetResponsiveView<BaseController> {
  BaseScreen() : super(alwaysUseBuilder: false);
  
  @override
  Widget desktop() {
    return Scaffold(
      key: controller.drawerKey,
      endDrawer: GlobalComment(),
      endDrawerEnableOpenDragGesture: false,
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          children: <Widget>[
            SideBar(),
            SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MenuBar(),
                SizedBox(height: 10),
                ObxValue(
                  (index) {
                    return Expanded(
                      child: AnimatedIndexedStack(
                        index: index.value,
                        children: controller.pages,
                      ),
                    );
                  },
                  controller.currentPageIndex,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return ObxValue(
      (index) {
        int _pageIndex = index.value;
        return Scaffold(
          bottomNavigationBar: BottomNavigation(pageIndex: _pageIndex),
          body: AnimatedIndexedStack(
            index: _pageIndex,
            children: controller.pages,
          ),
        );
      },
      controller.currentPageIndex,
    );
  }
}
