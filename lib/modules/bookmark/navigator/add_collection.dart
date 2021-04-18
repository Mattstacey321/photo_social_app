import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../../../global_widgets/input/custom_input.dart';
import '../controllers/bookmark_controller.dart';

class AddCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<BookmarkController>(
      builder: (_) {
        return  Container(
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
                CustomInput(controller: _.collectionCtrl, hintText: "Collection Name", onChange: (value) => _.validateCollectionName(value),)
              ],
            ),
          
        );
      },
    );
  }
}
