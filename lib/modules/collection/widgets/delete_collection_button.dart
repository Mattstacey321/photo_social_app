import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/modules/collection/collection_controller.dart';
import 'package:photo_social/widgets/index.dart';

class DeleteCollectionButton extends GetView<CollectionController> {
  @override
  Widget build(BuildContext context) {
    return ObxValue(
        (result) => AnimatedOpacity(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 200),
              opacity: result.value ? 1 : 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ObxValue(
                    (res) {
                      int totalSelection = res.value;
                      return LoadingButton(
                          controller: controller.deleteBookmarkCtrl,
                          height: 60,
                          width: totalSelection <= 0 ? 60 : 80,
                          onPressed: () {
                            controller.removeCollection();
                          },
                          radius: 15,
                          buttonColor: Colors.red,
                          initialWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(EvaIcons.trash2Outline),
                              totalSelection <= 0
                                  ? SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        "($totalSelection)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                            ],
                          ),
                          successWidget: Icon(EvaIcons.checkmark),
                          errorWidget: Icon(EvaIcons.close));
                    },
                    controller.totalDeletedCollection,
                  )
                ],
              ),
            ),
        controller.multiSelected);
  }
}
