import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../data/themes/app_colors.dart';
import '../../modules/base/controllers/base_controller.dart';
import '../../modules/theme/theme_controller.dart';

class BottomNavigation extends GetView<BaseController> {
  final int pageIndex;
  BottomNavigation({this.pageIndex});
  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (isDarkMode) => Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: GNav(
              gap: 0,
              activeColor: isDarkMode.value ? AppColors.darkGrey900 : Colors.white,
              iconSize: 25,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 500),
              tabs: [
                GButton(
                  leading: AnimatedCrossFade(
                    duration: Duration(milliseconds: 200),
                    firstChild: Icon(EvaIcons.image2),
                    secondChild: Icon(EvaIcons.imageOutline),
                    crossFadeState:
                        pageIndex == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  ),
                  icon: Icons.home,
                ),
                GButton(
                  icon: Icons.image,
                  leading: AnimatedCrossFade(
                    duration: Duration(milliseconds: 200),
                    firstChild: Icon(EvaIcons.heart),
                    secondChild: Icon(EvaIcons.heartOutline),
                    crossFadeState:
                        pageIndex == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  ),
                ),
                GButton(
                  icon: Icons.image,
                  leading: AnimatedCrossFade(
                    duration: Duration(milliseconds: 200),
                    firstChild: Icon(EvaIcons.person),
                    secondChild: Icon(EvaIcons.personOutline),
                    crossFadeState:
                        pageIndex == 2 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  ),
                ),
              ],
              selectedIndex: pageIndex,
              onTabChange: (index) {
                controller.changePage(index);
              },
            ),
          ),
        ),
      ),
      ThemeController.to.isDarkMode,
    );
  }
}
