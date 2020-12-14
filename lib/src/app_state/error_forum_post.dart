import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_social/widgets/text/clickable_text.dart';

class ErrorForumPost extends StatelessWidget {
  final VoidCallback onRetry;
  ErrorForumPost({this.onRetry});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            EvaIcons.slash,
            size: 30,
          ),
          Text("Error when loading post..., "),
          ClickableText(onTap: onRetry, text: Text("try again"))
        ],
      ),
    );
  }
}
