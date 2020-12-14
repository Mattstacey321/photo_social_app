import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_social/models/post_model.dart';
import 'package:photo_social/widgets/index.dart';

class CollectionDetailItem extends StatefulWidget {
  final PostModel post;
  final Function onTap;
  final Function onLongTap;
  CollectionDetailItem({@required this.post, this.onTap, this.onLongTap});

  @override
  _CollectionDetailItemState createState() => _CollectionDetailItemState();
}

class _CollectionDetailItemState extends State<CollectionDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomNetworkImage(
          url: widget.post.medias.first.thumb1,
          onTap: widget.onTap,
          onLongTap: widget.onLongTap,
          imageHeight: 150,
          imageWidth: 150,
          imageBorder: 10,
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: widget.post.isSelected
                ? Colors.grey.withOpacity(0.6)
                : Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.grey.withOpacity(0.1),
              onTap: widget.onTap,
              onLongPress: widget.onLongTap,
            ),
          ),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: widget.post.isSelected ? 1 : 0,
            child: Icon(EvaIcons.checkmarkCircle2),
          ),
        ),
      ],
    );
  }
}
