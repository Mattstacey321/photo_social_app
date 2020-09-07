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
  final bool isClickable;
  final Color backgroundColor;
  final bool showElevation;
  final Gradient gradient;
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> childs;
  CustomButton(
      {this.height = 36,
      this.width = 88,
      this.radius = 15,
      this.showElevation = false,
      this.backgroundColor,
      this.gradient,
      this.mainAxisAlignment = MainAxisAlignment.center,
      @required this.onPress,
      this.tooltip = "",
      @required this.iconColor,
      this.isClickable = true,
      this.opacity = 0.2,
      this.childs,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      //fix no ripple effect on stack
      color: Colors.transparent,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: iconColor.withOpacity(0.1),
          onTap: isClickable ? () => onPress() : null,
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                //padding: EdgeInsets.symmetric(horizontal: 5),
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
                        ? (isClickable != null || isClickable
                            ? iconColor.withOpacity(opacity)
                            : iconColor)
                        : (isClickable
                            ? backgroundColor.withOpacity(opacity * 3.5)
                            : backgroundColor)),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    icon != null
                        ? Icon(icon,
                            color: isClickable ? iconColor : iconColor,
                            size: height * 0.60)
                        : SizedBox(width: 0),
                    childs != null
                        ? icon != null
                            ? SizedBox(width: 10)
                            : SizedBox(width: 0)
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
                    onTap: isClickable ? () => onPress() : null,
                  ),
                ),
              ),
            ],
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
    bool isClickable = true,
    @required Color backgroundColor,
    bool showElevation = false,
    Gradient gradient,
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
      tooltip: tooltip,
      isClickable: isClickable,
      gradient: gradient,
      mainAxisAlignment: mainAxisAlignment,
      opacity: opacity,
      radius: radius,
      showElevation: showElevation,
    );
  }
}
