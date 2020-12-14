import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class OtherMoreComment extends StatelessWidget {
  final String userName;
  OtherMoreComment({this.userName});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Comment by ${userName ?? "..."}",
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(height: 10),
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Row(
            children: [
              Icon(EvaIcons.messageCircleOutline),
              SizedBox(width: 10),
              Text(
                "Reply",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Row(
            children: [
              Icon(EvaIcons.copyOutline),
              SizedBox(width: 10),
              Text(
                "Copy Comment",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Row(
            children: [
              Icon(EvaIcons.infoOutline),
              SizedBox(width: 10),
              Text(
                "Report Bad Comment",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
