import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/widgets/app_bar/custom_appBar.dart';

import '../widgets/setting_item.dart';

class AdvancedSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back(id: 1);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          childs: [Text("Advanced Setting")],
          onTapBack: () {
            Get.back(id: 1);
          },
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SettingItem(
                icon: EvaIcons.bell,
                title: "Notfication",
                subTitle: "Enables download notifications in the status bar",
                onTap: () {},
                widget: Column(
                  children: <Widget>[
                    ValueBuilder(
                      builder: (snapshot, updater) => Switch(
                        onChanged: updater,
                        value: snapshot,
                      ),
                      initialValue: true,
                    )
                  ],
                ),
                iconSize: 35,
                iconColor: Colors.amber,
              ),
              SettingItem(
                icon: EvaIcons.download,
                title: "Path to download",
                subTitle: "/storage/emulated/0/PhotoSocial",
                onTap: () {},
                iconSize: 35,
                iconColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
