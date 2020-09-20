import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/models/hashTagModel.dart';
import 'package:photo_social/screens/search/search_by_hashtag.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/widgets/custom_button.dart';

class HashTagDashboard extends StatefulWidget {
  @override
  _HashTagDashboardState createState() => _HashTagDashboardState();
}

class _HashTagDashboardState extends State<HashTagDashboard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(boxShadow: []),
        child: Center(
          child: Obx(
            () => _.hashTagData.isEmpty
                ? AppStyle.defaultLoading()
                : _.countHashTag == 0
                    ? Text("No hashtag found now")
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10),
                        itemCount: _.countHashTag,
                        itemBuilder: (context, index) {
                          List<HashTagModel> tags = _.hashTagData;
                          return CustomItem(
                            countryCode: '',
                            hashtag: tags[index].hashtag,
                            total: tags[index].total,
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}

class CustomItem extends StatelessWidget {
  final String countryCode;
  final String hashtag;
  final int total;
  CustomItem({this.countryCode, this.hashtag, this.total = 0});
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.red;
    return InkWell(
      onTap: () {
        Get.to(
          SearchByHashTag(
            hashTag: hashtag,
          ),
        );
      },
      child: Container(
        height: 40,
        constraints: BoxConstraints(maxWidth: 200),
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Text(
              "# $hashtag",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            total > 0
                ? CustomButton(
                    onPress: null,
                    iconColor: Colors.transparent,
                    backgroundColor: bg,
                    opacity: 0.1,
                    height: 22,
                    width: 30,
                    childs: [
                      Text(
                        "$total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.red),
                      )
                    ],
                  )
                : Container(),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
