import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:photo_social/modules/theme/theme_controller.dart';
import 'package:photo_social/modules/base/base_controller.dart';
import 'package:photo_social/themes/app_colors.dart';

class BottomNavigation extends StatelessWidget {
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
              activeColor:
                  isDarkMode.value ? AppColors.darkGrey900 : Colors.white,
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
                    crossFadeState: pageIndex == 0
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                  text: "",
                ),
                GButton(
                  text: "",
                  gap: 0,
                  leading: AnimatedCrossFade(
                    duration: Duration(milliseconds: 200),
                    firstChild: Icon(EvaIcons.heart),
                    secondChild: Icon(EvaIcons.heartOutline),
                    crossFadeState: pageIndex == 1
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                ),
                GButton(
                  leading: AnimatedCrossFade(
                    duration: Duration(milliseconds: 200),
                    firstChild: Icon(EvaIcons.person),
                    secondChild: Icon(EvaIcons.personOutline),
                    crossFadeState: pageIndex == 2
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                  text: '',
                ),
              ],
              selectedIndex: pageIndex,
              onTabChange: (index) {
                BaseController.to.changePage(index);
              },
            ),
          ),
        ),
      ),
      ThemeController.to.isDarkMode,
    );
  }
}
