import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/widgets/custom_button.dart';

class CustomSetting extends StatelessWidget {
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final String title;
  final Function onTap;
  final double padding;
  final Widget widget;
  final bool addPadding;
  CustomSetting(
      {@required this.icon,
      @required this.title,
      this.iconSize,
      this.iconColor,
      this.addPadding = true,
      this.widget = const SizedBox(),
      @required this.onTap,
      this.padding = 10});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: padding),
          width: Get.width,
          child: Row(
            children: [
              CustomButton(
                onPress: null,
                isClickable: false,
                iconColor: iconColor,
                height: iconSize,
                width: iconSize,
                icon: icon,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(right: addPadding ? 10 : 0),
                  child: widget)
            ],
          ),
        ),
      ),
    );
  }
}
