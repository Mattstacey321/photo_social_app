import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class EmptyBookmark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          EvaIcons.bookmark,
          size: 40,
        ),
        SizedBox(height: 5),
        Text(
          "No bookmark",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
