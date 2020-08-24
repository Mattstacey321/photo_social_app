import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_social/widgets/circle_icon.dart';

class CustomAppBar extends PreferredSize {
  final List<Widget> childs;
  final double height;
  final Widget homeIcon;
  final Function onTap;
  final Color color;

  CustomAppBar(
      {@required this.childs,
      @required this.height,
      this.color = Colors.transparent,
      this.homeIcon: const Icon(FeatherIcons.arrow_left),
      @required this.onTap});

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
          CircleIcon(onTap: () => onTap(), tooltip: "Home", child: homeIcon),
          SizedBox(
            width: 10,
          ),
          for (var widget in childs) widget
        ],
      ),
    );
  }
}
