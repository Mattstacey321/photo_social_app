import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../data/themes/app_size.dart';
class ErrorComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          EvaIcons.refresh,
          size: 30,
        ),
        Text(
          "Has problem when loading comment, try again",
          style: TextStyle(
            fontSize: AppSizes.errorText,
          ),
        )
      ],
    );
  }
}
