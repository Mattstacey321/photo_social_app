import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/controllers/controller.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/ui/list_photo/list_photo.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_avatar.dart';
import 'package:photo_social/widgets/custom_button.dart';
import 'package:photo_social/widgets/custom_netword_image.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
      return Scaffold(
          appBar: CustomAppBar(
              homeIcon: Icon(FeatherIcons.hash),
              onTap: () {},
              childs: [
                Text(
                  "Available Game",
                  style: AppStyle.appBarTitle,
                ),
                Spacer(),
                CustomButton(
                  onPress: () {},
                  tooltip: "Request game",
                  iconColor: Colors.red,
                  icon: FeatherIcons.zap,
                  width: 50,
                  height: 30,
                ),
                SizedBox(width: 10),
                CustomAvatar(
                  url: _.getAvatar(),
                  onTap: () {},
                  toolTip:"Profile",
                  size: 40,
                )
              ],
              height: 50),
          body: Container(
              height: Get.height,
              width: Get.width,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 15),
                  itemCount: _.countMockData,
                  itemBuilder: (context, index) {
                    var game = _.mockData;
                    return CustomNetworkImage(
                      onTap: () {
                        print("tap $index");
                        Get.to(ListPhoto());
                      },
                      url: game[index],
                      title: "$index",
                      imageHeight: 135,
                      imageWidth: Get.width,
                    );
                  })));
    });
  }
}
