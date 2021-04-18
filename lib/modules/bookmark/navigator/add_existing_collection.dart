import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/utils/nested_key.dart';
import '../../../global_widgets/index.dart';
import '../../collection/widgets/collection_item.dart';
import '../controllers/bookmark_controller.dart';

class AddExistingCollection extends GetView<BookmarkController> {
  @override
  Widget build(BuildContext context) {
    double collectionSize = 70;
    int collectionsLength = controller.collections.length;
    return Scaffold(
      appBar: CustomAppBar(
        childs: [
          Text("Modify", style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          GestureDetector(
            onTap: () => Get.toNamed("/new", id: NestedKey.addCollection),
            child: Icon(
              EvaIcons.plus,
              size: 20,
            ),
          ),
        ],
        height: 50,
        onTapBack: () => Get.back(),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: collectionsLength,
        itemBuilder: (context, index) {
          final collection = controller.collections[index];
          return InkWell(
            onTap: () => controller.selectCollection(id: collection.id),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                CollectionItem(
                  height: collectionSize,
                  width: collectionSize,
                  collection: collection,
                  onTap: null,
                  onLongTap: null,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  collection.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Spacer(),
                Obx(
                  () => AnimatedOpacity(
                    opacity:
                        controller.collectionSelected.contains(collection.id) ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                    child: Icon(EvaIcons.checkmark),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
