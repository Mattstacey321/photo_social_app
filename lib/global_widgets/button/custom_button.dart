import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final Function onPress;
  final String tooltip;
  final double radius;
  final IconData icon;
  final Color iconColor;
  final double opacity;
  final Color backgroundColor;
  final bool showElevation;
  final Gradient gradient;
  final double padding;
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> childs;
  CustomButton(
      {this.height = 36,
      this.width = 88,
      this.radius = 10,
      this.showElevation = false,
      this.backgroundColor,
      this.gradient,
      this.padding = 0,
      this.mainAxisAlignment = MainAxisAlignment.center,
      @required this.onPress,
      this.tooltip = "",
      @required this.iconColor,
      this.opacity = 0.2,
      this.childs,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: Material(
        //fix no ripple effect on stack
        color: Colors.transparent,
        child: Tooltip(
          message: tooltip,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            splashColor: iconColor.withOpacity(0.1),
            onTap: onPress != null ? () => onPress() : null,
            child: Stack(
              children: [
                Container(
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: gradient,
                      boxShadow: showElevation
                          ? [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(1, 2))
                            ]
                          : null,
                      color: backgroundColor == null
                          ? (onPress != null
                              ? iconColor.withOpacity(opacity)
                              : iconColor.withOpacity(opacity * 2))
                          : (iconColor != null
                              ? backgroundColor.withOpacity(opacity * 3.5)
                              : backgroundColor)),
                  child: Row(
                    mainAxisAlignment: mainAxisAlignment,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      icon != null
                          ? Icon(icon, color: iconColor, size: height * 0.6)
                          : const SizedBox(),
                      childs != null
                          ? icon != null
                              ? SizedBox(width: 5)
                              : const SizedBox()
                          : SizedBox(width: 0),
                      for (var widget in childs ?? []) widget
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(radius),
                      onTap: onPress != null ? () => onPress() : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static square({
    @required double size,
    @required Function onPress,
    String tooltip = "",
    double radius = 15,
    IconData icon,
    Color iconColor = Colors.transparent,
    double opacity = 0.2,
    Color backgroundColor,
    bool showElevation = false,
    Gradient gradient,
    double padding = 0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    List<Widget> childs,
  }) {
    return CustomButton(
      onPress: onPress,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      childs: childs,
      height: size,
      width: size,
      icon: icon,
      padding: padding,
      tooltip: tooltip,
      gradient: gradient,
      mainAxisAlignment: mainAxisAlignment,
      opacity: opacity,
      radius: radius,
      showElevation: showElevation,
    );
  }
}
