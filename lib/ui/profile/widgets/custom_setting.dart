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
  CustomSetting(
      {@required this.icon,
      @required this.title,
      this.iconSize,
      this.iconColor,
      @required this.onTap,
      this.padding = 10});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
