import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class CustomAppBar extends PreferredSize {
  final List<Widget> childs;
  final double height;
  final Widget homeIcon;
  final VoidCallback onTapBack;
  final Color color;
  final Widget tabBar;
  CustomAppBar(
      {@required this.childs,
      this.height = 50,
      this.color = Colors.transparent,
      this.homeIcon: const Icon(EvaIcons.arrowBack),
      this.tabBar,
      this.onTapBack});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(color: color, boxShadow: []),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              onTapBack == null
                  ? Container()
                  : CircleIcon(
                      onTap: () => onTapBack(),
                      tooltip: "Back",
                      child: homeIcon),
              SizedBox(
                width: 10,
              ),
              for (var widget in childs) widget
            ],
          ),
          tabBar == null
              ? Container()
              : Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: tabBar,
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
