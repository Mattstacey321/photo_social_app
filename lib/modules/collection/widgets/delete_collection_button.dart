import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/index.dart';
import '../controllers/collection_controller.dart';

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
                        buttonColor: Colors.red,
                        initialWidget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(EvaIcons.trash2Outline),
                            totalSelection <= 0
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "($totalSelection)",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  )
                          ],
                        ),
                      );
                    },
                    controller.totalDeletedCollection,
                  )
                ],
              ),
            ),
        controller.multiSelected);
  }
}
