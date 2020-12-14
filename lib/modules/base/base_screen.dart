import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/widgets/index.dart';

import 'base_controller.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
      init: BaseController(),
      builder: (_) => ObxValue(
        (index) {
          int _pageIndex = index.value;
          return Scaffold(
            bottomNavigationBar: BottomNavigation(pageIndex: _pageIndex),
            body: FadeIndexedStack(
              index: index.value,
              children: BaseController.to.pages,
            ),
          );
        },
        _.currentIndex,
      ),
    );
  }
}
