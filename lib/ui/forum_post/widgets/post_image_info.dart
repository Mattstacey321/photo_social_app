import 'package:flutter/material.dart';
import 'package:photo_social/widgets/clickable_text.dart';

class PostImageInfo extends StatelessWidget {
  final List tags;
  PostImageInfo({this.tags});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (var tag in tags)
            ClickableText(
                onTap: () {},
                text: Text(
                  "# $tag",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ))
        ],
      ),
    );
  }
}
