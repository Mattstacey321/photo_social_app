import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';
import 'package:photo_social/modules/collection/widgets/collection_item.dart';
import 'package:photo_social/utils/nested_key.dart';
import 'package:photo_social/widgets/app_bar/custom_appBar.dart';

class AddExistingCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double collectionSize = 70;
    return GetX<BookmarkController>(
      builder: (_) {
        int collectionsLength = _.collections.length;
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
              final collection = _.collections[index];
              return InkWell(
                onTap: () =>
                    BookmarkController.to.selectCollection(id: collection.id),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Spacer(),
                    Obx(
                      () => AnimatedOpacity(
                        opacity: BookmarkController.to.collectionSelected
                                .contains(collection.id)
                            ? 1
                            : 0,
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
      },
    );
  }
}
