import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint/app_controllers.dart';
import 'package:photo_social/widgets/index.dart';

class DeletePostButton extends GetView<CollectionDetailController> {
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
                          animateOnTap: false,
                          width: totalSelection <= 0 ? 60 : 80,
                          onPressed: () {
                            //controller.removePost();

                            Get.dialog(Center(
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 200,
                                  width: 300,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CustomButton(
                                        onPress: () {},
                                        iconColor: Colors.red,
                                        childs: [
                                          Icon(
                                            EvaIcons.trash2,
                                            size: 35,
                                          )
                                        ],
                                        height: 50,
                                        width: 50,
                                      ),
                                      Text(
                                        "Delete $totalSelection post ?",
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          FlatButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              color: Colors.indigo,
                                              child: Text("Cancel")),
                                          SizedBox(width: 5),
                                          FlatButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.removePost();
                                              },
                                              color: Colors.red,
                                              child: Text("Confirm"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
                            /*Get.defaultDialog(
                              radius: 10,
                            
                              onConfirm: () {
                                controller.deleteBookmarkCtrl.start();
                                Future.delayed(3.seconds, () {
                                  controller.deleteBookmarkCtrl.success();
                                });
                              },
                              onCancel: () {
                                print("user cancel");
                              },
                            );*/
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
                    controller.totaldeleteSelectedPost,
                  )
                ],
              ),
            ),
        controller.multiSelected);
  }
}
