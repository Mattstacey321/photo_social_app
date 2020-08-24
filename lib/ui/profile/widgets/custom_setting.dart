import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  CustomSetting({@required this.icon, @required this.title, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: Get.width,
          child: Row(
            children: [
              Icon(icon,size: 25,),
              SizedBox(
                width: 10,
              ),
              Text(title,style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }
}
