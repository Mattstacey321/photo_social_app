import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../data/themes/app_size.dart';
import '../../global_widgets/index.dart';
class ErrorForumPost extends StatelessWidget {
  final VoidCallback onRetry;
  ErrorForumPost({this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            EvaIcons.slash,
            size: 40,
          ),
          SizedBox(height: 5),
          Text(
            "Error when loading post ...",
            style: TextStyle(
              fontSize: AppSizes.errorText,
            ),
          ),
          ClickableText(onTap: onRetry, text: Text("try again"))
        ],
      ),
    );
  }
}
