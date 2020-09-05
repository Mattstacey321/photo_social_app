import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HashTagDashboard extends StatefulWidget {
  @override
  _HashTagDashboardState createState() => _HashTagDashboardState();
}

class _HashTagDashboardState extends State<HashTagDashboard>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(boxShadow: []),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomItem(
            countryCode: 'vn',
            hashtag: "vietnamese",
          ),
          CustomItem(
            countryCode: 'kr',
            hashtag: "korean",
          ),
          CustomItem(
            countryCode: 'cn',
            hashtag: "chinese",
          ),
          CustomItem(
            countryCode: 'jp',
            hashtag: "japanese",
          ),
        ],
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final String countryCode;
  final String hashtag;
  CustomItem({this.countryCode, this.hashtag});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Text(
              "# $hashtag",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Spacer(),
            Flag(
              countryCode,
              height: 20,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
