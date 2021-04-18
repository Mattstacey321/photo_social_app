import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/collection_model.dart';
import '../../../global_widgets/network_image/custom_netword_image.dart';
import '../../collection/controllers/collection_controller.dart';

class ViewCollection extends StatefulWidget {
  @override
  _ViewCollectionState createState() => _ViewCollectionState();
}

class _ViewCollectionState extends State<ViewCollection> {
  var selectedItem = <int>[];

  bool isItemSelected(int index) => selectedItem.contains(index);

  void selectItem(int index) {
    if (selectedItem.contains(index)) {
      selectedItem.remove(index);
    } else
      selectedItem.add(index);
    setState(() {});
  }

  Widget _buildItem(
    BookmarkCollectionModel collection, {
    @required Function onTap,
    bool isSelected = false,
  }) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height: 100,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      CustomNetworkImage(
                        url: collection.item.first.image.thumb1,
                        onTap: null,
                        imageHeight: 80,
                        imageWidth: 80,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            collection.name,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text("${collection.total} images"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              isSelected
                  ? Positioned.fill(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.centerRight,
                        child: Icon(EvaIcons.checkmarkCircle2, color: Colors.white),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20),
      shrinkWrap: true,
      itemCount: controller.collectionLength,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      itemBuilder: (context, index) {
        final collection = controller.collections[index];
        return _buildItem(
          collection,
          isSelected: isItemSelected(index),
          onTap: () {
            selectItem(index);
          },
        );
      },
    );
  }
}
