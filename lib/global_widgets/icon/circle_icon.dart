import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/theme/theme_controller.dart';

class CircleIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback onTap;
  final Color bgColor;
  final String tooltip;
  final bool showToolTip;
  CircleIcon({
    @required this.onTap,
    @required this.icon,
    this.bgColor,
    this.showToolTip = false,
    @required this.tooltip,
  });
  @override
  Widget build(BuildContext context) {
    const double iconSize = 30;
    Color iconColor = ThemeController.to.isDarkMode.value ? Colors.white : Colors.black;
    return Material(
      color: Colors.transparent,
      child: _buildTooltip(
        context,
        showToolTip,
        InkWell(
          splashColor: Colors.grey.withOpacity(0.2),
          customBorder: CircleBorder(), 
          onTap: onTap,
          child: Container(
              height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: IconTheme(
              data: IconThemeData(
                size: iconSize - 10, 
                color: iconColor,
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTooltip(BuildContext context, bool showTooltip, Widget child) {
    return context.isPhone
        ? Tooltip(message: tooltip, child: child)
        : showToolTip
            ? Tooltip(message: tooltip, child: child)
            : child;
  }
}
