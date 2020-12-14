import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/utils/nested_key.dart';
import 'package:photo_social/widgets/index.dart';

import '../bookmark_controller.dart';

class AddCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BookmarkController>(
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            childs: [
              Text(
                "Create New Collection",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
            onTapBack: () => Get.back(id: NestedKey.addCollection),
          ),
          body: Container(
            width: Get.width,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomNetworkImage(
                  url: _.getPostFirstImage,
                  onTap: null,
                  imageHeight: 150,
                  imageWidth: 150,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _.collectionCtrl,
                  onChanged: (value) => _.validateCollectionName(value),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration.collapsed(
                    hintText: "Collection Name",
                    filled: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
