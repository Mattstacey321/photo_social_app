import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../data/themes/app_size.dart';
class EmptyCollection extends StatelessWidget {
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
          "No Collection",
          style: TextStyle(
            fontSize: AppSizes.errorText,
          ),
        ),
      ],
    );
  }
}
