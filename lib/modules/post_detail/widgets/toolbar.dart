import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../global_widgets/index.dart';
import '../controllers/post_detail_controller.dart';

class Toolbar extends GetView<PostDetailController> {
  final String imageUrl;
  Toolbar({@required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          CustomButton(
            onPress: () {
              Get.back();
            },
            tooltip: "Close",
            iconColor: Colors.white,
            backgroundColor: Colors.transparent,
            showElevation: false,
            height: 40,
            width: 40,
            radius: 10,
            childs: [
              Icon(
                EvaIcons.close,
                color: Colors.white,
              ),
            ],
          ),
          Spacer(),
          CustomButton(
            onPress: () async {
              controller.copyLink(imageUrl);
            },
            tooltip: "Copy link",
            iconColor: Colors.white,
            backgroundColor: Colors.transparent,
            showElevation: false,
            height: 40,
            width: 40,
            radius: 10,
            childs: [
              Icon(
                EvaIcons.link,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(width: 10),
          CustomButton(
            onPress: () async {
              //controller.downloadImage();
            },
            tooltip: "Saved to device",
            iconColor: Colors.white,
            backgroundColor: Colors.transparent,
            showElevation: false,
            height: 40,
            width: 40,
            radius: 10,
            childs: [
              Icon(
                EvaIcons.download,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(width: 10),
          ObxValue<RxBool>(
            (res) {
              return CustomButton(
                onPress: () {
                  controller.hideCommentArea();
                },
                tooltip: "Hide comment",
                iconColor: Colors.white,
                backgroundColor: Colors.transparent,
                showElevation: true,
                height: 40,
                width: 40,
                radius: 10,
                childs: [
                  Icon(
                    res.value ? EvaIcons.arrowheadLeftOutline : EvaIcons.arrowheadRight,
                    color: Colors.white,
                  ),
                ],
              );
            },
            controller.hideComment,
          ),
        ],
      ),
    );
  }
}
