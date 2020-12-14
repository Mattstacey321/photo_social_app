import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestBookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            EvaIcons.layers,
            size: 100,
          ),
          SizedBox(height: 10),
          Column(
            children: <Widget>[
              Text(
                "No bookmark",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "You must login to view your bookmark",
              ),
            ],
          )
        ],
      ),
    );
  }
}
