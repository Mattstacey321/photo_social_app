import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_social/widgets/circle_icon.dart';

class CustomAppBar extends PreferredSize {
  final List<Widget> childs;
  final double height;
  final Widget homeIcon;
  final Function onTapBack;
  final Color color;

  CustomAppBar(
      {@required this.childs,
      this.height = 50,
      this.color = Colors.transparent,
      this.homeIcon: const Icon(EvaIcons.arrowBack),
      @required this.onTapBack});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(color: color, boxShadow: []),
      child: Row(
        children: [
          CircleIcon(
              onTap: () => onTapBack(), tooltip: "Home", child: homeIcon),
          SizedBox(
            width: 10,
          ),
          for (var widget in childs) widget
        ],
      ),
    );
  }
}
