import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';


class SettingItem extends StatelessWidget {
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final String title;
  final Function onTap;
  final double padding;
  final Widget widget;
  final bool addPadding;
  final String subTitle;
  SettingItem(
      {@required this.icon,
      @required this.title,
      @required this.iconSize,
      @required this.iconColor,
      @required this.onTap,
      this.addPadding = true,
      this.subTitle,
      this.widget = const SizedBox(),
      this.padding = 5});
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
                iconColor: iconColor,
                height: iconSize,
                width: iconSize,
                icon: icon,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: subTitle != null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subTitle != null
                        ? Flexible(
                            child: Text(
                              subTitle,
                              style: TextStyle(fontSize: 13),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Spacer(),
              widget
            ],
          ),
        ),
      ),
    );
  }
}
