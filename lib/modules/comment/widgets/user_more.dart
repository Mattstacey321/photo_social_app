import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class UserMoreComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Row(
            children: [
              Icon(EvaIcons.edit),
              SizedBox(width: 10),
              Text(
                "Edit Comment",
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
              Icon(
                EvaIcons.fileRemove,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                "Remove Comment",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
