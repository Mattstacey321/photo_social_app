import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class EmptyComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          EvaIcons.messageCircle,
          size: 40,
        ),
        SizedBox(height: 5),
        Text(
          "No comment",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "Be a first one comment",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
