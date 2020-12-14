import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../hashtag_detail.dart';

class HashTagItem extends StatelessWidget {
  final String hashtag;
  final int total;
  HashTagItem({this.hashtag, this.total = 0});
  @override
  Widget build(BuildContext context) {
    //Color bg = Colors.red;
    return InkWell(
      onTap: () {
        Get.to(
          HashTagDetail(
            hashTag: hashtag,
          ),
        );
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            Text(
              "# $hashtag",
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
                : Container(),
          ],
        ),
      ),
    );
  }
}
