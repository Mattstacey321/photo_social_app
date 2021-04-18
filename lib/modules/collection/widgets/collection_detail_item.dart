import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../../data/models/post_model.dart';
import '../../../global_widgets/index.dart';

class CollectionDetailItem extends StatefulWidget {
  final PostModel post;
  final Function onTap;
  final Function onLongTap;
  CollectionDetailItem({@required this.post, this.onTap, this.onLongTap});

  @override
  _CollectionDetailItemState createState() => _CollectionDetailItemState();
}

class _CollectionDetailItemState extends State<CollectionDetailItem> {
  PostModel get post => widget.post;

  List<Media> get medias => post.medias;
  Media get firstMedia => post.medias.first;

  String get firstImage => firstMedia.thumb1;
  double get firstImageHeight => firstMedia.height;
  double get firstImageWidth => firstMedia.width;

  bool get isSelected => post.isSelected;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomNetworkImage(
          url: firstImage,
          onTap: widget.onTap,
          onLongTap: widget.onLongTap,
          imageHeight: firstImageHeight,
          imageWidth: firstImageWidth,
          imageBorder: 10,
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.grey.withOpacity(0.6) : Colors.transparent,
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
            opacity: isSelected ? 1 : 0,
            child: Icon(EvaIcons.checkmarkCircle2),
          ),
        ),
      ],
    );
  }
}
