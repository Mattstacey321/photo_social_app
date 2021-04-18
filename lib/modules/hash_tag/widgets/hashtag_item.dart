import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../data/models/hash_tag_model.dart';
import '../controllers/hashtag_controller.dart';

class HashTagItem extends GetView<HashTagController> {
  final HashTagModel hashTag;
  final VoidCallback onTap;
  HashTagItem({this.hashTag, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    //Color bg = Colors.red;
    String name = hashTag.hashtag;
    int total = hashTag.total;
    //bool isSelected = hashTag.isSelected;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: Row(
          children: [
            ObxValue<RxList<HashTagModel>>(
              (res) {
                return AnimatedSwitcher(
                  duration: 200.milliseconds,
                  child: res.contains(hashTag)
                      ? VerticalDivider(
                          thickness: 3,
                          color: Colors.white,
                          width: 0,
                        )
                      : const SizedBox(),
                );
              },
              controller.selectHashTag,
            ),
            SizedBox(width: 10),
            Text(
              "# $name",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Spacer(),
            total > 0
                ? Container(
                    width: 25,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Text(
                      "$total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
