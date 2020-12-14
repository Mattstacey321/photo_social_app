import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/models/collection_model.dart';
import 'package:photo_social/widgets/index.dart';

class CollectionItem extends StatefulWidget {
  final double height, width;
  final BookmarkCollectionModel collection;
  final VoidCallback onTap;
  final VoidCallback onLongTap;
  const CollectionItem(
      {this.height,
      this.width,
      @required this.collection,
      this.onTap,
      this.onLongTap});

  @override
  _CollectionItemState createState() => _CollectionItemState();
}

class _CollectionItemState extends State<CollectionItem> {
  BookmarkCollectionModel get collection => widget.collection;
  int get total => widget.collection.total;
  List<CollectionModel> get images => widget.collection.item;
  String get coverUrl => widget.collection.item.first.image.thumb1;
  String imageUrl(i) => images[i].image.thumb1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: widget.height,
            width: widget.width,
            child: GridView.builder(
              itemCount: total == 1 ? 1 : 4,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: total == 1 ? 1 : 2,
                childAspectRatio: Get.width / (Get.height / 2),
              ),
              itemBuilder: (context, i) {
                return (total == 1) // display first image as thumbnail
                    ? CustomNetworkImage(
                        url: coverUrl,
                        onTap: null,
                        imageBorder: 0,
                        imageHeight: 300,
                        imageWidth: 300)
                    : (total > 4 &&
                            i ==
                                3) // display 3 image with remain image in this collection
                        ? Stack(
                            children: [
                              CustomNetworkImage(
                                url: imageUrl(i),
                                onTap: null,
                                imageBorder: 0,
                                imageHeight: 100,
                                imageWidth: 100,
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                alignment: Alignment.center,
                                color: Colors.grey.withOpacity(0.4),
                                child: Text(
                                  "+${total - 4}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        : (i < total) // if index > total only display emtpy Container
                            ? CustomNetworkImage(
                                url: imageUrl(i),
                                onTap: null,
                                imageBorder: 0,
                                imageHeight: 100,
                                imageWidth: 100,
                              )
                            : Container();
              },
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: collection.isSelected
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
            opacity: collection.isSelected ? 1 : 0,
            child: Icon(EvaIcons.checkmarkCircle2),
          ),
        ),
      ],
    );
  }
}
