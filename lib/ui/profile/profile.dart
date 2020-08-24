import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_social/constraint.dart';
import 'package:photo_social/controllers/account_controller.dart';
import 'package:photo_social/style.dart';
import 'package:photo_social/ui/profile/widgets/custom_setting.dart';
import 'package:photo_social/widgets/custom_appBar.dart';
import 'package:photo_social/widgets/custom_avatar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (_) {
          return Scaffold(
            appBar: CustomAppBar(
                color: Color(0xff5E6BFC).withOpacity(0.7),
                childs: [
                  Text(
                    "Profile",
                    style: AppStyle.appBarTitle,
                  )
                ],
                height: 50,
                onTap: () {
                  Get.back();
                }),
            body: Container(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  Container(
                    height: 300,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Color(0xff5E6BFC).withOpacity(0.7),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(1, 1),
                                spreadRadius: 4)
                          ]),
                          child: CustomAvatar(
                            url: _.getAvatar(),
                            onTap: () {},
                            size: 140,
                            toolTip: "Your avatar",
                            borderRadius: 15,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          _.getName(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          height: Get.height - 300,
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              CustomSetting(
                                icon: FeatherIcons.globe,
                                onTap: () {},
                                title: "Language",
                              ),
                              CustomSetting(
                                icon: FeatherIcons.image,
                                onTap: () {},
                                title: "Image Resolution",
                              ),
                              CustomSetting(
                                icon: FeatherIcons.moon,
                                onTap: () {},
                                title: "Theme Mode",
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomSetting(
                                  icon: FeatherIcons.log_out,
                                  onTap: () {},
                                  title: "Log out",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
