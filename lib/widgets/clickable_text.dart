import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final Function onTap;
  final double splashBorder;
  final Text text;
  final EdgeInsetsGeometry padding;
  ClickableText({@required this.onTap, this.padding : const EdgeInsets.symmetric(vertical: 5, horizontal: 10), this.splashBorder = 10, @required this.text});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(splashBorder),
      child: Padding(
        padding: padding,
        child: text,
      ),
    );
  }
}
